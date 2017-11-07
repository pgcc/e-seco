<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li><a href="<c:url value="/experiments"/>"><i class="fa fa-list"></i> List All Experiments</a></li>
    <li><a href="<c:url value="/experiments/wfms"/>"><i class="fa fa-list"></i> List All Wfms</a></li>
    <li><a href="<c:url value="/experiments/workflows"/>"><i class="fa fa-list"></i> List All Workflows</a></li>
    <li><a href="<c:url value="/experiments/workflowExecutions"/>"><i class="fa fa-list"></i> List All Workflow Executions</a></li>
    <li><a href="<c:url value="/experiments/activities"/>"><i class="fa fa-list"></i> List All Activities</a></li>
    <li><a href="<c:url value="/experiments/activityExecutions"/>"><i class="fa fa-list"></i> List All Activity Executions</a></li>
    <li><a href="<c:url value="/experiments/entities"/>"><i class="fa fa-list"></i> List All Entities</a></li>
    <li><a href="<c:url value="/experiments/add"/>"><i class="fa fa-plus-circle"></i> Add New Experiment</a></li>
        <c:if test="${experiment != null && sessionScope.problem_investigation}">
        <li><a href="<c:url value=""/>"><i class="fa fa-book"></i> Systematic Literature Review</a></li>
        </c:if>
        <c:if test="${experiment != null && sessionScope.experiment_execution}">
        <li><a href="<c:url value="/experiments/${experiment.id}/workflows/add"/>"><i class="fa fa-tasks"></i> Add Workflow</a></li>
        </c:if>
        <c:if test="${experiment != null && sessionScope.experiment_execution && experiment.workflows.size() > 0}">
        <li><a href="<c:url value="/experiments/${experiment.id}/addProvenance"/>"><i class="fa fa-book"></i> Import Prevenance Data</a></li>
        </c:if>
</ul>