<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Institutions
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/institutions"/>"> Institutions</a></li>
            <li><a href="<c:url value="/institutions/${institution.id}"/>">View</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:if test="${not empty msg}">
                <div class="alert alert-${css} alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <strong>${msg}</strong>
                </div>
            </c:if>

            <h2>Institution Detail</h2>
            <br />
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <label class="col-sm-2">ID</label>
                        <div class="col-sm-10">${institution.id}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Name</label>
                        <div class="col-sm-10">${institution.name}</div>
                    </div>
                    
                    <div class="row">
                        <label class="col-sm-2">City</label>
                        <div class="col-sm-10">${institution.city.name}</div>
                    </div>

                </div>

                <br/>
                <spring:url value="/institutions" var="urlinstitutions" />
                <nav class="navbar navbar-inverse">
                    <div>
                        <ul class="nav navbar-nav navbar-left">
                            <button onclick="location.href = '${urlinstitutions}'" class="btn btn-link">
                                <span class="glyphicon glyphicon-arrow-left"></span> Back
                            </button>
                        </ul>
                    </div>
                </nav>
            </div>
        </jsp:body>
    </t:layout-app>