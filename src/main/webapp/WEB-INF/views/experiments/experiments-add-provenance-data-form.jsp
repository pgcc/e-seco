<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Add Provenace Data
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            function fileSelected(myInput) {
                document.getElementById("file").setAttribute("value", myInput.value);
            }
            ;
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class = "breadcrumb">
            <li> <a class = "fa fa-street-view" href = "<c:url value="/experiments"/>"> Experiments </a></li>
            <li> <a href = "<c:url value="/experiments/${experimentForm.id}"/>"> View </a></li>
            <li> <a href = "<c:url value="/experiments/${experimentForm.id}/addProvenance"/>"> Add Provenance </a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div
            class = "container-fluid">

            <c:if test="${not empty msg}">
                <div class="alert alert-${css} alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <strong>${msg}</strong>
                </div>
            </c:if>
            <h2> Import Provenance Data </h2>               
            <br />
            <spring:url value="/experiments/saveProvenance/" var="saveProvenanceUrl" />            

            <f:form class="form form-horizontal" method="post" modelAttribute="experimentForm" 
                    enctype="multipart/form-data" action="${saveProvenanceUrl}">

                <spring:bind path="name">
                    <div class = "form-group ${status.error ? 'has-error' : ''}">
                        <label class = "col-sm-2 control-label">Experiment</label>
                        <div
                            class = "col-sm-10">
                            <f:input path="name" class="form-control" id="name" placeholder="Name" disabled="true"/>
                            <f:errors path="name" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="workflows">
                    <div class = "form-group ${status.error ? 'has-error' : ''}">
                        <label class = "col-sm-2 control-label">Workflow</label>
                        <div class="col-sm-10">
                            <f:select path="workflows" items="${workflowsList}" multiple="false" class="form-control" itemLabel="name" itemValue="id"/>
                        </div>
                    </div>
                    <f:errors path="workflows" class="control-label" />
                </spring:bind>
                <div class = "form-group ${status.error ? 'has-error' : ''}">
                    <label class = "col-sm-2 control-label">Provenance File </label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" type="button" onclick="$('#fileToUpload').click()">Choose File</button>
                            </span>
                            <input id="file" name="file" type="text" class="form-control" placeholder="File Name" value="${file}">
                        </div>
                    </div>   
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-primary pull-right">Import</button>
                    </div>
                </div>
            </div>
            <input type="file" id="fileToUpload" name="fileToUpload" style="visibility: hidden;" onchange="fileSelected(this)" />
        </f:form>
    </div>
</jsp:body>
</t:layout-app>