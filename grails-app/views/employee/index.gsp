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

.fc-border-separate th,.fc-border-separate td {
	cursor: pointer;
}

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
$(document).ready(function() {
	$( "#add_employee" ).dialog({
		autoOpen: false
	});
	registerAddButton();
	registerSaveButton();
});
	
function registerAddButton() {
	$('#addEmployeeButton').click(function(){
		$('#add_employee').dialog( "open" );
	});
}
	
function registerSaveButton() {
	// save hourly sales data
	$('#saveEmployeeButton').click(function(){
		console.log('add employee data');

		var loaderId = "loader_100";
		startLoader($(this), loaderId);

		var employeeParam = new Object();
		employeeParam.firstName = $('#add_employee form').find('input[name^=firstName]').val();
		employeeParam.lastName = $('#add_employee form').find('input[name^=lastName]').val();
		employeeParam.ssn = $('#add_employee form').find('input[name^=ssn]').val();
		employeeParam.dateHired = $('#add_employee form').find('input[name^=dateHired]').val();
		employeeParam.address = $('#add_employee form').find('input[name^=address]').val();
		employeeParam.phone = $('#add_employee form').find('input[name^=phone]').val();
		employeeParam.email = $('#add_employee form').find('input[name^=email]').val();
		
		// call backend to save
		$.ajax({
			  type: "POST",
			  dataType: "json",
			  url: "${g.createLink(controller:'employee', action:'add')}",
			  data : { employeeParam : JSON.stringify(employeeParam) },
			  success : function(obj) {
			  		console.log('saved data.');
					ajaxSuccess(loaderId);
			  },
			  error : function(obj) {
					console.log('error occured.');
					ajaxError(loaderId);
			  }
		});//end ajax

		return false;
		
	});//end click event
}
</script>
</head>
<body>
	<div class="row">
		<div class="small-12 columns">

			<h1>
				<g:message message="${companyName}" />
			</h1>
			<h3>Employee Administrator</h3>
			<h4 class="subhead">See the list of all employees.</h4>

			<pre>Time sheet entry for all employees.</pre>

			<hr />

			<table id="employee-tbl">
				<thead>
					<tr>
						<th>Hired Date</vth>
						<th>First Name</th>
						<th>Last Name</th>
						<th>SSN</th>
						<th>Email</th>
						<th>Active</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<g:each var="employee"
						in="${employeeList.sort{a,b-> a.firstName.compareTo(b.firstName)}}"
						status="i">
						<tr>
							<td><g:hiddenField name="employee_id_${i}"
									value="${employee.id}" /> <g:formatDate
									format="EEEE MMM, dd, yyyy" date="${employee.dateHired}" /></td>
							<td>
								${employee.firstName}
							</td>
							<td>
								${employee.lastName}
							</td>
							<td>
								${employee.ssn}
							</td>
							<td>
								${employee.email}
							</td>
							<td>
								${employee.active}
							</td>
							<td><a href="#" class="tiny button">EDIT</a></td>
						</tr>
					</g:each>
				</tbody>
			</table>

			<div class="row" style="padding: 20px;">
				<a href="#" id="addEmployeeButton" class="small button">Add
					Employee</a>
			</div>

		</div>
	</div>
	
<div id="add_employee">
	<form action="" >
		<table>
			<tr>
				<td>First name:</td>
				<td><input type="text" name="firstName" /></td>
			</tr>
			<tr>
				<td>Last name:</td>
				<td><input type="text" name="lastName" /></td>
			</tr>
			<tr>
				<td>SSN:</td>
				<td><input type="text" name="ssn" /></td>
			</tr>
			<tr>
				<td>Hired Date:</td>
				<td><input type="text" name="dateHired" /></td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><input type="text" name="address" /></td>
			</tr>
			<tr>
				<td>Phone:</td>
				<td><input type="text" name="phone" /></td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input type="text" name="email" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" id="saveEmployeeButton" value="Save" /></td>
			</tr>
			
		</table>
	</form>
</div>
</body>
</html>
