<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />


<style type="text/css" media="all">
@import "resources/n3c_login_style.css";
@import "resources/main_style.css";
</style>

<style type="text/css">
table.dataTable thead .sorting_asc {
	background-image: none !important;
}
</style>

<body>

	<jsp:include page="navbar.jsp" flush="true" />

	<div class="container-fluid">
		<h2 class="header-text">
			<img src="images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">Active NIH Funding Announcements
		</h2>
		<div class="row" style="margin: auto; padding-left: 10%; padding-right: 10%; font-size: 16px;">
			<p>These are the active funding announcements from NIH.</p>
		</div>
		<div id="FOAs"></div>
		<jsp:include page="footer.jsp" flush="true" />
	</div>
<script>
$.getJSON("feeds/foas.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="litcovid_publications";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("FOAs");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#litcovid_publications').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[1, 'desc']],
     	columns: [
        	{ data: 'primary_ic', orderable: true },
	       	{ data: 'doc_num', visible: true, orderable: true,
        		render: function ( data, type, row ) {
        			return '<a href="'+ row.guide_link + '"><span style="color:#376076";>' + row.doc_num + '<\/span></a>';
             		}
        		},
        	{ data: 'title', orderable: true },
        	{ data: 'purpose', orderable: true },
        	{ data: 'rel_date', orderable: true },
        	{ data: 'expiration_date', orderable: true }
    	]
	} );

	
});
</script>
</body>



</html>


