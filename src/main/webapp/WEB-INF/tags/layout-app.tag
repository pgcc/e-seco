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
            <li><a href="<c:url value="/services"/>"><i class="fa fa-cogs"></i> <span>SERVICES</span></a></li>
            <li><a href="<c:url value="/researchers"/>"><i class="fa fa-cogs"></i> <span>RESEARCHERS</span></a></li>
        </ul>
        <ul class="top-menu-right">
            <li>
                <div class="dropdown">
                    <a id="top-menu-item-user" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-user"></i> <span>${sessionScope.logged_user.name}</span>
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
        <ul>
            <c:if test="${fn:contains(pageContext.request.requestURI, 'services')}">
                <li><a href="<c:url value="/services"/>"><i class="fa fa-th"></i> Overview</a></li>
                <li><a href="<c:url value="/services/explore"/>"><i class="fa fa-binoculars"></i> Explore</a></li>
            </c:if>
        </ul>
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