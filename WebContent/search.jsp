<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="nihfoa" uri="http://icts.uiowa.edu/nihfoa"%>

<html>
<head>
</head>
<body>
<c:import url="header.jsp" />
<h2>Search:</h2>

<c:choose>
	<c:when test="${empty param.submit}">
		<form action="search.jsp" method="post">
		<table>
			<tr>
				<td>
				<table border=1 align=left>
					<tr>
						<th align=left>Query</th>
						<td><input type="text" name="query" size="40" value=""></td>
					</tr>
					<tr>
						<th align=left>Text to Search</th>
						<td><select name="mode">
							<option value="purpose">Title and Purpose</option>
							<option value="content">Full Text</option>
						</select></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><input type="submit" name="submit" value="Search"> <input type="submit" name="submit" value="Cancel"></td>
			</tr>
		</table>
		</form>
	</c:when>
	<c:when test="${param.submit == 'Cancel'}">
		<c:redirect url="index.jsp" />
	</c:when>
	<c:when test="${param.submit == 'Search'}">
		<c:choose>
			<c:when test="${empty param.mode}">
				<c:set var="mode" value="content"/>
			</c:when>
			<c:otherwise>
				<c:set var="mode" value="${param.mode}"/>
			</c:otherwise>
		</c:choose>
		<h3>Search Results:</h3>
		<p>search request: <c:out value="${param.query}" /></p>
		<table border=1 align=left>
			<tr>
				<th>Solicitation</th>
				<th>Title</th>
				<th>Score</th>
			</tr>
			<lucene:search lucenePath="/Users/eichmann/NIH_FOA_Index" queryParserName="boolean" queryString="${param.query}" label="${mode}">
					<lucene:searchIterator>
						<c:set var="id"><lucene:hit label="id" /></c:set>
						<tr>
							<nihfoa:guideDoc ID="${id}">
								<td><nihfoa:guideDocDocNum /></td>
								<td><a href="<nihfoa:guideDocGuideLink/>"><nihfoa:guideDocTitle /></a></td>
								<td><lucene:hit label="score" /></td>
							</nihfoa:guideDoc>
						</tr>
					</lucene:searchIterator>
				</lucene:search>
		</table>
	</c:when>
	<c:otherwise>
		A task is required for this function.
	</c:otherwise>
</c:choose>

<c:import url="footer.jsp" />
</body>
</html>
