<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments/activityExecutions"/>">
            <i class="fa fa-th"></i> Activity Executions
        </a>
    </li> 
    <c:if test="${activityExecution != null}">
        <li>
            <a href="<c:url value="/experiments/activityExecutions/${activityExecution.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
    </c:if>
</ul>