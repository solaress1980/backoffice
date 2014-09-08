package com.nashtechnology.backoffice.business.services

import grails.transaction.Transactional
import com.nashtechnology.backoffice.data.DailyPaperwork

@Transactional
class SalesEntryService {
	
	//get all registry sales entries for all shifts including day
	def currentDailyPaperwork() {
		def dailyPaperwork = DailyPaperwork.currentDailyPaperwork.get()
		
		return dailyPaperwork
	}
	
	//get all registry sales entries for all shifts including day for a given date
	def getPreviousDailyPaperwork(java.util.Date requestedDate) {
		def dailyPaperwork = DailyPaperwork.previousDailyPaperwork(requestedDate).get()
		
		return dailyPaperwork
	}
	
	
}
