<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Experiments
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Experiments Overview</h2>

            </div>
        </div>
    </jsp:body>
</t:layout-app>