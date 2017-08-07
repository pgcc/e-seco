<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app-login>
    <jsp:attribute name="title">
        E-SECO Account Activation
    </jsp:attribute>

    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            $("#login").focus();
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
                <p>Hi <strong>${user.name}</strong>, activate you account by filling the above form.</p>
                <form action="<c:url value="/register"/>" method="post">
                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-group">
                            <div class="input-group-addon"><i class="fa fa-envelope"></i></div>
                            <input id="password" name="password" class="form-control" type="password" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password_re">Password confirmation</label>
                        <div class="input-group">
                            <div class="input-group-addon"><i class="fa fa-envelope"></i></div>
                            <input id="password_re" name="password_re" class="form-control" type="password" required>
                        </div>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-block btn-success">Activate Account</button>
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