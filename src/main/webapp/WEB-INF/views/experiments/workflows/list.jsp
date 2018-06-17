<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Workflows
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            function post(id) {
                swal({
                    title: "Are you sure?",
                    text: "Your will not be able to recover this workflow!",
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
            <li><a href="<c:url value="/experiments/workflows"/>">Workflows</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">
            <c:if test="${not empty msg}">
                <div class="alert alert-${css} alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert"
                            aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <strong>${msg}</strong>
                </div>
            </c:if> 

            <h2>My Workflows</h2>
            <br/>
            <div class="panel panel-default">
                <div class="panel-body">
                    <table class="table table-hover table-responsive">
                        <thead>
                            <tr>
                                <th>#ID</th>
                                <th>Name</th>
                                <th>Wfms</th>
                                <th>Author</th>
                                <th>Version</th>
                                <th class="text-center" >Action</th>
                            </tr>
                        </thead>
                        <c:forEach var="workflow" items="${myworkflows}">

                            <spring:url value="workflows/${workflow.id}" var="workflowUrl" />
                            <spring:url value="workflows/${workflow.id}/delete" var="deleteUrl" /> 
                            <spring:url value="workflows/${workflow.id}/update" var="updateUrl" />


                            <tr>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.id}</td>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.name}</td>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.wfms.name}</td>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.author.displayName}</td>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.version}</td>


                                <td class="text-center">
                                    <button class="btn btn-link" title="view" onclick="location.href = '${workflowUrl}'">
                                        <span class="glyphicon glyphicon-eye-open"/>
                                    </button>
                                    <button class="btn btn-primary btn-link" title="edit" onclick="location.href = '${updateUrl}'">
                                        <span class="glyphicon glyphicon-edit"/>
                                    </button>
                                    <button class="btn btn-danger btn-link" title="delete" onclick="this.disabled = true;
                                            post('${deleteUrl}')">
                                        <span class="glyphicon glyphicon-remove"/>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            
            <h2>All Workflows</h2>
            <br/>
            <div class="panel panel-default">
                <div class="panel-body">
                    <table class="table table-hover table-responsive">
                        <thead>
                            <tr>
                                <th>#ID</th>
                                <th>Name</th>
                                <th>Wfms</th>
                                <th>Author</th>
                                <th>Version</th>
                                <th class="text-center" >Action</th>
                            </tr>
                        </thead>
                        <c:forEach var="workflow" items="${workflows}">

                            <spring:url value="workflows/${workflow.id}" var="workflowUrl" />
                           
                            <tr>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.id}</td>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.name}</td>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.wfms.name}</td>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.author.displayName}</td>
                                <td onclick="location.href = '${workflowUrl}'">${workflow.version}</td>


                                <td class="text-center">
                                    <button class="btn btn-link" title="view" onclick="location.href = '${workflowUrl}'">
                                        <span class="glyphicon glyphicon-eye-open"/>
                                    </button>                                    
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout-app>