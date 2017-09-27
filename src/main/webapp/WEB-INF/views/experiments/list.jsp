<%@ page session="false"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
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
                $.post(id, function (data) {
                    alert(data)
                });
            }
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a>
    </jsp:attribute>


    <jsp:body>
        <div class="container">

            <c:if test="${not empty msg}">
                <div class="alert alert-${css} alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <strong>${msg}</strong>
                </div>
            </c:if>

            <h2>All Experiments</h2>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>#ID</th>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Phase</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <c:forEach var="experiment" items="${experiments}">
                    <tr>
                        <td>${experiment.id}</td>
                        <td>${experiment.name}</td>
                        <td>${experiment.status.name}</td>
                        <td>${experiment.currentPhase.name}</td>

                        <td>
                            <spring:url value="/experiments/${experiment.id}" var="experimentUrl" />
                            <spring:url value="/experiments/${experiment.id}/delete" var="deleteUrl" /> 
                            <spring:url value="/experiments/${experiment.id}/update" var="updateUrl" />

                            <button class="btn btn-info" onclick="location.href = '${experimentUrl}'">
                                <span class="glyphicon glyphicon-eye-open"/>
                            </button>
                            <button class="btn btn-primary" onclick="location.href = '${updateUrl}'">
                                <span class="glyphicon glyphicon-edit"/>
                            </button>
                            <button class="btn btn-danger" onclick="this.disabled = true; post('${deleteUrl}')">
                                <span class="glyphicon glyphicon-remove"/>
                            </button></td>
                    </tr>
                </c:forEach>
            </table>

        </div>

    </jsp:body>
</t:layout-app>