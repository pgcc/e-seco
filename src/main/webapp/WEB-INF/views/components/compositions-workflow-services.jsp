<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Compositions - Workflow Services
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a>
        <a href="#"><i class="fa fa-angle-double-right"></i> Compositions</a>
        <a href="<c:url value="/components/compositions/workflow-services"/>"><i class="fa fa-angle-double-right"></i> Workflow Services</a>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Compositions - Workflow Services</h2>
            </div>
        </div>
    </jsp:body>
</t:layout-app>