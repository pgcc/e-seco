<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Researchers
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            // Get JSON Data for visualizations
            var researchRelationsGraphDATA = JSON.parse('${researchRelationsGraphJSON}');
            var researchExperimentsChartDATA = JSON.parse('${researchExperimentsChartJSON}');
            console.log(researchExperimentsChartDATA);
            /***********************************************/
            /* Research Relations GRAPH                            */
            /***********************************************/
            function showResearchRelationsGraphVisualization() {
                var target = "#box-research-relations-graph";
                var width = $(target).css("width");
                width = width.replace("px", "");

                var graphData = mountDataToRelationsGraph(researchRelationsGraphDATA);

                drawGraph(graphData, target, width);
            }
            ;
            function mountDataToRelationsGraph(itemData) {

                var info = "";
                for (var i in itemData.nodes) {
                    info = info += i + " => " + itemData.nodes[i].name;
                    info = info += '\n';
                }
                var graphData = {
                    "nodes": [],
                    "links": []
                };

                for (var i in itemData.nodes) {
                    graphData.nodes.push({
                        "name": itemData.nodes[i].name, "group": 1, "kind": 7, "img": itemData.nodes[i].img, info: ""
                    });
                }
                for (var i in itemData.relations) {
                    var experimentName = i;
                    for (var j in itemData.relations[i]) {
                        var targetName = itemData.relations[i][j].id_1;
                        var sourceName = itemData.relations[i][j].id_2;

                        var target = graphData.nodes.find(x => x.name == targetName);
                        var source = graphData.nodes.find(x => x.name == sourceName);
                        if (target.info == "") {
                            target.info = "Experiments: ";
                        }
                        if (!target.info.includes(experimentName)) {
                            target.info = target.info + experimentName + ", ";
                        }
                        graphData.links.push({
                            "source": source, "target": target, "value": 2, "type": "link"
                        });
                    }
                }
                return graphData;
            }
            showResearchRelationsGraphVisualization();
                           
            
            /***********************************************/
            /* Research Experiments CHART                  */
            /***********************************************/
            function showResearchExperimentsChartVisualization() {
                var target = "#box-research-experiments-chart";
                var width = $(target).css("width");
                width = width.replace("px", "");
                width = (width/12)*9;
                drawChordChart(researchExperimentsChartDATA, target, width );
            }
            ;
            showResearchExperimentsChartVisualization();
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/researchers"/>"><i class="fa fa-street-view"></i> Researchers</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">
            <c:if test="${not empty msg}">
                <div class="alert alert-${css} alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <strong>${msg}</strong>
                </div>
            </c:if>

            <h2>All Researchers</h2>
            <br/>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">
                                        Researchers Experiments
                                    </h3>
                                </div>
                                <div class="panel-body" style="position: relative;">
                                    <div id="box-research-experiments-chart"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">
                                        Relationship Between Researchers
                                    </h3>
                                </div>
                                <div class="panel-body" style="position: relative;">
                                    <img src="<c:url value="/resources/images/researchers-relations-graph-legend.png" />">
                                    <div id="box-research-relations-graph"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table class="table table-hover table-responsive">
                        <thead>
                            <tr>
                                <th>Photo</th>
                                <th>#ID</th>
                                <th>Display Name</th>
                                <th>Title</th>                                
                            </tr>
                        </thead>
                        <c:forEach var="res" items="${researchers}">

                            <spring:url value="/researchers/${res.id}" var="agentUrl" />

                            <tr>
                                <td onclick="location.href = '${agentUrl}'">
                                    <img src="${res.photo}" class="img-rounded img-responsive" style="max-width: 40px;">
                                </td>   
                                <td onclick="location.href = '${agentUrl}'" style="vertical-align: middle">${res.id}</td>
                                <td onclick="location.href = '${agentUrl}'" style="vertical-align: middle">${res.displayName}</td>
                                <td onclick="location.href = '${agentUrl}'" style="vertical-align: middle">${res.title}</td>

                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>