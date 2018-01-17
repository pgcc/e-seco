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