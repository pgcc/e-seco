<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li><a href="<c:url value="/support"/>"><i class="fa fa-th"></i> Overview</a></li>

    <li>
        <a href="#"><i class="fa fa-life-ring"></i> Basic</a>
        <ul>
            <li><a href="<c:url value="/support/terms-of-use"/>"><i class="fa fa-file-text-o"></i> Terms of Use</a></li>
            <li><a href="<c:url value="/support/privacy-policy"/>"><i class="fa fa-file-text-o"></i> Privacy Policy</a></li>
        </ul>
    </li>

    <c:if test="${sessionScope.role_admin || sessionScope.role_researcher}">
        <li>
            <a href="#"><i class="fa fa-flask"></i> Support for Researchers</a>
            <ul>
                <li><a href="<c:url value="/support/researchers/first-steps"/>"><i class="fa fa-play-circle"></i> First Steps</a></li>
            </ul>
        </li>
    </c:if>

    <c:if test="${sessionScope.role_admin || sessionScope.role_developer}">
        <li>
            <a href="#"><i class="fa fa-wrench"></i> Support for Developers</a>
            <ul>
                <li><a href="<c:url value="/support/developers/guidelines"/>"><i class="fa fa-book"></i> Guidelines</a></li>
            </ul>
        </li>
    </c:if>
</ul>