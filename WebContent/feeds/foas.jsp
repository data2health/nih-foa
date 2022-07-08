<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="foas" dataSource="jdbc/nih-foa">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM (select * from nih_foa.guide_doc) AS foo;
</sql:query>
{
    "headers": [
        {"value":"primary_ic", "label":"Primary IC"},
        {"value":"doc_num", "label":"Document Number"},
        {"value":"title", "label":"Title"},
        {"value":"purpose", "label":"Purpose"},
        {"value":"rel_date", "label":"Release Date"},
        {"value":"expiration_date", "label":"Expiration Date"}
    ],
    "rows" : 
<c:forEach items="${foas.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
