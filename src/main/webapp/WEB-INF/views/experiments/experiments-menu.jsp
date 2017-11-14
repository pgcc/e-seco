<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments"/>">
            <i class="fa fa-list"></i> Experiments
        </a>
        <ul>
            <li>
                <a href="<c:url value="/experiments/add"/>">
                    <i class="fa fa-plus-circle"></i> Add Experiment
                </a>
            </li>
        </ul>
    </li>
    <li>
        <a href="<c:url value="/experiments/workflows"/>">
            <i class="fa fa-list"></i> Workflows
        </a>
        <ul>
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
    </li>

    <li>
        <a href="<c:url value="/experiments/activities"/>">
            <i class="fa fa-list"></i> Activities</a>
        <ul>
            <li>
                <a href="<c:url value="/experiments/activityExecutions"/>">
                    <i class="fa fa-list"></i> Activity Executions
                </a>
            </li>
        </ul>
    </li>

    <li>
        <a href="<c:url value="/experiments/entities"/>">
            <i class="fa fa-list"></i> Entities
        </a>
    </li>
</ul>