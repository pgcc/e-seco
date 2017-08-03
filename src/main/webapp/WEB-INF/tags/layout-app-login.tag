<%@tag description="Login App Layout Template" pageEncoding="UTF-8" %>
<%@attribute name="title" fragment="true" %>
<%@attribute name="stylesheets" fragment="true" %>
<%@attribute name="javascripts" fragment="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<body class="structure-login">
<main>
    <jsp:doBody/>
</main>

<!-- CORE JAVASCRIPTS START -->
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/jquery/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/bootstrap/js/bootstrap.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/sweetalert/sweetalert.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/core.js" />"></script>
<!-- CORE JAVASCRIPTS END -->

<!-- GLOBAL LEVEL JAVASCRIPTS START -->
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/jquery.backstretch.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/custom/custom.js" />"></script>
<script type="text/javascript">
    $.backstretch([
            "<c:url value="/resources/images/login-bg-1.jpg" />",
            "<c:url value="/resources/images/login-bg-2.jpg" />",
            "<c:url value="/resources/images/login-bg-3.jpg" />",
            "<c:url value="/resources/images/login-bg-4.jpg" />"
        ], {
            fade: 2000,
            duration: 5000
        }
    );
</script>
<!-- GLOBAL LEVEL JAVASCRIPTS END -->

<!-- PAGE LEVEL JAVASCRIPTS START -->
<jsp:invoke fragment="javascripts"/>
<!-- PAGE LEVEL JAVASCRIPTS END -->
</body>
</html>