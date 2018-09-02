<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Data Sources
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/dataSources"/>">Data Sources</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">
            <c:if test="${not empty msg}">
                <div class="alert alert-${css} alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert"
                            aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <strong>${msg}</strong>
                </div>
            </c:if>

            <h2>My Data Sources</h2>
            <br/>
            <div class="panel panel-default">
                <div class="panel-body">
                    <table class="table table-hover table-responsive">
                        <thead>
                        <tr>
                            <th>#ID</th>
                            <th>Name</th>
                            <th>Author</th>
                            <th class="text-center" >Action</th>
                        </tr>
                        </thead>
                        <c:forEach var="dataSource" items="${myDataSources}">

                            <spring:url value="dataSources/${dataSource.id}" var="dataSourceUrl" />
                            <spring:url value="dataSources/${dataSource.id}/delete" var="deleteUrl" />
                            <spring:url value="dataSources/${dataSource.id}/update" var="updateUrl" />

                            <tr>
                                <td onclick="location.href = '${dataSourceUrl}'">${dataSource.id}</td>
                                <td onclick="location.href = '${dataSourceUrl}'">${dataSource.name}</td>
                                <td onclick="location.href = '${dataSourceUrl}'">${dataSource.author.displayName}</td>


                                <td class="text-center">
                                    <button class="btn btn-link" title="view" onclick="location.href = '${dataSourceUrl}'">
                                        <span class="glyphicon glyphicon-eye-open"/>
                                    </button>
                                    <button class="btn btn-primary btn-link" title="edit" onclick="location.href = '${updateUrl}'">
                                        <span class="glyphicon glyphicon-edit"/>
                                    </button>
                                    <button class="btn btn-danger btn-link" title="delete" onclick="this.disabled = true;
                                            post('${deleteUrl}')">
                                        <span class="glyphicon glyphicon-remove"/>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>


            <h2>All Data Sources</h2>
            <br/>
            <div class="panel panel-default">
                <div class="panel-body">
                    <table class="table table-hover table-responsive">
                        <thead>
                        <tr>
                            <th>#ID</th>
                            <th>Name</th>
                            <th>Author</th>
                            <th class="text-center" >Action</th>
                        </tr>
                        </thead>
                        <c:forEach var="dataSource" items="${dataSources}">

                            <spring:url value="dataSources/${dataSource.id}" var="dataSourceUrl" />

                            <tr>
                                <td onclick="location.href = '${dataSourceUrl}'">${dataSource.id}</td>
                                <td onclick="location.href = '${dataSourceUrl}'">${dataSource.name}</td>
                                <td onclick="location.href = '${dataSourceUrl}'">${dataSource.author.displayName}</td>


                                <td class="text-center">
                                    <button class="btn btn-link" title="view" onclick="location.href = '${dataSourceUrl}'">
                                        <span class="glyphicon glyphicon-eye-open"/>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>