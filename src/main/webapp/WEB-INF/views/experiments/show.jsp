<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Experiment
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/experiments"/>"> Experiments</a></li>
            <li><a href="<c:url value="/experiments/${experiment.id}"/>">View</a></li>
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

            <h2>Experiment Detail</h2>
            <br />
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <label class="col-sm-2">ID</label>
                        <div class="col-sm-10">${experiment.id}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Name</label>
                        <div class="col-sm-10">${experiment.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Status</label>
                        <div class="col-sm-10">${experiment.status.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Current Phase</label>
                        <div class="col-sm-10">${experiment.currentPhase.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Description</label>
                        <div class="col-sm-10">${experiment.description}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Version</label>
                        <div class="col-sm-10">${experiment.version}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Author</label>
                        <div class="col-sm-10">${experiment.author.displayName}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Keywords</label>
                        <div class="col-sm-10">${experiment.keywords}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Created in</label>
                        <div class="col-sm-10">${experiment.dateCreated}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Updated in</label>
                        <div class="col-sm-10">${experiment.dateUpdated}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Ended in</label>
                        <div class="col-sm-10">${experiment.dateEnded}</div>
                    </div>
                </div>
            </div>
            <br/>
            <spring:url value="/experiments" var="urlExperiments" />
            <spring:url value="/experiments/${experiment.id}/experimentPhaseReport/add" var="urlExperimentPhaseReport" />
            <nav class="navbar navbar-inverse">
                <div>
                    <ul class="nav navbar-nav navbar-left">
                        <button onclick="location.href = '${urlExperiments}'" class="btn btn-link">
                            <span class="glyphicon glyphicon-arrow-left"></span> Back
                        </button>
                        <c:if test="${!sessionScope.experiment_finished}">
                            <button onclick="location.href = '${urlExperimentPhaseReport}'" class="btn btn-link">
                                <span class="glyphicon glyphicon-arrow-right"></span> Go To Next Phase
                            </button>
                        </c:if>
                    </ul>
                </div>
            </nav>
        </div>
    </jsp:body>
</t:layout-app>