<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Explorer - Workflow Services - External
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="<c:url value="#"/>">Explorer</a></li>
            <li><a href="<c:url value="#"/>">Workflow Services</a></li>
            <li><a href="<c:url value="/components/workflow-services/external"/>">External</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Components Explorer - Workflow Services - External</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">List of External Workflow Services</h3>
                    </div>
                    <div class="panel-body">

                        <form action="<c:url value="/components/workflow-services/search" />" method="post">
                            <div class="form-group">
                                <label for="search_string">Search String</label>

                                <div class="input-group">
                                    <div class="input-group-addon"><i class="fa fa-search"></i></div>
                                    <input id="search_string" name="search_string" class="form-control" type="text"
                                           value="${searchString}">

                                    <span class="input-group-btn">
                                        <button class="btn btn-primary">Search!</button>
                                    </span>
                                </div>
                            </div>
                        </form>

                        <c:if test="${searchResults != null}">
                            <hr>
                            <p>
                                <strong>${fn:length(searchResults)}</strong>
                                Results for term
                                <strong>${searchString}</strong>
                            </p>
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>Name</th>
                                    <th class="text-center" style="width:130px;">Repository</th>
                                    <th class="text-center" style="width:130px;">Type</th>
                                    <th style="width:300px;">Description</th>
                                    <th class="text-center" style="width:60px;">Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="service" items="${searchResults}">
                                    <tr>
                                        <td>${service.name}</td>
                                        <td class="text-center">${service.repositoryName}</td>
                                        <td class="text-center">${service.componentType}</td>
                                        <td>
                                            <p class="text-justify">${service.shortDescription}</p>
                                        </td>
                                        <td class="text-center">
                                            <a class="btn btn-xs btn-info" href="<c:url value="/components/details/3/${service.serviceIdRepository}"/>">More Details</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>