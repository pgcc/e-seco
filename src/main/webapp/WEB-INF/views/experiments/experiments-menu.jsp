<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li><a href="<c:url value="/experiments"/>"><i class="fa fa-list"></i> List All Experiments</a></li>
    <li><a href="<c:url value="/experiments/add"/>"><i class="fa fa-plus-circle"></i> Add New Experiment</a></li>
        <c:if test="${experiment != null && sessionScope.problem_investigation}">
        <li><a href="<c:url value=""/>"><i class="fa fa-book"></i> Systematic Literature Review</a></li>
        </c:if>
        <c:if test="${experiment != null && sessionScope.experiment_execution}">
        <li><a href="<c:url value=""/>"><i class="fa fa-book"></i> Import Prevenance Data</a></li>
        </c:if>
</ul>