<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Activity
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            function addDetail() {
                var form = document.getElementById("activityform");
                var url = window.location.pathname.split("/activities", 1) + "/activities/addDetail";
                form.action = url;
                form.submit();
            }
            ;
            function removeDetail(index) {
                var form = document.getElementById("activityform");
                var url = window.location.pathname.split("/activities", 1) + "/activities/removeDetail?index=" + index;
                form.action = url;
                form.submit();
            }
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/workflows"/>">Workflows</a></li>
            <li><a href="<c:url value="/experiments/activities"/>"> Activities</a></li>
                <c:choose>
                    <c:when test="${activityForm['new']}">
                    <li><a href="<c:url value="/experiments/activities/add"/>">Add Activity</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/experiments/activities/${activityForm['id']}/update"/>">Update</a></li>
                    </c:otherwise>
                </c:choose>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${activityForm['new']}">
                    <h2>Add Activity</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Activity</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/experiments/activities" var="experimentActivitiesUrl" />

            <f:form id="activityform" class="form form-horizontal" method="post" modelAttribute="activityForm" 
                    action="${experimentActivitiesUrl}">

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
                            <f:input path="dateCreated" class="form-control" id="dateCreated" placeholder="Created in" disabled="true"/>
                        </div>                        
                    </div>
                </spring:bind>

                <spring:bind path="workflowServices">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Services</label>
                        <div class="col-sm-10">
                            <f:select path="workflowServices" items="${servicesList}" multiple="true" size="3" class="form-control" itemLabel="description" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

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
                                <label class="col-sm-2 ">Name</label>         
                                <label class="col-sm-10 ">Description</label>                     
                            </div>
                            <spring:bind path="details">
                                <c:forEach items="${activityForm['details'].toArray()}" var="detail" varStatus="loop">
                                    <div class="form-group">
                                        <div class="col-sm-2">
                                            <f:input path="details[${loop.index}].name" type="text" class="form-control " id="name" placeholder="Name" />
                                        </div>
                                        <div class="col-sm-8">
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

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${activityForm['new']}">
                                <button type="submit" cc:when test="${activityForm['new']}" 
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