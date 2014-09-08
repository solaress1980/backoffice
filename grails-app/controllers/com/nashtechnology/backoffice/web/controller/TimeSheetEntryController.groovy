package com.nashtechnology.backoffice.web.controller;

import java.util.GregorianCalendar
import com.nashtechnology.backoffice.business.services.TimeSheetEntryService
import com.nashtechnology.backoffice.data.DailyTimeEntry
import com.nashtechnology.backoffice.data.TimeEntry
import grails.converters.JSON
import groovy.json.JsonSlurper


class TimeSheetEntryController {

	TimeSheetEntryService timeSheetEntryService
	def today = new Date() //represents the date and time when it is created

	//gets paperwork by selected date or if not creates new daily paperwork for today
	def index() {
		
		//get month in numeral, jan=1, dec=12
		def requestedMonthStr = params.m
		if ( !requestedMonthStr ) {
			requestedMonthStr = today.getAt(Calendar.MONTH) + 1 + ''	//get current month, add one to make jan=0 to jan=1 as user input
		}
		
		def requestedMonth = requestedMonthStr.toInteger()
		
		//get year
		def requestedYearStr = params.y
		if ( !requestedYearStr ) {
			requestedYearStr = today.getAt(Calendar.YEAR) + ''	//get current year
		}
		
		def requestedYear = requestedYearStr.toInteger()
		
		
		Calendar currentMonth = GregorianCalendar.instance
		currentMonth.set(Calendar.MONTH, requestedMonth-1)
		currentMonth.set(Calendar.YEAR, requestedYear)
		
		//next, get if exists in DB
		def timeSheetEntryList = timeSheetEntryService.getPreviousMonthlyTimeEntry(currentMonth.getTime())
		
		//if does not exist, create and save
		if ( !timeSheetEntryList ) {
			
			def noOfDays = currentMonth.getActualMaximum(GregorianCalendar.DAY_OF_MONTH)
			log.debug "Last Day of a Month: ${noOfDays}"
			
			timeSheetEntryList = new ArrayList()
			
			for ( i in 1..noOfDays ) {
				def dailyTimeEntry = new DailyTimeEntry()
				def tempCalendar = currentMonth.clone()
				tempCalendar.set(Calendar.DAY_OF_MONTH, i)
				dailyTimeEntry.entryDate = tempCalendar.getTime()
				dailyTimeEntry.updatedDate = today
				dailyTimeEntry.updatedBy = 'ROHANS'
				//loop thru each four employees
				for ( e in 1..4) {
					def timeEntry = new TimeEntry()
					timeEntry.employeeNo = e
					timeEntry.hoursWorked = 0
					dailyTimeEntry.addToTimeEntries(timeEntry)
				}
				
				timeSheetEntryList.add(dailyTimeEntry)
			}
			
			// Save 
			timeSheetEntryService.saveAll(timeSheetEntryList)
			
		}
		 
		//set previous month
		def previousMonth = currentMonth.clone()
		previousMonth.add(Calendar.MONTH, -1)
		//set next month
		def nextMonth = currentMonth.clone()
		nextMonth.add(Calendar.MONTH, 1)
		
		return [currentMonth: currentMonth, previousMonth: previousMonth, nextMonth: nextMonth, timeSheetEntryList: timeSheetEntryList, companyName: 'New Quick Way Mart']
	}
	
	def multiUpdate = {
		def dailyTimeEntryObjListParam = new JsonSlurper().parseText(params['dailyTimeEntryObjListParam'])
		//save all 
		for (dailyTimeEntryObj in dailyTimeEntryObjListParam ){
			log.debug('load ' + dailyTimeEntryObj.id + ' from Db.')
			def dailyTimeEntryCurrent = DailyTimeEntry.get(dailyTimeEntryObj.id)
			
			// Update values
			dailyTimeEntryCurrent.updatedBy = 'ROHANS'
			dailyTimeEntryCurrent.updatedDate = today
			
			def timeEntryCurrentList = []
			for ( timeEntryObjParam in dailyTimeEntryObj.timeEntries ) {
				
				def timeEntryCurrent = TimeEntry.get(timeEntryObjParam.id)
				timeEntryCurrent.employeeNo = timeEntryObjParam.employeeNo.toInteger()
				timeEntryCurrent.hoursWorked = timeEntryObjParam.hoursWorked.toInteger()
				
				timeEntryCurrentList.push(timeEntryCurrent);
			}
			dailyTimeEntryCurrent.timeEntries = timeEntryCurrentList
			
			// Save
			if ( !dailyTimeEntryCurrent.save(flush:true)) {
				log.error "${dailyTimeEntryCurrent.errors}"
			}
		}
			
		render dailyTimeEntryObjListParam as JSON
	}

}
