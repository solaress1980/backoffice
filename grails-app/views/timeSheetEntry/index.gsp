<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="template" />
<title>New Quick Way Mart</title>

<link type="text/css" rel="stylesheet"
	href="${resource(dir: 'css', file: 'fullcalendar.css')}">
<link type="text/css" rel="stylesheet" media="print"
	href="${resource(dir: 'css', file: 'fullcalendar.print.css')}">

<script type="text/javascript"
	src="${resource(dir: 'js/calendar', file: 'moment.min.js')}"></script>
<script type="text/javascript"
	src="${resource(dir: 'js/calendar', file: 'fullcalendar.min.js')}"></script>
<script type="text/javascript"
	src="${resource(dir: 'dynamic/js', file: 'common.js')}"></script>

<style type="text/css" media="screen">
#page-body h1 {
	text-transform: uppercase;
	font-size: 1.5em;
	margin: 0 0 0.3em;
}

#page-body {
	margin: 0em 1em 1.25em 1em;
}

#calendar h2 {
	margin: 0;
	font-size: 6em;
	color: dodgerblue;
}

@media screen and (max-width: 480px) {
	#page-body {
		margin: 0 1em 1em;
	}
	#page-body h1 {
		margin-top: 0;
	}
}
.fc-border-separate th, .fc-border-separate td { cursor:pointer; }
body {
	margin: 0;
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 14px;
}

#calendar {
	width: 900px;
	margin: 0px auto;
	padding: 20px 0;
}

.container {
	max-width: 940px;
}

.fc-grid .fc-day-number {
	font-size: 5em;
	padding: 24px;
	color: dodgerblue;
}

.fc-state-highlight {
	background: lawngreen;
}

.fc-header td.fc-header-left {
	padding: 20px;
}
</style>

<script>
	$(document)
			.ready(
					function() {

						$('#calendar')
								.fullCalendar(
										{
											header : {
												left : 'prev,next today',
												center : 'title',
												right : ''
											},
											defaultDate : new Date(),
											editable : false,
											dayRender : function(date, cell) {
												maxDate = new Date();
												if (date > maxDate) {
													$(cell)
															.addClass(
																	'disabled');
												}
											},
											dayClick : function(date, allDay,
													jsEvent, view) {
												console.log(date);
												var selectedDate = date._i; //gets date in YYYY-MM-DD format

												console
														.log('view daily paperwork for '
																+ selectedDate);
												//call daily paperwork for selectedDate
												window.location = 'http://localhost:8080/backoffice/dailySalesEntry/index?d='
														+ selectedDate;
											}
										});

						registerSaveButton();
					});


function registerSaveButton() {
	// save hourly sales data
	$('#saveButton').click(function(){
		console.log('save employee hours data');

		var loaderId = "loader_100";
		startLoader($(this), loaderId);

	    
	    // accumulate all scratch off ticket sales
		var dailyTimeEntryObjList = [];
		$('#employee-hours-tbl > tbody > tr').each(function( i ) {
			var dailyTimeEntryObj = new Object();
			dailyTimeEntryObj.id = $(this).find('input[name^=dailyTimeEntry_id_]').val();	// get id
			dailyTimeEntryObj.timeEntries = [];
			$(this).find("td:not(':eq(0)')").each(function(i) { 
				var timeEntryObj = new Object();
				timeEntryObj.id = $(this).find('input[name^=timeEntry_id_]').val();
				timeEntryObj.employeeNo = $(this).find('input[name^=timeEntry_employeeNo_]').val();
				timeEntryObj.hoursWorked = $(this).find('input[name^=timeEntry_hoursWorked_]').val();
				dailyTimeEntryObj.timeEntries.push(timeEntryObj);
			});
			console.log('added object: ' + JSON.stringify(dailyTimeEntryObj));
			dailyTimeEntryObjList.push(dailyTimeEntryObj);
		});
		

		// call backend to save
		$.ajax({
			  type: "POST",
			  dataType: "json",
			  url: "${g.createLink(controller:'timeSheetEntry',action:'multiUpdate')}",
			  data: {dailyTimeEntryObjListParam:JSON.stringify(dailyTimeEntryObjList)},
			  success: function(obj){
				  console.log('saved hours data.');
				  ajaxSuccess(loaderId);
			  },
			  error: function(obj){
				  console.log('error occured.');
				  ajaxError(loaderId);
			  }
		});
	});
}

</script>
</head>
<body>
	<div class="row">
	<div class="small-12 columns">
			
		<h1><g:message message="${companyName}" /></h1>
		<h3>Time Sheet Entry - <g:formatDate format="MMM, yyyy" date="${currentMonth.time}"/></h3>
		<h4 class="subhead">Enter times daily here. Failure to enter time will result in pay delay.</h4>

		<pre>Time sheet entry for all employees.</pre>
		
		<hr/>
			
		<div class="row" style="padding:0 20px 20px;">
			<a href="/backoffice/timeSheetEntry/index?m=${previousMonth.get(Calendar.MONTH)+1}&y=${previousMonth.get(Calendar.YEAR)}" class="small button">Previous Month</a>
			<a href="/backoffice/timeSheetEntry/index?m=${nextMonth.get(Calendar.MONTH)+1}&y=${nextMonth.get(Calendar.YEAR)}" class="small button">Next Month</a>
		</div>
		
		<table id="employee-hours-tbl">
			<thead>
				<tr>
					<td>Date/Employee</td>
					<td>Ashish</td>
					<td>Mia</td>
					<td>Kris</td>
					<td>Ruth</td>
				</tr>
			</thead>
			<tbody>
				<g:each var="dailyTimeEntry" in="${timeSheetEntryList.sort{a,b-> a.entryDate.compareTo(b.entryDate)}}" status="i">
				<tr>
					<td>
						<g:hiddenField name="dailyTimeEntry_id_${i}" value="${dailyTimeEntry.id}" />
						<g:formatDate format="EEEE MMM, dd, yyyy" date="${dailyTimeEntry.entryDate}"/>
					</td>
					<g:each var="timeEntry" in="${dailyTimeEntry.timeEntries.sort{a,b-> a.employeeNo.compareTo(b.employeeNo)}}" status="j">
					<td>
						<g:hiddenField name="timeEntry_id_${j}" value="${timeEntry.id}" />
						<g:hiddenField name="timeEntry_employeeNo_${j}" value="${timeEntry.employeeNo}" />
						<input type="text" id="timeEntry_hoursWorked_${j}" name="timeEntry_hoursWorked_${j}" value="${timeEntry.hoursWorked}" />
					</td>
					</g:each>
				</tr>
				</g:each>
			</tbody>
		</table>
		
		<div class="row" style="padding:20px;">
			<a href="#" id="saveButton" class="small button">Save</a>
		</div>
	
	</div>
	</div>
</body>
</html>
