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
    <link rel="stylesheet"
          href="<c:url value="/resources/theme-eseco/core/jquery-datetimepicker/jquery.datetimepicker.min.css" />">
    <link rel="stylesheet"
          href="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/plugins/perspective-page-view/component.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/custom/custom.css" />">
    <!-- GLOBAL LEVEL STYLESHEETS END -->

    <!-- PAGE LEVEL STYLESHEETS START -->
    <jsp:invoke fragment="stylesheets"/>
    <!-- PAGE LEVEL STYLESHEETS END -->
</head>
<body class="structure-app-inner">
<div id="perspective" class="perspective effect-rotatetop">
    <div class="ppv-container">
        <div class="wrapper">
            <button id="showMenu">Show Menu</button>
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
                <p class="text-center">

                    E-SECO © 2017 - Federal University of Juiz de Fora - Computer Science Department
                </p>
            </footer>
        </div>
    </div>
    <div class="outer-nav bottom horizontal">
        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Collaborative Research Environment</h3>
                    </div>

                    <div class="panel-body" style="max-height: 260px;overflow: auto;">
                        <!--
                        <div class="row">
                            <div class="col-xs-12 col-sm-6">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li role="presentation"><a href="#tab-network" aria-controls="tab-network" role="tab" data-toggle="tab">Network</a></li>
                                    <li role="presentation" class="active"><a href="#tab-activities" aria-controls="tab-activities" role="tab" data-toggle="tab">Activities</a></li>
                                    <li role="presentation"><a href="#tab-my-experiments" aria-controls="settings" role="tab" data-toggle="tab">My Experiments</a></li>
                                    <li role="presentation"><a href="#tab-my-notes" aria-controls="settings" role="tab" data-toggle="tab">My Notes</a></li>
                                </ul>

                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane" id="tab-network">

                                    </div>

                                    <div role="tabpanel" class="tab-pane active" id="tab-activities">
                                        <div class="panel panel-default">
                                            <div class="panel-heading" id="accordion">
                                                <div class="input-group">
                                                    <input id="btn-input" type="text" class="form-control input-sm" placeholder="Search activities from users..." vk_18c1e="subscribed" style="direction: ltr;" />
                                                    <span class="input-group-btn">
                                                            <button class="btn btn-default btn-sm" id="btn-chat">
                                                                <i class="glyphicon glyphicon-search" aria-hidden="true"></i>
                                                             </button>
                                                        </span>
                                                </div>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapseOne">
                                                <div class="panel-body">
                                                    <ul class="chat">
                                                        <li class="right clearfix">
                                                                <span class="chat-img pull-right">
                                                                    <img src="http://placehold.it/30/FA6F57/fff&text=PA" alt="User Avatar" class="img-circle">
                                                                </span>
                                                            <div class="chat-body clearfix">
                                                                <div class="header">
                                                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>5 mins ago</small>
                                                                    <strong class="pull-right primary-font">Pedro AlcĂ˘ntara</strong>
                                                                </div>
                                                                <p>
                                                                    Joined <strong>Leonardo de Aguiar</strong> in viewing data-source analysis of id: 3
                                                                </p>
                                                            </div>
                                                        </li>
                                                        <li class="right clearfix">
                                                                <span class="chat-img pull-right">
                                                                    <img src="http://placehold.it/30/FA6F57/fff&text=JS" alt="User Avatar" class="img-circle">
                                                                </span>
                                                            <div class="chat-body clearfix">
                                                                <div class="header">
                                                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>13 mins ago</small>
                                                                    <strong class="pull-right primary-font">Julia Salvador</strong>
                                                                </div>
                                                                <p>
                                                                    Joined <strong>Leonardo de Aguiar</strong> in viewing data-source analysis of id: 3
                                                                </p>
                                                            </div>
                                                        </li>
                                                        <li class="right clearfix">
                                                                <span class="chat-img pull-right">
                                                                    <img src="http://placehold.it/30/FA6F57/fff&text=L" alt="User Avatar" class="img-circle">
                                                                </span>
                                                            <div class="chat-body clearfix">
                                                                <div class="header">
                                                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>15 mins ago</small>
                                                                    <strong class="pull-right primary-font">Leonardo de Aguiar</strong>
                                                                </div>
                                                                <p>
                                                                    In viewing data-source analysis of id: 3
                                                                </p>
                                                            </div>
                                                        </li>
                                                        <li class="right clearfix">
                                                                <span class="chat-img pull-right">
                                                                    <img src="http://placehold.it/30/FA6F57/fff&text=L" alt="User Avatar" class="img-circle">
                                                                </span>
                                                            <div class="chat-body clearfix">
                                                                <div class="header">
                                                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>15 mins ago</small>
                                                                    <strong class="pull-right primary-font">Leonardo de Aguiar</strong>
                                                                </div>
                                                                <p>
                                                                    In viewing data-sources list
                                                                </p>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div role="tabpanel" class="tab-pane" id="tab-my-experiments">

                                    </div>

                                    <div role="tabpanel" class="tab-pane" id="tab-my-notes">

                                    </div>
                                </div>
                            </div>

                            <div class="col-xs-12 col-sm-6">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li role="presentation"><a href="#tab-users-and-groups" aria-controls="tab-users-and-groups" role="tab" data-toggle="tab">Users and Groups</a></li>
                                    <li role="presentation"><a href="#tab-tasks" aria-controls="tab-tasks" role="tab" data-toggle="tab">Tasks</a></li>
                                    <li role="presentation" class="active"><a href="#tab-chat" aria-controls="tab-chat" role="tab" data-toggle="tab">Chat</a></li>
                                </ul>

                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane" id="tab-users-and-groups">

                                    </div>

                                    <div role="tabpanel" class="tab-pane" id="tab-tasks">

                                    </div>

                                    <div role="tabpanel" class="tab-pane active" id="tab-chat">

                                        <div class="messaging">
                                            <div class="inbox_msg">
                                                <div class="inbox_people">
                                                    <div class="headind_srch">
                                                        <div class="recent_heading">
                                                            <h4>Recent</h4>
                                                        </div>
                                                        <div class="srch_bar">
                                                            <div class="stylish-input-group">
                                                                <input type="text" class="search-bar"  placeholder="Search" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="inbox_chat scroll">
                                                        <div class="chat_list active_chat">
                                                            <div class="chat_people">

                                                                <div class="chat_ib">
                                                                    <h5>Nenc Group</h5>
                                                                    <p>16 Users (5 online)</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="chat_list">
                                                            <div class="chat_people">

                                                                <div class="chat_ib">
                                                                    <h5>E-SECO Public Group</h5>
                                                                    <p>458 Users (31 online)</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mesgs">
                                                    <div class="msg_history">
                                                        <div class="incoming_msg">
                                                            <div class="incoming_msg_img"> <img class="img-circle" src="http://placehold.it/35/FA6F57/fff&text=PA" alt="sunil"> </div>
                                                            <div class="received_msg">
                                                                <div class="received_withd_msg">
                                                                    <p>Probably we will need data from more points</p>
                                                                    <span class="time_date"> 11:01 AM    |    Feb 9</span></div>
                                                            </div>
                                                        </div>
                                                        <div class="incoming_msg">
                                                            <div class="incoming_msg_img"> <img class="img-circle" src="http://placehold.it/35/FA6F57/fff&text=JS" alt="sunil"> </div>
                                                            <div class="received_msg">
                                                                <div class="received_withd_msg">
                                                                    <p>Got a new data from third point</p>
                                                                    <span class="time_date"> 11:13 AM    |    Feb 9</span></div>
                                                            </div>
                                                        </div>
                                                        <div class="outgoing_msg">
                                                            <div class="sent_msg">
                                                                <p>I'll get from the other locations</p>
                                                                <span class="time_date"> 11:14 AM    |    Feb 9</span> </div>
                                                        </div>
                                                    </div>
                                                    <div class="type_msg">
                                                        <div class="input_msg_write">
                                                            <input type="text" class="write_msg" placeholder="Type a message" />
                                                            <button class="msg_send_btn" type="button"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CORE JAVASCRIPTS START -->
<script src="<c:url value="/resources/theme-eseco/core/jquery/jquery.min.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/core/bootstrap/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/core/sweetalert/sweetalert.min.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/core/jquery-maskedinput/jquery.maskedinput.min.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/core/jquery-datetimepicker/jquery.datetimepicker.full.min.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/core/core.js" />"></script>
<!-- CORE JAVASCRIPTS END -->

<!-- GLOBAL LEVEL JAVASCRIPTS START -->
<script src="<c:url value="/resources/theme-eseco/plugins/d3.v4.min.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/d3.legend.min.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/d3-sankey.min.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/d3-sankey.js" />"></script>
<script type="text/javascript">
    var d3version4 = d3;
    window.d3 = null;
</script>
<script src="<c:url value="/resources/theme-eseco/plugins/d3.v3.min.js" />"></script>
<script type="text/javascript">
    var d3version3 = d3;
    window.d3 = null;
</script>
<script src="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/misc.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/micro-observer.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/microplugin.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/bubble-chart.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/central-click.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/lines.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/perspective-page-view/modernizr.custom.25376.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/perspective-page-view/classie.js" />"></script>
<script src="<c:url value="/resources/theme-eseco/plugins/perspective-page-view/menu.js" />"></script>

<script src="<c:url value="/resources/theme-eseco/custom/custom.js" />"></script>
<!-- GLOBAL LEVEL JAVASCRIPTS END -->

<!-- PAGE LEVEL JAVASCRIPTS START -->
<jsp:invoke fragment="javascripts"/>
<!-- PAGE LEVEL JAVASCRIPTS END -->
</body>
</html>
