<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
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
        <script type="text/javascript">
            function addDetail() {
                var url = window.location.pathname.split("/experiments", 1) + "/experiments/addDetail";
                var form = document.getElementById("experimentform");
                form.action = url;
                form.submit();
            }
            ;
            function removeDetail(index) {
                var form = document.getElementById("experimentform");
                var url = window.location.pathname.split("/experiments", 1) + "/experiments/removeDetail?index=" + index;
                form.action = url;
                form.submit();
            }
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
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

            <f:form id="experimentform" class="form form-horizontal" method="post" modelAttribute="experimentForm" action="${experimentActionUrl}">

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
                            <f:input path="author.displayName" class="form-control" id="author" disabled="true" />
                        </div>
                    </div>
                </spring:bind>
                <div class="form-group">
                    <spring:bind path="dateCreated">
                        <label class="col-sm-2 control-label">Created in</label>
                        <div class="col-sm-2">
                            <div class="input-group">
                                <f:input path="dateCreated" class="form-control datepicker" id="dateCreated" />
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>    
                        </div>
                    </spring:bind>
                    <spring:bind path="dateUpdated">                    
                        <label class="col-sm-2 control-label">Updated in</label>
                        <div class="col-sm-2">
                            <div class="input-group">
                                <f:input path="dateUpdated" class="form-control datepicker" id="dateUpdated" />
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>                    
                    </spring:bind>

                    <spring:bind path="dateEnded">                    
                        <label class="col-sm-2 control-label">Ended in</label>
                        <div class="col-sm-2">
                            <div class="input-group">
                                <f:input path="dateEnded" class="form-control datepicker" id="dateEnded"/>
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>                    
                    </spring:bind>
                </div>

                <div class="form-group">
                    <spring:bind path="status">
                        <label class="col-sm-2 control-label">Status</label>
                        <div class="col-sm-2">
                            <f:radiobuttons path="status" items="${statusList}" itemLabel="name" element="label class='radio-inline'" disabled="true" />
                        </div>
                    </spring:bind>

                    <spring:bind path="currentPhase">                    
                        <label class="col-sm-2 control-label">Current Phase</label>
                        <div class="col-sm-6">
                            <f:radiobuttons path="currentPhase" items="${phaseList}" itemLabel="name" element="label class='radio-inline'" disabled="true" />
                        </div>                    
                    </spring:bind>
                </div>

                <spring:bind path="version">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Version</label>
                        <div class="col-sm-10">
                            <f:input path="version" type="text" class="form-control" id="version" placeholder="Version"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="disciplines">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Disciplines</label>
                        <div class="col-sm-10">
                            <f:select path="disciplines" items="${disciplinesList}" multiple="true" size="3" itemLabel="name" itemValue="id" class="form-control"/>
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

                <spring:bind path="workflows">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Workflows</label>
                        <div class="col-sm-10">
                            <f:select path="workflows" items="${workflowsList}" multiple="true" size="3" class="form-control" itemLabel="name" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

                <div class="form-group">
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingOne">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Agents Involved
                                    </a>                                    
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    <spring:bind path="institutions">
                                        <div class="form-group ${status.error ? 'has-error' : ''}">
                                            <label class="col-sm-2 control-label">Institutions</label>
                                            <div class="col-sm-10">
                                                <f:select path="institutions" items="${institutionsList}" multiple="true" size="3" class="form-control" itemLabel="name" itemValue="id"/>
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

                                    <spring:bind path="researchers">
                                        <div class="form-group ${status.error ? 'has-error' : ''}">
                                            <label class="col-sm-2 control-label">Researchers</label>
                                            <div class="col-sm-10">
                                                <f:select path="researchers" items="${researchesList}" multiple="true" size="3" class="form-control" itemLabel="displayName" itemValue="id"/>
                                            </div>
                                        </div>
                                    </spring:bind>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingTwo">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                        Protocol                         
                                    </a>                                    
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTwo">
                                <div class="panel-body">    
                                    <div class="form-group">
                                        <label class="col-sm-4 ">Name</label>         
                                        <label class="col-sm-8 ">Description</label>                     
                                    </div>
                                    <spring:bind path="details">
                                        <c:forEach items="${experimentForm['details'].toArray()}" var="detail" varStatus="loop">
                                            <div class="form-group">
                                                <div class="col-sm-4">
                                                    <f:input path="details[${loop.index}].name" type="text" class="form-control " id="name" placeholder="Name" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <f:textarea path="details[${loop.index}].description"  class="form-control" rows="1" id="description" placeholder="Description" />                                            
                                                </div>
                                                <div class="col-sm-2">
                                                    <button type="button" class="btn btn-danger btn-link" title="add new" onclick="addDetail()">
                                                        <span class="glyphicon glyphicon-plus"/>
                                                    </button>
                                                    <button type="button" class="btn btn-danger btn-link" title="delete" onclick="removeDetail('${loop.index}')">
                                                        <span class="glyphicon glyphicon-remove"/>
                                                    </button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </spring:bind>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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