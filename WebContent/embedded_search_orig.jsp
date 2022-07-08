<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="nihfoa" uri="http://icts.uiowa.edu/nihfoa"%>

<style type="text/css" media="all">
body {
    font-size: 84%;
    font-family: Arial,Helvetica,sans-serif;
    color: #000;
    margin: 0;
    padding: 0;
    line-height: 1.5em;
}

a {
    text-decoration: none;
}
a:link {
    color: #005a8c;
    text-decoration: none;
}

ul, .block ul, ol {
    margin: 0.5em 0 1em;
    padding: 0 0 0 1.5em;
}

ul, ul li.leaf {
    list-style-image: url(https://test.cd2h.org/themes/danland/images/menu-leaf.png);
}

.item-list ul li, li.leaf {
    margin: 0.15em 0 0.15em .5em;
    padding-bottom: .1em;
}
</style>

<c:choose>
	<c:when test="${empty param.mode}">
		<c:set var="mode" value="content" />
	</c:when>
	<c:otherwise>
		<c:set var="mode" value="${param.mode}" />
	</c:otherwise>
</c:choose>
<ul>
	<lucene:search lucenePath="/Users/eichmann/NIH_FOA_Index" queryParserName="boolean" queryString="${param.query}" label="${mode}">
		<lucene:searchIterator>
			<c:set var="id"><lucene:hit label="id" /></c:set>
			<nihfoa:guideDoc ID="${id}">
				<li><a target="_parent" href="<nihfoa:guideDocGuideLink/>"><nihfoa:guideDocDocNum /></a>: <nihfoa:guideDocTitle /></li>
			</nihfoa:guideDoc>
		</lucene:searchIterator>
	</lucene:search>
</ul>
