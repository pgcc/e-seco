<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Activities
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/experiments/activities"/>"> Activities</a></li>
            <li><a href="<c:url value="/experiments/activities/${activity.id}"/>">View</a></li>
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

            <h2>Activity Detail</h2>
            <br />
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <label class="col-sm-2">ID</label>
                        <div class="col-sm-10">${activity.id}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Name</label>
                        <div class="col-sm-10">${activity.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Description</label>
                        <div class="col-sm-10">${activity.description}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Author</label>
                        <div class="col-sm-10">${activity.author.displayName}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Created in</label>
                        <div class="col-sm-10">${activity.dateCreated}</div>
                    </div>

                </div>
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                    Workflow Services                                
                                </a>
                                <span class="badge">${activity.workflowServices.size()}</span>
                            </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <ul class="list-group" >
                                    <c:forEach items="${activity.workflowServices}" var="service">
                                        <li class="list-group-item">${service.description}</li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <br/>
                <spring:url value="/experiments/activities" var="urlActivities" />
                <nav class="navbar navbar-inverse">
                <div>
                    <ul class="nav navbar-nav navbar-left">
                        <button onclick="location.href = '${urlActivities}'" class="btn btn-link">
                            <span class="glyphicon glyphicon-arrow-left"></span> Back
                        </button>
                    </ul>
                </div>
                </nav>
            </div>
        </jsp:body>
    </t:layout-app>