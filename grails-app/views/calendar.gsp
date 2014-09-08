<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="template"/>
		<title>New Quick Way Mart</title>
		
		<link type="text/css" rel="stylesheet" href="${resource(dir: 'css', file: 'fullcalendar.css')}">
		<link type="text/css" rel="stylesheet" media="print" href="${resource(dir: 'css', file: 'fullcalendar.print.css')}">
		
		<script type="text/javascript" src="${resource(dir: 'js/calendar', file: 'moment.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/calendar', file: 'fullcalendar.min.js')}"></script>
		
		<style type="text/css" media="screen">
			

			#page-body h1 {
				text-transform: uppercase;
				font-size: 1.5em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 0em 1em 1.25em 1em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			@media screen and (max-width: 480px) {
				
				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
			
	body {
		margin: 0;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		width: 900px;
		margin: 0px auto;
		padding:20px 0;
	}
	.container {
		max-width: 940px;
	}
		</style>
		
		<script>

	$(document).ready(function() {
		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			defaultDate: '2014-06-12',
			editable: true,
			events: [
				{
					title: 'All Day Event',
					start: '2014-06-01'
				},
				{
					title: 'Long Event',
					start: '2014-06-07',
					end: '2014-06-10'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2014-06-09T16:00:00'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2014-06-16T16:00:00'
				},
				{
					title: 'Meeting',
					start: '2014-06-12T10:30:00',
					end: '2014-06-12T12:30:00'
				},
				{
					title: 'Lunch',
					start: '2014-06-12T12:00:00'
				},
				{
					title: 'Birthday Party',
					start: '2014-06-13T07:00:00'
				},
				{
					title: 'Click for Google',
					url: 'http://google.com/',
					start: '2014-06-28'
				}
			]
		});
		
	});

</script>
	</head>
	<body>
		
		<div id='calendar'></div>
		
	</body>
</html>
