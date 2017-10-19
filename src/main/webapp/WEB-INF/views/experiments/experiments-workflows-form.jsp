<%@page contentType="text/html;charset=UTF-8" language="java" %>
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

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/experiments"/>"> Experiments</a></li>
            <li><a href="<c:url value="/experiments/${sessionScope.current_experiment_id}"/>"> View</a></li>
            <li><a href="<c:url value="/experiments/${sessionScope.current_experiment_id}/workflows/add"/>">Add Workflow</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${experimentWorkflowForm['new']}">
                    <h2>Add Workflow</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Workflow</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/experiments/${sessionScope.current_experiment_id}/workflows" var="experimentWorkflowsUrl" />

            <f:form class="form form-horizontal" method="post" modelAttribute="experimentWorkflowForm" 
                    action="${experimentWorkflowsUrl}">

                <f:hidden path="id" />

                <spring:bind path="name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <f:input path="name" class="form-control" rows="5" id="name" placeholder="Name" />
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

                <spring:bind path="link">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Link</label>
                        <div class="col-sm-10">
                            <f:input path="link" class="form-control" rows="5" id="link" placeholder="Link" />
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
                            <f:input path="dateCreated" class="form-control mask-date" id="dateCreated" placeholder="Created in" disabled="true"/>
                        </div>                        
                    </div>
                </spring:bind>

                <spring:bind path="version">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Version</label>
                        <div class="col-sm-10">
                            <f:input path="version" class="form-control" rows="5" id="version" placeholder="Version" />
                            <f:errors path="version" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${experimentWorkflowForm['new']}">
                                <button type="submit" cc:when test="${experimentWorkflowForm['new']}" class="btn-lg btn-primary pull-right">Add</button>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" class="btn-lg btn-primary pull-right">Update</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </f:form>
        </div>
    </jsp:body>
</t:layout-app>