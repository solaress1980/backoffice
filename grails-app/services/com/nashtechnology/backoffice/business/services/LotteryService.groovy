package com.nashtechnology.backoffice.business.services

import com.nashtechnology.backoffice.data.LotterySalesEntry
import com.nashtechnology.backoffice.data.ScratchOff
import grails.transaction.Transactional

@Transactional
class LotteryService {

    def serviceMethod() {

    }
	
	def getAllScratchOff() {
		def scratchOffList = ScratchOff.list(sort: "gamePrice", order: "asc")
		
		log.info('scratchOffList size = ' + scratchOffList.size())
		
		return scratchOffList
	}
	
	def getAllActiveScratchOff() {
		def scratchOffList = ScratchOff.where {
			active == 'Y'
		}.list(sort: "boxNo", order: "asc")
		
		log.info('scratchOffList size = ' + scratchOffList.size())
		
		return scratchOffList
	}
	
	def updateLotterySales(lotterySalesEntryList) {
		for ( lotterySalesEntry in lotterySalesEntryList ) {
			log.debug('trying to save: ' + lotterySalesEntry.dump())
			if(lotterySalesEntry.save(flush: true)) {
				log.error('lottery sales entry created.')
			} else {
				//handle errors...
				log.error "${lotterySalesEntry.errors}"
			}
		}
	}
	
}
