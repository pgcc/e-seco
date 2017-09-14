<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components: Details of ${component.name}
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

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
                                        <span>1</span>
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
                                        <span>Protocol</span>
                                        <span>REST</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Nature</span>
                                        <span>Composed</span>
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
                                        <span>3</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Cientists</span>
                                        <span>2</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Most Common Area</span>
                                        <span>Biology</span>
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
                                        <span>Total Ratings</span>
                                        <span>0</span>
                                    </li>
                                </ul>

                                <div class="text-center">
                                    <button class="btn btn-info" type="button">Invite for Rating</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col col-xs-12 col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Dependencies</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="list-group lst-data-value">
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
                                    <button class="btn btn-info" type="button">Visualize</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>