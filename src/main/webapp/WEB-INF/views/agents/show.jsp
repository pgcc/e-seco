<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Agent Details of ${agent.name}
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/agents"/>"><i class="fa fa-street-view"></i> Agents</a></li>
            <li><a href="<c:url value="/agents/${agent.id}"/>"> Details of ${agent.name}</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Details of ${agent.name}</h2>
            </div>
            <div class="col-xs-12 col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading pnl-heading-buttons">
                        <h3 class="panel-title">Agent Basic Data</h3>
                    </div>
                    <div class="panel-body">
                        <ul class="list-group lst-data-value">
                            <li class="list-group-item">
                                <span>Name</span>
                                <span>${agent.name}</span>
                            </li>
                            <li class="list-group-item">
                                <span>Gender</span>
                                <c:if test="${fn:contains(agent.gender, 'M')}">
                                    <span>Male</span>
                                </c:if>
                                <c:if test="${fn:contains(agent.gender, 'F')}">
                                    <span>Female</span>
                                </c:if>
                            </li>
                            <li class="list-group-item">
                                <span>Birthday</span>
                                <span><fmt:formatDate pattern="yyyy-MM-dd" value="${agent.birthday}"/></span>
                            </li>
                            <li class="list-group-item">
                                <span>Email</span>
                                <span>${agent.user.email}</span>
                            </li>

                            <li class="list-group-item">
                                <span>Date Registered</span>
                                <span><fmt:formatDate pattern="yyyy-MM-dd H:m" value="${agent.user.registerDate}"/></span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-xs-12 col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading pnl-heading-buttons">
                        <h3 class="panel-title">Researcher Profile</h3>
                    </div>
                    <div class="panel-body">
                        <c:if test="${not empty agent.researcher}">
                            <a href="<c:url value="/researchers/${agent.researcher.id}"/>"> Click here to access the Profile</a>
                        </c:if>
                        <c:if test="${empty agent.researcher}">
                            <span>${agent.name} does not have a Researcher Profile</span>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="col-xs-12 col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading pnl-heading-buttons">
                        <h3 class="panel-title">Developer Profile</h3>
                    </div>
                    <div class="panel-body">
                        <c:if test="${not empty agent.developer}">
                            <a href="<c:url value="/developers/${agent.developer.id}"/>"> Click here to access the Profile</a>
                        </c:if>
                        <c:if test="${empty agent.developer}">
                            <span>${agent.name} does not have a Developer Profile</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>