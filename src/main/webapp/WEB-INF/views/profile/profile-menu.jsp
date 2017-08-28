<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li><a href="<c:url value="/profile"/>"><i class="fa fa-user"></i> Basic User Information</a></li>

    <c:if test="${sessionScope.role_admin || sessionScope.role_researcher}">
        <li><a href="<c:url value="/researchers"/>"><i class="fa fa-id-card-o"></i> Researcher Profile</a></li>
    </c:if>

    <c:if test="${sessionScope.role_admin || sessionScope.role_developer}">
        <li><a href="<c:url value="/developers"/>"><i class="fa fa-id-card-o"></i> Developer Profile</a></li>
    </c:if>

</ul>