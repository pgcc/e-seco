<%@page contentType="text/html;charset=ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Add Data Source
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            // Messages scripts
            <c:if test="${not empty success}">
            swal({
                    title: "Success!",
                    text: "Data Source Added. Press OK to go to Data Sources List",
                    type: "success",
                    closeOnClickOutside: false,
                    closeOnEsc: false,
                }, function () {
                    window.location.href = '<c:url value="/experiments/dataSources"/>';
                }
            );
            </c:if>

            <c:if test="${not empty errorNameRequired}">
            swal("Error", "Name is required", "error");
            </c:if>

            <c:if test="${not empty errorDataProviderRequired}">
            swal("Error", "At least one Data Provider must be chosen!", "error");
            </c:if>

            <c:if test="${not empty errorDataBase}">
            swal("Error", "An error occurred while trying to register the Data Source on database, please try again.", "error");
            </c:if>

            // Automated script in document.ready state
            (function () {
                // Data Providers checkboxes behavior
                $(".provider-checkbox").on("change", function () {
                    var id = $(this).data("provider_id");
                    if ($(this).prop("checked")) {
                        $(".dataprovider-parameters-" + id).slideDown();
                    } else {
                        $(".dataprovider-parameters-" + id).slideUp();
                    }
                });
            })();
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i>Experiments</a></li>
            <li><a href="<c:url value="/experiments/dataSources"/>">Data Sources</a></li>
            <li><a href="<c:url value="/experiments/dataSources/add"/>">Add</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Data Sources - Add</h2>

                <div class="row">
                    <div class="col-xs-12 col-sm-8">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    Add Data Source Form
                                </h3>
                            </div>
                            <div class="panel-body">
                                <form action="<c:url value="/experiments/dataSources/add"/>" method="post">
                                    <div class="form-group">
                                        <label for="datasource-name">Name</label>
                                        <input id="datasource-name" name="datasource-name" class="form-control"
                                               required>
                                    </div>
                                    <div class="form-group">
                                        <span><strong>Data Providers</strong></span>
                                        <div>
                                            <c:forEach var="dataProvider" items="${dataProvidersList}">
                                                <div class="checkbox">
                                                    <label for="datasource-dataprovider-${dataProvider.id}">
                                                        <input id="datasource-dataprovider-${dataProvider.id}"
                                                               name="datasource-dataprovider-${dataProvider.id}"
                                                               class="provider-checkbox"
                                                               type="checkbox" data-provider_id="${dataProvider.id}">
                                                            ${dataProvider.name}
                                                    </label>
                                                </div>
                                                <div class="dataprovider-parameters-${dataProvider.id}"
                                                     style="display: none">
                                                    <div class="row">
                                                        <c:forEach var="dpParameter" items="${dataProvider.parameters}">
                                                            <div class="col-xs-12 col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="dp-parameter-${dpParameter.id}">
                                                                            ${dpParameter.name}</label>
                                                                    <input id="dp-parameter-${dpParameter.id}"
                                                                           name="dp-parameter-${dpParameter.id}"
                                                                           class="form-control">
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </c:forEach>
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

            </div>
        </div>
    </jsp:body>

</t:layout-app>