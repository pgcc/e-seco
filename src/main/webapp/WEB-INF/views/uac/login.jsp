<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app-login>
    <jsp:attribute name="title">
        E-SECO Login
    </jsp:attribute>

    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            $("#login").focus();
            <c:if test="${not empty error_credentials}">
            swal("Error", "Invalid credentials!", "error");
            </c:if>
            <c:if test="${not empty error_active}">
            swal("Error", "You user is not active!", "error");
            </c:if>
            <c:if test="${not empty error_jdbc}">
            swal("Error", "Unable to acquire JDBC Connection!", "error");
            </c:if>
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="panel panel-default pnl-login">
            <div class="panel-heading">
                <img src="<c:url value="/resources/images/eseco-logo-1.png"/>" alt="E-SECO">
            </div>
            <div class="panel-body">
                <form action="<c:url value="/login" />" method="post">
                    <div class="form-group">
                        <label for="login">Login</label>
                        <div class="input-group">
                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                            <input id="login" name="login" class="form-control" type="text">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-group">
                            <div class="input-group-addon"><i class="fa fa-key"></i></div>
                            <input id="password" name="password" class="form-control" type="password">
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-block btn-success">Enter</button>
                        <p class="margin-10-top no-margin-bottom"><a href="<c:url value="/recovery"/>">Account recovery</a></p>
                        <p class="margin-10-top no-margin-bottom"><a href="<c:url value="/register"/>">Create Account</a></p>
                    </div>
                </form>
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