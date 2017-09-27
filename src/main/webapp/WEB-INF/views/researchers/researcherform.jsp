<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Researcher Profile
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/profile"/>"><i class="fa fa-street-view"></i> User Profile</a>
        <a href="<c:url value="/researcher/mendeleySearch"/>"><i class="fa fa-angle-double-right"></i> Researcher Profile</a>
    </jsp:attribute>


    <jsp:body>
        <div class="container">
            <c:choose>
                <c:when test="${researcher['new']}">
                    <h2>Add Researcher</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Researcher</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <c:url var="mendeleySearch" value="/researchers/mendeleySearch" />
            <f:form class="form form-horizontal" method="get" action="${mendeleySearch}"  modelAttribute="user">
                <div class="form-group">
                    <f:label path="email">E-mail</f:label>
                    <f:input path="email" class="form-control" type="email"/>
                </div>
                <div class="form-group">
                    <f:button type="submit" class="btn btn-block btn-primary">Mendeley Search</f:button>
                    </div>
            </f:form>
            <c:url var="register" value="/researchers" />
            <f:form class="form form-horizontal" method="post" action="${register}" modelAttribute="researcher" >                            
                <div class="form-group">
                    <f:label path="title">Title</f:label>                               
                    <f:input path="title" class="form-control" type="text"/>
                </div>                           
                <div class="form-group">
                    <f:label path="displayName">Display Name</f:label>
                    <f:input path="displayName" class="form-control" type="text" />
                </div>
                <div class="form-group">
                    <f:label path="academicStatus">Academic Status</f:label>
                    <f:input path="academicStatus" class="form-control" type="text"/>
                </div>        
                <div class="form-group">
                    <f:label path="institutions">Institutions</f:label>
                    <c:forEach items="institutions" varStatus="uStatus">
                        <f:input path="institutions[${uStatus.index}].name" class="form-control" type="text"/>
                    </c:forEach>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${researcher['new']}">
                                <button type="submit" cc:when test="${researcher['new']}" class="btn-lg btn-primary pull-right">Add</button>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" class="btn-lg btn-primary pull-right">Update</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <%--<f:button type="submit" class="btn-lg btn-primary pull-right">Save</f:button>--%>
            </f:form>

        </div>
    </jsp:body>
</t:layout-app>