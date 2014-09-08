package com.nashtechnology.backoffice.web.controller

import com.nashtechnology.backoffice.data.SalesEntry
import grails.converters.JSON
import groovy.json.JsonSlurper

class MainSalesEntryController {

	def show = {
		if(params.id && SalesEntry.exists(params.id)){
			render SalesEntry.findById(params.id) as JSON
		} 
		else {
			render SalesEntry.list() as JSON
		}
	}

	def create = {
		def salesEntry = new SalesEntry(params['SalesEntry'])

		if(salesEntry.save()){
			render salesEntry as JSON
		}else{
			//handle errors...
		}
	}
	
	
	def update = {
		def salesEntry = new SalesEntry(new JsonSlurper().parseText(params['SalesEntry']))

		if(salesEntry.update()){
			render salesEntry as JSON
		}else{
			//handle errors...
		}
	}
	
	def multiUpdate = {
		def salesEntryObjListParam = new JsonSlurper().parseText(params['salesEntryObjListParam'])
		//save all scratch off entry
		for (salesEntryObjParam in salesEntryObjListParam ){ 
			log.debug('load ' + salesEntryObjParam.id + ' from Db.')
			def salesEntryCurrent = SalesEntry.get(salesEntryObjParam.id) 
			// Update values 
			salesEntryCurrent.totalSalesRevenue = salesEntryObjParam.totalSalesRevenue.toDouble();
			salesEntryCurrent.diffInLotto = salesEntryObjParam.diffInLotto.toDouble();
			salesEntryCurrent.diffInMO = salesEntryObjParam.diffInMO.toDouble();
			salesEntryCurrent.paidIns = salesEntryObjParam.paidIns.toDouble();
			salesEntryCurrent.tabCredit = salesEntryObjParam.tabCredit.toDouble();
			salesEntryCurrent.networkRevenue = salesEntryObjParam.networkRevenue.toDouble();
			salesEntryCurrent.ebtRevenue = salesEntryObjParam.ebtRevenue.toDouble();
			salesEntryCurrent.lotteryCashPaidouts = salesEntryObjParam.lotteryCashPaidouts.toDouble();
			salesEntryCurrent.ticketPaidouts = salesEntryObjParam.ticketPaidouts.toDouble();
			salesEntryCurrent.moneyGramPaidouts = salesEntryObjParam.moneyGramPaidouts.toDouble();
			salesEntryCurrent.totalSafeDrops = salesEntryObjParam.totalSafeDrops.toDouble();
			// Save scratchOffTicketSalesEntryCurrent 
			if ( !salesEntryCurrent.save()) {
				log.error "${salesEntryCurrent.errors}"
			} 
		}
			
		render salesEntryObjListParam as JSON
	}
}
