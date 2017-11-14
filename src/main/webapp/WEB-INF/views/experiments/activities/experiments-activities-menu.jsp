<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments/activities"/>">
            <i class="fa fa-th"></i> Overview
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/activityExecutions"/>">
            <i class="fa fa-plus-circle"></i> Add Activity
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/activityExecutions"/>">
            <i class="fa fa-list"></i> Activity Executions
        </a>
    </li>
</ul>