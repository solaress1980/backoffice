package com.nashtechnology.backoffice.data

import com.nashtechnology.backoffice.ExpenseType;
import com.nashtechnology.backoffice.TenderType

class Expense {
	
	String name
	Double amount
	ExpenseType expenseType
	TenderType tenderType
	
	// Mappings
	static belongsTo = [dailyPaperwork: DailyPaperwork]
		
    static constraints = {
		name nullable:true
		amount nullable:true
		expenseType nullable:false
		tenderType nullable:true
    }
	
	public Expense() {}
	
	public Expense(ExpenseType expenseType) {
		this.expenseType = expenseType
	}
}
