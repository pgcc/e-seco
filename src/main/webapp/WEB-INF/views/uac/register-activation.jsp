<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app-login>
    <jsp:attribute name="title">
        E-SECO Account Activation
    </jsp:attribute>

    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            $("#gender").focus();

            // Process Errors
            <c:if test="${not empty error}">
            var message = "";
            <c:forEach var="msg" items="${error_messages}">
            message += "${msg}\n";
            </c:forEach>
            swal("Error", message, "error");
            </c:if>

            // Populate Form Fields
            $("#birthday").val("${param.birthday}");
            $("#gender").val("${param.gender}");
            <c:if test="${param.role_researcher == 'on'}">
            $("#role_researcher").prop("checked", true);
            </c:if>
            <c:if test="${param.role_developer == 'on'}">
            $("#role_developer").prop("checked", true);
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
                        <p>Hi <strong>${user.name}</strong>, complete the information required below to activate you
                            account.</p>
                        <form action="<c:url value="/register/${user.activationCode}"/>" method="post">
                            <div class="row">
                                <div class="col col-xs-12 col-md-6">
                                    <div class="form-group">
                                        <label for="gender">Gender</label>
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-venus-mars"></i></div>
                                            <select id="gender" name="gender" class="form-control" required>
                                                <option value="">Choose</option>
                                                <option value="M">Male</option>
                                                <option value="F">Female</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col col-xs-12 col-md-6">
                                    <div class="form-group">
                                        <label for="birthday">Birthday
                                            <i class="fa fa-info-circle text-info"
                                               data-toggle="tooltip" data-placement="top"
                                               title="Format: dd/mm/yyyy"></i>
                                        </label>
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            <input id="birthday" name="birthday" class="form-control mask-date">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col col-xs-12">
                                    <div class="form-group">
                                        <p>
                                            <strong>Roles</strong>
                                            <i class="fa fa-info-circle text-info"
                                               data-toggle="tooltip" data-placement="top"
                                               title="You may have one or more roles at the same time"></i>
                                        </p>
                                        <label class="checkbox-inline" for="role_researcher">
                                            <input id="role_researcher" name="role_researcher" type="checkbox">
                                            Researcher
                                        </label>
                                        <label class="checkbox-inline" for="role_developer">
                                            <input id="role_developer" name="role_developer" type="checkbox">
                                            Developer
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col col-xs-12 col-md-6">
                                    <div class="form-group">
                                        <label for="password">Password</label>
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-key"></i></div>
                                            <input id="password" name="password" class="form-control" type="password"
                                                   required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col col-xs-12 col-md-6">
                                    <div class="form-group">
                                        <label for="password_re">Password confirmation</label>
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-key"></i></div>
                                            <input id="password_re" name="password_re" class="form-control"
                                                   type="password" required>
                                        </div>
                                    </div>
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