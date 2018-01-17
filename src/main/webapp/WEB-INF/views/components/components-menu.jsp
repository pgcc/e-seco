<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
    <li><a href="<c:url value="/components"/>"><i class="fa fa-th"></i> Overview</a></li>

    <li>
        <a href="#"><i class="fa fa-binoculars"></i> Components Explorer</a>
        <ul>
            <li><a href="<c:url value="/components/plugins"/>"><i class="fa fa-plug"></i> Plugins</a></li>
            <li>
                <a href="#"><i class="fa fa-share-alt"></i> Workflow Services</a>
                <ul>
                    <li><a href="<c:url value="/components/workflow-services/internal"/>"><i class="fa fa-certificate"></i> Internal</a></li>
                    <li><a href="<c:url value="/components/workflow-services/external"/>"><i class="fa fa-external-link"></i> External</a></li>
                </ul>
            </li>
        </ul>
    </li>
    <c:if test="${sessionScope.role_admin || sessionScope.role_developer}">
    <li><a href="<c:url value="/components/actions/register"/>"><i class="fa fa-plus"></i> Register Component</a></li>
    <li>
        <a href="#"><i class="fa fa-object-group"></i> Components Composition</a>
        <ul>
            <li><a href="<c:url value="/components/compositions/workflow-services"/>"><i class="fa fa-share-alt"></i> Workflow Services</a></li>
        </ul>
    </li>
    </c:if>
</ul>