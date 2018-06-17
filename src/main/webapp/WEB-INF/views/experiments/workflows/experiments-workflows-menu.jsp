<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments/workflows"/>">
            <i class="fa fa-th"></i> Workflows
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/workflows/add"/>">
            <i class="fa fa-plus-circle"></i> Add Workflow
        </a>
    </li>
    <c:if test="${workflow != null && workflow.author.agent.user.id == sessionScope.logged_user.id}">
        <li>
            <a href="<c:url value="/experiments/workflows/${workflow.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
        <li>
            <a href="<c:url value="/experiments/workflowExecutions/add/${workflow.id}"/>">
                <i class="fa fa-plus-circle"></i> Execute
            </a>
        </li>  
    </c:if>


</ul>