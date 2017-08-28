<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Notifications
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/notifications"/>"><i class="fa fa-street-view"></i> Notifications</a>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Notifications</h2>

                <c:if test="${fn:length(importantNotifications) >= 1}">
                    <ul class="list-group">
                        <li class="list-group-item list-group-item-warning">
                            <i class="fa fa-exclamation-triangle"></i> Important Notifications
                        </li>

                        <c:forEach var="notification" items="${importantNotifications}">
                            <li class="list-group-item ">
                                <a href="<c:url value="${notification.link}"/>">
                                    <i class="fa ${notification.icon}"></i> <span>${notification.text}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>

                <c:if test="${fn:length(commonNotifications) >= 1}">
                    <ul class="list-group">
                        <li class="list-group-item list-group-item-info">
                            <i class="fa fa-bell"></i> Common Notifications
                        </li>

                        <c:forEach var="notification" items="${commonNotifications}">
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
    </jsp:body>
</t:layout-app>