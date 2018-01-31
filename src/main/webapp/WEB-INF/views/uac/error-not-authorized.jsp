<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app-login>
    <jsp:attribute name="title">
        E-SECO Unauthorized
    </jsp:attribute>

    <jsp:attribute name="javascripts">

    </jsp:attribute>

    <jsp:body>
        <div class="panel panel-default pnl-register">
            <div class="panel-heading">
                <img src="<c:url value="/resources/images/eseco-logo-1.png"/>" alt="E-SECO">
            </div>
            <div class="panel-body">
                <p class="text-center"><strong>Unauthorized Access Attempt</strong>!</p>
                <p>
                    You don't have the appropriate permissions to access this resource.
                </p>
                <p class="text-center">
                    <a href="<c:url value="/"/>">Go to Back</a>
                </p>
            </div>
            <div class="panel-footer">
                <p class="text-center text-small no-margin">
                    E-SECO © 2017
                    <br>
                    Federal University of Juiz de Fora
                    <br>
                    Computer Science Department
                </p>
            </div>
        </div>
    </jsp:body>
</t:layout-app-login>