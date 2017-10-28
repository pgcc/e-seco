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
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v4.min.js" />"></script>
        <script type="text/javascript"
                src="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.js" />"></script>
        <script type="text/javascript">
            $("#btn-visualize-dependencies").on("click", function () {
                $('#myModal').modal();

                //drawTreemap('<c:url value="/returnjson"/>');
                //drawRadar('/eseco/resources/json/radar11.json');



                drawTreemap('/eseco/resources/json/mydata-3.json');


            });
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a>
        <a href="<c:url value="/components/details/${component.id}"/>"><i class="fa fa-angle-double-right"></i> Details
            of ${component.name}</a>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Details: <strong>${component.name}</strong></h2>

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
                                        <span>${component.id}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Name</span>
                                        <span>${component.name}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Type</span>
                                        <span>${component.type.name}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Versions</span>
                                        <span>1 <button class="btn btn-xs btn-info" type="button">View all</button></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Author</span>
                                        <span>${component.author.agent.name}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Date Created</span>
                                        <span><fmt:formatDate pattern="yyyy-MM-dd"
                                                              value="${component.dateCreated}"/></span>
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
                                        <span>${component.serviceWorkflow.type}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Nature</span>
                                        <span>Composed</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Location</span>
                                        <span>http://localhost:8888/eseco/services/3</span>
                                    </li>
                                </ul>
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
                                        <span>Experiments</span>
                                        <span>3 <button class="btn btn-xs btn-info" type="button">View all</button></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Cientists</span>
                                        <span>2 <button class="btn btn-xs btn-info" type="button">View all</button></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Most Common Area</span>
                                        <span>Biology</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Date Last Used</span>
                                        <span>2017-09-22</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Most Used Version</span>
                                        <span>1</span>
                                    </li>

                                </ul>

                                <div class="text-center">
                                    <button class="btn btn-info" type="button">Visualize</button>
                                </div>
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
                                        <span>3 <button class="btn btn-xs btn-info" type="button">View all</button></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Problems Related</span>
                                        <span>8</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Approvals</span>
                                        <span>3</span>
                                    </li>
                                </ul>

                                <div class="text-center">
                                    <button class="btn btn-info" type="button">Visualize</button>

                                    <button class="btn btn-info" type="button">Invite for Rating</button>
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
                                <ul class="list-group lst-data-value">
                                    <li class="list-group-item">
                                        <span>Parameters</span>
                                        <span>0</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Methods</span>
                                        <span>5</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Atomic Services</span>
                                        <span>2</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>E-Seco Classes</span>
                                        <span>5</span>
                                    </li>
                                </ul>
                                <div class="text-center">
                                    <button id="btn-visualize-dependencies" class="btn btn-info" type="button">
                                        Visualize
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog width-95" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Dependencies of <strong>${component.name}</strong>
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12 col-sm-8">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Dependencies</h3>
                                    </div>
                                    <div class="panel-body">
                                        <div style="overflow: auto;width: 800px;height: 500px;">
                                            <div id="chart"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xs-12 col-sm-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Filters</h3>
                                    </div>
                                    <div class="panel-body">

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary">Export</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>