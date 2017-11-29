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
        <style type="text/css">
            .sort {
                border: none;
                color: #286090;
                background-color: #fff;
            }

            .sort:after {
                display: inline-block;
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
                border-bottom: 5px solid transparent;
                content: "";
                position: relative;
                top: -10px;
                right: -5px;
            }

            .sort.asc:after {
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
                border-top: 5px solid #286090;
                content: "";
                position: relative;
                top: 4px;
                right: -5px;
            }

            .sort.desc:after {
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
                border-bottom: 5px solid #286090;
                content: "";
                position: relative;
                top: -4px;
                right: -5px;
            }
        </style>
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/list.js" />"></script>
        <script type="text/javascript">
            // Table Search
            var options = {
                valueNames: ['service_name', 'service_repository', 'service_type', 'service_description']
            };

            var servicesList = new List('services', options);
        </script>
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

                        <div id="services" class="table-responsive">
                            <div class="row">
                                <div class="col-xs-12 col-sm-6">
                                    <p>
                                        <strong>${fn:length(searchResults)}</strong>
                                        Results for term
                                        <strong>${searchString}</strong>
                                    </p>
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <input class="search form-control" placeholder="Search">
                                    </div>
                                </div>
                            </div>

                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th><button class="sort" data-sort="service_name">Name</button></th>
                                    <th class="text-center" style="width:130px;">
                                        <button class="sort" data-sort="service_repository">Repository</button></th>
                                    <th class="text-center" style="width:130px;">
                                        <button class="sort" data-sort="service_type">Type</button></th>
                                    <th style="width:300px;">Description</th>
                                    <th class="text-center" style="width:60px;">Actions</th>
                                </tr>
                                </thead>
                                <tbody class="list">
                                <c:forEach var="service" items="${searchResults}">
                                    <tr>
                                        <td class="service_name">${service.name}</td>
                                        <td class="service_repository text-center">${service.repositoryName}</td>
                                        <td class="service_type text-center">${service.componentType}</td>
                                        <td>
                                            <p class="service_description text-justify">${service.shortDescription}</p>
                                        </td>
                                        <td class="text-center">
                                            <a class="btn btn-xs btn-info"
                                               href="<c:url value="/components/details/3/${service.serviceIdRepository}"/>">More
                                                Details</a>
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