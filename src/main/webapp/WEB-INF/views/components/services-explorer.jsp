<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Services Explorer
    </jsp:attribute>


    <jsp:attribute name="stylesheets">
        <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/plugins/jquery.responsiveTabs/responsive-tabs.css" />">
        <link rel="stylesheet" href="<c:url value="/resources/theme-eseco/plugins/jquery.responsiveTabs/responsive-tabs-theme.css" />">
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/jquery.responsiveTabs/jquery.responsiveTabs.min.js" />"></script>
        <script type="text/javascript">
            (function () {
                $('#tabs-services').responsiveTabs({
                    startCollapsed: 'accordion'
                });
            })();
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a>
        <a href="<c:url value="/components/services-explorer"/>"><i class="fa fa-angle-double-right"></i> Services Explorer</a>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Services Explorer</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Workflow Services</h3>
                    </div>
                    <div class="panel-body">

                        <!-- Services Tabs -->
                        <div id="tabs-services">
                            <!-- Tab Headers -->
                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation" class="active">
                                    <a href="#eseco" aria-controls="eseco" role="tab" data-toggle="tab">E-Seco Provided</a>
                                </li>
                                <li role="presentation">
                                    <a href="#external" aria-controls="external" role="tab" data-toggle="tab">External Sources</a>
                                </li>
                            </ul>

                            <!-- Tab Contents -->
                            <div class="tab-content">
                                <!-- E-Seco Provided -->
                                <div role="tabpanel" class="tab-pane active" id="eseco">

                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Protocol</th>
                                                <th>Author</th>
                                                <th>Date Created</th>
                                                <th>Actions</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="service" items="${services_workflow_list}">
                                                <tr>
                                                    <td><c:out value = "${service.component.name}"/></td>
                                                    <td><c:out value = "${service.protocol}"/></td>
                                                    <td><c:out value = "${service.component.author.agent.name}"/></td>
                                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${service.component.dateCreated}"/></td>
                                                    <td>
                                                        <a class="btn btn-xs btn-info" href="<c:url value="/components/details/${service.component.id}"/>">Explore</a>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <!-- External Sources -->
                                <div role="tabpanel" class="tab-pane" id="external">

                                    <form action="<c:url value="/components/services-search" />" method="post">
                                        <div class="form-group">
                                            <label for="search_string">Search String</label>
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-search"></i></div>
                                                <input id="search_string" name="search_string" class="form-control" type="text">
                                            </div>
                                        </div>

                                        <button type="submit" class="btn btn-block btn-success">Search</button>
                                    </form>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>