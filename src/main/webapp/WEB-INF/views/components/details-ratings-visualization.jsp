<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components: Details of ${component.name}
    </jsp:attribute>


    <jsp:attribute name="stylesheets">
        <!--
        <link rel="stylesheet"
              href="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.css"/>">
        -->
        <style type="text/css">
            .parcoords {
                display: block;
            }

            .parcoords svg,
            .parcoords canvas {
                font: 12px sans-serif;
                position: absolute;
                opacity: 0.9;
                pointer-events: none;
            }

            .axis .title {
                font-size: 11px;
                transform: rotate(-20deg) translate(-5px, -6px);
            }

            .axis line,
            .axis path {
                fill: none;
                stroke: #000;
                stroke-width: 1px;
            }

            .brush .extent {
                fill-opacity: .3;
                stroke: #fff;
                stroke-width: 1px;
            }
        </style>
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v3.min.js" />"></script>
        <script type="text/javascript"
                src="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.js" />"></script>
        <script type="text/javascript">
            // Get JSON Data for visualizations
            var ratingsContextJson = JSON.parse('${workflowServiceRatingContextInfoJSON}');

            /***********************************************/
            /* RATINGS VISUALIZATIONS                      */
            /***********************************************/
            function showRatingsVisualization() {
                var parallelCoordinatesData = mountDataToParallelCoordinates(ratingsContextJson);
                drawParallelCoordinates(parallelCoordinatesData, "chart-ratings");
            };

            function mountDataToParallelCoordinates(ratingsData) {

                var parallelCoordinatesData = [];

                $.each(ratingsData, function (i, rating) {

                    var dateCreated = new Date(rating.dateCreated);
                    var month = dateCreated.getUTCMonth() + 1;
                    var day = dateCreated.getUTCDate();
                    var year = dateCreated.getUTCFullYear();

                    dateCreated = year + "/" + month + "/" + day;

                    var dataObject = {
                        "developer": rating.authorName,
                        "date": dateCreated,
                        "documentation": rating.valueDocumentation,
                        "ease_of_use": rating.valueEaseOfUse,
                        "reliability": rating.valueReliability,
                        "performance": rating.valuePerformance,
                        "availability": rating.valueDisponibility
                    };

                    parallelCoordinatesData.push(dataObject);
                });

                return parallelCoordinatesData;
            }

            showRatingsVisualization();
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="<c:url value="/components/details/${type}/${component.id}"/>">Details of ${component.name}</a>
            </li>
            <li><a href="<c:url value="/components/details/${type}/${component.id}/ratings-visualization"/>">Ratings
                for ${component.name}</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Ratings for: <strong>${componentContextInfo.name}</strong></h2>

                <div class="row">
                    <div class="col col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="chart-ratings"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>