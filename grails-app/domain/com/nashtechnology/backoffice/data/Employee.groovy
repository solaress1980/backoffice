package com.nashtechnology.backoffice.data


class Employee implements Serializable {
	
	String employeeId
	String firstName
	String lastName
	String ssn
	String phone
	String email
	String address
	Character active
	Date dateHired

    static constraints = {
		employeeId unique: true, nullable:true
		ssn unique:true, nullable:true
		phone nullable:true
		email nullable:true
		address nullable:true
		active nullable:true
		dateHired nullable:true
    }
	
	
	def beforeInsert() {
		employeeId = UUID.randomUUID().toString()
	}
}
