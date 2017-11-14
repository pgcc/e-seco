<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Workflow Executions
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/experiments"/>"> Experiments</a></li>
            <li><a href="<c:url value="/experiments/workflows"/>">Workflows</a></li>
            <li><a href="<c:url value="/experiments/workflowExecutions"/>">Workflow Executions</a></li>
            <li><a href="<c:url value="/experiments/workflowExecutions/${workflowExecution.id}"/>">View</a></li>
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

            <h2>Workflow Execution Detail</h2>
            <br />
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <label class="col-sm-2">ID</label>
                        <div class="col-sm-10">${workflowExecution.id}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Workflow Name</label>
                        <div class="col-sm-10">${workflowExecution.workflow.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Author</label>
                        <div class="col-sm-10">${workflowExecution.author.displayName}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Start Time</label>
                        <div class="col-sm-10">${workflowExecution.startTime}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">End Time</label>
                        <div class="col-sm-10">${workflowExecution.endTime}</div>
                    </div>
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingOne">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Inputs                                
                                    </a>
                                    <span class="badge">${workflowExecution.inputs.size()}</span>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <c:forEach items="${workflowExecution.inputs}" var="input">
                                            <li class="list-group-item"><a href="<c:url value="/experiments/entities/${input.entity.id}"/>">${input.entity.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingTwo">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                        Outputs
                                    </a>
                                    <span class="badge">${workflowExecution.outputs.size()}</span>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <c:forEach items="${workflowExecution.outputs}" var="output">
                                            <li class="list-group-item"><a href="<c:url value="/experiments/entities/${output.entity.id}"/>">${output.entity.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <br/>
                <spring:url value="/experiments/workflowExecutions" var="urlWorkflowExecutions" />
                <spring:url value="/experiments/workflowExecutions/${workflowExecution.id}/update" var="urlUpdate" />
                <nav class="navbar navbar-inverse">
                    <div>
                        <ul class="nav navbar-nav navbar-left">
                            <button onclick="location.href = '${urlWorkflowExecutions}'" class="btn btn-link">
                                <span class="glyphicon glyphicon-arrow-left"></span> Back
                            </button>
                            <button onclick="location.href = '${urlUpdate}'" class="btn btn-link"><span class="glyphicon glyphicon-refresh"></span> Update</button>
                        </ul>
                    </div>
                </nav>
            </div>
        </jsp:body>
    </t:layout-app>