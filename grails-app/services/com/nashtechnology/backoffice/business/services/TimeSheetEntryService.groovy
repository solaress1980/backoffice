package com.nashtechnology.backoffice.business.services

import grails.transaction.Transactional
import com.nashtechnology.backoffice.data.TimeEntry
import com.nashtechnology.backoffice.data.DailyTimeEntry

@Transactional
class TimeSheetEntryService {	
	
	//get monthly time entries for given month and year
	def getPreviousMonthlyTimeEntry(Date requestedDate) {
		
		def requestedMonth = requestedDate.getAt(Calendar.MONTH)
		def requestedYear = requestedDate.getAt(Calendar.YEAR)
		
		def timeSheetEntryList = DailyTimeEntry.where {
			month(entryDate) == (requestedMonth+1) &&
			year(entryDate) == requestedYear
		}.list()
		
		return timeSheetEntryList
	}
	
	def saveAll(timeSheetEntryList) {
		for ( timeSheetEntry in timeSheetEntryList ) {
			log.debug('trying to save: ' + timeSheetEntry.dump())
			if(timeSheetEntry.save(flush: true)) {
				log.error('time sheet entry created.')
			} else {
				//handle errors...
				log.error "${timeSheetEntry.errors}"
			}
		}
	}
	
	def updateAll(timeSheetEntryList) {
		for ( timeSheetEntry in timeSheetEntryList ) {
			log.debug('trying to save: ' + timeSheetEntry.dump())
			if(timeSheetEntry.save(flush: true)) {
				log.error('time sheet entry updated.')
			} else {
				//handle errors...
				log.error "${timeSheetEntry.errors}"
			}
		}
	}
	
}
