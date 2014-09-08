<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="New Quick Way Mart"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">

		<!-- Included CSS Files -->
		<!-- Combine and Compress These CSS Files -->
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'globals.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'normalize.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'foundation.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'responsive-tables.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.qtip.min.css')}">
		<!-- End Combine and Compress These CSS Files -->
		<link rel="stylesheet" href="${resource(dir: 'dynamic/css', file: 'app.css')}"> 
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'responsive-tables.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.qtip.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.numeric.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/foundation', file: 'foundation.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/foundation', file: 'foundation.topbar.js')}"></script>
		<g:layoutHead/>
		<g:javascript library="application"/>		
		<r:require module="application"/>
		<r:layoutResources />
		<!--[if lt IE 9]>
  <link rel="stylesheet" href="/css/ie.css">
  <![endif]-->


<!-- IE Fix for HTML5 Tags -->
<!--[if lt IE 9]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
	</head>
	<body rel="${pageProperty( name:'body.rel' )}">
		<!-- top bar -->
		<div class="sticky">
		<nav class="top-bar" data-topbar data-options="sticky_on: large">
		  <ul class="title-area">
		    <li class="name">
		      <h1><a href="#">NQWM Site</a></h1>
		    </li>
		     <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
		    <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
		  </ul>
		
		  <section class="top-bar-section">
		    <!-- Right Nav Section -->
		    <ul class="right">
		      <li class="active"><a href="#">Rohan S.</a></li>
		      <li class="has-dropdown">
		        <a href="#">Sign Out</a>
		        <ul class="dropdown">
		          <li><a href="#">rohan shrestha</a></li>
		        </ul>
		      </li>
		    </ul>
		
		    <!-- Left Nav Section -->
		    <ul class="left">
		      <li><a href="/backoffice/dailySalesEntry/pick">Daily Paperwork</a></li>
		      <li><a href="/backoffice/lotterySalesEntry/admin">Lottery Admin</a></li>
		      <li><g:link url="/backoffice/calendar">Calendar</g:link></li>
		      <li><a href="/backoffice/dailySalesEntry/index">Tickets</a></li>
		      <li><a href="/backoffice/employee/index">Employees</a></li>
		      <li><a href="/backoffice/timeSheetEntry/index">Time Sheet</a></li>
		    </ul>
		  </section>
		</nav>
		</div>
		<div class="container">
	
			<g:layoutBody/>
			
			<div class="footer" role="contentinfo"></div>
			<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
			<r:layoutResources />
			
			<div id="footer">
				Designed @Nash Technology Inc.
			</div>
		
		</div><!-- end container -->
		
		<script>
		    $(document).foundation();
		</script>
	</body>
</html>
