package com.nashtechnology.backoffice.data

import java.util.Date;

class ScratchOffTicketSaleEntry {
	ScratchOff scratchOff
	Integer openNo = 0
	Integer end1No = 0
	Integer end2No = 0
	Integer sales1 = 0
	Integer sales2 = 0
	
	// Mappings
	static belongsTo = [dailyPaperwork: DailyPaperwork]
		
    static constraints = {
		
    }
		
	//do not persist
	static transients = [ "sales1", "sales2" ]
	
	//override getter: saves only the date and not the time portion
	def getSales1() {
		return (end1No - openNo) * scratchOff.gamePrice
	}
	def getSales2() {
		return (end2No - end1No) * scratchOff.gamePrice
	}
}
