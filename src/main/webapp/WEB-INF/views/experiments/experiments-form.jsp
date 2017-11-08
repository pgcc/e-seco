<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Experiment
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/experiments"/>"> Experiments</a></li>
                <c:choose>
                    <c:when test="${experimentForm['new']}">
                    <li><a href="<c:url value="/experiments/add"/>">Add</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/experiments/${experimentForm['id']}/update"/>">Update</a></li>
                    </c:otherwise>
                </c:choose>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">
            <c:choose>
                <c:when test="${experimentForm['new']}">
                    <h2>Add Experiment</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Experiment</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/experiments" var="experimentActionUrl" />

            <f:form class="form form-horizontal" method="post" modelAttribute="experimentForm" action="${experimentActionUrl}">

                <f:hidden path="id" />

                <spring:bind path="name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <f:input path="name" type="text" class="form-control " id="name" placeholder="Name" />
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


                <spring:bind path="dateUpdated">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Updated in</label>
                        <div class="col-sm-10">
                            <f:input path="dateUpdated" class="form-control mask-date" id="dateUpdated" placeholder="Updated in" disabled="true"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="dateEnded">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Ended in</label>
                        <div class="col-sm-10">
                            <f:input path="dateEnded" class="form-control mask-date" id="dateEnded" placeholder="Ended in" disabled="true"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="status">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Status</label>
                        <div class="col-sm-10">
                            <f:radiobuttons path="status" items="${statusList}" itemLabel="name" element="label class='radio-inline'" disabled="true" />
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

                <spring:bind path="version">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Version</label>
                        <div class="col-sm-10">
                            <f:input path="version" type="text" class="form-control" id="version" placeholder="Version" disabled="true"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="disciplines">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Disciplines</label>
                        <div class="col-sm-10">
                            <f:select path="disciplines" items="${disciplinesList}" multiple="true" size="3" class="form-control"/>
                            <f:errors path="disciplines" class="control-label" />
                        </div>
                    </div>
                </spring:bind>


                <spring:bind path="keywords">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Key Words</label>
                        <div class="col-sm-10">
                            <f:input path="keywords" type="text" class="form-control " id="keywords" placeholder="Type the keywords separated with commas." />
                            <f:errors path="keywords" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="institutions">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Institutions</label>
                        <div class="col-sm-10">
                            <f:select path="institutions" items="${institutionsList}" multiple="true" size="3" class="form-control" itemLabel="name" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="researchers">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Researchers</label>
                        <div class="col-sm-10">
                            <f:select path="researchers" items="${researchesList}" multiple="true" size="3" class="form-control" itemLabel="displayName" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="researchGroups">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Research Groups</label>
                        <div class="col-sm-10">
                            <f:select path="researchGroups" items="${researchGroupsList}" multiple="true" size="3" class="form-control" itemLabel="name" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="workflows">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Workflows</label>
                        <div class="col-sm-10">
                            <f:select path="workflows" items="${workflowsList}" multiple="true" size="3" class="form-control" itemLabel="name" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${experimentForm['new']}">
                                <button type="submit" cc:when test="${experimentForm['new']}" 
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