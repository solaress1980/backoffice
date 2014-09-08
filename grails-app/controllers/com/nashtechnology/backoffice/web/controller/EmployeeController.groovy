package com.nashtechnology.backoffice.web.controller

import grails.converters.JSON
import groovy.json.JsonSlurper
import com.nashtechnology.backoffice.business.services.EmployeeService
import com.nashtechnology.backoffice.data.Employee
import grails.transaction.*


class EmployeeController {
	EmployeeService employeeService
	
    def index() { 
		
		//get the list of current employee	
		def employeeList = employeeService.getAll()
		
		return [employeeList: employeeList, companyName: 'New Quick Way Mart']
	}
	
	
	//add the new employee
	@Transactional
	def save(Employee employee) {
		if(employee.hasErrors()) {
			respond employee.errors, view:'index'
		}
		else {
			employee.save flush:true
		    withFormat {
		        html { 
		            flash.message = message(code: 'default.created.message', args: [message(code: 'book.label', default: 'Book'), book.id])
		            redirect book 
		        }
		        '*' { render status: CREATED }
		    }
		}
	}
		
	def add = {
		def employeeParam = new JsonSlurper().parseText(params['employeeParam'])
		def employee
		
		if ( employeeParam ) { 
			//check if already exists
			employee = employeeService.getByName(employeeParam.firstName, employeeParam.lastName)
			
			if (!employee) {
				employee = new Employee(employeeParam)
				
				//save
				employeeService.save(employee)
			}
			else {
				log.debug 'Already exists.'
				render status: 404
			}
		}
		
		render status: 200
	}
}
