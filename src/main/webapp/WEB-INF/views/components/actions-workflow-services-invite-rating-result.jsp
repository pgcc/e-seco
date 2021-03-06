<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Actions - Workflow Services - <strong>${component.name}</strong> - Invite for Rating - Results
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
            <li><a href="<c:url value="/components/details/2/${component.id}"/>">${component.name}</a>
            </li>
            <li><a href="<c:url value="/components/actions/workflow-services/invite-rating/${component.id}"/>">Invite
                for Rating</a></li>
            <li><a href="#">Results</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Actions - Workflow Services - <strong>${component.name}</strong> - Invite for Rating</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Invitation Results</h3>
                    </div>
                    <div class="panel-body">
                        <p>Ok, <strong>${totalInvitations}</strong> researchers were successfully invited.</p>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>