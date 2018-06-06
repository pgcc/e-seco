<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Researchers
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/researchers"/>"><i class="fa fa-street-view"></i> Researchers</a></li>
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

            <h2>All Researchers</h2>
            <br/>
            <div class="panel panel-default">
                <div class="panel-body">
                    <table class="table table-hover table-responsive">
                        <thead>
                            <tr>
                                <th>Photo</th>
                                <th>#ID</th>
                                <th>Display Name</th>
                                <th>Title</th>                                
                            </tr>
                        </thead>
                        <c:forEach var="res" items="${researchers}">

                            <spring:url value="/researchers/${res.id}" var="agentUrl" />

                            <tr>
                                <td onclick="location.href = '${agentUrl}'">
                                    <img src="${res.photo}" class="img-rounded img-responsive" style="max-width: 40px;">
                                </td>   
                                <td onclick="location.href = '${agentUrl}'" style="vertical-align: middle">${res.id}</td>
                                <td onclick="location.href = '${agentUrl}'" style="vertical-align: middle">${res.displayName}</td>
                                <td onclick="location.href = '${agentUrl}'" style="vertical-align: middle">${res.title}</td>

                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>