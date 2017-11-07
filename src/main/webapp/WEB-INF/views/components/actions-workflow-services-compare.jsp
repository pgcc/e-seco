<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Compositions - Workflow Services
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
            // Get Items
            var itemsToCompare = JSON.parse('${componentsContextInfo}');

            /***********************************************/
            /* TABLES POPULATE                             */
            /***********************************************/
            function addItemToComparationsTable(item) {
                /**********************************/
                /* HEAD SETTING                   */
                /**********************************/
                var tbl_thead = $("table thead");

                // Header Title
                tbl_thead.find("tr").append(
                    $("<th>").text(item.name)
                );


                /**********************************/
                /* BODY SETTING                   */
                /**********************************/
                var tbl_tbody = $("table tbody");

                // Type
                tbl_tbody.find("tr.row-compare-info-type").append(
                    $("<td>").text(item.type)
                );

                // Date Created
                var dateCreated = "";
                if (item.dateCreated) {
                    dateCreated = new Date(item.dateCreated);
                    dateCreated = dateCreated.toLocaleString();
                }
                tbl_tbody.find("tr.row-compare-info-datecreated").append(
                    $("<td>").text(dateCreated)
                );

                // Date Updated
                var dateUpdated = "Never Updated";
                if (item.dateUpdated) {
                    dateUpdated = new Date(item.dateUpdated);
                    dateUpdated = dateUpdated.toLocaleDateString();
                }
                tbl_tbody.find("tr.row-compare-info-dateupdated").append(
                    $("<td>").text(dateUpdated)
                );

                // Author
                tbl_tbody.find("tr.row-compare-info-author").append(
                    $("<td>").text(item.author)
                );

                // Workflow Service Type
                tbl_tbody.find("tr.row-compare-info-wstype").append(
                    $("<td>").text(item.wsType)
                );

                // Workflow Service Nature
                tbl_tbody.find("tr.row-compare-info-wsnature").append(
                    $("<td>").text(item.wsNature)
                );

                // Workflow Service Location
                tbl_tbody.find("tr.row-compare-info-wslocation").append(
                    $("<td>").text(item.wsUrl)
                );

                // Workflow Service Internal Class
                tbl_tbody.find("tr.row-compare-info-wsinternalclass").append(
                    $("<td>").text(item.wsInternalClass)
                );

                // Workflow Service Class Parameter Count
                tbl_tbody.find("tr.row-compare-info-wsclassparametercount").append(
                    $("<td>").text(item.wsInternalClassInternalMetrics.parametersCount)
                );

                // Workflow Service Class Method Count
                tbl_tbody.find("tr.row-compare-info-wsclassmethodcount").append(
                    $("<td>").text(item.wsInternalClassInternalMetrics.methodsCount)
                );

                // Workflow Service Total Services Used
                tbl_tbody.find("tr.row-compare-info-wstotalservicesused").append(
                    $("<td>").text(item.wsInternalClassInternalMetrics.servicesCount)
                );

                // Workflow Service E-Seco Core Services Used
                tbl_tbody.find("tr.row-compare-info-wsesecocoreservicesused").append(
                    $("<td>").text(item.wsInternalClassInternalMetrics.esecoCoreServicesCount)
                );

                // Workflow Service E-Seco Workflow Services Used
                tbl_tbody.find("tr.row-compare-info-wsesecoworkflowservicesused").append(
                    $("<td>").text(item.wsInternalClassInternalMetrics.esecoWorkflowServicesCount)
                );

                // Workflow Service Activities Using
                tbl_tbody.find("tr.row-compare-info-usageactivities").append(
                    $("<td>").text(item.activitiesUsingCount)
                );

                // Workflow Service Workflows Using
                tbl_tbody.find("tr.row-compare-info-usageworkflows").append(
                    $("<td>").text(item.workflowsUsingCount)
                );

                // Workflow Service Experiments Using
                tbl_tbody.find("tr.row-compare-info-usageexperiments").append(
                    $("<td>").text(item.experimentsUsingCount)
                );

                // Workflow Service Researchers Using
                tbl_tbody.find("tr.row-compare-info-usageresearchers").append(
                    $("<td>").text(item.researchersUsingCount)
                );

                // Workflow Service Most Common Area
                tbl_tbody.find("tr.row-compare-info-usagemostcommonarea").append(
                    $("<td>").text(item.mostCommonArea)
                );

                // Workflow Service Date Last Used
                tbl_tbody.find("tr.row-compare-info-usagedatelastused").append(
                    $("<td>").text(item.dateLastUsed)
                );

                // Workflow Service Total Ratings
                tbl_tbody.find("tr.row-compare-info-wstotalratings").append(
                    $("<td>").text(item.totalRatings)
                );

                // Workflow Service Total Approvals
                tbl_tbody.find("tr.row-compare-info-wstotalapprovals").append(
                    $("<td>").text(item.totalApprovals)
                );

                // Workflow Service Average Value for Documentation
                tbl_tbody.find("tr.row-compare-info-wsvaluedocumentation").append(
                    $("<td>").text(item.totalValueDocumentation)
                );

                // Workflow Service Average Value for Ease of Use
                tbl_tbody.find("tr.row-compare-info-wsvalueeaseofuse").append(
                    $("<td>").text(item.totalValueEaseOfUse)
                );

                // Workflow Service Average Value for Reliability
                tbl_tbody.find("tr.row-compare-info-wsvaluereliability").append(
                    $("<td>").text(item.totalValueReliability)
                );

                // Workflow Service Average Value for Performance
                tbl_tbody.find("tr.row-compare-info-wsvaluePerformance").append(
                    $("<td>").text(item.totalValuePerformance)
                );

                // Workflow Service Average Value for Disponibility
                tbl_tbody.find("tr.row-compare-info-wsvalueDisponibility").append(
                    $("<td>").text(item.totalValueDisponibility)
                );
            }

            $.each(itemsToCompare, function (i, item) {
                addItemToComparationsTable(item);
            });


            /***********************************************/
            /* INTERNAL METRICS VISUALIZATION              */
            /***********************************************/
            function showInternalMetricsVisualization() {

                // Mount Radar Data
                var radarData = [];
                $.each(itemsToCompare, function (i, item) {
                    var itemData = [];

                    itemData.push({
                        "item_id": item.name,
                        "area": "Class Parameters Count",
                        "value": item.wsInternalClassInternalMetrics.parametersCount
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Class Methods Count",
                        "value": item.wsInternalClassInternalMetrics.methodsCount
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Total Services Used",
                        "value": item.wsInternalClassInternalMetrics.servicesCount
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "E-Seco Core Services Used",
                        "value": item.wsInternalClassInternalMetrics.esecoCoreServicesCount
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "E-Seco Workflow Services Used",
                        "value": item.wsInternalClassInternalMetrics.esecoWorkflowServicesCount
                    });

                    radarData.push(itemData);
                });

                drawRadar(radarData, "chart-internalmetrics");
            };

            function showUsageVisualization() {

                // Mount Radar Data
                var radarData = [];
                $.each(itemsToCompare, function (i, item) {
                    var itemData = [];

                    itemData.push({
                        "item_id": item.name,
                        "area": "Activities Using",
                        "value": item.activitiesUsingCount
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Workflows Using",
                        "value": item.workflowsUsingCount
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Experiments Using",
                        "value": item.experimentsUsingCount
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Researchers Using",
                        "value": item.researchersUsingCount
                    });

                    radarData.push(itemData);
                });

                drawRadar(radarData, "chart-usage");
            };

            function showRatingsVisualization() {

                // Mount Radar Data
                var radarData = [];
                $.each(itemsToCompare, function (i, item) {
                    var itemData = [];

                    itemData.push({
                        "item_id": item.name,
                        "area": "Documentation",
                        "value": item.totalValueDocumentation
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Ease of Use",
                        "value": item.totalValueEaseOfUse
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Reliability",
                        "value": item.totalValueReliability
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Performance",
                        "value": item.totalValuePerformance
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Disponibility",
                        "value": item.totalValueDisponibility
                    });

                    radarData.push(itemData);
                });

                drawRadar(radarData, "chart-ratings");
            };

            showInternalMetricsVisualization();
            showUsageVisualization();
            showRatingsVisualization();
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="#">Actions</a></li>
            <li><a href="#">Workflow Services</a></li>
            <li><a href="<c:url value="/components/actions/workflow-services/compare"/>">Compare</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Actions - Workflow Services - Compare</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Basic Info</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table id="tbl-compare-basicinfo" class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>Info</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="row-compare-info-type">
                                    <td>Type</td>
                                </tr>
                                <tr class="row-compare-info-datecreated">
                                    <td>Date Created</td>
                                </tr>
                                <tr class="row-compare-info-dateupdated">
                                    <td>Date Last Updated</td>
                                </tr>
                                <tr class="row-compare-info-author">
                                    <td>Author</td>
                                </tr>
                                <tr class="row-compare-info-wstype">
                                    <td>WorkFlow Service Type</td>
                                </tr>
                                <tr class="row-compare-info-wsnature">
                                    <td>WorkFlow Service Nature</td>
                                </tr>
                                <tr class="row-compare-info-wslocation">
                                    <td>WorkFlow Service Location</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Internal Metrics</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table id="tbl-compare-internalmetrics" class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>Info</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="row-compare-info-wsinternalclass">
                                    <td>WorkFlow Service Internal Class</td>
                                </tr>
                                <tr class="row-compare-info-wsclassparametercount">
                                    <td>WorkFlow Service Class Parameter Count</td>
                                </tr>
                                <tr class="row-compare-info-wsclassmethodcount">
                                    <td>WorkFlow Service Class Method Count</td>
                                </tr>
                                <tr class="row-compare-info-wstotalservicesused">
                                    <td>WorkFlow Service Total Services Used</td>
                                </tr>
                                <tr class="row-compare-info-wsesecocoreservicesused">
                                    <td>WorkFlow Service E-Seco Core Services Used</td>
                                </tr>
                                <tr class="row-compare-info-wsesecoworkflowservicesused">
                                    <td>WorkFlow Service E-Seco Workflow Services Used</td>
                                </tr>
                                <tr class="row-compare-info-wstotalratings">
                                    <td>WorkFlow Service Total Ratings</td>
                                </tr>
                                <tr class="row-compare-info-wstotalapprovals">
                                    <td>WorkFlow Service Total Approvals</td>
                                </tr>
                                <tr class="row-compare-info-wsvaluedocumentation">
                                    <td>WorkFlow Service Average Value for Documentation</td>
                                </tr>
                                <tr class="row-compare-info-wsvalueeaseofuse">
                                    <td>WorkFlow Service Average Value for Ease of Use</td>
                                </tr>
                                <tr class="row-compare-info-wsvaluereliability">
                                    <td>WorkFlow Service Average Value for Reliability</td>
                                </tr>
                                <tr class="row-compare-info-wsvaluePerformance">
                                    <td>WorkFlow Service Average Value for Performance</td>
                                </tr>
                                <tr class="row-compare-info-wsvalueDisponibility">
                                    <td>WorkFlow Service Average Value for Disponibility</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Internal Metrics Visualization</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div id="chart-internalmetrics"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Usage</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table id="tbl-compare-usage" class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>Info</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="row-compare-info-usageactivities">
                                    <td>Activities Using</td>
                                </tr>
                                <tr class="row-compare-info-usageworkflows">
                                    <td>Workflows Using</td>
                                </tr>
                                <tr class="row-compare-info-usageexperiments">
                                    <td>Experiments Using</td>
                                </tr>
                                <tr class="row-compare-info-usageresearchers">
                                    <td>Researchers Using</td>
                                </tr>
                                <tr class="row-compare-info-usagemostcommonarea">
                                    <td>Most Common Area</td>
                                </tr>
                                <tr class="row-compare-info-usagedatelastused">
                                    <td>Date Last Used</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Usage Visualization</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div id="chart-usage"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Ratings</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table id="tbl-compare" class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>Info</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="row-compare-info-wstotalratings">
                                    <td>WorkFlow Service Total Ratings</td>
                                </tr>
                                <tr class="row-compare-info-wstotalapprovals">
                                    <td>WorkFlow Service Total Approvals</td>
                                </tr>
                                <tr class="row-compare-info-wsvaluedocumentation">
                                    <td>WorkFlow Service Average Value for Documentation</td>
                                </tr>
                                <tr class="row-compare-info-wsvalueeaseofuse">
                                    <td>WorkFlow Service Average Value for Ease of Use</td>
                                </tr>
                                <tr class="row-compare-info-wsvaluereliability">
                                    <td>WorkFlow Service Average Value for Reliability</td>
                                </tr>
                                <tr class="row-compare-info-wsvaluePerformance">
                                    <td>WorkFlow Service Average Value for Performance</td>
                                </tr>
                                <tr class="row-compare-info-wsvalueDisponibility">
                                    <td>WorkFlow Service Average Value for Disponibility</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Ratings Visualization</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div id="chart-ratings"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>