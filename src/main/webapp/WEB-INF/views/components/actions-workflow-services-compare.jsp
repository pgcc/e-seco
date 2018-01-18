<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Actions - Workflow Services Compare
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
                tbl_tbody.find("tr.row-compare-info-wstotalresearcherratings").append(
                    $("<td>").text(item.totalResearcherRatings)
                );

                tbl_tbody.find("tr.row-compare-info-wstotaldeveloperratings").append(
                    $("<td>").text(item.totalDeveloperRatings)
                );

                // Workflow Service Total Approvals
                tbl_tbody.find("tr.row-compare-info-wstotalapprovals").append(
                    $("<td>").text(item.totalApprovals)
                );

                // Workflow Service Total Approvals
                tbl_tbody.find("tr.row-compare-info-wstotalreprovals").append(
                    $("<td>").text(item.totalReprovals)
                );

                // Workflow Service Average Value for Documentation
                tbl_tbody.find("tr.row-compare-info-wsvaluedocumentation").append(
                    $("<td>").text(item.avgValueDocumentation)
                );

                // Workflow Service Average Value for Ease of Use
                tbl_tbody.find("tr.row-compare-info-wsvalueeaseofuse").append(
                    $("<td>").text(item.avgValueEaseOfUse)
                );

                // Workflow Service Average Value for Reliability
                tbl_tbody.find("tr.row-compare-info-wsvaluereliability").append(
                    $("<td>").text(item.avgValueReliability)
                );

                // Workflow Service Average Value for Performance
                tbl_tbody.find("tr.row-compare-info-wsvaluePerformance").append(
                    $("<td>").text(item.avgValuePerformance)
                );

                // Workflow Service Average Value for Disponibility
                tbl_tbody.find("tr.row-compare-info-wsvalueDisponibility").append(
                    $("<td>").text(item.avgValueDisponibility)
                );
            }

            $.each(itemsToCompare, function (i, item) {
                addItemToComparationsTable(item);
            });


            /***********************************************/
            /* INTERNAL METRICS VISUALIZATION              */
            /***********************************************/
            function showInternalMetricsVisualization() {

                var higherNumber = 0;

                // Mount Radar Data
                var radarData = [];
                $.each(itemsToCompare, function (i, item) {
                    // Determine Higher Number
                    if(item.wsInternalClassInternalMetrics.parametersCount > higherNumber){
                        higherNumber = item.wsInternalClassInternalMetrics.parametersCount;
                    }
                    if(item.wsInternalClassInternalMetrics.methodsCount > higherNumber){
                        higherNumber = item.wsInternalClassInternalMetrics.methodsCount;
                    }
                    if(item.wsInternalClassInternalMetrics.servicesCount > higherNumber){
                        higherNumber = item.wsInternalClassInternalMetrics.servicesCount;
                    }
                    if(item.wsInternalClassInternalMetrics.esecoCoreServicesCount > higherNumber){
                        higherNumber = item.wsInternalClassInternalMetrics.esecoCoreServicesCount;
                    }
                    if(item.wsInternalClassInternalMetrics.esecoWorkflowServicesCount > higherNumber){
                        higherNumber = item.wsInternalClassInternalMetrics.esecoWorkflowServicesCount;
                    }

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

                drawRadar(radarData, "chart-internalmetrics", higherNumber);
            };

            function showUsageVisualization() {

                var higherNumber = 0;

                // Mount Radar Data
                var radarData = [];
                $.each(itemsToCompare, function (i, item) {
                    // Determine Higher Number
                    if(item.activitiesUsingCount > higherNumber){
                        higherNumber = item.activitiesUsingCount;
                    }
                    if(item.activitiesUsingCount > higherNumber){
                        higherNumber = item.workflowsUsingCount;
                    }
                    if(item.activitiesUsingCount > higherNumber){
                        higherNumber = item.experimentsUsingCount;
                    }
                    if(item.activitiesUsingCount > higherNumber){
                        higherNumber = item.researchersUsingCount;
                    }

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

                drawRadar(radarData, "chart-usage", higherNumber);
            };

            function showRatingsVisualization() {

                // Mount Radar Data
                var radarData = [];
                $.each(itemsToCompare, function (i, item) {
                    var itemData = [];

                    itemData.push({
                        "item_id": item.name,
                        "area": "Documentation",
                        "value": item.avgValueDocumentation
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Ease of Use",
                        "value": item.avgValueEaseOfUse
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Reliability",
                        "value": item.avgValueReliability
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Performance",
                        "value": item.avgValuePerformance
                    });
                    itemData.push({
                        "item_id": item.name,
                        "area": "Availability",
                        "value": item.avgValueDisponibility
                    });

                    radarData.push(itemData);
                });

                drawRadar(radarData, "chart-ratings", 10);
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
                        <h3 class="panel-title">
                            <a href="#collapseBasicInfo" class="collapsed" role="button" data-toggle="collapse">
                                Basic Info <i class="fa fa-plus-circle"></i>
                            </a>
                        </h3>
                    </div>
                    <div id="collapseBasicInfo" class="panel-collapse collapse out">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table id="tbl-compare-basicinfo" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th class="text-center">Info / Service</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr class="row-compare-info-type">
                                        <td><strong>Type</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-datecreated">
                                        <td><strong>Date Created</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-dateupdated">
                                        <td><strong>Date Last Updated</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-author">
                                        <td><strong>Author</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wstype">
                                        <td><strong>WorkFlow Service Type</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsnature">
                                        <td><strong>WorkFlow Service Nature</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wslocation">
                                        <td><strong>WorkFlow Service Location</strong></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <a href="#collapseInternalMetrics" class="collapsed" role="button" data-toggle="collapse">
                                Internal Metrics <i class="fa fa-plus-circle"></i>
                            </a>
                        </h3>
                    </div>
                    <div id="collapseInternalMetrics" class="panel-collapse collapse out">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table id="tbl-compare-internalmetrics" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th class="text-center">Info / Service</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr class="row-compare-info-wsinternalclass">
                                        <td><strong>WorkFlow Service Internal Class</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsclassparametercount">
                                        <td><strong>Class Parameter Count</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsclassmethodcount">
                                        <td><strong>Class Method Count</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wstotalservicesused">
                                        <td><strong>Total Services Used</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsesecocoreservicesused">
                                        <td><strong>E-Seco Core Services Used</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsesecoworkflowservicesused">
                                        <td><strong>E-Seco Workflow Services Used</strong></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <a href="#collapseInternalMetricsVisualization" class="collapsed" role="button"
                               data-toggle="collapse">
                                Internal Metrics Visualization <i class="fa fa-plus-circle"></i>
                            </a>
                        </h3>
                    </div>
                    <div id="collapseInternalMetricsVisualization" class="panel-collapse collapse out">
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
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <a href="#collapseUsage" class="collapsed" role="button" data-toggle="collapse">
                                Service Usage <i class="fa fa-plus-circle"></i>
                            </a>
                        </h3>
                    </div>
                    <div id="collapseUsage" class="panel-collapse collapse out">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table id="tbl-compare-usage" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th class="text-center">Info / Service</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr class="row-compare-info-usageactivities">
                                        <td><strong>Activities Using</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-usageworkflows">
                                        <td><strong>Workflows Using</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-usageexperiments">
                                        <td><strong>Experiments Using</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-usageresearchers">
                                        <td><strong>Researchers Using</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-usagemostcommonarea">
                                        <td><strong>Most Common Area</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-usagedatelastused">
                                        <td><strong>Date Last Used</strong></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <a href="#collapseUsageVisualization" class="collapsed" role="button"
                               data-toggle="collapse">
                                Visualization of Service Usage <i class="fa fa-plus-circle"></i>
                            </a>
                        </h3>
                    </div>
                    <div id="collapseUsageVisualization" class="panel-collapse collapse out">
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
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <a href="#collapseResearchersRatings" class="collapsed" role="button" data-toggle="collapse">
                                Reseachers Ratings <i class="fa fa-plus-circle"></i>
                            </a>
                        </h3>
                    </div>
                    <div id="collapseResearchersRatings" class="panel-collapse collapse out">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table id="tbl-compare-researcher-ratings" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th class="text-center">Info / Service</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr class="row-compare-info-wstotalresearcherratings">
                                        <td><strong>Total Researchers Ratings</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wstotalapprovals">
                                        <td><strong>Total Approvals</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wstotalreprovals">
                                        <td><strong>Total Reprovals</strong></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <a href="#collapseDevelopersRatings" class="collapsed" role="button" data-toggle="collapse">
                                Developers Ratings <i class="fa fa-plus-circle"></i>
                            </a>
                        </h3>
                    </div>
                    <div id="collapseDevelopersRatings" class="panel-collapse collapse out">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table id="tbl-compare-developers-ratings" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th class="text-center">Info / Service</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr class="row-compare-info-wstotaldeveloperratings">
                                        <td><strong>Total Developers Ratings</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsvaluedocumentation">
                                        <td><strong>Average Value for Documentation</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsvalueeaseofuse">
                                        <td><strong>Average Value for Ease of Use</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsvaluereliability">
                                        <td><strong>Average Value for Reliability</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsvaluePerformance">
                                        <td><strong>Average Value for Performance</strong></td>
                                    </tr>
                                    <tr class="row-compare-info-wsvalueDisponibility">
                                        <td><strong>Average Value for Availability</strong></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <a href="#collapseDevelopersRatingsVisualization" class="collapsed" role="button"
                               data-toggle="collapse">
                                Developers Ratings Visualization <i class="fa fa-plus-circle"></i>
                            </a>
                        </h3>
                    </div>
                    <div id="collapseDevelopersRatingsVisualization" class="panel-collapse collapse out">
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
        </div>
    </jsp:body>
</t:layout-app>