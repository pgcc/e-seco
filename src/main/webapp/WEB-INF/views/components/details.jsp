<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components: Details of ${component.name}
    </jsp:attribute>


    <jsp:attribute name="stylesheets">
        <link rel="stylesheet"
              href="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.css"/>">
        <style type="text/css">
            #tbl-rating-avg-values {
                border-radius: 4px !important;
            }

            #tbl-rating-avg-values .progress {
                margin-bottom: 0 !important;
            }
        </style>
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v4.min.js" />"></script>
        <script type="text/javascript"
                src="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.js" />"></script>
        <script type="text/javascript">
            // Get JSON Data for visualizations
            var componentContextJson = JSON.parse('${componentContextInfoJSON}');

            /***********************************************/
            /* DEPENDENCIES VISUALIZATION                  */
            /***********************************************/
            function showDependenciesVisualization() {
                var treemapData = mountDataToTreemap(componentContextJson);
                drawTreemap(treemapData);
            };

            function mountDataToTreemap(itemData) {
                var treemapData = {
                    "name": itemData.wsInternalClass,
                    "size": null,
                    "children": null
                };

                // If it has childs
                if (itemData.usedEsecoCoreServicesList || itemData.usedEsecoWorkflowServicesList) {
                    var children = [];

                    // Seek for Eseco Core Services Childs
                    if (itemData.usedEsecoCoreServicesList && itemData.usedEsecoCoreServicesList.length > 0) {
                        $.each(itemData.usedEsecoCoreServicesList, function (i, item) {
                            var esecoCoreServiceData = {
                                "name": item,
                                "wsInternalClass": item
                            };
                            var childrenData = mountDataToTreemap(esecoCoreServiceData);
                            children.push(childrenData);
                        });
                    }

                    // Seek for Eseco Workflow Services Childs
                    if (itemData.usedEsecoWorkflowServicesList && itemData.usedEsecoWorkflowServicesList.length > 0) {
                        $.each(itemData.usedEsecoWorkflowServicesList, function (i, item) {
                            var childrenData = mountDataToTreemap(item);
                            children.push(childrenData);
                        });
                    }

                    treemapData.children = children;

                } else {
                    treemapData.size = 5;
                }

                return treemapData;
            }

            $("#btn-visualize-dependencies").on("click", function () {
                $('#modal-visualize-dependencies').modal();
                showDependenciesVisualization();
            });


            /***********************************************/
            /* USAGE VISUALIZATIONS                        */
            /***********************************************/
            $("#btn-visualize-activities-using").on("click", function () {
                $('#modal-visualize-activities-using').modal();
            });

            $("#btn-visualize-workflows-using").on("click", function () {
                $('#modal-visualize-workflows-using').modal();
            });

            $("#btn-visualize-experiments-using").on("click", function () {
                $('#modal-visualize-experiments-using').modal();
            });

            $("#btn-visualize-researchers-using").on("click", function () {
                $('#modal-visualize-researchers-using').modal();
            });


            /***********************************************/
            /* RATINGS VISUALIZATIONS                      */
            /***********************************************/
            $("#btn-visualize-ratings").on("click", function () {
                $('#modal-visualize-ratings').modal();
            });

            $("#tbl-rating-avg-values").find(".progress-bar").each(function () {
                if (parseInt($(this).data("value")) <= 3) {
                    $(this).addClass("progress-bar-danger");
                } else if (parseInt($(this).data("value")) > 3 && parseInt($(this).data("value")) < 7) {
                    $(this).addClass("progress-bar-warning");
                } else if (parseInt($(this).data("value")) >= 7) {
                    $(this).addClass("progress-bar-success");
                }
            });
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="<c:url value="/components/details/${type}/${component.id}"/>">Details of ${component.name}</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Details: <strong>${componentContextInfo.name}</strong></h2>

                <div class="row">
                    <div class="col col-xs-12 col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Component Info</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="list-group lst-data-value">
                                    <li class="list-group-item">
                                        <span>Id</span>
                                        <span>${componentContextInfo.id}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Name</span>
                                        <span>${componentContextInfo.name}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Type</span>
                                        <span>${componentContextInfo.type}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Author</span>
                                        <span>${componentContextInfo.author}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Date Created</span>
                                        <span><fmt:formatDate pattern="yyyy-MM-dd"
                                                              value="${componentContextInfo.dateCreated}"/></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Date Last Updated</span>
                                        <c:choose>
                                            <c:when test="${componentContextInfo.dateUpdated}">
                                                <span><fmt:formatDate pattern="yyyy-MM-dd"
                                                                      value="${componentContextInfo.dateUpdated}"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>Never Updated</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="col col-xs-12 col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Workflow Service Info</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="list-group lst-data-value">
                                    <li class="list-group-item">
                                        <span>Type</span>
                                        <span>${componentContextInfo.wsType}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Nature</span>
                                        <span>${componentContextInfo.wsNature}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Location</span>
                                        <span>${componentContextInfo.wsUrl}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Description</h3>
                            </div>
                            <div class="panel-body">
                                <p>${component.workflowService.description}</p>
                            </div>
                        </div>
                    </div>

                    <div class="col col-xs-12 col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Usage</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="list-group lst-data-value">
                                    <li class="list-group-item">
                                        <span>Activities Using</span>
                                        <span>${componentContextInfo.activitiesUsingCount}
                                            <button id="btn-visualize-activities-using" class="btn btn-xs btn-info"
                                                    type="button">View all</button>
                                        </span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Workflows Using</span>
                                        <span>${componentContextInfo.workflowsUsingCount}
                                            <button id="btn-visualize-workflows-using" class="btn btn-xs btn-info"
                                                    type="button">View all</button>
                                        </span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Experiments Using</span>
                                        <span>${componentContextInfo.experimentsUsingCount}
                                            <button id="btn-visualize-experiments-using" class="btn btn-xs btn-info"
                                                    type="button">View all</button>
                                        </span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Researchers Using</span>
                                        <span>${componentContextInfo.researchersUsingCount}
                                            <button id="btn-visualize-researchers-using" class="btn btn-xs btn-info"
                                                    type="button">View all</button>
                                        </span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Most Common Area</span>
                                        <span>${componentContextInfo.mostCommonArea}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Date Last Used</span>
                                        <span>
                                            <c:choose>
                                                <c:when test="${componentContextInfo.dateLastUsed}">
                                                <span><fmt:formatDate pattern="yyyy-MM-dd"
                                                                      value="${componentContextInfo.dateLastUsed}"/></span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span>Never Used</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col col-xs-12 col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Ratings</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="list-group lst-data-value">
                                    <li class="list-group-item">
                                        <span>Total Ratings </span>
                                        <span>${componentContextInfo.totalRatings}
                                            <button id="btn-visualize-ratings" class="btn btn-xs btn-info"
                                                    type="button">View all</button>
                                        </span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Approvals</span>
                                        <span>${componentContextInfo.totalApprovals}</span>
                                    </li>
                                </ul>

                                <table id="tbl-rating-avg-values" class="table table-bordered">
                                    <tr>
                                        <td width="60px;">Documentation</td>
                                        <td>
                                            <div class="progress">
                                                <div class="progress-bar" role="progressbar"
                                                     data-value="${componentContextInfo.avgValueDocumentation}"
                                                     aria-valuenow="${componentContextInfo.avgValueDocumentation}"
                                                     aria-valuemin="0"
                                                     aria-valuemax="10"
                                                     style="width: ${componentContextInfo.avgValueDocumentation}0%">
                                                        ${componentContextInfo.avgValueDocumentation}
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="60px;">Ease of Use</td>
                                        <td>
                                            <div class="progress">
                                                <div class="progress-bar" role="progressbar"
                                                     data-value="${componentContextInfo.avgValueEaseOfUse}"
                                                     aria-valuenow="${componentContextInfo.avgValueEaseOfUse}"
                                                     aria-valuemin="0"
                                                     aria-valuemax="10"
                                                     style="width: ${componentContextInfo.avgValueEaseOfUse}0%">
                                                        ${componentContextInfo.avgValueEaseOfUse}
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="60px;">Reliability</td>
                                        <td>
                                            <div class="progress">
                                                <div class="progress-bar" role="progressbar"
                                                     data-value="${componentContextInfo.avgValueReliability}"
                                                     aria-valuenow="${componentContextInfo.avgValueReliability}"
                                                     aria-valuemin="0"
                                                     aria-valuemax="10"
                                                     style="width: ${componentContextInfo.avgValueReliability}0%">
                                                        ${componentContextInfo.avgValueReliability}
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="60px;">Performance</td>
                                        <td>
                                            <div class="progress">
                                                <div class="progress-bar" role="progressbar"
                                                     data-value="${componentContextInfo.avgValuePerformance}"
                                                     aria-valuenow="${componentContextInfo.avgValuePerformance}"
                                                     aria-valuemin="0"
                                                     aria-valuemax="10"
                                                     style="width: ${componentContextInfo.avgValuePerformance}0%">
                                                        ${componentContextInfo.avgValuePerformance}
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="60px;">Disponibility</td>
                                        <td>
                                            <div class="progress">
                                                <div class="progress-bar" role="progressbar"
                                                     data-value="${componentContextInfo.avgValueDisponibility}"
                                                     aria-valuenow="${componentContextInfo.avgValueDisponibility}"
                                                     aria-valuemin="0"
                                                     aria-valuemax="10"
                                                     style="width: ${componentContextInfo.avgValueDisponibility}0%">
                                                        ${componentContextInfo.avgValueDisponibility}
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>

                                <div class="text-center">
                                    <a class="btn btn-info" href="<c:url value="/components/details/${type}/${component.id}/ratings-visualization"/>">Visualize</a>

                                    <a class="btn btn-info" href="<c:url value="/components/actions/workflow-services/invite-rating/${component.id}"/>">Invite for Rating</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col col-xs-12 col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Internal Metrics</h3>
                            </div>
                            <div class="panel-body">
                                <c:choose>
                                    <c:when test="${type == 2}">
                                        <ul class="list-group lst-data-value">
                                            <li class="list-group-item">
                                                <span>Internal Class</span>
                                                <span>${componentContextInfo.wsInternalClass}</span>
                                            </li>
                                            <li class="list-group-item">
                                                <span>Parameters</span>
                                                <span>${componentContextInfo.wsInternalClassInternalMetrics.parametersCount}</span>
                                            </li>
                                            <li class="list-group-item">
                                                <span>Methods</span>
                                                <span>${componentContextInfo.wsInternalClassInternalMetrics.methodsCount}</span>
                                            </li>
                                            <li class="list-group-item">
                                                <span>Total Services Used</span>
                                                <span>${componentContextInfo.wsInternalClassInternalMetrics.servicesCount}</span>
                                            </li>
                                            <li class="list-group-item">
                                                <span>E-Seco Core Services Used</span>
                                                <span>${componentContextInfo.wsInternalClassInternalMetrics.esecoCoreServicesCount}</span>
                                            </li>
                                            <li class="list-group-item">
                                                <span>E-Seco Workflow Services Used</span>
                                                <span>${componentContextInfo.wsInternalClassInternalMetrics.esecoWorkflowServicesCount}</span>
                                            </li>
                                        </ul>
                                        <div class="text-center">
                                            <button id="btn-visualize-dependencies" class="btn btn-info" type="button">
                                                Visualize Dependencies
                                            </button>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-center">No internal metrics is avaiable to external services</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- MODAL VISUALIZE DEPENDENCIES -->
        <div class="modal fade" id="modal-visualize-dependencies" tabindex="-1" role="dialog"
             aria-labelledby="modal-visualize-dependencies-label">
            <div class="modal-dialog width-95" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="modal-visualize-dependencies-label">Dependencies of
                            <strong>${component.name}</strong>
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div style="overflow: auto;width: 850px;height: 550px;">
                                            <div id="chart"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL VISUALIZE ACTIVITIES USING -->
        <div class="modal fade" id="modal-visualize-activities-using" tabindex="-1" role="dialog"
             aria-labelledby="modal-visualize-activities-using-label">
            <div class="modal-dialog width-95" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="modal-visualize-activities-using-label">Activities Using
                            <strong>${component.name}</strong>
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>Name</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="activity" items="${activitiesList}">
                                                <tr>
                                                    <td>${activity.name}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL VISUALIZE WORKFLOWS USING -->
        <div class="modal fade" id="modal-visualize-workflows-using" tabindex="-1" role="dialog"
             aria-labelledby="modal-visualize-workflows-using-label">
            <div class="modal-dialog width-95" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="modal-visualize-workflows-using-label">Workflows Using
                            <strong>${component.name}</strong>
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>Name</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="experiment" items="${workflowsList}">
                                                <tr>
                                                    <td>${experiment.name}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL VISUALIZE EXPERIMENTS USING -->
        <div class="modal fade" id="modal-visualize-experiments-using" tabindex="-1" role="dialog"
             aria-labelledby="modal-visualize-experiments-using-label">
            <div class="modal-dialog width-95" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="modal-visualize-experiments-using-label">Experiments Using
                            <strong>${component.name}</strong>
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>Name</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="experiment" items="${experimentsList}">
                                                <tr>
                                                    <td>${experiment.name}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL VISUALIZE ACTIVITIES USING -->
        <div class="modal fade" id="modal-visualize-researchers-using" tabindex="-1" role="dialog"
             aria-labelledby="modal-visualize-researchers-using-label">
            <div class="modal-dialog width-95" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="modal-visualize-researchers-using-label">Researchers Using
                            <strong>${component.name}</strong>
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>Name</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="researcher" items="${researchersList}">
                                                <tr>
                                                    <td>${researcher.displayName}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL VISUALIZE RATINGS -->
        <div class="modal fade" id="modal-visualize-ratings" tabindex="-1" role="dialog"
             aria-labelledby="modal-visualize-ratings-label">
            <div class="modal-dialog width-95" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="modal-visualize-ratings-label">Ratings for
                            <strong>${component.name}</strong>
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th class="text-center" style="width:150px;">Date</th>
                                                <th class="text-center" style="width:60px;">Approved?</th>
                                                <th class="text-center" style="width:100px;">Documentation</th>
                                                <th class="text-center" style="width:100px;">Ease of Use</th>
                                                <th class="text-center" style="width:100px;">Reliability</th>
                                                <th class="text-center" style="width:100px;">Performance</th>
                                                <th class="text-center" style="width:100px;">Disponibility</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="rating" items="${ratingsList}">
                                                <tr>
                                                    <td>${rating.rater.displayName}</td>
                                                    <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd"
                                                                        value="${rating.date}"/></td>
                                                    <td class="text-center">${rating.approved}</td>
                                                    <td class="text-center">${rating.valueDocumentation}</td>
                                                    <td class="text-center">${rating.valueEaseOfUse}</td>
                                                    <td class="text-center">${rating.valueReliability}</td>
                                                    <td class="text-center">${rating.valuePerformance}</td>
                                                    <td class="text-center">${rating.valueDisponibility}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </jsp:body>
</t:layout-app>