<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Workflow
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            function addActivity() {
                var url = window.location.pathname.split("/experiments", 1) + "/experiments/workflows/addActivities";
                var form = document.getElementById("workflowform");

                form.action = url;
                form.submit();
            }
            ;
            function removeActivity(index) {
                var form = document.getElementById("workflowform");
                var url = window.location.pathname.split("/experiments", 1) + "/experiments/workflows/removeActivity?index=" + index;
                form.action = url;
                form.submit();
            }
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/workflows"/>">Workflows</a></li>
                <c:choose>
                    <c:when test="${workflowForm['new']}">
                    <li><a href="<c:url value="/experiments/workflows/add"/>">Add</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/experiments/workflows/${workflowForm['id']}/update"/>">Update</a></li>
                    </c:otherwise>
                </c:choose>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${workflowForm['new']}">
                    <h2>Add Workflow</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Workflow</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/experiments/workflows" var="experimentWorkflowsUrl" />

            <f:form id="workflowform" class="form form-horizontal" method="post" modelAttribute="workflowForm" 
                    action="${experimentWorkflowsUrl}">

                <f:hidden path="id" />

                <spring:bind path="name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <f:input path="name" class="form-control" id="name" placeholder="Name" />
                            <f:errors path="name" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="description">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Description</label>
                        <div class="col-sm-10">
                            <f:textarea path="description" class="form-control" rows="5" id="description" placeholder="Description" />
                            <f:errors path="description" class="control-label" />
                        </div>
                    </div>
                </spring:bind>
                <spring:bind path="wfms">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Wfms</label>
                        <div class="col-sm-10">
                            <f:radiobuttons path="wfms.id" items="${wfmsList}" itemLabel="name" itemValue="id" element="label class='radio-inline'" />

                        </div>
                        <div class="col-sm-10 col-sm-offset-2">
                            <f:errors path="wfms" class="control-label" />
                        </div>
                    </div>
                </spring:bind>
                <spring:bind path="link">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Link</label>
                        <div class="col-sm-10">
                            <f:input path="link" class="form-control" id="link" placeholder="Link" />
                            <f:errors path="link" class="control-label" />
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

                <spring:bind path="dateCreated">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Created in</label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <f:input path="dateCreated" class="form-control datepicker" id="dateCreated"  disabled="true"/>
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>    
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="version">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Version</label>
                        <div class="col-sm-10">
                            <f:input path="version" class="form-control" id="version" placeholder="Version" />
                            <f:errors path="version" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="experiments">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Experiments</label>
                        <div class="col-sm-10">
                            <f:select path="experiments" items="${experimentsList}" multiple="true" size="3" class="form-control" itemLabel="name" itemValue="id"/>
                            <f:errors path="experiments" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="activities">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Activities</label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <f:select path="activities" items="${activitiesList}" multiple="true" size="3" class="form-control" itemLabel="name" itemValue="id"/>
                                <span class="input-group-btn">
                                    <button class="btn btn-primary" type="button" style="height: 68px" onclick="addActivity()">Select Activities</button>
                                </span>
                            </div>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="workflowActivities">
                    <label class="col-sm-2 control-label">Activities Sequence</label>
                    <label class="col-sm-2 control-label" style="text-align: center">Sequence</label>
                    <label class="col-sm-8 control-label" style="text-align: center">Activity</label>
                    <c:forEach items="${workflowForm['workflowActivities']}" var="workflowActivity" varStatus="loop">
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            
                            <label class="col-sm-2 control-label"></label>
                            <div class="col-sm-2">
                                <f:input path="workflowActivities[${loop.index}].orderExec" type="text" class="form-control " id="orderExec" placeholder="Execution Order" />
                            </div>
                            <div class="col-sm-7">
                                <f:input path="workflowActivities[${loop.index}].activity.name" disabled="true" class="form-control" id="activity" placeholder="Activity" />                                            
                            </div>
                            <div class="col-sm-1">
                                <button type="button" class="btn btn-danger btn-link" title="delete" onclick="removeActivity('${loop.index}')">
                                    <span class="glyphicon glyphicon-remove"/>
                                </button>
                            </div>
                        </div>
                        <f:errors path="workflowActivities" class="control-label" />
                    </c:forEach>
                </spring:bind>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${workflowForm['new']}">
                                <button type="submit" cc:when test="${workflowForm['new']}" 
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