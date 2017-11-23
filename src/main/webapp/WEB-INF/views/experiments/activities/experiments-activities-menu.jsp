<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments/activities"/>">
            <i class="fa fa-th"></i> Activities
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/activities/add"/>">
            <i class="fa fa-plus-circle"></i> Add Activity
        </a>
    </li>
    <c:if test="${activity != null}">
        <li>
            <a href="<c:url value="/experiments/activityExecutions/${activity.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
    </c:if>
</ul>