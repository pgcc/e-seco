<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Actions - Workflow Services - Rating ${invitation.workflowService.component.name}
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            $("#rad-approved").on("click", function () {
                if ($(this).prop("checked")) {
                    $("#box-text-reprove").fadeOut();
                }
            });

            $("#rad-reproved").on("click", function () {
                if ($(this).prop("checked")) {
                    $("#box-text-reprove").fadeIn();
                }
            });
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="#">Actions</a></li>
            <li><a href="#">Workflow Services</a></li>
            <li><a href="<c:url value="/components/actions/workflow-services/rating"/>">Rating Invitations</a></li>
            <li>
                <a href="<c:url value="/components/actions/workflow-services/rating/${invitation.id}"/>">Rating ${invitation.workflowService.component.name}</a>
            </li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Actions - Workflow Services - Rating ${invitation.workflowService.component.name}</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Rating Form</h3>
                    </div>
                    <div class="panel-body">

                        <form action="<c:url value="/components/actions/workflow-services/rating/${invitation.id}"/>"
                              method="post">

                            <div class="row">
                                <div class="col col-xs-12">
                                    <div class="form-group">
                                        <div class="radio-inline">
                                            <label>
                                                <input id="rad-approved" name="approved" type="radio" value="1" checked>
                                                Approved
                                            </label>
                                        </div>
                                        <div class="radio-inline">
                                            <label>
                                                <input id="rad-reproved" name="approved" type="radio" value="0">
                                                Reproved
                                            </label>
                                        </div>
                                    </div>
                                    <div id="box-text-reprove" class="form-group" style="display: none;">
                                        <label for="text-reproved">Reason for the reprove</label>
                                        <textarea id="text-reproved" name="text-reproved"
                                                  class="form-control"></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col col-xs-12 col-md-4">
                                    <div class="form-group">
                                        <label for="documentation">Documentation</label>
                                        <select id="documentation" name="documentation" class="form-control" required>
                                            <option value="">Choose</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col col-xs-12 col-md-4">
                                    <div class="form-group">
                                        <label for="ease_of_use">Ease of Use</label>
                                        <select id="ease_of_use" name="ease_of_use" class="form-control" required>
                                            <option value="">Choose</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col col-xs-12 col-md-4">
                                    <div class="form-group">
                                        <label for="performance">Performance</label>
                                        <select id="performance" name="performance" class="form-control" required>
                                            <option value="">Choose</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col col-xs-12 col-md-4">
                                    <div class="form-group">
                                        <label for="reliability">Reliability</label>
                                        <select id="reliability" name="reliability" class="form-control" required>
                                            <option value="">Choose</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col col-xs-12 col-md-4">
                                    <div class="form-group">
                                        <label for="disponibility">Availability</label>
                                        <select id="disponibility" name="disponibility" class="form-control" required>
                                            <option value="">Choose</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center">
                                <button class="btn btn-success">Confirm</button>
                            </div>
                        </form>

                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>