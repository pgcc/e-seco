<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Actions - Workflow Services - <strong>${component.name}</strong> - Invite for Rating
    </jsp:attribute>


    <jsp:attribute name="stylesheets">
        <link rel="stylesheet"
              href="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.css"/>">
        <style type="text/css">
            path.link {
                fill: none;
                stroke: #666;
                stroke-width: 1.5px;
            }

            path.link.twofive {
                opacity: 0.25;
            }

            path.link.fivezero {
                opacity: 0.50;
            }

            path.link.sevenfive {
                opacity: 0.75;
            }

            path.link.onezerozero {
                opacity: 1.0;
            }

            circle {
                fill: #ccc;
                stroke: #fff;
                stroke-width: 1.5px;
            }

            text {
                fill: #000;
                pointer-events: none;
            }

            #content {
                padding: 7px;
            }
        </style>
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v3.min.js" />"></script>
        <script type="text/javascript"
                src="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.js" />"></script>
        <script type="text/javascript">

            // Get JSON Data for visualizations
            var reseacherRelevanceListJSON = JSON.parse('${reseacherRelevanceListJSON}');


            /***********************************************/
            /* RELEVANCE VISUALIZATION                     */
            /***********************************************/
            function showRelevanceVisualization() {
                var target = "#chart";
                var width = $(target).css("width");
                width = width.replace("px", "");

                var graphData = mountDataToGraph(reseacherRelevanceListJSON);

                drawGraph(graphData, target, width);
            };

            function mountDataToGraph(itemData) {

                var graphData = {
                    "nodes": [
                        {
                            "name": "${component.name}",
                            "group": 0
                        }
                    ],
                    "links": []
                };

                var groupId = 1;

                $.each(itemData, function (i, researcherRelevance) {
                    console.log(researcherRelevance);
                    graphData.nodes.push({
                        "name": researcherRelevance.name,
                        "group": groupId
                    });
                    graphData.links.push({
                        "source": groupId,
                        "target": 0,
                        "value": researcherRelevance.relevance + 1,
                        "type": "arrow"
                    });

                    groupId++;
                });

                return graphData;
            }

            showRelevanceVisualization();


            /*********************************************************/
            /* FORM BEHAVIORS                                        */
            /*********************************************************/
            function updateActionsButtons() {
                $("#fld-actions-invite").prop("disabled", $(".cbx-actions-item:checked").length < 1);
            }

            function updateFldActionsIds() {
                var ids = "";
                $(".cbx-actions-item:checked").each(function () {
                    ids += $(this).val() + ",";
                });

                ids = ids.slice(0, -1);

                $('input[name="actions-ids"]').val(ids);
            }

            function updateTxtActionsInfo() {
                var selected = $(".cbx-actions-item:checked").length;
                var text = "With <strong>" + selected + "</strong> selected, do: ";
                $(".txt-actions-info").html(text);
            };

            // Pre-Actions
            updateTxtActionsInfo();
            updateActionsButtons();

            // Event Actions
            $("#cbx-actions-select-all").on("click", function () {
                $(".cbx-actions-item").prop("checked", $(this).prop("checked"));
                updateFldActionsIds();
                updateActionsButtons();
                updateTxtActionsInfo();
            });

            $(".cbx-actions-item").on("click", function () {
                updateFldActionsIds();
                updateActionsButtons();
                updateTxtActionsInfo();
            });
        </script>
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
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Actions - Workflow Services - <strong>${component.name}</strong> - Invite for Rating</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Select Researchers</h3>
                    </div>
                    <div class="panel-body">

                        <div id="chart"></div>

                        <form id="frm-actions"
                              action="<c:url value="/components/actions/workflow-services/invite-rating/${component.id}"/>"
                              method="post">

                            <input name="actions-ids" type="hidden">

                            <div class="form-group">
                                <label for="datechat">Chat Date
                                    <i class="fa fa-info-circle text-info"
                                       data-toggle="tooltip" data-placement="top"
                                       title="Format: yyyy/mm/dd"></i>
                                </label>
                                <div class="input-group">
                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                    <input id="datechat" name="datechat" class="form-control datepicker">
                                </div>
                            </div>

                            <div class="form-group">
                                <span class="txt-actions-info"></span>
                                <input id="fld-actions-invite" name="actions-invite"
                                       class="btn btn-primary" type="submit" value="Invite for Rating">
                            </div>

                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th class="text-center" style="width:40px;">
                                        <input id="cbx-actions-select-all" title="Select All"
                                               type="checkbox">
                                    </th>
                                    <th>Name</th>
                                    <th class="text-center" style="width:130px;">Relevance</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="researcher" items="${reseacherRelevanceList}">
                                    <tr>
                                        <td class="text-center">
                                            <input name="actions-item-${researcher.id}"
                                                   class="cbx-actions-item" title="Select This"
                                                   type="checkbox" value="${researcher.id}">
                                        </td>
                                        <td><c:out value="${researcher.name}"/></td>
                                        <td class="text-center"><c:out value="${researcher.relevance}"/></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </form>

                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>