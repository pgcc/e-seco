<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Actions - Register
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            $("#component-type").on("change", function () {
                if ($(this).find(":selected").val() == 1) {
                    $(".form-workflow_service-info").fadeOut(function () {
                        $(".form-plugin-info").fadeIn();
                    });
                } else if ($(this).find(":selected").val() == 2) {
                    $(".form-plugin-info").fadeOut(function () {
                        $(".form-workflow_service-info").fadeIn();
                    });
                }else{
                    $(".form-workflow_service-info").fadeOut();
                    $(".form-plugin-info").fadeOut();
                }
            });
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="#">Actions</a></li>
            <li><a href="<c:url value="/components/actions/register"/>">Register</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Actions - Register</h2>

                <div class="row">
                    <div class="col-xs-12 col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    Component Register Form
                                </h3>
                            </div>
                            <div class="panel-body">
                                <form action="<c:url value="/components/actions/register"/>" method="post">
                                    <div class="form-group">
                                        <label for="component-name">Name</label>
                                        <input id="component-name" name="component-name" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="component-name">Type</label>
                                        <select id="component-type" name="component-type" class="form-control" required>
                                            <option value="">Choose</option>
                                            <option value="1">Plugin</option>
                                            <option value="2">Workflow Service</option>
                                        </select>
                                    </div>

                                    <div class="form-plugin-info" style="display:none;">

                                    </div>

                                    <div class="form-workflow_service-info" style="display:none;">
                                        <div class="form-group">
                                            <label for="ws-internal_class">Internal Class Name</label>
                                            <input id="ws-internal_class" name="ws-internal_class" class="form-control" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="ws-type">Service Type</label>
                                            <select id="ws-type" name="ws-type" class="form-control" required>
                                                <option value="">Choose</option>
                                                <option value="REST">REST</option>
                                                <option value="SOAP">SOAP</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="ws-url">URL</label>
                                            <input id="ws-url" name="ws-url" class="form-control" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="ws-description">Description</label>
                                            <textarea id="ws-description" name="ws-description" class="form-control" required></textarea>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="component-documentation">Documentation URI</label>
                                        <input id="component-documentation" name="component-documentation" class="form-control">
                                    </div>

                                    <div class="text-center">
                                        <button class="btn btn-success">Confirm</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>