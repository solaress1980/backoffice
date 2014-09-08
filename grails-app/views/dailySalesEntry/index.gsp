<%@ page import="com.nashtechnology.backoffice.CloseType" %>

<!DOCTYPE html>

<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en">
<!--<![endif]-->
<head>
	<meta name="layout" content="template"/>

	<title>Daily Paperwork - ${companyName}</title>

	<!-- Included CSS Files -->
	<link rel="stylesheet" media="print" href="${resource(dir: 'css', file: 'print.css')}"/>
	
	<script type="text/javascript" src="${resource(dir: 'dynamic/js', file: 'jquery.form.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'dynamic/js', file: 'jquery.validate.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'dynamic/js', file: 'common.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'dynamic/js/app', file: 'daily_sales_entry.js')}"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		
			
	});
	</script>
</head>

<body rel="${dailyPaperwork.id}">
		<div class="row">
			<div class="small-12 columns">
				
				<a id='close-button' href="#"></a><a id='print-button' href="#"></a>
				
				<h1><g:message message="${companyName}" /></h1>
				<h3>Daily Paperwork - <g:formatDate format="EEEE MMM dd, yyyy" date="${dailyPaperwork.entryDate}"/></h3>
				<h4 class="subhead">Daily sales entry form should be saved
					daily after filling all form fields.</h4>

				<pre>Lottery sales, daily sales, vendor paidouts and maintenance expenses are all to be entered.<br/><br/>Once all is entered and saved. Hit Complete daily paperwork to print.</pre>

				<div class="main_menu">
					<a href="#" id="completeTop" class="small radius button">Complete daily paperwork</a>
				</div>
				
				<hr />
				
				<section id="lottery_sales_section">
				
				<h5>Lottery Sales Entry</h5>
				
				<form id="lottery-sales-form">
				<table id="lottery-tbl" class="responsive table-style1 numeric">
					<thead>
					<tr>
						<th><th></th><th>Game</th><th></th><th></th>
						<th>Shift</th><th>1</th>
						<th>Shift</th><th>2</th>
						<th>Total</th>
					</tr>
					<tr class="second-child">
						<th></th><th width="20%">Name</th>
						<th>No</th>
						<th>Price</th>
						<th>Start</th>
						<th>End</th>
						<th>Total</th>
						<th>End</th>
						<th>Total</th>
						<th></th>
					</tr>
					</thead>
					<tbody>
					<g:each var="scratchOffTicketSaleEntry" in="${dailyPaperwork.scratchOffTicketSaleEntries.sort{a,b-> a.scratchOff.boxNo.compareTo(b.scratchOff.boxNo)}}" status="i">
						<tr class="lottery-sales-entry">
							<td><g:message message="${scratchOffTicketSaleEntry.scratchOff.boxNo}" />. 
								<g:hiddenField name="scratchOffTicketSaleEntry_id_${i}" value="${scratchOffTicketSaleEntry.id}" />
								<g:hiddenField name="scratchOffTicketSaleEntry_scratchOff_gameSize_${i}" value="${scratchOffTicketSaleEntry.scratchOff.gameSize}" />
							</td>
							<td width="30%">
								<g:message message="${scratchOffTicketSaleEntry.scratchOff.gameName}" /></td>
							<td><g:message message="${scratchOffTicketSaleEntry.scratchOff.gameNumber}" /></td>
							<td><g:message message="${scratchOffTicketSaleEntry.scratchOff.gamePrice}" /></td>
							<td><input type="text" name="open-${scratchOffTicketSaleEntry.scratchOff.gameNumber}"
								class="small30" maxlength="3" value="${scratchOffTicketSaleEntry.openNo}" /></td>
							<td><input type="text" name="end1-${scratchOffTicketSaleEntry.scratchOff.gameNumber}"
								class="small30" maxlength="3" value="${scratchOffTicketSaleEntry.end1No}" /></td>
							<td><input type="text"
								name="total1-${scratchOffTicketSaleEntry.scratchOff.gameNumber}" class="small50" readonly disabled /></td>
							<td><input type="text" name="end2-${scratchOffTicketSaleEntry.scratchOff.gameNumber}"
								class="small30" maxlength="3" value="${scratchOffTicketSaleEntry.end2No}" /></td>
							<td><input type="text"
								name="total2-${scratchOffTicketSaleEntry.scratchOff.gameNumber}" class="small50" readonly disabled /></td>
							<td><input type="text"
								name="dailytotal-${scratchOffTicketSaleEntry.scratchOff.gameNumber}" class="small50"
								readonly disabled /></td>
						</tr>
					</g:each>
					</tbody>
					<tfoot>
					<tr class="lottery-subtotal">
						<td></td><td></td><td colspan="4">I. Lottery sales</td>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==1}"><td></td></g:if>
						<td><g:hiddenField name="id-lotterySales_${i}" value="${salesEntryObj.lotterySalesEntry.id}" />
							<input type="text"
								name="lotterySales_${i}" class="small50" readonly disabled value="${salesEntryObj.lotterySalesEntry.lotterySales}" />
						</td>
						</g:each>
					</tr>
					<tr class="lottery-subtotal">
						<td></td><td></td><td colspan="4">II. Lotto sales</td>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==1}"><td></td></g:if>
						<td><input type="text"
								name="lottoSales_${i}" class="small50" value="${salesEntryObj.lotterySalesEntry.lottoSales}"<g:if test="${i==1}"> readonly disabled</g:if> />
						</td>
						</g:each>
					</tr>
					<tr class="lottery-subtotal">
						<td></td><td></td><td colspan="4">A. Total sales = ( I + II )</td>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==1}"><td></td></g:if>
						<td><input type="text"
								name="totalSales_${i}" class="small50" readonly disabled value="${salesEntryObj.lotterySalesEntry.totalSales}" />
						</td>
						</g:each>
					</tr>
					<tr class="lottery-subtotal">
						<td></td><td></td><td colspan="4">B. Total sales in register</td>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==1}"><td></td></g:if>
						<td><input type="text"
								name="registerSales_${i}" class="small50" value="${salesEntryObj.lotterySalesEntry.registerSales}"<g:if test="${i==1}"> readonly disabled</g:if> />
						</td>
						</g:each>
					</tr>
					<tr class="lottery-subtotal">
						<td></td><td></td><td colspan="4">Difference ( = A - B )</td>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==1}"><td></td></g:if>
						<td><input type="text"
								name="diffInSales_${i}" class="small50" readonly disabled value="${salesEntryObj.lotterySalesEntry.diffInSales}" />
						</td>
						</g:each>
					</tr>
					</tfoot>
				</table>
				</form>
				
				<div class="row">
					<div class="twelve columns">
						<input id="saveLotterySalesData" type="submit" class="small radius button" value="Save data">
					</div>
				</div>
				
				</section><!-- lottery_sales_section -->

				<section id="main_sales_section">
				<h5>Sales</h5>
				<table id="mainSalesPlusData" class="responsive table-style1 plus numeric">
					<thead>
						<tr>
							<th width="200px">Plus</th>
							<th>Shift 1</th>
							<th>Shift 2</th>
							<th>Total</th>
						</tr>
					</thead>
					<tbody>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Beginning Cash in register</td></g:if>
							<td>
								<g:hiddenField name="salesEntryId_${i}" value="${salesEntryObj.id}" />
								<input type="text" name="beginningCashInRegister_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.beginningCashInRegister}" format="#.00" />' readonly disabled /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Total Sales</td></g:if>
							<td>
								<input type="text" name="totalSalesRevenue_${i}" class="small50 salesEditable" 
								value='<g:formatNumber number="${salesEntryObj.totalSalesRevenue}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Diff In Lotto</td></g:if>
							<td>
								<input type="text" name="diffInLotto_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.diffInLotto}" format="#.00" />' readonly disabled /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Diff In MO</td></g:if>
							<td>
								<input type="text" name="diffInMO_${i}" class="small50 salesEditable" 
								value='<g:formatNumber number="${salesEntryObj.diffInMO}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Paid Ins</td></g:if>
							<td>
								<input type="text" name="paidIns_${i}" class="small50 salesEditable" 
								value='<g:formatNumber number="${salesEntryObj.paidIns}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr id="subtotal"><td>Total Plus</td></g:if>
							<td class="subtotal">
								<input type="text" name="totalPlus_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.totalPlus}" format="#.00" />' readonly disabled /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
					</tbody>
				</table>
				<table id="mainSalesMinsusData" class="responsive table-style1 minus numeric">
					<thead>
						<tr>
							<th width="200px">Minus</th>
							<th>Shift 1</th>
							<th>Shift 2</th>
							<th>Total</th>
						</tr>
					</thead>
					<tbody>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Ending Cash in register</td></g:if>
							<td>
								<input type="text" name="endingCashInRegister_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.endingCashInRegister}" format="#.00" />' readonly disabled /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>TAB CREDIT a/c</td></g:if>
							<td>
								<input type="text" name="tabCredit_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.tabCredit}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Network Revenue / Credit Card</td></g:if>
							<td>
								<input type="text" name="networkRevenue_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.networkRevenue}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>EBT Revenue</td></g:if>
							<td>
								<input type="text" name="ebtRevenue_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.ebtRevenue}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Lottery Cash Paid-out</td></g:if>
							<td>
								<input type="text" name="lotteryCashPaidouts_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.lotteryCashPaidouts}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Tickets Cash Paid-out</td></g:if>
							<td>
								<input type="text" name="ticketPaidouts_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.ticketPaidouts}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Tickets Match</td></g:if>
							<td>
								<input type="text" name="ticketPaidouts_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.ticketMatch}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Moneygram Paid-out</td></g:if>
							<td>
								<input type="text" name="moneyGramPaidouts_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.moneyGramPaidouts}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Total Safe Drops</td></g:if>
							<td>
								<input type="text" name="totalSafeDrops_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.totalSafeDrops}" format="#.00" />' /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr id="subtotal"><td>Total Minus</td></g:if>
							<td class="subtotal">
								<input type="text" name="totalMinus_${i}" class="small50 .subtotal" 
								value='<g:formatNumber number="${salesEntryObj.totalMinus}" format="#.00" />' readonly disabled /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
						<g:each var="salesEntryObj" in="${dailyPaperwork.salesEntries.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<g:if test="${i==0}"><tr><td>Short/Over</td></g:if>
							<td>
								<input type="text" name="shortOver_${i}" class="small50" 
								value='<g:formatNumber number="${salesEntryObj.shortOver}" format="#.00" />' readonly disabled /></td>
						<g:if test="${i==2}"></tr></g:if>
						</g:each>
					</tbody>
				</table>
				
				<div class="row">
					<div class="small-4 columns">
						<a href="#" id="saveMainSalesData" type="submit" class="small radius button">Save data</a>
					</div>
					<div class="small-8 columns" style="vertical-align:middle;text-align:right">
						Bank Deposit:&nbsp;
						<input type="text" id="bank-deposits" value="$2300" readonly disabled />
					</div>
				</div>
				
				</section><!-- end main_sales_section -->
				

				<section id="vendor_paidouts_section">
				<h5>Vendor Paidouts</h5>
				<table class="table-style1 responsive">
					<thead>
						<tr>
							<th width="40%">Name</th>
							<th>Amount</th>
							<th>Tender Type</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<g:each var="expenseObj" in="${dailyPaperwork.expenses.findAll{it.expenseType.name() == 'VENDOR_PAIDOUTS'}.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<tr>
							<td>
								<g:hiddenField name="expenseId_${i}" value="${expenseObj.id}" />
								<g:hiddenField name="expenseType_${i}" value="${expenseObj.expenseType}" />
								<input type="text" name="expenseName_${i}" class="small200"
								value="${expenseObj.name}" placeholder="eg: Plumbing" /></td>
							<td><input type="text" name="expenseAmount_${i}" class="small50"
								value="${expenseObj.amount}" placeholder="eg. $100" /></td>
							<td>
								<g:select name="expenseTenderType_${i}" from="${com.nashtechnology.backoffice.TenderType?.values()}"
                          		keys="${com.nashtechnology.backoffice.TenderType.values() }"
                          		value="${expenseObj.tenderType}" />
                          	</td>
							<td>
								<a href="#" class="tiny radius button" id="delete_0">Delete Row</a></td>
						</tr>
						</g:each>
					</tbody>
				</table>
				<a href="#" class="small radius button add" id="add_vendor_paidouts">Add New Paidouts</a>
				<a href="#" class="small radius button" id="saveVendorPaidoutsData">Save Vendor Paidouts</a>
				</section>
				
				<section id="maintenance_expense_section">
				<h5>Maintenance Expenses</h5>
				<table class="table-style1 responsive">
					<thead>
						<tr>
							<th width="40%">Name</th>
							<th>Amount</th>
							<th>Tender Type</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<g:each var="expenseObj" in="${dailyPaperwork.expenses.findAll{it.expenseType.name() == 'MAINTENANCE'}.sort{a,b-> a.id.compareTo(b.id)}}" status="i">
						<tr>
							<td>
								<g:hiddenField name="expenseId_${i}" value="${expenseObj.id}" />
								<g:hiddenField name="expenseType_${i}" value="${expenseObj.expenseType}" />
								<input type="text" name="expenseName_${i}" class="small200"
								value="${expenseObj.name}" placeholder="eg: Plumbing" /></td>
							<td><input type="text" name="expenseAmount_${i}" class="small50"
								value="${expenseObj.amount}" placeholder="eg. $100" /></td>
							<td>
								<g:select name="expenseTenderType_${i}" from="${com.nashtechnology.backoffice.TenderType?.values()}"
                          		keys="${com.nashtechnology.backoffice.TenderType.values() }"
                          		value="${expenseObj.tenderType}" />
							</td>
							<td>
								<a href="#" class="tiny radius button" id="delete_0">Delete Row</a></td>
						</tr>
						</g:each>
					</tbody>
				</table>
				<a href="#" class="small radius button add" id="add_maintenance_expenses">Add New Expense</a>
				<a href="#" class="small radius button" id="saveMaintenanceExpensesData">Save Maintenance Expenses</a>
				</section>

				<div class="main_menu">
					<a href="#" id="completeBottom" class="small radius button">Complete daily paperwork</a>
				</div>
				
				
			</div>

		</div>
	
</body>
</html>
