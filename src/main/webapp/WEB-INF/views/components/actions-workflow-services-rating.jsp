<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Actions - Workflow Services - Rating Invitations
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="#">Actions</a></li>
            <li><a href="#">Workflow Services</a></li>
            <li><a href="<c:url value="/components/actions/workflow-services/rating"/>">Rating Invitations</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Actions - Workflow Services - Rating Invitations</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Open Invitations</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>Workflow Service</th>
                                <th>Researcher</th>
                                <th class="text-center" style="width:130px;">Date Invited</th>
                                <th class="text-center" style="width:130px;">Date Chat</th>
                                <th class="text-center" style="width:60px;">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="invitation" items="${workflowServiceRatingInvitationListOpen}">
                                <tr>
                                    <td><c:out value="${invitation.workflowService.component.name}"/></td>
                                    <td><c:out value="${invitation.rater.displayName}"/></td>
                                    <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd"
                                                                            value="${invitation.dateInvited}"/></td>
                                    <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd"
                                                                            value="${invitation.dateChat}"/></td>
                                    <td>
                                        <a class="btn btn-xs btn-primary"
                                           href="<c:url value="/components/actions/workflow-services/rating/${invitation.id}"/>">Rate!</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>