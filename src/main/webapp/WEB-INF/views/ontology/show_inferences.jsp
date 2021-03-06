<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<% pageContext.setAttribute("lf", "\n"); %>
<% pageContext.setAttribute("cr", "\r");%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Experiments
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
            var provenanceJson = JSON.parse('${objectInferencesJson}');
            /***********************************************/
            /* USAGE AND RELATIONS GRAPH                   */
            /***********************************************/
            function showProvenanceGraphVisualization() {
                var target = "#box-chart-provenance-graph";
                var width = $(target).css("width");
                width = width.replace("px", "");
                drawProvenanceGraph(provenanceJson, target, width);
            }
            ;
            showProvenanceGraphVisualization();

        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/ontology"/>"><i class="fa fa-street-view"></i> Ontology Service</a></li>
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

            <h2>Provenance Visualization</h2>
            <br/>

            <div class="panel panel-default">             
                <div class="panel-body" style="position: relative;">
                    <div id="box-chart-provenance-graph"></div>
                </div>
            </div>


        </div>
    </jsp:body>
</t:layout-app>