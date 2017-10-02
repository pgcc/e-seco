<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO User Profile
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/profile"/>"> User Profile</a></li>
        </ol>   
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Profile of ${sessionScope.logged_user.agent.name}</h2>
            </div>
            <div class="col-xs-12 col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading pnl-heading-buttons">
                        <h3 class="panel-title">Basic Information</h3>
                        <div class="pnl-heading-buttons-buttons">
                            <a class="btn" href="#" data-toggle="tooltip" title="Edit basic information">
                                <i class="fa fa-edit"></i></a>
                        </div>
                    </div>
                    <div class="panel-body">
                        <ul class="list-group lst-data-value">
                            <li class="list-group-item">
                                <span>Id</span>
                                <span>${sessionScope.logged_user.id}</span>
                            </li>
                            <li class="list-group-item">
                                <span>Name</span>
                                <span>${sessionScope.logged_user.agent.name}</span>
                            </li>
                            <li class="list-group-item">
                                <span>Gender</span>
                                <c:if test="${fn:contains(sessionScope.logged_user.agent.gender, 'M')}">
                                    <span>Male</span>
                                </c:if>
                                <c:if test="${fn:contains(sessionScope.logged_user.agent.gender, 'F')}">
                                    <span>Female</span>
                                </c:if>
                            </li>
                            <li class="list-group-item">
                                <span>Birthday</span>
                                <span><fmt:formatDate pattern="yyyy-MM-dd" value="${sessionScope.logged_user.agent.birthday}"/></span>
                            </li>
                            <li class="list-group-item">
                                <span>Email</span>
                                <span>${sessionScope.logged_user.email}</span>
                            </li>

                            <li class="list-group-item">
                                <span>Login</span>
                                <span>${sessionScope.logged_user.login}</span>
                            </li>
                            <li class="list-group-item">
                                <span>Password</span>
                                <span>*******</span>
                            </li>
                            <li class="list-group-item">
                                <span>Date Registered</span>
                                <span><fmt:formatDate pattern="yyyy-MM-dd H:m" value="${sessionScope.logged_user.registerDate}"/></span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>