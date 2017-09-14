<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Services Composer
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a>
        <a href="<c:url value="/components/services-composer"/>"><i class="fa fa-angle-double-right"></i> Services Composer</a>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Services Composer</h2>
            </div>
        </div>
    </jsp:body>
</t:layout-app>