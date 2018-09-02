<%--
  Created by IntelliJ IDEA.
  User: jadef
  Date: 21/08/2018
  Time: 21:22
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
   <jsp:attribute name="title">
        E-SECO Data Sources
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i>Experiments</a></li>
            <li><a href="<c:url value="/experiments/dataSources"/>">Data Sources</a></li>
            <c:choose>
                    <c:when test="${dataSourceForm['new']}">
                    <li><a href="<c:url value="/experiments/dataSources/add"/>">Add</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/experiments/dataSources/${dataSourceForm['id']}/update"/>">Update</a>
                    </li>
                    </c:otherwise>
                </c:choose>

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

            <c:choose>
                <c:when test="${dataSourceForm['new']}">
                    <h2>Add Data Source</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Data Source</h2>
                </c:otherwise>
            </c:choose>
            <br/>

            <spring:url value="/dataSources" var="dataSourcesUrl"/>

            <f:form class="form form-horizontal" method="post" modelAttribute="dataSourceForm"
                    action="${dataSourcesUrl}">

                <f:hidden path="id"/>

                <spring:bind path="name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input id="name" name="name" class="form-control" type="text">
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="dataSourceName">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Data Source</label>
                        <div class="col-sm-10">
                            <label class="checkbox-inline" for="datasource_darksky">
                                <input id="datasource_darksky" name="datasource_darksky" type="checkbox">
                                Dark Sky
                            </label>
                            <label class="checkbox-inline" for="datasource_ufjf">
                                <input id="datasource_ufjf" name="datasource_ufjf" type="checkbox">
                                UFJF Forecast
                            </label>
                            <label class="checkbox-inline" for="datasource_openweather">
                                <input id="datasource_openweather" name="datasource_openweather" type="checkbox">
                                Open Weather
                            </label>
                            <label class="checkbox-inline" for="datasource_solcast">
                                <input id="datasource_solcast" name="datasource_solcast" type="checkbox">
                                Solcast
                            </label>


                            <c:choose>
                                <c:when test="${dataSourceForm['new']}">
                                    <f:radiobuttons path="dataSourceName" items="${sourceNameList}" itemLabel="name"
                                                    element="label class='radio-inline'"
                                                    onchange="showOtherFields(this)"/>
                                </c:when>
                                <c:otherwise>
                                    <f:radiobuttons path="dataSourceName" items="${sourceNameList}" itemLabel="name"
                                                    element="label class='radio-inline'"
                                                    onchange="showOtherFields(this)" disabled="true"/>
                                </c:otherwise>
                            </c:choose>
                            <f:errors path="dataSourceName" class="control-label"/>
                        </div>
                    </div>
                </spring:bind>


                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">Latitude</label>
                    <div class="col-sm-4">
                        <input id="latitude" name="latitude" class="form-control" type="text">
                    </div>

                    <label class="col-sm-2 control-label">Longitude</label>
                    <div class="col-sm-4">
                        <input id="longitude" name="longitude" class="form-control" type="text">
                    </div>
                </div>


                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">Author</label>
                    <div class="col-sm-10">
                        <input id="authorName" name="authorName" class="form-control" type="text">
                    </div>
                </div>


                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${dataSourceForm['new']}">
                                <button type="submit" cc:when test="${dataSourceForm['new']}"
                                        class="btn btn-primary pull-right">Save
                                </button>
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