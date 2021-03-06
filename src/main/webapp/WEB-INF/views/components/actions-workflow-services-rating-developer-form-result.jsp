<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Actions - Workflow Services - Rating ${workflowService.component.name} - Results
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
            <li><a href="<c:url value="/components/actions/workflow-services/developer-rating/${workflowService.component.id}"/>">Developer Rating</a></li>
            <li><a href="#">Result</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Actions - Workflow Services - Rating ${workflowService.component.name}</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Rating Successfully</h3>
                    </div>
                    <div class="panel-body">
                        <p>Rated!</p>
                        <p>
                            <a href="<c:url value="/components/details/${workflowService.component.type.id}/${workflowService.component.id}"/>">
                                Go to details of the Service
                            </a>
                        </p>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>