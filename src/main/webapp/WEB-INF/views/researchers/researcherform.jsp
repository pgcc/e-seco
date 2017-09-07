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
        <div class="row">
            <div class="col-xs-12">
                <h2>Researcher Profile</h2>
            </div>
            <div class="col-xs-12 col-sm-6">
                <div class="panel panel-default">

                    <div class="panel-body">
                        <c:url var="mendeleySearch" value="/researchers/mendeleySearch" />
                        <f:form method="get" action="${mendeleySearch}"  modelAttribute="user">
                            <div class="form-group">
                                <f:label path="email">E-mail</f:label>
                                <f:input path="email" class="form-control" type="email"/>
                            </div>
                            <div class="form-group">
                                <f:button type="submit" class="btn btn-block btn-primary">Mendeley Search</f:button>
                                </div>
                        </f:form>
                        <c:url var="register" value="/researchers" />
                        <f:form method="post" action="${register}" modelAttribute="researcher" >                            
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
                            <f:button type="submit" class="btn btn-success">Save</f:button>
                        </f:form>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>