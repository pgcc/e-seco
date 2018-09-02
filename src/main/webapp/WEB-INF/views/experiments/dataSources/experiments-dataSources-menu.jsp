<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li><a href="<c:url value="/experiments/dataSources"/>"><i class="fa fa-database"></i> Data Sources</a></li>
    <li>
        <a href="<c:url value="/experiments/dataSources/add"/>">
            <i class="fa fa-plus-circle"></i> Add Data Source
        </a>
    </li>
    <c:if test="${dataSource != null}">
        <li>
            <a href="<c:url value="/experiments/dataSources/${dataSource.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>
    </c:if>

</ul>
