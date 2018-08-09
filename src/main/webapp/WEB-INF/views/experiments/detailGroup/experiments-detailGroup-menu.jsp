<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments/detailGroup"/>">
            <i class="fa fa-th"></i> Details Group
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/detailGroup/add"/>">
            <i class="fa fa-plus-circle"></i> Add Detail Group
        </a>
    </li>
    <c:if test="${detailGroup != null}">
        <li>
            <a href="<c:url value="/experiments/detailGroup/${detailGroup.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
    </c:if>
</ul>