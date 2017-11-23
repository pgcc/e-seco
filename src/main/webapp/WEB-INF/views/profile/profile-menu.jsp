<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li><a href="<c:url value="/profile"/>"><i class="fa fa-user"></i> Basic User Information</a></li>

    <c:if test="${(sessionScope.role_admin || sessionScope.role_researcher) && sessionScope.logged_user.agent.researcher != null}">
        <li><a href="<c:url value="/researchers/${sessionScope.logged_user.agent.researcher.id}"/>"><i class="fa fa-id-card-o"></i> Researcher Profile</a></li>
        </c:if>

    <c:if test="${(sessionScope.role_admin || sessionScope.role_researcher) && sessionScope.logged_user.agent.researcher == null}">
        <li><a href="<c:url value="/researchers/add"/>"><i class="fa fa-id-card-o"></i> Add Researcher Profile</a></li>
        </c:if>

    <c:if test="${(sessionScope.role_admin || sessionScope.role_developer) && sessionScope.logged_user.agent.developer != null}">
        <li><a href="<c:url value="/developers/me"/>"><i class="fa fa-id-card-o"></i> Developer Profile</a></li>
        </c:if>

    <c:if test="${(sessionScope.role_admin || sessionScope.role_developer) && sessionScope.logged_user.agent.developer == null}">
        <li><a href="<c:url value="/developers/add"/>"><i class="fa fa-id-card-o"></i> Add Developer Profile</a></li>
    </c:if>

</ul>