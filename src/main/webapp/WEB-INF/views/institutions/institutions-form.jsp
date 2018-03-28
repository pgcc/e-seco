<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Institution
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">

        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/institutions"/>"><i class="fa fa-street-view"></i> Institutions</a></li>            
            <c:choose>
                    <c:when test="${institutionForm['new']}">
                    <li><a href="<c:url value="/institutions/add"/>">Add</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/institutions/${institutionForm['id']}/update"/>">Update</a></li>
                    </c:otherwise>
                </c:choose>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${institutionForm['new']}">
                    <h2>Add Institution</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Institution</h2>
                </c:otherwise>
            </c:choose>
            <br />
            
            <spring:url value="/institutions" var="institutionsUrl" />

            <f:form class="form form-horizontal" method="post" modelAttribute="institutionForm" 
                    action="${institutionsUrl}">

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
                
                <spring:bind path="city">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">City</label>
                        <div class="col-sm-10">
                            <f:select path="city.id" items="${citiesList}" class="form-control" itemLabel="name" itemValue="id"/>
                            <f:errors path="city" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${institutionForm['new']}">
                                <button type="submit" cc:when test="${institutionForm['new']}" 
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