package com.nashtechnology.backoffice.data

import java.util.Date
import com.nashtechnology.backoffice.ExpenseType

class DailyPaperwork {
	Date entryDate
	Date  updatedDate
	String updatedBy	

	// Mappings
	static hasMany = [expenses: Expense,  salesEntries: SalesEntry, scratchOffTicketSaleEntries: ScratchOffTicketSaleEntry]
	
	static constraints = {
		entryDate nullable:true
		updatedDate nullable:true
		updatedBy nullable:true
	}

	static mapping = {
		updatedBy defaultValue: "'ROHANS'"
	}
	
	static namedQueries = {
		currentDailyPaperwork {
			def now = new Date()
			now.clearTime()	
			eq 'entryDate', now
		}
		
		previousDailyPaperwork { Date requestedDate ->
			requestedDate.clearTime()
			eq 'entryDate', requestedDate
		}
	}

	def beforeInsert() {
		updatedDate = new Date()
	}
	
	//override setter: saves only the date and not the time portion
	def setEntryDate( Date date ) {
		date.clearTime()
		entryDate = date
	}

	/*def getVendorPaidouts() {
		return expenses.find { it.expenseType == ExpenseType.VENDOR_PAIDOUTS }
	}
	
	def getMaintenanceExpenses() {
		return expenses.find { it.expenseType == ExpenseType.MAINTENANCE }
	}*/
	
}
