<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/institutions"/>">
            <i class="fa fa-th"></i> Institutions
        </a>
    </li>
    <li><a href="<c:url value="/institutions/add"/>">
            <i class="glyphicon glyphicon-plus-sign"></i> Add Institution
        </a>
    </li>
    <c:if test="${institution != null}">
        <li>
            <a href="<c:url value="/institutions/${institution.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
    </c:if>
</ul>