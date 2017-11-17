<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/disciplines"/>">
            <i class="fa fa-th"></i> Disciplines
        </a>
    </li>
    <li><a href="<c:url value="/disciplines/add"/>">
            <i class="glyphicon glyphicon-plus-sign"></i> Add Discipline
        </a>
    </li>
    <c:if test="${discipline != null}">
        <li>
            <a href="<c:url value="/disciplines/${discipline.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
    </c:if>
</ul>