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

	<title>NQWM - Scratch Off Administration</title>
	<style type="text/css">
	input[type="number"] {
		width:50px;
		padding:0;
	}
	table thead tr th, table tfoot tr th, table tbody tr td, table tr td, table tfoot tr td {
		font-size:14px;padding: 0.5625rem 0.625rem;
	}
	
	</style>
</head>

<body>
	<div class="row">
		<div class="small-12 columns">
				
				<h1>Scratch Off Administration Page</h1>
				<h4 class="subhead">Displays a list of scratch off currently available in TX Lottery.</h4>

				<pre>Please make changes and hit save when done. Check the current daily paperwork for the changed list.</pre>

				<hr />
				
				<section id="lottery_sales_section">
				
				<h5>Scratch Off List</h5>
				<table id="lottery-tbl" class="responsive table-style1 numeric">
					<thead>
					<tr>
						<th width="30%">Game Name</th>
						<th>Game No</th>
						<th>Price</th>
						<th>Size</th>
						<th>Active</th>
						<th>Box No</th>
					</tr>
					</thead>
					<tbody>
					<g:each var="scratchOff" in="${scratchOffList.sort{a,b-> a.gamePrice.compareTo(b.gamePrice)}}" status="i">
						<tr class="lottery-sales-entry">
							<td width="40%"><g:hiddenField name="id-${scratchOff.gameNumber}" value="${id}" />
							<g:message message="${scratchOff.gameName}" /></td>
							<td><g:message message="${scratchOff.gameNumber}" /></td>
							<td><g:message message="${scratchOff.gamePrice}" /></td>
							<td><g:message message="${scratchOff.gameSize}" /></td>
							<td><g:checkBox name="scratchOff_active_${i}" value="${scratchOff.active=='Y'}" /></td>
							<td><input type="number" value="${scratchOff.boxNo}" name="scratchOff_boxNo_${i}" class="small50" /></td>
						</tr>
					</g:each>
					</tbody>
					<tfoot>
					</tfoot>
				</table>

				<div class="row">
					<div class="twelve columns">
						<input id="saveLotterySalesData" type="submit" class="small radius button" value="Save data">
					</div>
				</div>
				
				</section>
				
				
			</div>

		</div>
	
</body>
</html>
