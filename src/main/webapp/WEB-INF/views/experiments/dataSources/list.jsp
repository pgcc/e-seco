<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Data Sources
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/dataSources"/>">Data Sources</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Data Sources</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">List of Data Sources</h3>
                    </div>
                    <div class="panel-body">
                        <div id="datasources" class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>Name</th>
                                    <th style="width:200px;">Author</th>
                                    <th class="text-center" style="width:60px;">Actions</th>
                                </tr>
                                </thead>
                                <tbody class="list">
                                <c:forEach var="datasource" items="${dataSourceList}">
                                    <tr>
                                        <td><c:out value="${datasource.name}"/></td>
                                        <td><c:out value="${datasource.author.displayName}"/></td>
                                        <td>
                                            <a class="btn btn-xs btn-primary"
                                               href="<c:url value="/experiments/dataSources/${datasource.id}"/>">View</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>