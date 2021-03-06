<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Entities
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            // Get JSON Data for visualizations
            var provenanceJson = JSON.parse('${entityProvenanceJSON}');
            /***********************************************/
            /* BUBLLE MENU                                 */
            /***********************************************/
            function showBubbleMenuVisualization() {
                var target = "#box-chart-entity-provenance-graph";
                var width = $(target).css("width");
                width = width.replace("px", "");
                drawBubbleMenu(provenanceJson, target, width);
            }
            ;
            showBubbleMenuVisualization();
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/entities"/>">Entities</a></li>
            <li><a href="<c:url value="/experiments/entities/${entity.id}"/>">View</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:if test="${not empty msg}">
                <div class="alert alert-${css} alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <strong>${msg}</strong>
                </div>
            </c:if>

            <h2>Entity Detail</h2>
            <br />
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <label class="col-sm-2">ID</label>
                        <div class="col-sm-10">${entity.id}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Name</label>
                        <div class="col-sm-10">${entity.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Author</label>
                        <div class="col-sm-10">${entity.author.displayName}</div>
                    </div>

                    <c:choose>
                        <c:when test="${entity['kind']=='DATA'}">
                            <div class="row">
                                <label class="col-sm-2">Kind</label>
                                <div class="col-sm-10">DATA</div>
                            </div>
                            <div class="row">
                                <label class="col-sm-2">Type</label>
                                <div class="col-sm-10">${entity.data.type}</div>
                            </div>
                            <div class="row">
                                <label class="col-sm-2">Value</label>
                                <div class="col-sm-10">${entity.data.value}</div>
                            </div>
                        </c:when>
                        <c:when test="${entity['kind']=='DOCUMENT'}">     
                            <div class="row">
                                <label class="col-sm-2">Kind</label>
                                <div class="col-sm-10">DOCUMENT</div>
                            </div>
                            <spring:url value="/experiments/entities/${entity.id}/download" var="downloadUrl" />
                            <div class="row">
                                <label class="col-sm-2">Link</label>
                                <div class="col-sm-8">${entity.document.file}</div>
                                <button class="btn btn-primary" type="button" onclick="location.href = '${downloadUrl}'">Download</button>
                            </div>                            
                        </c:when>
                    </c:choose>
                </div>   

                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    Provenance Visualization
                                </h3>
                            </div>
                            <div class="panel-body" style="position: relative;">
                                <div class="col-xs-2"></div>
                                <div class="col-xs-7">
                                    <div id="box-chart-entity-provenance-graph"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </jsp:body>
    </t:layout-app>