package com.nashtechnology.backoffice.data

import java.util.Date;

class SalesEntry {
	String closeType
	Date  updatedDate
	String updatedBy
	Double beginningCashInRegister = 0.00
	Double totalSalesRevenue = 0.00
	Double diffInLotto = 0.00
	Double diffInMO = 0.00
	Double paidIns = 0.00
	Double totalPlus = 0.0
	
	Double tabCredit = 0.00
	Double networkRevenue = 0.00 	//credit card charges
	Double ebtRevenue = 0.00		//food stamp charges
	Double lotteryCashPaidouts = 0.00
	Double ticketPaidouts = 0.00
	Double ticketMatch = 0.0
	Double moneyGramPaidouts = 0.00
	Double totalSafeDrops = 0.00
	Double endingCashInRegister = 0.00	
	Double totalMinus = 0.0	
	
	Double shortOver = 0.0
	
	//foreign key will exist in SalesEntry table
	LotterySalesEntry lotterySalesEntry
	
	static belongsTo = [dailyPaperwork: DailyPaperwork]
	
	static constraints = {
		beginningCashInRegister nullable:true
		totalSalesRevenue nullable:true
		diffInLotto nullable:true
		diffInMO nullable:true
		paidIns nullable:true
		tabCredit nullable:true
		networkRevenue nullable:true
		ebtRevenue nullable:true
		lotteryCashPaidouts nullable:true
		ticketPaidouts nullable:true 
		moneyGramPaidouts nullable:true
		totalSafeDrops nullable:true
		endingCashInRegister nullable:true
	}
	
	static mapping = {
		updatedBy defaultValue: "'ROHANS'"
	}
		
	//override setter: saves only the date and not the time portion
	def setEntryDate( Date date ) {
		date.clearTime()
		entryDate = date
	}
	
	//do not persist
	static transients = [ "totalPlus", "totalMinus", "shortOver" ]
	
	//override getter: saves only the date and not the time portion
	def getTotalPlus() {
		return (beginningCashInRegister + totalSalesRevenue + diffInLotto + diffInMO + paidIns)
	}
	def gettotalMinus() {
		return (tabCredit + networkRevenue + ebtRevenue + lotteryCashPaidouts + ticketPaidouts + ticketMatch + moneyGramPaidouts + totalSafeDrops + endingCashInRegister)
	}
	def getShortOver() {
		return (totalPlus - totalMinus)
	}
	
}
