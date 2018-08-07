<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Workflows
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            // Get JSON Data for visualizations
            var workflowTreeDATA = JSON.parse('${workflowTreeJSON}');
            
            /***********************************************/
            /* Research Experiments CHART                            */
            /***********************************************/
            function showWorkflowVisualization() {
                var target = "#box-workflow-tree";
                var width = $(target).css("width");
                width = width.replace("px", "");
                if (workflowTreeDATA.phases > 0) {
                    var graphData = mountDataToWorkflowVis(workflowTreeDATA);
                    drawWorkflow(graphData, target, width, workflowTreeDATA.phases);
                }
            }
            ;
            function mountDataToWorkflowVis(itemData) {

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
                    var node = itemData.nodes[i];
                    graphData.nodes.push({
                        "name": node.name, "group": 1, "kind": 4, "description": node.description, id: i,
                        "orderExec": node.orderExec, "siblings": node.siblings, "author": node.author, 
                        "position": node.position, "reusedFrom": node.reusedFrom, "reusedBy": node.reusedBy
                    });
                }

                for (var i in itemData.links) {
                    var targetID = itemData.links[i].activity2;
                    var sourceID = itemData.links[i].activity1;

                    var target = graphData.nodes.find(x => x.id == targetID);
                    var source = graphData.nodes.find(x => x.id == sourceID);

                    graphData.links.push({
                        "source": source, "target": target, "value": 1, "type": "link"
                    });
                }
                return graphData;
            }
            showWorkflowVisualization();
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/workflows"/>">Workflows</a></li>
            <li><a href="<c:url value="/experiments/workflows/${workflow.id}"/>">View</a></li>
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

            <h2>Workflow Detail</h2>
            <br />
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <label class="col-sm-2">ID</label>
                        <div class="col-sm-10">${workflow.id}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Name</label>
                        <div class="col-sm-10">${workflow.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Description</label>
                        <div class="col-sm-10">${workflow.description}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Link</label>
                        <div class="col-sm-10">${workflow.link}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Wfms</label>
                        <div class="col-sm-10">${workflow.wfms.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Version</label>
                        <div class="col-sm-10">${workflow.version}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Author</label>
                        <div class="col-sm-10">${workflow.author.displayName}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Created in</label>
                        <div class="col-sm-10">${workflow.dateCreated}</div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">
                                        Workflow Visualization
                                    </h3>
                                </div>
                                <div class="panel-body" style="position: relative;">
                                    <div id="box-workflow-tree"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                    Activities                                
                                </a>
                                <span class="badge">${workflow.activities.size()}</span>
                            </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <ul class="list-group" >
                                    <c:forEach items="${workflow.activities}" var="wa">
                                        <li class="list-group-item">
                                            <a href="<c:url value="/experiments/activities/${wa.activity.id}"/>">${wa.activity.name}</a> Sequence: ${wa.orderExec} 
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingOne">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Executions
                                    </a>
                                    <span class="badge">${workflow.executions.size()}</span>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <c:forEach items="${workflow.executions}" var="execution">
                                            <li class="list-group-item"><a href="<c:url value="/experiments/workflowExecutions/${execution.id}"/>">${execution.startTime}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingFour">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="true" aria-controls="collapseFour">
                                        Experiments
                                    </a>
                                    <span class="badge">${workflow.experiments.size()}</span>
                                </h4>
                            </div>
                            <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <c:forEach items="${workflow.experiments}" var="experiment">
                                            <li class="list-group-item"><a href="<c:url value="/experiments/${experiment.id}"/>">${experiment.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </jsp:body>
    </t:layout-app>