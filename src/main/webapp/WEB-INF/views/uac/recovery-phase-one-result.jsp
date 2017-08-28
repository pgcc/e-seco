<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app-login>
    <jsp:attribute name="title">
        E-SECO Account Recovery
    </jsp:attribute>

    <jsp:attribute name="javascripts">

    </jsp:attribute>

    <jsp:body>
        <div class="panel panel-default pnl-register">
            <div class="panel-heading">
                <img src="<c:url value="/resources/images/eseco-logo-1.png"/>" alt="E-SECO">
            </div>
            <div class="panel-body">
                <p class="text-center">Hi <strong>${user.agent.name}</strong>!</p>
                <p>
                    You have initiated a recovery process. An email has been sent to:
                    <strong>${user.email}</strong>.
                    Please, follow its instructions to proceed with your password resetting.
                </p>
            </div>
            <div class="panel-footer">
                <p class="text-center text-small no-margin">
                    E-SECO © 2017
                    <br>
                    Federal University of Juiz de Fora
                    <br>
                    Computer Sciences Department
                </p>
            </div>
        </div>
    </jsp:body>
</t:layout-app-login>