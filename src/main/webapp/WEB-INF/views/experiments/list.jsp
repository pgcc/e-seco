<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Experiments
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            function post(id) {
                swal({
                        title: "Are you sure?",
                        text: "Your will not be able to recover this experiment!",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonClass: "btn-danger",
                        confirmButtonText: "Yes, delete it!",
                        closeOnConfirm: true
                    },
                    function () {
                        var form = $('<form action="' + id + '" method="post">' +
                            '</form>');
                        $('body').append(form);
                        form.submit();
                    });
            }
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Experiments</h2>
                <div class="pnl-experiments">
                    <div class="panel panel-phase01">
                        <div class="panel-heading">
                            <h2 class="panel-title"><i class="fa fa-search"></i> Problem Investigation</h2>
                        </div>
                        <div class="panel-body">
                            <c:forEach var="experiment" items="${experimentsPhase01}">
                                <spring:url value="/experiments/${experiment.id}" var="experimentUrl"/>
                                <spring:url value="/experiments/${experiment.id}/delete" var="deleteUrl"/>
                                <spring:url value="/experiments/${experiment.id}/update" var="updateUrl"/>

                                <div class="box-experiment">
                                    <p>${experiment.name}</p>
                                    <p><strong>${experiment.author.displayName}</strong></p>
                                    <p class="text-right">
                                        <a href="${experimentUrl}"><i class="glyphicon glyphicon-eye-open"></i></a>
                                        <c:if test="${experiment.author.agent.user.id == sessionScope.logged_user.id}">
                                            <a href="${updateUrl}"><i class="glyphicon glyphicon-edit"></i></a>
                                            <a href="${deleteUrl}"><i class="glyphicon glyphicon-remove"></i></a>
                                        </c:if>
                                    </p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="panel panel-phase02">
                        <div class="panel-heading">
                            <h2 class="panel-title"><i class="fa fa-cubes"></i> Prototyping</h2>
                        </div>
                        <div class="panel-body">
                            <c:forEach var="experiment" items="${experimentsPhase02}">
                                <spring:url value="/experiments/${experiment.id}" var="experimentUrl"/>
                                <spring:url value="/experiments/${experiment.id}/delete" var="deleteUrl"/>
                                <spring:url value="/experiments/${experiment.id}/update" var="updateUrl"/>

                                <div class="box-experiment">
                                    <p>${experiment.name}</p>
                                    <p><strong>${experiment.author.displayName}</strong></p>
                                    <p class="text-right">
                                        <a href="${experimentUrl}"><i class="glyphicon glyphicon-eye-open"></i></a>
                                        <c:if test="${experiment.author.agent.user.id == sessionScope.logged_user.id}">
                                            <a href="${updateUrl}"><i class="glyphicon glyphicon-edit"></i></a>
                                            <a href="${deleteUrl}"><i class="glyphicon glyphicon-remove"></i></a>
                                        </c:if>
                                    </p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="panel panel-phase03">
                        <div class="panel-heading">
                            <h2 class="panel-title"><i class="fa fa-forward"></i> Execution</h2>
                        </div>
                        <div class="panel-body">
                            <c:forEach var="experiment" items="${experimentsPhase03}">
                                <spring:url value="/experiments/${experiment.id}" var="experimentUrl"/>
                                <spring:url value="/experiments/${experiment.id}/delete" var="deleteUrl"/>
                                <spring:url value="/experiments/${experiment.id}/update" var="updateUrl"/>

                                <div class="box-experiment">
                                    <p>${experiment.name}</p>
                                    <p><strong>${experiment.author.displayName}</strong></p>
                                    <p class="text-right">
                                        <a href="${experimentUrl}"><i class="glyphicon glyphicon-eye-open"></i></a>
                                        <c:if test="${experiment.author.agent.user.id == sessionScope.logged_user.id}">
                                            <a href="${updateUrl}"><i class="glyphicon glyphicon-edit"></i></a>
                                            <a href="${deleteUrl}"><i class="glyphicon glyphicon-remove"></i></a>
                                        </c:if>
                                    </p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="panel panel-phase04">
                        <div class="panel-heading">
                            <h2 class="panel-title"><i class="fa fa-newspaper-o"></i> Publication</h2>
                        </div>
                        <div class="panel-body">
                            <c:forEach var="experiment" items="${experimentsPhase04}">
                                <spring:url value="/experiments/${experiment.id}" var="experimentUrl"/>
                                <spring:url value="/experiments/${experiment.id}/update" var="updateUrl"/>
                                <spring:url value="/experiments/${experiment.id}/delete" var="deleteUrl"/>

                                <div class="box-experiment">
                                    <p>${experiment.name}</p>
                                    <p><strong>${experiment.author.displayName}</strong></p>
                                    <p class="text-right">
                                        <a href="${experimentUrl}"><i class="glyphicon glyphicon-eye-open"></i></a>
                                        <c:if test="${experiment.author.agent.user.id == sessionScope.logged_user.id}">
                                            <a href="${updateUrl}"><i class="glyphicon glyphicon-edit"></i></a>
                                            <a href="${deleteUrl}"><i class="glyphicon glyphicon-remove"></i></a>
                                        </c:if>
                                    </p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>