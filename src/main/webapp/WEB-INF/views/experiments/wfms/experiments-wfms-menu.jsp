<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li>
        <a href="<c:url value="/experiments/wfms"/>">
            <i class="fa fa-th"></i> WFMSs
        </a>
    </li>
    <li>
        <a href="<c:url value="/experiments/wfms/add"/>">
            <i class="fa fa-plus-circle"></i> Add WFMS
        </a>
    </li>
    <c:if test="${wfms != null}">
        <li>
            <a href="<c:url value="/experiments/wfms/${wfms.id}/update"/>">
                <i class="fa fa-refresh"></i> Update
            </a>
        </li>  
    </c:if>
</ul>