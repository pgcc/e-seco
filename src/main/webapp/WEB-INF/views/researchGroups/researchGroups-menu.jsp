<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/researchGroups"/>">
            <i class="fa fa-th"></i> Research Groups
        </a>
    </li>
    <li><a href="<c:url value="/researchGroups/add"/>">
            <i class="glyphicon glyphicon-plus-sign"></i> Add Research Group
        </a>
    </li>
    <c:if test="${researchGroup != null}">
        <li>
            <a href="<c:url value="/researchGroups/${researchGroup.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
    </c:if>
</ul>