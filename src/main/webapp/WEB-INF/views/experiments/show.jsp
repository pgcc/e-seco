<%@ page session="false"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Experiments
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a>
        <a href="<c:url value="/experiments"/>"><i class="fa fa-angle-double-right"></i> View</a>
    </jsp:attribute>


    <jsp:body>
        <div class="container">

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

            <div class="row">
                <label class="col-sm-2">ID</label>
                <div class="col-sm-10">${experiment.id}</div>
            </div>

            <div class="row">
                <label class="col-sm-2">Name</label>
                <div class="col-sm-10">${experiment.name}</div>
            </div>

            <div class="row">
                <label class="col-sm-2">Description</label>
                <div class="col-sm-10">${experiment.description}</div>
            </div>

            <div class="row">
                <label class="col-sm-2">Author</label>
                <div class="col-sm-10">${experiment.author.displayName}</div>
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

            <div class="row">
                <label class="col-sm-2">Status</label>
                <div class="col-sm-10">${experiment.status.name}</div>
            </div>

            <div class="row">
                <label class="col-sm-2">Current Phase</label>
                <div class="col-sm-10">${experiment.currentPhase.name}</div>
            </div>

            <div class="row">
                <label class="col-sm-2">Version</label>
                <div class="col-sm-10">${experiment.version}</div>
            </div>
            
            <div class="row">
                <label class="col-sm-2">Keywords</label>
                <div class="col-sm-10">${experiment.keywords}</div>
            </div>
        </div>

    </jsp:body>
</t:layout-app>