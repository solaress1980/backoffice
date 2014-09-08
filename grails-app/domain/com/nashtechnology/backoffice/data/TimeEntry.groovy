package com.nashtechnology.backoffice.data

import java.util.Date;


class TimeEntry {
	String employeeNo
	String hoursWorked
	
	static belongsTo = [dailyTimeEntry: DailyTimeEntry]
	
	static constraints = {
		employeeNo nullable:true
		hoursWorked nullable:true
	}
		
}
