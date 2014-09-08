package com.nashtechnology.backoffice.web.controller

import com.nashtechnology.backoffice.data.DailyPaperwork
import com.nashtechnology.backoffice.data.Expense
import grails.converters.JSON
import groovy.json.JsonSlurper

class ExpensesEntryController {

	def show = {
		if(params.id && Expense.exists(params.id)){
			render Expense.findById(params.id) as JSON
		}
		else {
			render Expense.list() as JSON
		}
	}

	def create = {
		def expense = new Expense(new JsonSlurper().parseText(params['expenseParam']))

		if(expense.save(flush:true)){
			render expense as JSON
		}
		else{
			log.error "${expense.errors}"
		}
	}


	def update = {
		def expense = new Expense(new JsonSlurper().parseText(params['expenseParam']))

		if(expense.update(flush:true)){
			render expense as JSON
		}
		else{
			log.error "${expense.errors}"
		}
	}

	def delete = {
		def expenseParam = new JsonSlurper().parseText(params['expenseParam'])
		def expense = Expense.get(expenseParam.id)

		try{
			expense.delete(flush:true, failOnError:true)
		}
		catch(e) {
			log.error "${expense.errors}"
		}
		
		render expense as JSON
	}

	def multiUpdate = {
		def expenseParamList = new JsonSlurper().parseText(params['expenseParamList'])
		//save all expenses entry
		for (expenseParam in expenseParamList ){
			log.debug('load ' + expenseParam.id + ' from Db.')
			def expenseCurrent = Expense.get(expenseParam.id)
			// Update values
			expenseCurrent.name = expenseParam.name;
			expenseCurrent.amount = expenseParam.amount?expenseParam.amount.toDouble():0;
			expenseCurrent.tenderType = expenseParam.tenderType;
			
			// Save scratchOffTicketSalesEntryCurrent
			if ( !expenseCurrent.save(flush:true)) {
				log.error "${expenseCurrent.errors}"
			}
		}

		render expenseParamList as JSON
	}
}
