package com.nashtechnology.backoffice.data

import java.util.Date
import com.nashtechnology.backoffice.data.TimeEntry


class DailyTimeEntry {
	Date  updatedDate
	String updatedBy
	Date entryDate
	
	// Mappings
	static hasMany = [timeEntries: TimeEntry]
	
	static constraints = {
		entryDate nullable: false, unique: true
	}
	
	static mapping = {
		updatedBy defaultValue: "'ROHANS'"
	}
		
	//override setter: saves only the date and not the time portion
	def setUpdatedDate( Date date ) {
		updatedDate = date
	}
	def setEntryDate( Date date ) {
		date.clearTime()
		entryDate = date
	}
		
}
