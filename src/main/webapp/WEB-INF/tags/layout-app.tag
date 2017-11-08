<%@tag description="Inner App Layout Template" pageEncoding="UTF-8" %>
<%@attribute name="title" fragment="true" %>
<%@attribute name="breadcrumbs" fragment="true" %>
<%@attribute name="stylesheets" fragment="true" %>
<%@attribute name="javascripts" fragment="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>
            <jsp:invoke fragment="title"/>
        </title>

        <!-- CORE STYLESHEETS START -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:100,300,400">
        <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/core/bootstrap/css/bootstrap.min.css" />">
        <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/core/font-awesome/css/font-awesome.min.css" />">
        <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/core/sweetalert/sweetalert.css" />">
        <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/core/core.css" />">
        <!-- CORE STYLESHEETS END -->

        <!-- GLOBAL LEVEL STYLESHEETS START -->
        <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/custom/custom.css" />">
        <!-- GLOBAL LEVEL STYLESHEETS END -->

        <!-- PAGE LEVEL STYLESHEETS START -->
        <jsp:invoke fragment="stylesheets"/>
        <!-- PAGE LEVEL STYLESHEETS END -->
    </head>
    <body class="structure-app-inner">
        <header>
            <div class="top-header">
                <img class="logo" src="<c:url value="/resources/images/eseco-logo-1.png"/>" alt="E-SECO">
            </div>
            <nav class="top-menu">
                <ul class="top-menu-left">
                    <li><a href="<c:url value="/"/>"><i class="fa fa-home"></i> <span>HOME</span></a></li>
                    <li><a href="<c:url value="/experiments"/>"><i class="fa fa-flask"></i> <span>EXPERIMENTS</span></a></li>
                    <li><a href="<c:url value="/agents"/>"><i class="fa fa-id-card"></i> <span>MEMBERS</span></a></li>
                    <li><a href="<c:url value="/components"/>"><i class="fa fa-cogs"></i> <span>COMPONENTS</span></a></li>
                    <li class="dropdown">
                        <a href="#"  data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-plus"></i> <span>INSERT</span></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="<c:url value="/disciplines"/>">DISCIPLINES</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="<c:url value="/institutions"/>">INSTITUTIONS</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="<c:url value="/researchGroups"/>">RESEARCH GROUPS</a></li> 
                            <li role="separator" class="divider"></li>
                            <li><a href="<c:url value="/experiments/wfms"/>">WFMS</a></li>                            
                        </ul>
                    </li>

                    <c:if test="${sessionScope.role_admin || sessionScope.role_developer}">

                    </c:if>

                </ul>
                <ul class="top-menu-right">
                    <li>
                        <div class="dropdown">
                            <a id="top-menu-item-notifications" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false">
                                <i class="fa fa-bell"></i>
                                <c:choose>
                                    <c:when test="${fn:length(sessionScope.notifications) >= 1}">
                                        <span class="el-notification-number el-notification-number-one-or-more">${fn:length(sessionScope.notifications)}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="el-notification-number el-notification-number-none">0</span>
                                    </c:otherwise>
                                </c:choose>
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="top-menu-item-user">
                                <c:forEach var="notification" items="${sessionScope.notifications}" end="2">
                                    <li>
                                        <p>
                                            <a href="<c:url value="${notification.link}"/>">
                                                <i class="fa ${notification.icon}"></i> <span>${notification.text}</span>
                                            </a>
                                        </p>
                                    </li>
                                    <li role="separator" class="divider"></li>
                                    </c:forEach>
                                <li>
                                    <a href="<c:url value="/notifications"/>">
                                        <i class="fa fa-bell"></i> <span>View All Notifications</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>

                    <li>
                        <div class="dropdown">
                            <a id="top-menu-item-user" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false">
                                <i class="fa fa-user"></i> <span>${sessionScope.logged_user.email}</span>
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="top-menu-item-user">
                                <li>
                                    <a href="<c:url value="/profile"/>">
                                        <i class="fa fa-user"></i> <span>Profile</span>
                                    </a>
                                </li>
                                <li role="separator" class="divider"></li>
                                <li>
                                    <a href="<c:url value="/logout"/>">
                                        <i class="fa fa-sign-out"></i> <span>Logout</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </nav>

            <nav class="breadcrumbs">
                <jsp:invoke fragment="breadcrumbs"/>
            </nav>
        </header>
        <main>
            <div class="main-menu">
                <c:set var="urlParts" value="${fn:split(requestScope['javax.servlet.forward.request_uri'], '/')}"/>
                <c:if test="${urlParts[1] != null}">
                    <jsp:include page="/WEB-INF/views/${urlParts[1]}/${urlParts[1]}-menu.jsp"/>
                </c:if>
            </div>
            <div class="main-content container-fluid">
                <jsp:doBody/>
            </div>
        </main>
        <footer>
            <p class="text-center">E-SECO © 2017 - Federal University of Juiz de Fora - Computer Sciences Department</p>
        </footer>

        <!-- CORE JAVASCRIPTS START -->
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/jquery/jquery.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/bootstrap/js/bootstrap.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/sweetalert/sweetalert.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/jquery-maskedinput/jquery.maskedinput.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/jquery-datetimepicker/jquery.datetimepicker.full.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/core.js" />"></script>
        <!-- CORE JAVASCRIPTS END -->

        <!-- GLOBAL LEVEL JAVASCRIPTS START -->
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/custom/custom.js" />"></script>
        <!-- GLOBAL LEVEL JAVASCRIPTS END -->

        <!-- PAGE LEVEL JAVASCRIPTS START -->
        <jsp:invoke fragment="javascripts"/>
        <!-- PAGE LEVEL JAVASCRIPTS END -->
    </body>
</html>
