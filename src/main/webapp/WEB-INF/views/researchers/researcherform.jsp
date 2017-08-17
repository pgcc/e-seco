<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Researcher
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/researcher/mendeleySearch"/>"><i class="fa fa-street-view"></i> Researcher Profile</a>
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
                        <f:form method="post" action="${mendeleySearch}"  modelAttribute="researcherForm">
                            <div class="form-group">
                                <f:label path="user.email">E-mail</f:label>
                                <f:input path="user.email" class="form-control" type="email" value="${sessionScope.logged_user.email}"/>
                            </div>
                            <div class="form-group">
                                <f:button type="submit" class="btn btn-block btn-primary">Mendeley Search</f:button>
                                </div>
                        </f:form>
                        <c:url var="register" value="/researchers" />
                        <f:form method="post" action="${register}" modelAttribute="researcherForm">
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
                                <f:label path="institution.name">Institution</f:label>
                                <f:input path="institution.name" class="form-control" type="text" />
                            </div>
                            <f:button type="submit" class="btn btn-success">Save</f:button>
                        </f:form>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>