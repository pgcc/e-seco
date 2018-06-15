<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Workflow Execution
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">

        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/workflows"/>">Workflows</a></li>
            <li><a href="<c:url value="/experiments/workflowExecutions"/>">Workflow Executions</a></li>
                <c:choose>
                    <c:when test="${workflowExecutionForm['new']}">
                    <li><a href="<c:url value="/experiments/workflowExecutions/add"/>">Add Workflow Execution</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/experiments/workflowExecutions/${workflowExecutionForm['id']}/update"/>">Update</a></li>
                    </c:otherwise>
                </c:choose>

        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${workflowExecutionForm['new']}">
                    <h2>Add Workflow Execution</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Workflow Execution</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/experiments/workflowExecutions" var="experimentWorkflowExecutionsUrl" />

            <f:form class="form form-horizontal" method="post" modelAttribute="workflowExecutionForm" 
                    action="${experimentWorkflowExecutionsUrl}">

                <f:hidden path="id" />

                <spring:bind path="experiment">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Experiment</label>
                        <div class="col-sm-10">
                            <f:select path="experiment" items="${experimentList}" multiple="false" size="1" class="form-control" itemLabel="name" itemValue="id"/>
                            <f:errors path="experiment" class="control-label" />
                        </div>
                    </div>
                </spring:bind>
                
                <spring:bind path="workflow">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Workflow</label>
                        <div class="col-sm-10">
                            <f:select path="workflow" items="${workflowList}" multiple="false" size="1" class="form-control" itemLabel="name" itemValue="id"/>
                            <f:errors path="workflow" class="control-label" />
                        </div>
                    </div>
                </spring:bind>


                <spring:bind path="author.displayName">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Author</label>
                        <div class="col-sm-10">
                            <f:input path="author.displayName" class="form-control" id="author" placeholder="Author" disabled="true"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="startTime">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Start Time</label>
                        <div class="col-sm-10">
                            <f:input path="startTime" class="form-control datetimepicker" id="startTime" placeholder="Start Time"/>
                            <f:errors path="startTime" class="control-label" />
                        </div>                        
                    </div>
                </spring:bind>

                <spring:bind path="endTime">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">End Time</label>
                        <div class="col-sm-10">
                            <f:input path="endTime" class="form-control datetimepicker" id="endTime" placeholder="End Time"/>
                            <f:errors path="endTime" class="control-label" />
                        </div>                        
                    </div>
                </spring:bind>

                <spring:bind path="activityExecutions">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Activities Executions</label>
                        <div class="col-sm-10">
                            <f:select path="activityExecutions" items="${activityExecutionsList}" multiple="true" size="3" class="form-control" itemLabel="activity.name" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${workflowExecutionForm['new']}">
                                <button type="submit" cc:when test="${workflowExecutionForm['new']}" 
                                        class="btn btn-primary pull-right">Save</button>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" class="btn btn-primary pull-right">Update</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </f:form>
        </div>
    </jsp:body>
</t:layout-app>