<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("lf", "\n"); %>
<% pageContext.setAttribute("cr", "\r"); %>

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

            .img-graph-legend {
                position: absolute;
                top: 20px;
                left: 20px;
            }
        </style>
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v4.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.legend.min.js" />"></script>
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
            /* USAGE AND RELATIONS GRAPH                   */
            /***********************************************/
            function showUsageAndRelationsGraphVisualization() {
                var target = "#box-chart-usage-and-relations-graph";
                var width = $(target).css("width");
                width = width.replace("px", "");

                var graphData = mountDataToUsageAndRelations(componentContextJson);

                drawGraph(graphData, target, width);
            };

            function mountDataToUsageAndRelations(itemData) {

                var graphData = {
                    "nodes": [
                        {
                            "name": itemData.name,
                            "group": 0,
                            "kind": 1 // Kind 1 = Principal item
                        }
                    ],
                    "links": []
                };

                var groupId = 1;

                // Developer Relation
                graphData.nodes.push({
                    "name": itemData.author, "group": groupId, "kind": 2
                });
                graphData.links.push({
                    "source": groupId, "target": 0, "value": 1, "type": "arrow"
                });
                groupId++;

                <c:forEach var="activity" items="${activitiesList}">

                graphData.nodes.push({
                    "name": "${activity.name}", "group": groupId, "kind": 3
                });
                graphData.links.push({
                    "source": 0, "target": groupId, "value": 1, "type": "arrow"
                });

                groupIdActivity = groupId;
                groupId++;

                <c:forEach var="workflow" items="${activity.workflows}">

                graphData.nodes.push({
                    "name": "${workflow.name}", "group": groupId, "kind": 4
                });
                graphData.links.push({
                    "source": groupIdActivity, "target": groupId, "value": 1, "type": "arrow"
                });

                groupIdWorkflow = groupId;
                groupId++;

                <c:forEach var="experiment" items="${workflow.experiments}">

                graphData.nodes.push({
                    "name": "${experiment.name}", "group": groupId, "kind": 5
                });
                graphData.links.push({
                    "source": groupIdWorkflow, "target": groupId, "value": 1, "type": "arrow"
                });

                groupIdExperiment = groupId;
                groupId++;

                <c:forEach var="researcher" items="${experiment.researchers}">

                graphData.nodes.push({
                    "name": "${researcher.agent.name}", "group": groupId, "kind": 6
                });
                graphData.links.push({
                    "source": groupId, "target": groupIdExperiment, "value": 1, "type": "arrow"
                });

                groupId++;

                </c:forEach>

                </c:forEach>

                </c:forEach>

                </c:forEach>

                console.log(graphData)


                return graphData;
            }

            showUsageAndRelationsGraphVisualization();


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
            /* RESEARCHER RATINGS VISUALIZATION              */
            /***********************************************/
            function showResearcherRatingsVisualization() {
                if (componentContextJson.totalResearcherRatings > 0) {
                    var width = "200";
                    var pieData = mountDataToPie(componentContextJson);
                    drawPie(pieData, "#box-chart-researcher-ratings-pie", width)
                }
            };

            function mountDataToPie(itemData) {
                var pieData = [
                    {"rating": "Approvals", "quantity": componentContextJson.totalApprovals},
                    {"rating": "Reprovals", "quantity": componentContextJson.totalReprovals}
                ];

                return pieData;
            }

            showResearcherRatingsVisualization();


            /***********************************************/
            /* DEVELOPER RATINGS VISUALIZATIONS            */
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
            /* DEPENDENCIES VISUALIZATION                  */
            /***********************************************/
            // Treemap
            function showDependenciesVisualization() {
                var width = $("#box-chart-dependencies-treemap").css("width");
                width = width.replace("px", "");
                var treemapData = mountDataToTreemap(componentContextJson);
                drawTreemap(treemapData, "#box-chart-dependencies-treemap", width);
            };

            function mountDataToTreemap(itemData) {
                var treemapData = {
                    "name": itemData.wsInternalClass,
                    "size": null,
                    "children": null
                };

                // If it has childs
                if (itemData.usedEsecoCoreServicesList || itemData.usedEsecoWorkflowServicesStringList) {
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
                    if (itemData.usedEsecoWorkflowServicesStringList && itemData.usedEsecoWorkflowServicesStringList.length > 0) {
                        $.each(itemData.usedEsecoWorkflowServicesStringList, function (i, item) {

                            var esecoWorkflowServiceData = {
                                "name": item,
                                "wsInternalClass": item
                            };
                            var childrenData = mountDataToTreemap(esecoWorkflowServiceData);
                            children.push(childrenData);
                        });
                    }

                    treemapData.children = children;

                } else {
                    treemapData.size = 5;
                }

                return treemapData;
            }

            showDependenciesVisualization();

            // Graph
            function showDependenciesGraphVisualization() {
                var target = "#box-chart-dependencies-graph";
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
                            "group": 0,
                            "kind": 1 // Kind 1 = Principal item
                        }
                    ],
                    "links": []
                };

                var groupId = 1;

                $.each(data1, function (i, item) {
                    graphData.nodes.push({
                        "name": item,
                        "group": groupId,
                        "kind": 2 // kind 2 = Eseco Workflow Services
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
                        "group": groupId,
                        "kind": 3 // kind 3 = Eseco Core Services
                    });
                    graphData.links.push({
                        "source": groupId,
                        "target": 0,
                        "value": 1,
                        "type": "arrow"
                    });

                    groupId++;
                });

                if (itemData.id == 13 || itemData.id == 45 || itemData.id == 46 || itemData.id >= 158) {
                    graphData.nodes.push({
                        "name": "BiologicalSpecimenScientificNameRetriever", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "BloodTypeProbabilityPrimitiveType", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "FetchBarCode", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "MatrixCombinationPhenotypesPrimitiveTypes", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "PhenotypeTranslationPrimitiveType", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "SpecimenInformationSearch", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;
                }

                if (itemData.id == 159) {
                    graphData.nodes.push({
                        "name": "FoodDryMatterPercentage", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "MeanExperimentMeanMetabolicWeight", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;
                }

                if (itemData.id == 160) {
                    graphData.nodes.push({
                        "name": "FoodDryMatterPercentage", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "MeanExperimentDiaryWeightGain", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;
                }

                if (itemData.id == 161) {
                    graphData.nodes.push({
                        "name": "MeanExperimentDiaryWeightGain", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "MeanExperimentDiaryWeightGain", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;
                }

                if (itemData.id == 4) {
                    graphData.nodes.push({
                        "name": "BiologicalSpecimenScientificNameRetriever", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 1, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 2, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 3, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "BloodTypeProbabilityPrimitiveType", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 1, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 2, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 3, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "FetchBarCode", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 1, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 2, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 3, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "MatrixCombinationPhenotypesPrimitiveTypes", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 1, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 2, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 3, "value": 1, "type": "arrow", "way": "interoperate"
                    });

                    groupId++;

                    graphData.nodes.push({
                        "name": "PhenotypeTranslationPrimitiveType", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 1, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 2, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 3, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    groupId++;

                    graphData.nodes.push({
                        "name": "SpecimenInformationSearch", "group": groupId, "kind": 4
                    });
                    graphData.links.push({
                        "source": groupId, "target": 0, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 1, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 2, "value": 1, "type": "arrow", "way": "interoperate"
                    });
                    graphData.links.push({
                        "source": groupId, "target": 3, "value": 1, "type": "arrow", "way": "interoperate"
                    });

                    groupId++;
                }


                return graphData;
            }

            showDependenciesGraphVisualization();


            /***********************************************/
            /* POPOVERS                                    */
            /***********************************************/
            $('#pop-parameters-names').popover({
                "title": "Attributes names",
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
            var Utf8 = {
                // public method for url encoding
                encode: function (string) {
                    string = string.replace(/\r\n/g, "\n");
                    var utftext = "";
                    for (var n = 0; n < string.length; n++) {
                        var c = string.charCodeAt(n);
                        if (c < 128) {
                            utftext += String.fromCharCode(c);
                        } else if ((c > 127) && (c < 2048)) {
                            utftext += String.fromCharCode((c >> 6) | 192);
                            utftext += String.fromCharCode((c & 63) | 128);
                        } else {
                            utftext += String.fromCharCode((c >> 12) | 224);
                            utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                            utftext += String.fromCharCode((c & 63) | 128);
                        }
                    }

                    return utftext;
                },

                // public method for url decoding
                decode: function (utftext) {
                    var string = "";
                    var i = 0;
                    var c = c1 = c2 = 0;
                    while (i < utftext.length) {
                        c = utftext.charCodeAt(i);
                        if (c < 128) {
                            string += String.fromCharCode(c);
                            i++;
                        } else if ((c > 191) && (c < 224)) {
                            c2 = utftext.charCodeAt(i + 1);
                            string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                            i += 2;
                        } else {
                            c2 = utftext.charCodeAt(i + 1);
                            c3 = utftext.charCodeAt(i + 2);
                            string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                            i += 3;
                        }
                    }

                    return string;
                }
            }

            function decodeEntities(encodedString) {
                var textArea = document.createElement('textarea');
                textArea.innerHTML = encodedString;
                var regexp = new RegExp("<br>", 'g');
                return Utf8.decode(textArea.value.replace(regexp, '\n'));
            }

            function mountBoxCommentStars(data, ommitlink) {

                var rateStarsTotal = data.rateStarsTotal;
                var rateStar1 = data.rateStarsAverage >= 1 ? "fa-star" : "fa-star-o";
                var rateStar2 = data.rateStarsAverage >= 2 ? "fa-star" : "fa-star-o";
                var rateStar3 = data.rateStarsAverage >= 3 ? "fa-star" : "fa-star-o";
                var rateStar4 = data.rateStarsAverage >= 4 ? "fa-star" : "fa-star-o";
                var rateStar5 = data.rateStarsAverage >= 5 ? "fa-star" : "fa-star-o";

                var rateStarsLink = null;
                if (!ommitlink) {
                    rateStarsLink = $("<a>")
                        .addClass("btn-rate-comment text-small")
                        .data("comment-id", data.id)
                        .attr("href", "#").text(" rate");
                }


                return $("<div>").addClass("box-comment-stars")
                    .data("id", data.id)
                    .data("rateStarsTotal", data.rateStarsTotal)
                    .data("rateStarsAverage", data.rateStarsAverage)
                    .append(
                        $("<span>").addClass("fa " + rateStar1),
                        $("<span>").addClass("fa " + rateStar2),
                        $("<span>").addClass("fa " + rateStar3),
                        $("<span>").addClass("fa " + rateStar4),
                        $("<span>").addClass("fa " + rateStar5),

                        $("<span>").attr("class", "rateText").append(
                            $("<span>").addClass("text-small")
                                .text(" (" + rateStarsTotal + " ratings"),
                            rateStarsLink,
                            $("<span>").addClass("text-small").text(")")
                        )
                    );
            }

            function addCommentToTable(tbody, data, isChild) {
                var photoWidth = isChild ? "50px" : "80px";
                var tr = null;

                var boxCommentStars = mountBoxCommentStars(data, false);

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
                        $("<p>").text(decodeEntities(data.comment)),
                        $("<p>").addClass("box-comment-rating").append(
                            boxCommentStars
                        ),
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
                "comment": '${fn:replace(fn:replace(fn:escapeXml(comment.content), lf, "<br>"), cr, "<br>")}',
                "rateStarsTotal": "${comment.rateStarsTotal}",
                "rateStars1": "${comment.rateStar1}",
                "rateStars2": "${comment.rateStar2}",
                "rateStars3": "${comment.rateStar3}",
                "rateStars4": "${comment.rateStar4}",
                "rateStars5": "${comment.rateStar5}",
                "rateStarsAverage": "${comment.rateStarsAverage}"
            }, false);

            <c:forEach var="response1" items="${comment.responses}">
            addCommentToTable("#tbl-comment-replies-${response1.parent.id} tbody.replies-tbody-${response1.parent.id}", {
                "id": "${response1.id}",
                "author": "${response1.commenter.name}",
                "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response1.date}"/>",
                "photo": "${response1.commenter.photo}",
                "comment": '${fn:replace(fn:replace(fn:escapeXml(response1.content), lf, "<br>"), cr, "<br>")}',
                "rateStarsTotal": "${response1.rateStarsTotal}",
                "rateStarsAverage": "${response1.rateStarsAverage}"
            }, true);

            <c:forEach var="response2" items="${response1.responses}">
            addCommentToTable("#tbl-comment-replies-${response2.parent.id} tbody.replies-tbody-${response2.parent.id}", {
                "id": "${response2.id}",
                "author": "${response2.commenter.name}",
                "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response2.date}"/>",
                "photo": "${response2.commenter.photo}",
                "comment": '${fn:replace(fn:replace(fn:escapeXml(response2.content), lf, "<br>"), cr, "<br>")}',
                "rateStarsTotal": "${response2.rateStarsTotal}",
                "rateStarsAverage": "${response2.rateStarsAverage}"
            }, true);

            <c:forEach var="response3" items="${response2.responses}">
            addCommentToTable("#tbl-comment-replies-${response3.parent.id} tbody.replies-tbody-${response3.parent.id}", {
                "id": "${response3.id}",
                "author": "${response3.commenter.name}",
                "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response3.date}"/>",
                "photo": "${response3.commenter.photo}",
                "comment": '${fn:replace(fn:replace(fn:escapeXml(response3.content), lf, "<br>"), cr, "<br>")}',
                "rateStarsTotal": "${response3.rateStarsTotal}",
                "rateStarsAverage": "${response3.rateStarsAverage}"
            }, true);

            <c:forEach var="response4" items="${response3.responses}">
            addCommentToTable("#tbl-comment-replies-${response4.parent.id} tbody.replies-tbody-${response4.parent.id}", {
                "id": "${response4.id}",
                "author": "${response4.commenter.name}",
                "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response4.date}"/>",
                "photo": "${response4.commenter.photo}",
                "comment": '${fn:replace(fn:replace(fn:escapeXml(response4.content), lf, "<br>"), cr, "<br>")}',
                "rateStarsTotal": "${response4.rateStarsTotal}",
                "rateStarsAverage": "${response4.rateStarsAverage}"
            }, true);

            <c:forEach var="response5" items="${response4.responses}">
            addCommentToTable("#tbl-comment-replies-${response5.parent.id} tbody.replies-tbody-${response5.parent.id}", {
                "id": "${response5.id}",
                "author": "${response5.commenter.name}",
                "date": "<fmt:formatDate pattern="yyyy-MM-dd" value="${response5.date}"/>",
                "photo": "${response5.commenter.photo}",
                "comment": '${fn:replace(fn:replace(fn:escapeXml(response5.content), lf, "<br>"), cr, "<br>")}',
                "rateStarsTotal": "${response5.rateStarsTotal}",
                "rateStarsAverage": "${response5.rateStarsAverage}"
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

            // Rate Comment
            $(".btn-rate-comment").on("click", function () {
                var commentId = $(this).data("comment-id");

                var stars = prompt("Give you rating (1 to 5)");

                if (stars != "1" && stars != "2" && stars != "3" && stars != "4" && stars != "5") {
                    swal("Error", "The value is out bounds.", "error");
                    return false;
                }

                var urlPost = "<c:url value="/components/actions/workflow-services/comment/${component.id}/rate"/>";

                var data = {
                    "rd-comment-id": commentId,
                    "rd-stars": stars
                };

                var thisLink = $(this);

                $.ajax({
                    method: "post",
                    url: urlPost,
                    data: data,
                    success: function (data) {
                        if (data !== "error") {
                            swal("Success", "Comment Rated!", "success");

                            var boxCommentRating = thisLink.parents(".box-comment-rating");
                            var boxCommentStars = boxCommentRating.find(".box-comment-stars");

                            var newRateStarsTotal = parseInt((boxCommentStars.data("rateStarsTotal"))) + 1;

                            var newCommentStarsData = {
                                "id": boxCommentStars.data("id"),
                                "rateStarsTotal": newRateStarsTotal,
                                "rateStarsAverage": data
                            };

                            var newBoxCommentStars = mountBoxCommentStars(newCommentStarsData, true);

                            thisLink.parents(".box-comment-rating").html("").append(newBoxCommentStars);

                        } else {
                            swal("Error", "An error occurred while rating, please try again.", "error");
                        }
                    }
                });

                return false;
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
                                        <span><a href="<c:url value="/agents/${component.author.agent.id}"/>"
                                                 target="_blank">${componentContextInfo.author} <i
                                                class="fa fa-external-link"></i></a></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Date Created</span>
                                        <span><fmt:formatDate pattern="yyyy-MM-dd"
                                                              value="${componentContextInfo.dateCreated}"/></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Date Last Updated</span>
                                        <c:choose>
                                            <c:when test="${not empty componentContextInfo.dateUpdated}">
                                                <span><fmt:formatDate pattern="yyyy-MM-dd"
                                                                      value="${componentContextInfo.dateUpdated}"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>Never Updated</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Documentation</span>
                                        <c:choose>
                                            <c:when test="${not empty component.documentationUrl}">
                                                <a href="${component.documentationUrl}" target="_blank">
                                                    Go To Documentation
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span>Not Avaiable</span>
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
                                <h3 class="panel-title">Plugin Info</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="list-group lst-data-value">
                                    <li class="list-group-item">
                                        <span>Internal Class</span>
                                        <span>${componentContextInfo.pluginInternalClass}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>