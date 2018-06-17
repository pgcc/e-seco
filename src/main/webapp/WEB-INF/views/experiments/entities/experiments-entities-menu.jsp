<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments/entities"/>">
            <i class="fa fa-th"></i> Entities
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/entities/add"/>">
            <i class="fa fa-plus-circle"></i> Add Entity
        </a>
    </li>
    <c:if test="${entity != null && entity.author.agent.user.id == sessionScope.logged_user.id}">
        <li>
            <a href="<c:url value="/experiments/entities/${entity.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
    </c:if>
</ul>