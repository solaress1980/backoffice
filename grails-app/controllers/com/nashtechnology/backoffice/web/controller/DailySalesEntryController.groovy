package com.nashtechnology.backoffice.web.controller;

import com.nashtechnology.backoffice.data.DailyPaperwork
import com.nashtechnology.backoffice.data.Expense
import com.nashtechnology.backoffice.data.LotterySalesEntry
import com.nashtechnology.backoffice.data.ScratchOffTicketSaleEntry
import com.nashtechnology.backoffice.data.SalesEntry
import com.nashtechnology.backoffice.data.ScratchOff
import com.nashtechnology.backoffice.business.services.LotteryService
import com.nashtechnology.backoffice.business.services.SalesEntryService
import org.springframework.web.servlet.ModelAndView
import com.nashtechnology.backoffice.CloseType
import com.nashtechnology.backoffice.ExpenseType

class DailySalesEntryController {

	LotteryService lotteryService
	SalesEntryService salesEntryService

	def today = new Date() //represents the date and time when it is created

	//gets paperwork by selected date or if not creates new daily paperwork for today
	def index() {
		
		def dailyPaperwork;
		
		//get day
		def requestedDateStr = params.d;
		log.info('get paperwork for ' + requestedDateStr);
		def requestedEntryDate
		
		if ( requestedDateStr ) {
			requestedEntryDate = Date.parse("yyyy-MM-dd", requestedDateStr)
		}
		
		if ( requestedEntryDate ) {
			dailyPaperwork = salesEntryService.getPreviousDailyPaperwork(requestedEntryDate)
		}
		else {
			requestedEntryDate = today	//set entry date to today
			dailyPaperwork = salesEntryService.currentDailyPaperwork()
		}

		if ( dailyPaperwork ) {
			//do nothing
		}
		else {	//new day daily sales entry preparation
			dailyPaperwork = new DailyPaperwork()
			dailyPaperwork.entryDate = requestedEntryDate
			dailyPaperwork.updatedDate = today
			dailyPaperwork.updatedBy = 'ROHANS'

			//1.create registrySalesEntry for Shift 1, Shift 2 and Day
			for ( i in 0..2 ) {
				/* set default values for register sales entry */
				def salesEntry = new SalesEntry()
				if ( i == 0 ) {
					salesEntry.closeType = CloseType.SHIFT1.name()
				}
				else if ( i == 1 ) {
					salesEntry.closeType = CloseType.SHIFT2.name()
				}
				else if ( i == 2 ) {
					salesEntry.closeType = CloseType.DAY.name()
				}
				log.debug('Populating ' + salesEntry.closeType)

				salesEntry.updatedDate = today
				salesEntry.updatedBy = 'ROHANS'
				salesEntry.beginningCashInRegister = 300.00
				salesEntry.endingCashInRegister = 300.00

				def lotterySalesEntry = new LotterySalesEntry()
				if ( !lotterySalesEntry.save(flush:true) ) {
					log.error "${lotterySalesEntry.errors}"
				}
				salesEntry.setLotterySalesEntry(lotterySalesEntry)

				dailyPaperwork.addToSalesEntries(salesEntry)

			}//end for

			//prepare scratch off data
			def scratchOffList = lotteryService.getAllActiveScratchOff()

			//prepare lottery sales entry field for today
			def scratchOffTicketSaleEntry

			for ( scratchOff in scratchOffList ) {
				log.info('scratch off no: ' + scratchOff.gameNumber);
				scratchOffTicketSaleEntry = new ScratchOffTicketSaleEntry()
				scratchOffTicketSaleEntry.scratchOff = scratchOff
				scratchOffTicketSaleEntry.openNo = 0
				scratchOffTicketSaleEntry.dailyPaperwork = dailyPaperwork
				dailyPaperwork.addToScratchOffTicketSaleEntries(scratchOffTicketSaleEntry);
			}


			//prepare one expenses and one vendor paidouts record by default
			def maintenance_expense = new Expense()
			maintenance_expense.setExpenseType(ExpenseType.MAINTENANCE)
			dailyPaperwork.addToExpenses(maintenance_expense)
			def vendor_paidouts = new Expense()
			vendor_paidouts.setExpenseType(ExpenseType.VENDOR_PAIDOUTS)
			dailyPaperwork.addToExpenses(vendor_paidouts)

			//update db with new records
			if ( !dailyPaperwork.save(flush:true) ) {
				log.error "${dailyPaperwork.errors}"
			}


		}//end else

		return [dailyPaperwork:dailyPaperwork, companyName: 'New Quick Way Mart']
	}


	def pick() {

	}
}
