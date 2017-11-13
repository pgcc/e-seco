<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments"/>"><i class="fa fa-list"></i> Experiments</a>
        <ul>
            <li><a href="<c:url value="/experiments/add"/>"><i class="fa fa-plus-circle"></i> Add Experiment</a></li>
                <c:if test="${experiment != null && sessionScope.problem_investigation}">
                <li><a href="<c:url value=""/>"><i class="fa fa-book"></i> Systematic Literature Review</a></li>
                </c:if>
        </ul>
    </li>
    <li>
        <a href="<c:url value="/experiments/workflows"/>"><i class="fa fa-list"></i> Workflows</a>
        <ul>
            <li><a href="<c:url value="/experiments/workflows/add"/>"><i class="fa fa-plus-circle"></i> Add Workflow</a></li>
                <c:if test="${experiment != null && sessionScope.experiment_execution && experiment.workflows.size() > 0}">
                <li><a href="<c:url value="/experiments/${experiment.id}/addProvenance"/>"><i class="fa fa-book"></i> Import Provenance Data</a></li>
                </c:if>
            <li><a href="<c:url value="/experiments/workflowExecutions"/>"><i class="fa fa-list"></i> Workflow Executions</a></li>
        </ul>
    </li>

    <li>
        <a href="<c:url value="/experiments/activities"/>"><i class="fa fa-list"></i> Activities</a>
        <ul>
            <li><a href="<c:url value="/experiments/activityExecutions"/>"><i class="fa fa-list"></i> Activity Executions</a></li>
        </ul>
    </li>

    <li><a href="<c:url value="/experiments/entities"/>"><i class="fa fa-list"></i> Entities</a></li>
</ul>