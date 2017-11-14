<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<ul>
    <li>
        <a href="<c:url value="/experiments"/>">
            <i class="fa fa-th"></i> Overview
        </a>
    </li>            
    <li>
        <a href="<c:url value="/experiments/add"/>">
            <i class="fa fa-plus-circle"></i> Add Experiment
        </a>
    </li>    

    <c:if test="${experiment != null}">
        <li>
            <a href="<c:url value="/experiments/${experiment.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  

        <c:if test="${experiment != null && sessionScope.problem_investigation}">
            <li>
                <a href = "https://parsif.al/" target="_blank">
                    <i class="fa fa-book"></i> Systematic Literature Review
                </a>
            </li> 
        </c:if>

        <c:if test="${sessionScope.experiment_execution}">
            <li>
                <a href="<c:url value="/experiments/${experiment.id}/workflows/add"/>">
                    <i class="fa fa-plus-circle"></i> Add Workflow
                </a>
            </li>
        </c:if>

        <c:if test="${sessionScope.experiment_execution && experiment.workflows.size() > 0}">
            <li>
                <a href="<c:url value="/experiments/${experiment.id}/addProvenance"/>">
                    <i class="glyphicon glyphicon-import"></i> Import Provenance Data
                </a>
            </li> 
        </c:if>

        <c:if test="${!sessionScope.experiment_finished}">
            <li>
                <a href="<c:url value="/experiments/${experiment.id}/experimentPhaseReport/add"/>">
                    <i class="fa fa-arrow-right"></i> Go To Next Phase
                </a>
            </li>
        </c:if>
    </c:if>

</ul>