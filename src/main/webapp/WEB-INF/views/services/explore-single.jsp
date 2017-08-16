<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Services Explore Single view of ${resource.name}
    </jsp:attribute>


    <jsp:attribute name="stylesheets">
        <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.css"/>">
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v4.min.js" />"></script>
        <script type="text/javascript"
                src="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.js" />"></script>
        <script type="text/javascript">
            $("#btn-show-treemap").on("click", function () {
                drawTreemap('/eseco/resources/json/mydata.json');
            });

            $("#btn-show-treemap-2").on("click", function () {
                drawTreemap('<c:url value="/returnjson"/>');
            });

            $("#btn-show-radar").on("click", function () {
                drawRadar('/eseco/resources/json/radar11.json');
            });
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/services"/>"><i class="fa fa-street-view"></i> Services</a>
        <a href="<c:url value="/services/explore"/>"><i class="fa fa-angle-double-right"></i> Explore</a>
        <a href="<c:url value="/services/explore/single/${resource.id}"/>">
            <i class="fa fa-angle-double-right"></i> Single view of ${resource.name}</a>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Single view of resource: <strong>${resource.name}</strong></h2>

                <p>
                    <button id="btn-show-treemap" class="btn btn-info" type="button">TreeMap</button>
                    <button id="btn-show-treemap-2" class="btn btn-info" type="button">TreeMap 2</button>
                    <button id="btn-show-radar" class="btn btn-info" type="button">Radar</button>
                </p>

                <div id="chart"></div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>