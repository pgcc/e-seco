<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Experiment Phase Report
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/experiments"/>"> Experiments</a></li>
            <li><a href="<c:url value="/experiments/${experimentPhaseReportForm.experiment.id}"/>"> View</a></li>
            <li><a href="<c:url value="/experiments/${experimentPhaseReportForm.experiment.id}/experimentPhaseReport/add"/>">Add Experiment Phase Report</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${experimentPhaseReportForm['new']}">
                    <h2>Add Experiment Phase Report</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Experiment Phase Report</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/experiments/experimentPhaseReport" var="experimentPhaseReportActionUrl" />

            <f:form class="form form-horizontal" method="post" modelAttribute="experimentPhaseReportForm" action="${experimentPhaseReportActionUrl}">

                <f:hidden path="id" />

                <spring:bind path="description">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Description</label>
                        <div class="col-sm-10">
                            <f:textarea path="description" class="form-control" rows="5" id="description" placeholder="Description" />
                            <f:errors path="description" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="experiment.name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Experiment Name</label>
                        <div class="col-sm-10">
                            <f:input path="experiment.name" class="form-control" id="experiment.name" placeholder="Experiment Name" disabled="true"/>
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

                <spring:bind path="currentPhase">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Current Phase</label>
                        <div class="col-sm-10">
                            <f:radiobuttons path="currentPhase" items="${phaseList}" itemLabel="name" element="label class='radio-inline'" disabled="true" />
                        </div>
                    </div>
                </spring:bind>


                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${experimentPhaseReportForm['new']}">
                                <button type="submit" cc:when test="${experimentPhaseReportForm['new']}" 
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