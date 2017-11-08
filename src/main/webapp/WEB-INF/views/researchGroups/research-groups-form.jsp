<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Research Group
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">

        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/researchGroups"/>"> Research Groups</a></li>
            <li><a href="<c:url value="/researchGroups/add"/>">Add Research Group</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${researchGroupForm['new']}">
                    <h2>Add Research Group</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Research Group</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/researchGroups" var="researchGroupsUrl" />

            <f:form class="form form-horizontal" method="post" modelAttribute="researchGroupForm" 
                    action="${researchGroupsUrl}">

                <f:hidden path="id" />

                <spring:bind path="name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <f:input path="name" class="form-control" rows="5" id="name" placeholder="Name"/>
                            <f:errors path="name" class="control-label" />
                        </div>
                    </div>
                </spring:bind>
                <spring:bind path="description">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Description</label>
                        <div class="col-sm-10">
                            <f:textarea path="description" class="form-control" rows="5" id="description" placeholder="Description"/>
                            <f:errors path="description" class="control-label" />
                        </div>
                    </div>
                </spring:bind>
                <spring:bind path="webPage">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Web Page</label>
                        <div class="col-sm-10">
                            <f:input path="webPage" class="form-control" rows="5" id="webPage" placeholder="Web Page"/>
                            <f:errors path="webPage" class="control-label" />
                        </div>
                    </div>
                </spring:bind>
                <spring:bind path="members">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Members</label>
                        <div class="col-sm-10">
                            <f:select path="members" items="${researchesList}" multiple="true" size="3" class="form-control" itemLabel="displayName" itemValue="id"/>
                            <f:errors path="members" class="control-label" />
                        </div>
                    </div>
                </spring:bind>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${researchGroupForm['new']}">
                                <button type="submit" cc:when test="${researchGroupForm['new']}" 
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