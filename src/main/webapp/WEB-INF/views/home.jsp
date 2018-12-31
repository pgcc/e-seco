<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Home
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            // Get JSON Data for visualizations;
            var chartJson = JSON.parse('${chartDataJSON}');

            /***********************************************/
            /* BUBLLE MENU                                 */
            /***********************************************/
            function showBubbleChartVisualization() {
                drawBubbleChart(chartJson);
            };
            showBubbleChartVisualization();
        </script>

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/"/>"><i class="fa fa-street-view"></i> Home</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <c:if test="${fn:length(notifications) >= 1}">
                    <ul class="list-group margin-15-top">
                        <li class="list-group-item list-group-item-warning">
                            <i class="fa fa-exclamation-triangle"></i> Important Notifications
                        </li>

                        <c:forEach var="notification" items="${notifications}">
                            <li class="list-group-item">
                                <a href="<c:url value="${notification.link}"/>">
                                    <i class="fa ${notification.icon}"></i> <span>${notification.text}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Welcome to E-SECO
                        </h3>
                    </div>
                    <div class="panel-body">
                        <p>E-science Software Ecosystem</p>
                    </div>
                </div>
            </div>

            <div class="col-xs-12 col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Network Stats
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div class="bubbleChart"></div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>