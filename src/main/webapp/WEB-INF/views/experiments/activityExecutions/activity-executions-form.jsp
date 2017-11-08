<%@page contentType="text/html;charset=UTF-8" language="java" %>
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
            <li><a class="fa fa-street-view" href="<c:url value="/experiments"/>"> Experiments</a></li>
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

                <spring:bind path="activity.name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Activity Name</label>
                        <div class="col-sm-10">
                            <f:input path="activity.name" class="form-control" rows="5" id="name" placeholder="Activity Name" disabled="true"/>
                            <f:errors path="activity.name" class="control-label" />
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
                            <f:input path="startTime" class="form-control" id="startTime" placeholder="Start Time"/>
                        </div>                        
                    </div>
                </spring:bind>

                <spring:bind path="endTime">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">End Time</label>
                        <div class="col-sm-10">
                            <f:input path="endTime" class="form-control" id="endTime" placeholder="End Time"/>
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