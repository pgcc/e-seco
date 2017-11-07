<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Activity Executions
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/experiments/activityExecutions"/>"> Activity Executions</a></li>
            <li><a href="<c:url value="/experiments/activityExecutions/${activityExecution.id}"/>">View</a></li>
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

            <h2>Activity Execution Detail</h2>
            <br />
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <label class="col-sm-2">ID</label>
                        <div class="col-sm-10">${activityExecution.id}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Activity Name</label>
                        <div class="col-sm-10">${activityExecution.activity.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Author</label>
                        <div class="col-sm-10">${activityExecution.author.displayName}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Start Time</label>
                        <div class="col-sm-10">${activityExecution.startTime}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">End Time</label>
                        <div class="col-sm-10">${activityExecution.endTime}</div>
                    </div>
                </div>


                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                    Inputs                                
                                </a>
                                <span class="badge">${activityExecution.inputs.size()}</span>
                            </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <ul class="list-group" >
                                    <c:forEach items="${activityExecution.inputs}" var="input">
                                        <li class="list-group-item">${input.entity.name}</li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingFour">
                            <h4 class="panel-title">
                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="true" aria-controls="collapseFour">
                                    Outputs
                                </a>
                                <span class="badge">${activityExecution.outputs.size()}</span>
                            </h4>
                        </div>
                        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                            <div class="panel-body">
                                <ul class="list-group" >
                                    <c:forEach items="${activityExecution.outputs}" var="output">
                                        <li class="list-group-item">${output.entity.name}</li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <br/>
                <spring:url value="/experiments/activityExecutions" var="urlActivityExecutions" />
                <nav class="navbar navbar-inverse">
                    <div>
                        <ul class="nav navbar-nav navbar-left">
                            <button onclick="location.href = '${urlActivityExecutions}'" class="btn btn-link">
                                <span class="glyphicon glyphicon-arrow-left"></span> Back
                            </button>
                        </ul>
                    </div>
                </nav>
            </div>
        </jsp:body>
    </t:layout-app>