<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app-login>
    <jsp:attribute name="title">
        E-SECO Account Recovery
    </jsp:attribute>

    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            $("#email").focus();
            <c:if test="${not empty error}">
            var message = "";
            <c:forEach var="msg" items="${error_messages}">
            message += "${msg}\n";
            </c:forEach>
            swal("Error", message, "error");
            </c:if>
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="panel panel-default pnl-register">
            <div class="panel-heading">
                <img src="<c:url value="/resources/images/eseco-logo-1.png"/>" alt="E-SECO">
            </div>
            <div class="panel-body">
                <p>
                    In order to recovery your account, please, inform your email below.
                    We will send an email containing instructions to reset your password.
                </p>
                <form action="<c:url value="/recovery"/>" method="post">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <div class="input-group">
                            <div class="input-group-addon"><i class="fa fa-envelope"></i></div>
                            <input id="email" name="email" class="form-control" type="text" required>
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-block btn-success">Send Email</button>
                        <p class="margin-10-top no-margin-bottom">
                            <a href="<c:url value="/login" />">Back to Login</a>
                        </p>
                    </div>
                </form>
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