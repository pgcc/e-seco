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
    <link rel="stylesheet"
          href="<c:url value="/resources/theme-eseco/core/jquery-datetimepicker/jquery.datetimepicker.min.css" />">
    <link rel="stylesheet"
          href="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.css"/>">
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
        <div class="top-header-left">
            <a href="<c:url value="/"/>">
                <img class="logo-eseco" src="<c:url value="/resources/images/eseco-logo-1.png"/>" alt="E-SECO">
            </a>
        </div>
        <div class="top-header-right">
            <a href="http://www.ufjf.br/pgcc/">
                <img class="logo-ufjf" src="<c:url value="/resources/images/logo_da_UFJF_2.png"/>" alt="UFJF">
            </a>
        </div>
    </div>
    <nav class="top-menu">
        <ul class="top-menu-left">
            <li><a href="<c:url value="/"/>"><i class="fa fa-home"></i> <span>HOME</span></a></li>

            <li class="dropdown">
                <a href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-flask"></i> <span>EXPERIMENTS</span></a>
                <ul class="dropdown-menu">
                    <li><a href="<c:url value="/experiments/activities"/>">Activities</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/experiments/dataSources"/>">Data Sources</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/experiments/entities"/>">Entities</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/experiments"/>">Experiments</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/experiments/wfms"/>">WFMS</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/experiments/workflows"/>">Workflows</a></li>
                </ul>
            </li>

            <li><a href="<c:url value="/components"/>"><i class="fa fa-cogs"></i> <span>COMPONENTS</span></a></li>

            <c:if test="${not empty sessionScope.eseco_plugins_menu_entries}">
            <li class="dropdown">
                <a href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-plug"></i> <span>PLUGINS</span></a>
                <ul class="dropdown-menu">
                    <c:forEach var="plugin_menu_entry" items="${sessionScope.eseco_plugins_menu_entries}" varStatus="loop">
                    <li><a href="<c:url value="/plugins${plugin_menu_entry.uri}"/>">${plugin_menu_entry.title}</a></li>

                        <c:if test="${!loop.last}">
                            <li role="separator" class="divider"></li>
                        </c:if>
                    </c:forEach>
                </ul>
            </li>
            </c:if>

            <li class="dropdown">
                <a href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-cog"></i> <span>CONFIG</span></a>
                <ul class="dropdown-menu">
                    <li><a href="<c:url value="/agents"/>">Agents</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/disciplines"/>">Disciplines</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/experiments/detailGroup"/>">Details Group</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/institutions"/>">Institutions</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/researchers"/>">Researchers</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/researchGroups"/>">Research Groups</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/ontology"/>">Ontology Service</a></li>
                </ul>
            </li>

            <li class="dropdown">
                <a href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-question-circle"></i> <span>SUPPORT</span></a>
                <ul class="dropdown-menu">
                    <li><a href="<c:url value="/support/terms-of-use"/>">Terms of Use</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="<c:url value="/support/privacy-policy"/>">Privacy Policy</a></li>

                    <c:if test="${sessionScope.role_admin || sessionScope.role_researcher}">
                        <li role="separator" class="divider"></li>
                        <li><a href="<c:url value="/support/researchers/first-steps"/>">Researchers First Steps</a></li>
                    </c:if>

                    <c:if test="${sessionScope.role_admin || sessionScope.role_developer}">
                        <li role="separator" class="divider"></li>
                        <li><a href="<c:url value="/support/developers/guidelines"/>">Developers Guidelines</a></li>
                    </c:if>
                </ul>
            </li>
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

    <c:set var="urlParts" value="${fn:split(requestScope['javax.servlet.forward.request_uri'], '/')}"/>
    <c:if test="${urlParts[1] != null && urlParts[1] != 'plugins'}">
    <div class="main-menu">
        <c:choose>
            <c:when test="${urlParts[2]!= null}">
                <c:catch var="e">
                    <jsp:include
                            page="/WEB-INF/views/${urlParts[1]}/${urlParts[2]}/${urlParts[1]}-${urlParts[2]}-menu.jsp"/>
                </c:catch>
                <c:if test="${!empty e}">
                    <jsp:include page="/WEB-INF/views/${urlParts[1]}/${urlParts[1]}-menu.jsp"/>
                </c:if>
            </c:when>
            <c:otherwise>
                <jsp:include page="/WEB-INF/views/${urlParts[1]}/${urlParts[1]}-menu.jsp"/>
            </c:otherwise>
        </c:choose>
    </div>
    </c:if>

    <div class="main-content container-fluid">
        <jsp:doBody/>
    </div>
</main>

<footer>
    <p class="text-center">E-SECO © 2017 - Federal University of Juiz de Fora - Computer Science Department</p>
</footer>

<!-- CORE JAVASCRIPTS START -->
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/jquery/jquery.min.js" />"></script>
<script type="text/javascript"
        src="<c:url value="/resources/theme-eseco/core/bootstrap/js/bootstrap.min.js" />"></script>
<script type="text/javascript"
        src="<c:url value="/resources/theme-eseco/core/sweetalert/sweetalert.min.js" />"></script>
<script type="text/javascript"
        src="<c:url value="/resources/theme-eseco/core/jquery-maskedinput/jquery.maskedinput.min.js" />"></script>
<script type="text/javascript"
        src="<c:url value="/resources/theme-eseco/core/jquery-datetimepicker/jquery.datetimepicker.full.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/core/core.js" />"></script>


<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.legend.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3-sankey.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3-sankey.js" />"></script>
<script type="text/javascript">
    var d3version4 = d3;
    window.d3 = null;
</script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v3.min.js" />"></script>
<script type="text/javascript">
    var d3version3 = d3;
    window.d3 = null;
</script>

<script type="text/javascript"
        src="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/misc.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/micro-observer.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/microplugin.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/bubble-chart.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/central-click.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/lines.js" />"></script>
<!-- CORE JAVASCRIPTS END -->

<!-- GLOBAL LEVEL JAVASCRIPTS START -->
<script type="text/javascript" src="<c:url value="/resources/theme-eseco/custom/custom.js" />"></script>
<!-- GLOBAL LEVEL JAVASCRIPTS END -->

<!-- PAGE LEVEL JAVASCRIPTS START -->
<jsp:invoke fragment="javascripts"/>
<!-- PAGE LEVEL JAVASCRIPTS END -->
</body>
</html>
