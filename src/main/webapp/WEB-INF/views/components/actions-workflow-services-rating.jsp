<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Compositions - Workflow Services
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
            <li><a href="<c:url value="/components/actions/workflow-services/ratings"/>">Ratings</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Actions - Workflow Services - Ratings</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Open Invitations</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>Workflow Service</th>
                                <th class="text-center" style="width:130px;">Type</th>
                                <th style="width:130px;">Author</th>
                                <th class="text-center" style="width:130px;">Date Created</th>
                                <th style="width:300px;">Description</th>
                                <th class="text-center" style="width:60px;">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="service" items="${services_workflow_list}">
                                <tr>
                                    <td><c:out value="${service.component.name}"/></td>
                                    <td class="text-center"><c:out value="${service.type}"/></td>
                                    <td><c:out value="${service.component.author.agent.name}"/></td>
                                    <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd"
                                                                            value="${service.component.dateCreated}"/></td>
                                    <td><c:out value="${service.shortDescription}"/></td>
                                    <td>
                                        <a class="btn btn-xs btn-primary"
                                           href="<c:url value="/components/details/2/${service.component.id}"/>">Explore</a>
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