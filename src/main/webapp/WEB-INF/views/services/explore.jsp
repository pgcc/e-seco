<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Services Explorer
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/services"/>"><i class="fa fa-street-view"></i> Services</a>
        <a href="<c:url value="/services/explore"/>"><i class="fa fa-angle-double-right"></i> Explore</a>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Services Explorer</h2>

                <!-- Nav tabs -->
                <ul class="nav nav-tabs margin-10-bottom" role="tablist">
                    <li role="presentation" class="active">
                        <a href="#internal_services" aria-controls="internal_services" role="tab" data-toggle="tab">Internal Services</a>
                    </li>
                    <li role="presentation">
                        <a href="#external_services" aria-controls="external_services" role="tab" data-toggle="tab">External Services</a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <!-- internal_services -->
                    <div role="tabpanel" class="tab-pane active" id="internal_services">
                        <div class="row">
                            <div class="col-xs-12 col-sm-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">WsUserList</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p>Description of this resource...</p>
                                        <a class="btn btn-info" href="<c:url value="/services/explore/single/1"/>">Explore
                                            this</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">WsProVersion</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p>Description of this resource...</p>
                                        <a class="btn btn-info" href="<c:url value="/services/explore/single/1"/>">Explore
                                            this</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">WsAlignmentServices</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p>Description of this resource...</p>
                                        <a class="btn btn-info" href="<c:url value="/services/explore/single/1"/>">Explore
                                            this</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">WSGeneIdStr</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p>Description of this resource...</p>
                                        <a class="btn btn-info" href="<c:url value="/services/explore/single/1"/>">Explore
                                            this</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">WsMessage</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p>Description of this resource...</p>
                                        <a class="btn btn-info" href="<c:url value="/services/explore/single/1"/>">Explore
                                            this</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- external_services -->
                    <div role="tabpanel" class="tab-pane" id="external_services">

                        <div class="row">
                            <div class="col-xs-12 col-sm-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Service#1123</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p>Description of this resource...</p>
                                        <a class="btn btn-info" href="<c:url value="/services/explore/single/1"/>">Explore
                                            this</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>






            </div>
        </div>
    </jsp:body>
</t:layout-app>