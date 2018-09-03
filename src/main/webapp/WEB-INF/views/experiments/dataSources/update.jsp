<%@page contentType="text/html;charset=ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Update Data Source
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
                <h2>Data Sources - Update</h2>

                <div class="row">
                    <div class="col-xs-12 col-sm-8">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    Update Data Source Form
                                </h3>
                            </div>
                            <div class="panel-body">
                                <p>Soon</p>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>

</t:layout-app>