<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments/workflows"/>">
            <i class="fa fa-th"></i> Overview
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/workflows/add"/>">
            <i class="fa fa-plus-circle"></i> Add Workflow
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/workflowExecutions"/>">
            <i class="fa fa-list"></i> Workflow Executions
        </a>
    </li>
</ul>