<%@page contentType="text/html;charset=UTF-8" language="java" %>
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

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class = "breadcrumb">
            <li> <a class = "fa fa-street-view" href = "<c:url value="/experiments"/>"> Experiments </a></li>
            <li> <a href = "<c:url value="/experiments/${sessionScope.current_experiment_id}"/>"> View </a></li>
            <li> <a href = "<c:url value="/experiments/${experimentForm.id}/addProvenance"/>"> Add Provenance </a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div
            class = "container-fluid">
            <h2> Import Provenance Data </h2>               
            <br />
            <spring:url value="/experiments/saveProvenance/" var="saveProvenanceUrl" />            
            <spring:url value="/experiments/${experimentForm.id}/addProvenance" var="chooseFileUrl"/>

            <f:form class="form form-horizontal" method="post" modelAttribute="experimentForm" 
                    action="${saveProvenanceUrl}">

                <spring:bind path="name">
                    <div class = "form-group ${status.error ? 'has-error' : ''}">
                        <label class = "col-sm-2 control-label"> Name </label>
                        <div
                            class = "col-sm-10">
                            <f:input path="name" class="form-control" rows="5" id="name" placeholder="Name" disabled="true"/>
                            <f:errors path="name" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="workflows">
                    <div class = "form-group ${status.error ? 'has-error' : ''}">
                        <label class = "col-sm-2 control-label"> Workflow </label>
                        <div class="col-sm-10">
                            <f:select path="workflows" items="${workflowsList}" multiple="false" class="form-control" itemLabel="name" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>
                <div class = "form-group ${status.error ? 'has-error' : ''}">
                    <label class = "col-sm-2 control-label"> Provenance File </label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" type="button" onclick="type = 'post', action = '${chooseFileUrl}'">Choose File</button>
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
        </f:form>
    </div>
</jsp:body>
</t:layout-app>