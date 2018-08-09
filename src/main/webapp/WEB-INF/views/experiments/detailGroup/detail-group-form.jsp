<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Details Group
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
            <li><a href="<c:url value="/experiments/detailGroup/"/>">Detail Group</a></li>
            <c:choose>
                <c:when test="${detailGroupForm['new']}">
                    <li><a href="<c:url value="/experiments/detailGroup/add"/>">Add</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/experiments/detailGroup/${detailGroupForm['id']}/update"/>">Update</a></li>
                    </c:otherwise>
                </c:choose>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${detailGroupForm['new']}">
                    <h2>Add Detail Group</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Detail Group</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/experiments/detailGroup" var="experimentDetailGroupUrl" />

            <f:form class="form form-horizontal" method="post" modelAttribute="detailGroupForm" 
                    action="${experimentDetailGroupUrl}">

                <f:hidden path="id" />

                <spring:bind path="name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <f:input path="name" class="form-control" id="name" placeholder="Name"/>
                            <f:errors path="name" class="control-label" />
                        </div>
                    </div>
                </spring:bind>


                <spring:bind path="details">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Details</label>
                        <div class="col-sm-10">
                            <f:textarea path="details" class="form-control" id="details" placeholder="Enter with the required details for this group separated by comma." rows="5"/>
                            <f:errors path="details" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${detailGroupForm['new']}">
                                <button type="submit" cc:when test="${detailGroupForm['new']}" 
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