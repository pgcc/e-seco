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
                <c:choose>
                    <c:when test="${error_activation}">
                        <p class="text-center"><strong>Error</strong>!</p>
                        <p>
                            The activation code is not valid, or have been expired.
                            <br>
                            Please, <a href="<c:url value="/register"/>">restart the registration process</a>.
                        </p>
                    </c:when>
                    <c:otherwise>
                        <p>Hi <strong>${user.name}</strong>, complete the information required below to activate you account.</p>
                        <form action="<c:url value="/register"/>" method="post">
                            <div class="row">
                                <div class="col col-xs-12 col-md-6">
                                    <div class="form-group">
                                        <label for="gender">Gender</label>
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-venus-mars"></i></div>
                                            <select id="gender" name="gender" class="form-control" required>
                                                <option value="">Choose</option>
                                                <option value="1">Male</option>
                                                <option value="2">Female</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col col-xs-12 col-md-6">
                                    <div class="form-group">
                                        <label for="birthday">Birthday</label>
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            <input id="birthday" name="birthday" class="form-control">
                                        </div>
                                    </div>
                                </div>
                            </div>
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
                                <button class="btn btn-block btn-success">Activate Account</button>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
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