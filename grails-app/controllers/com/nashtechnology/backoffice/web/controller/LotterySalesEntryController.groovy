package com.nashtechnology.backoffice.web.controller

import com.nashtechnology.backoffice.data.LotterySalesEntry
import com.nashtechnology.backoffice.data.ScratchOffTicketSaleEntry
import com.nashtechnology.backoffice.business.services.LotteryService;

import grails.converters.JSON
import groovy.json.JsonSlurper

class LotterySalesEntryController {
	LotteryService lotteryService
	
	def show = {
		if(params.id && ScratchOffTicketSaleEntry.exists(params.id)){
			render ScratchOffTicketSaleEntry.findById(params.id) as JSON
		} 
		else {
			render ScratchOffTicketSaleEntry.list() as JSON
		}
	}

	def create = {
		def lotterySalesEntry = new ScratchOffTicketSaleEntry(params['lotterySalesEntry'])

		if(lotterySalesEntry.save()){
			render lotterySalesEntry as JSON
		}else{
			//handle errors...
		}
	}
	
	
	def update = {
		def lotterySalesEntry = new LotterySalesEntry(new JsonSlurper().parseText(params['lotterySalesEntry']))

		if(lotterySalesEntry.update()){
			render lotterySalesEntry as JSON
		}else{
			//handle errors...
		}
	}
	
	def multiUpdate = {
		def lotterySalesDataParam = new JsonSlurper().parseText(params['lotterySalesDataParam'])
		//save all scratch off entry
		def scratchOffTicketSalesEntryObjList = lotterySalesDataParam.scratchOffTicketSalesEntryObjList;
		for (scratchOffTicketSalesEntryParam in scratchOffTicketSalesEntryObjList ){ 
			log.debug('load ' + scratchOffTicketSalesEntryParam.id + ' from Db.')
			def scratchOffTicketSalesEntryCurrent = ScratchOffTicketSaleEntry.get(scratchOffTicketSalesEntryParam.id) 
			// Update values 
			scratchOffTicketSalesEntryCurrent.openNo = scratchOffTicketSalesEntryParam.openNo.toInteger()
			scratchOffTicketSalesEntryCurrent.end1No = scratchOffTicketSalesEntryParam.end1No.toInteger()
			scratchOffTicketSalesEntryCurrent.end2No = scratchOffTicketSalesEntryParam.end2No.toInteger()
			// Save scratchOffTicketSalesEntryCurrent 
			if ( !scratchOffTicketSalesEntryCurrent.save()) {
				log.error "${scratchOffTicketSalesEntryCurrent.errors}"
			} 
		}
		
		//save lottery sales entry
		def lotterySalesEntryObjList = lotterySalesDataParam.lotterySalesEntryObjList;
		for (lotterySalesEntryParam in lotterySalesEntryObjList ){
			log.debug('load ' + lotterySalesEntryParam.id + ' from Db.')
			def lotterySalesEntryCurrent = LotterySalesEntry.get(lotterySalesEntryParam.id) 
			// Update values
			lotterySalesEntryCurrent.lotterySales = lotterySalesEntryParam.lotterySales.toDouble()
			lotterySalesEntryCurrent.lottoSales = lotterySalesEntryParam.lottoSales.toDouble()
			lotterySalesEntryCurrent.registerSales = lotterySalesEntryParam.registerSales.toDouble()
			//calculate rest
			lotterySalesEntryCurrent.totalSales = ( lotterySalesEntryCurrent.lotterySales + lotterySalesEntryCurrent.lottoSales)
			lotterySalesEntryCurrent.diffInSales = ( lotterySalesEntryCurrent.totalSales + lotterySalesEntryCurrent.registerSales) 
			// Save lotterySalesEntryCurrent
			if ( !lotterySalesEntryCurrent.save()) {
				log.error "${lotterySalesEntryCurrent.errors}"
			}
		}
		
		//save lottery register sales entry
			
		render scratchOffTicketSalesEntryObjList as JSON
	}//end multiUpdate
	
	//get current list of all scratchoffs
	def admin() {
		def scratchOffList = lotteryService.getAllScratchOff()
		
		return [scratchOffList:scratchOffList]
	}
	
}
