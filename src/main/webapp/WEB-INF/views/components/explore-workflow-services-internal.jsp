<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Explorer - Workflow Services - Internal
    </jsp:attribute>


    <jsp:attribute name="stylesheets">
        <style type="text/css">
            .sort {
                border: none;
                color: #286090;
                background-color: #fff;
            }

            .sort:after {
                display: inline-block;
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
                border-bottom: 5px solid transparent;
                content: "";
                position: relative;
                top: -10px;
                right: -5px;
            }

            .sort.asc:after {
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
                border-top: 5px solid #286090;
                content: "";
                position: relative;
                top: 4px;
                right: -5px;
            }

            .sort.desc:after {
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
                border-bottom: 5px solid #286090;
                content: "";
                position: relative;
                top: -4px;
                right: -5px;
            }
        </style>
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/list.js" />"></script>
        <script type="text/javascript">
            function updateActionsButtons() {
                $("#fld-actions-compare").prop("disabled", $(".cbx-actions-item:checked").length <= 1);
            }

            function updateFldActionsIds() {
                var ids = "";
                $(".cbx-actions-item:checked").each(function () {
                    ids += $(this).val() + ",";
                });

                ids = ids.slice(0, -1);

                $('input[name="actions-ids"]').val(ids);
            }

            function updateTxtActionsInfo() {
                var selected = $(".cbx-actions-item:checked").length;
                var text = "With <strong>" + selected + "</strong> selected, do: ";
                $(".txt-actions-info").html(text);
            };

            // Pre-Actions
            updateTxtActionsInfo();
            updateActionsButtons();

            // Event Actions
            $("#cbx-actions-select-all").on("click", function () {
                $(".cbx-actions-item").prop("checked", $(this).prop("checked"));
                updateFldActionsIds();
                updateActionsButtons();
                updateTxtActionsInfo();
            });

            $(".cbx-actions-item").on("click", function () {
                updateFldActionsIds();
                updateActionsButtons();
                updateTxtActionsInfo();
            });


            // Table Search
            var options = {
                valueNames: ['service_name', 'service_type', 'service_author', 'service_description']
            };

            var servicesList = new List('services', options);
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="<c:url value="#"/>">Explorer</a></li>
            <li><a href="<c:url value="#"/>">Workflow Services</a></li>
            <li><a href="<c:url value="/components/workflow-services/internal"/>">Internal</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Components Explorer - Workflow Services - Internal</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">List of Internal Workflow Services</h3>
                    </div>
                    <div class="panel-body">
                        <div id="services">
                            <div class="row">
                                <div class="col-xs-12 col-sm-6">
                                    <form id="frm-actions"
                                          action="<c:url value="/components/actions/workflow-services/compare"/>"
                                          method="post">
                                        <input name="actions-ids" type="hidden">
                                        <div class="form-group">
                                            <span class="txt-actions-info"></span>
                                            <input id="fld-actions-compare" name="actions-compare"
                                                   class="btn btn-primary btn-xs" type="submit"
                                                   value="Compare Services">
                                        </div>
                                    </form>
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <input class="search form-control" placeholder="Search">
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th class="text-center" style="width:40px;">
                                            <input id="cbx-actions-select-all" title="Select All"
                                                   type="checkbox">
                                        </th>
                                        <th>
                                            <button class="sort" data-sort="service_name">Name</button>
                                        </th>
                                        <th class="text-center" style="width:130px;">
                                            <button class="sort" data-sort="service_type">Type</button>
                                        </th>
                                        <th style="width:130px;">
                                            <button class="sort" data-sort="service_author">Author</button>
                                        </th>
                                        <th class="text-center" style="width:130px;">Date Created</th>
                                        <th style="width:300px;">Description</th>
                                        <th class="text-center" style="width:60px;">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody class="list">
                                    <c:forEach var="service" items="${services_workflow_list}">
                                        <tr>
                                            <td class="text-center">
                                                <input name="actions-item-${service.component.id}"
                                                       class="cbx-actions-item" title="Select This"
                                                       type="checkbox" value="${service.component.id}">
                                            </td>
                                            <td class="service_name"><c:out value="${service.component.name}"/></td>
                                            <td class="service_type text-center"><c:out
                                                    value="${service.type}"/></td>
                                            <td class="service_author"><c:out
                                                    value="${service.component.author.agent.name}"/></td>
                                            <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd"
                                                                                    value="${service.component.dateCreated}"/></td>
                                            <td class="service_description text-justify"><c:out
                                                    value="${service.shortDescription}"/></td>
                                            <td>
                                                <a class="btn btn-xs btn-primary"
                                                   href="<c:url value="/components/details/2/${service.component.id}"/>">Explore</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>