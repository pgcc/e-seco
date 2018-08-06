<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Activity Execution
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
            <li><a href="<c:url value="/experiments/activities"/>"> Activities</a></li>
            <li><a href="<c:url value="/experiments/activityExecutions"/>">Activity Executions</a></li>
                <c:choose>
                    <c:when test="${activityExecutionForm['new']}">
                    <li><a href="<c:url value="/experiments/activityExecutions/add"/>">Add Activity Execution</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/experiments/activityExecutions/${activityExecutionForm['id']}/update"/>">Update</a></li>
                    </c:otherwise>
                </c:choose>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${activityExecutionForm['new']}">
                    <h2>Add Activity Execution</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Activity Execution</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/experiments/activityExecutions" var="experimentActivityExecutionsUrl" />

            <f:form class="form form-horizontal" method="post" modelAttribute="activityExecutionForm" 
                    action="${experimentActivityExecutionsUrl}">

                <f:hidden path="id" />


                <spring:bind path="activity">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Activity</label>
                        <div class="col-sm-10">
                            <f:select path="activity" items="${activityList}" multiple="false" size="1" class="form-control" itemLabel="name" itemValue="id" disabled="true"/>
                            <f:errors path="activity" class="control-label" />
                        </div>
                    </div>
                </spring:bind>


                <spring:bind path="author.displayName">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Author</label>
                        <div class="col-sm-10">
                            <f:input path="author.displayName" class="form-control" id="author" placeholder="Author" disabled="true"/>
                            <f:errors path="author" class="control-label" />
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

                <spring:bind path="inputs">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Inputs</label>
                        <div class="col-sm-10">
                            <f:select path="inputs" items="${inputsList}" multiple="true" size="3" class="form-control" itemLabel="fullName" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="outputs">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Outputs</label>
                        <div class="col-sm-10">
                            <f:select path="outputs" items="${outputsList}" multiple="true" size="3" class="form-control" itemLabel="fullName" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${activityExecutionForm['new']}">
                                <button type="submit" cc:when test="${activityExecutionForm['new']}" 
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