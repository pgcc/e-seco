<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments/workflowExecutions"/>">
            <i class="fa fa-th"></i> Workflow Executions
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/workflowExecutions/add"/>">
            <i class="fa fa-plus-circle"></i> Add Workflow Execution
        </a>
    </li>    
    <c:if test="${workflowExecution != null}">
        <li>
            <a href="<c:url value="/experiments/workflowExecutions/${workflowExecution.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
    </c:if>
</ul>