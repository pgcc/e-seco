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
        <script type="text/javascript">
            var d3version4 = d3;
            window.d3 = null;
        </script>
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v3.min.js" />"></script>
        <script type="text/javascript">
            var d3version3 = d3;
            window.d3 = null;
        </script>
        <script type="text/javascript"
                src="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.js" />"></script>
        <script type="text/javascript">
            // Get JSON Data for visualizations
            var componentContextJson = JSON.parse('${componentContextInfoJSON}');

            /***********************************************/
            /* DEPENDENCIES VISUALIZATION                  */
            /***********************************************/
            // Treemap
            function showDependenciesVisualization() {
                var width = $("#box-chart-dependencies").css("width");
                width = width.replace("px", "");
                var treemapData = mountDataToTreemap(componentContextJson);
                drawTreemap(treemapData, "#box-chart-dependencies", width);
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

            $("#btn-visualize-dependencies-treemap").on("click", function () {
                showDependenciesVisualization();
            });

            showDependenciesVisualization();

            // Graph
            function showDependenciesGraphVisualization() {
                var target = "#box-chart-dependencies";
                var width = $(target).css("width");
                width = width.replace("px", "");

                var graphData = mountDataToGraph(componentContextJson);

                drawGraph(graphData, target, width);
            };

            function mountDataToGraph(itemData) {
                var data1 = itemData.wsInternalClassInternalMetrics.esecoWorkflowServicesNames;
                var data2 = itemData.wsInternalClassInternalMetrics.esecoCoreServicesNames;

                var graphData = {
                    "nodes": [
                        {
                            "name": itemData.name,
                            "group": 0
                        }
                    ],
                    "links": []
                };

                var groupId = 1;

                $.each(data1, function (i, item) {
                    graphData.nodes.push({
                        "name": item,
                        "group": groupId
                    });
                    graphData.links.push({
                        "source": groupId,
                        "target": 0,
                        "value": 1,
                        "type": "arrow"
                    });

                    groupId++;
                });

                $.each(data2, function (i, item) {
                    graphData.nodes.push({
                        "name": item,
                        "group": groupId
                    });
                    graphData.links.push({
                        "source": groupId,
                        "target": 0,
                        "value": 1,
                        "type": "arrow"
                    });

                    groupId++;
                });


                return graphData;
            }

            $("#btn-visualize-dependencies-graph").on("click", function () {
                showDependenciesGraphVisualization();
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


            /***********************************************/
            /* POPOVERS                                    */
            /***********************************************/
            $('#pop-parameters-names').popover({
                "title": "Parameters names",
                "html": true,
                "placement": "right",
                "template": '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content" style="overflow: auto"></div></div>'
            });

            $('#pop-method-names').popover({
                "title": "Methods names",
                "html": true,
                "placement": "right",
                "template": '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content" style="overflow: auto"></div></div>'
            });

            $('#pop-eseco-core-services-names').popover({
                "title": "E-Seco Core Services names",
                "html": true,
                "placement": "right",
                "template": '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content" style="overflow: auto"></div></div>'
            });

            $('#pop-eseco-workflow-services-names').popover({
                "title": "E-Seco Workflow Services names",
                "html": true,
                "placement": "right",
                "template": '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content" style="overflow: auto"></div></div>'
            });

            $('#pop-rating-documentation-info').popover({
                "title": "Documentation",
                "html": true,
                "placement": "right",
                "content": 'Quality of the documentation provided by the service to aid its usage'
            });

            $('#pop-rating-ease-of-use-info').popover({
                "title": "Ease of Use",
                "html": true,
                "placement": "right",
                "content": 'How easy it is to use the service'
            });

            $('#pop-rating-reliability-info').popover({
                "title": "Reliability",
                "html": true,
                "placement": "right",
                "content": 'How correct is the data returned or the processing results of the service'
            });

            $('#pop-rating-performance-info').popover({
                "title": "Performance",
                "html": true,
                "placement": "right",
                "content": 'How smoothly the service processes, does it takes short or long time to return the data?'
            });

            $('#pop-rating-availability-info').popover({
                "title": "Availability",
                "html": true,
                "placement": "right",
                "content": 'How well the service responds the calls, its always on?'
            });


            /***********************************************/
            /* COMMENTS                                    */
            /***********************************************/

            // Populate Comments Table
            function addCommentToTable(tbody, data, isChild) {
                var photoWidth = isChild ? "50px" : "80px";
                var tr = null;
                tr = $("<tr>").append(
                    $("<td>").css("width", photoWidth).append(
                        $("<img>").addClass("img-responsive img-circle")
                            .attr("src", data.photo)
                            .attr("alt", "Author Photo")
                    ),
                    $("<td>").append(
                        $("<p>").append(
                            $("<strong>").text(data.author),
                            $("<span>").addClass("text-muted text-small").text(" (" + data.date + ")")
                        ),
                        $("<p>").text(data.comment),
                        $("<p>").append(
                            $("<button>").addClass("btn btn-xs btn-info btn-comment-reply")
                                .attr("type", "button")
                                .attr("data-comment_id", data.id)
                                .text("Reply")
                        ),
                        $("<p>").append(
                            $("<table>").addClass("table").attr("id", "tbl-comment-replies-" + data.id)
                                .append(
                                    $("<tbody>").addClass("replies-tbody-" + data.id)
                                )
                        )
                    )
                );

                $(tbody).append(tr);
            }

            <c:forEach var="comment" items="${rootCommentsList}">
            addCommentToTable("#tbl-comments tbody.comments-tbody", {
                "id": "${comment.id}",
                "author": "${comment.commenter.name}",
                "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${comment.date}"/>",
                "photo": "${comment.commenter.photo}",
                "comment": "${comment.content}"
            }, false);

                <c:forEach var="response1" items="${comment.responses}">
                addCommentToTable("#tbl-comment-replies-${response1.parent.id} tbody.replies-tbody-${response1.parent.id}", {
                    "id": "${response1.id}",
                    "author": "${response1.commenter.name}",
                    "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response1.date}"/>",
                    "photo": "${response1.commenter.photo}",
                    "comment": "${response1.content}"
                }, true);

                    <c:forEach var="response2" items="${response1.responses}">
                    addCommentToTable("#tbl-comment-replies-${response2.parent.id} tbody.replies-tbody-${response2.parent.id}", {
                        "id": "${response2.id}",
                        "author": "${response2.commenter.name}",
                        "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response2.date}"/>",
                        "photo": "${response2.commenter.photo}",
                        "comment": "${response2.content}"
                    }, true);

                        <c:forEach var="response3" items="${response2.responses}">
                        addCommentToTable("#tbl-comment-replies-${response3.parent.id} tbody.replies-tbody-${response3.parent.id}", {
                            "id": "${response3.id}",
                            "author": "${response3.commenter.name}",
                            "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response3.date}"/>",
                            "photo": "${response3.commenter.photo}",
                            "comment": "${response3.content}"
                        }, true);

                            <c:forEach var="response4" items="${response3.responses}">
                            addCommentToTable("#tbl-comment-replies-${response4.parent.id} tbody.replies-tbody-${response4.parent.id}", {
                                "id": "${response4.id}",
                                "author": "${response4.commenter.name}",
                                "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response4.date}"/>",
                                "photo": "${response4.commenter.photo}",
                                "comment": "${response4.content}"
                            }, true);

                                <c:forEach var="response5" items="${response4.responses}">
                                addCommentToTable("#tbl-comment-replies-${response5.parent.id} tbody.replies-tbody-${response5.parent.id}", {
                                    "id": "${response5.id}",
                                    "author": "${response5.commenter.name}",
                                    "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response5.date}"/>",
                                    "photo": "${response5.commenter.photo}",
                                    "comment": "${response5.content}"
                                }, true);
                                </c:forEach>

                            </c:forEach>

                        </c:forEach>

                    </c:forEach>

                </c:forEach>

            </c:forEach>

            // Reply Comment
            $(".btn-comment-reply").on("click", function () {
                $("#comment-reply-to").val($(this).data("comment_id"));

                $(".btn-comment-reply").show();
                $(".reply-group").remove();
                $(this).hide();

                var form_group = $("<div>").addClass("form-group reply-group");
                var textarea = $("<textarea>").attr("name", "comment-reply").addClass("form-control");
                var button = $("<button>").addClass("btn btn-success margin-10-top")
                    .text("Confirm")
                    .attr("name", "submit-comment-reply")
                ;

                form_group.append(textarea, button);

                $(this).parent("p").append(form_group);
            });

            // Comment Added
            <c:if test="${not empty comment_inserted}">
            swal("Success", "Comment Added!", "success");
            </c:if>
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="<c:url value="/components/details/${type}/${component.id}"/>">Details of ${component.name}</a>
            </li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Details: <strong>${componentContextInfo.name}</strong></h2>

                <div class="row">
                    <div class="col-xs-12 col-sm-6">
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

                    <div class="col-xs-12 col-sm-6">
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
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Service Usage</h3>
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

                    <div class="col-xs-12 col-sm-6">
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
                                        <td style="width:130px;">
                                            Documentation
                                            <i id="pop-rating-documentation-info"
                                               class="fa fa-info-circle text-info cursor-pointer"></i>
                                        </td>
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
                                        <td>
                                            Ease of Use
                                            <i id="pop-rating-ease-of-use-info"
                                               class="fa fa-info-circle text-info cursor-pointer"></i>
                                        </td>
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
                                        <td>
                                            Reliability
                                            <i id="pop-rating-reliability-info"
                                               class="fa fa-info-circle text-info cursor-pointer"></i>
                                        </td>
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
                                        <td>
                                            Performance
                                            <i id="pop-rating-performance-info"
                                               class="fa fa-info-circle text-info cursor-pointer"></i>
                                        </td>
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
                                        <td>
                                            Availability
                                            <i id="pop-rating-availability-info"
                                               class="fa fa-info-circle text-info cursor-pointer"></i>
                                        </td>
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
                                    <a class="btn btn-info"
                                       href="<c:url value="/components/details/${type}/${component.id}/ratings-visualization"/>">Visualize</a>

                                    <a class="btn btn-info"
                                       href="<c:url value="/components/actions/workflow-services/invite-rating/${component.id}"/>">Invite
                                        for Rating</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Internal Metrics</h3>
                            </div>
                            <div class="panel-body">
                                <c:choose>
                                    <c:when test="${type == 2}">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-6">
                                                <ul class="list-group lst-data-value">
                                                    <li class="list-group-item">
                                                        <span>Internal Class</span>
                                                        <span>${componentContextInfo.wsInternalClass}</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <span>Parameters</span>
                                                        <span>
                                                            ${componentContextInfo.wsInternalClassInternalMetrics.parametersCount}
                                                            <i id="pop-parameters-names"
                                                               class="fa fa-info-circle text-info cursor-pointer"
                                                               data-content="<c:forEach var="name" items="${componentContextInfo.wsInternalClassInternalMetrics.parametersNames}">${name}<br></c:forEach>"
                                                            ></i>
                                                        </span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <span>Methods</span>
                                                        <span>
                                                            ${componentContextInfo.wsInternalClassInternalMetrics.methodsCount}
                                                            <i id="pop-method-names"
                                                               class="fa fa-info-circle text-info cursor-pointer"
                                                               data-content="<c:forEach var="name" items="${componentContextInfo.wsInternalClassInternalMetrics.methodsNames}">${name}<br></c:forEach>"
                                                            ></i>
                                                        </span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <span>Total Services Used</span>
                                                        <span>${componentContextInfo.wsInternalClassInternalMetrics.servicesCount}</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <span>E-Seco Core Services Used</span>
                                                        <span>
                                                            ${componentContextInfo.wsInternalClassInternalMetrics.esecoCoreServicesCount}
                                                            <i id="pop-eseco-core-services-names"
                                                               class="fa fa-info-circle text-info cursor-pointer"
                                                               data-content="<c:forEach var="name" items="${componentContextInfo.wsInternalClassInternalMetrics.esecoCoreServicesNames}">${name}<br></c:forEach>"
                                                            ></i>
                                                        </span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <span>E-Seco Workflow Services Used</span>
                                                        <span>
                                                            ${componentContextInfo.wsInternalClassInternalMetrics.esecoWorkflowServicesCount}
                                                            <i id="pop-eseco-workflow-services-names"
                                                               class="fa fa-info-circle text-info cursor-pointer"
                                                               data-content="<c:forEach var="name" items="${componentContextInfo.wsInternalClassInternalMetrics.esecoWorkflowServicesNames}">${name}<br></c:forEach>"
                                                            ></i>
                                                        </span>
                                                    </li>
                                                </ul>
                                            </div>

                                            <div class="col-xs-12 col-sm-6">
                                                <div class="text-center margin-10-bottom">
                                                    <button id="btn-visualize-dependencies-treemap" class="btn btn-info"
                                                            type="button">
                                                        View Treemap
                                                    </button>
                                                    <button id="btn-visualize-dependencies-graph" class="btn btn-info"
                                                            type="button">
                                                        View Graph
                                                    </button>
                                                </div>
                                                <div id="box-chart-dependencies"></div>
                                            </div>
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

                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Comments</h3>
                            </div>
                            <div class="panel-body">
                                <form id="frm-comment"
                                      action="<c:url value="/components/actions/workflow-services/comment/${componentContextInfo.id}"/>"
                                      method="post">
                                    <input id="comment-reply-to" name="comment-reply-to" type="hidden">

                                    <table id="tbl-comments" class="table">
                                        <tbody class="comments-tbody"></tbody>
                                    </table>

                                    <div class="form-group">
                                        <label for="comment-content">Insert a Comment</label>
                                        <textarea id="comment-content" name="comment-content"
                                                  class="form-control"></textarea>
                                    </div>

                                    <div>
                                        <button name="submit-comment" class="btn btn-success">Confirm Comment</button>
                                    </div>
                                </form>
                            </div>
                        </div>
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