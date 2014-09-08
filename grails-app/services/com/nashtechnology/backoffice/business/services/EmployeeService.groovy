package com.nashtechnology.backoffice.business.services

import com.nashtechnology.backoffice.data.Employee

class EmployeeService {

	def getByName(firstName, lastName) {
		def employee = Employee.where {
			firstName == firstName &&
			lastName == lastName
		}.find()
		
		return employee
	}
	
	def getAll() {
		def employeeList = Employee.list()
		
		log.info('No. of employeed enrolled = ' + employeeList.size())
		
		return employeeList
	}
	
	def save(employee) {
		log.debug 'trying to save: ' + employee.dump()
			
		if(!employee.save(flush: true)) {
			log.error "${employee.errors}"
		}
		else { 
			log.debug 'employee saved'
		}
	}
}
