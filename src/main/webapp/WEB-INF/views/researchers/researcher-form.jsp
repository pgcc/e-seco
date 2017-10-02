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
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/profile"/>"> User Profile</a></li>
            <li><a href="<c:url value="/researchers/add"/>">Add Researcher Profile</a></li>
        </ol>       
    </jsp:attribute>


    <jsp:body>
        <div class="container-fluid">
            <c:choose>
                <c:when test="${researcherForm['new']}">
                    <h2>Add Researcher</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Researcher</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <c:url var="mendeleySearch" value="/researchers/mendeleySearch" />
            <f:form class="form form-horizontal" method="get" action="${mendeleySearch}"  modelAttribute="user">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">E-mail</label>
                    <div class="col-sm-10">
                        <f:input path="email" class="form-control" type="email"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-10 col-sm-offset-2">
                        <f:button type="submit" class="btn btn-block btn-primary">Mendeley Search</f:button>
                        </div>
                    </div>
            </f:form>
            <c:url var="register" value="/researchers" />
            <f:form class="form form-horizontal" method="post" action="${register}" modelAttribute="researcherForm" >                            
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">Title</label>    
                    <div class="col-sm-10">
                        <f:input path="title" class="form-control" type="text"/>
                    </div>
                </div>                           
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">Display Name</label>
                    <div class="col-sm-10">
                        <f:input path="displayName" class="form-control" type="text" />
                    </div>
                </div>
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">Academic Status</label>
                    <div class="col-sm-10">
                        <f:input path="academicStatus" class="form-control" type="text"/>
                    </div>
                </div>        
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">Institutions</label>
                    <div class="col-sm-10">
                        <c:forEach items="institutions" varStatus="uStatus">
                            <f:input path="institutions[${uStatus.index}].name" class="form-control" type="text"/>
                        </c:forEach>
                    </div>
                </div>
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${researcherForm['new']}">
                                <button type="submit" cc:when test="${researcherForm['new']}" class="btn btn-primary pull-right">Add</button>
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