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

					});
</script>
</head>
<body>

	<div id='calendar'></div>

</body>
</html>
