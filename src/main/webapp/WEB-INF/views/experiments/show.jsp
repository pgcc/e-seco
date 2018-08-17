<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<% pageContext.setAttribute("lf", "\n"); %>
<% pageContext.setAttribute("cr", "\r");%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Experiment
    </jsp:attribute>


    <jsp:attribute name="stylesheets">      
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            // Get JSON Data for visualizations
            var provenanceJson = JSON.parse('${experimentProvenanceJSON}');

            /***********************************************/
            /* PROVENANCE GRAPH                            */
            /***********************************************/
            function showProvenanceGraphVisualization() {
                var target = "#box-chart-provenance-graph";
                var width = $(target).css("width");
                width = width.replace("px", "");
                drawProvenanceGraph(provenanceJson, target, width);
            }
            ;
            showProvenanceGraphVisualization();
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/${experiment.id}"/>">View</a></li>
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

            <h2>Experiment Detail</h2>
            <br />
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <label class="col-sm-2">ID</label>
                        <div class="col-sm-10">${experiment.id}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Name</label>
                        <div class="col-sm-10">${experiment.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Status</label>
                        <div class="col-sm-10">${experiment.status.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Current Phase</label>
                        <div class="col-sm-10">${experiment.currentPhase.name}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Description</label>
                        <div class="col-sm-10">${experiment.description}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Version</label>
                        <div class="col-sm-10">${experiment.version}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Author</label>
                        <div class="col-sm-10">${experiment.author.displayName}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Keywords</label>
                        <div class="col-sm-10">${experiment.keywords}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Disciplines</label>
                        <div class="col-sm-10">
                            <c:forEach items="${experiment.disciplines}" var="discipline">
                                ${discipline.name}, 
                            </c:forEach>
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Created in</label>
                        <div class="col-sm-10">${experiment.dateCreated}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Updated in</label>
                        <div class="col-sm-10">${experiment.dateUpdated}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Ended in</label>
                        <div class="col-sm-10">${experiment.dateEnded}</div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">
                                        Experiment Provenance Graph Visualization
                                    </h3>
                                </div>
                                <div class="panel-body" style="position: relative;">
                                    <div id="box-chart-provenance-graph"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingFive">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="true" aria-controls="collapseFive">
                                        Protocol                                
                                    </a>
                                    <span class="badge">${experiment.details.size()}</span>
                                </h4>
                            </div>                                
                            <div id="collapseFive" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingFive">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <li class="list-group-item">
                                            <h4 style="text-align: center; color: #337ab7">
                                                As informações do protocolo apresentadas neste estudo de caso são apenas uma amostra.
                                                O pesquisador deve inserir neste campo todos os detalhes necessários para a realização do experimento.
                                                Outras informações do protocolo deste experimento são encontradas distribuídas no protocolo das atividades que compõem o experimento.
                                            </h4>
                                        </li>
                                        <c:forEach items="${experiment.details}" var="detail">
                                            <li class="list-group-item">${detail.name} = ${detail.description}</li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingThree">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
                                        Workflows                                
                                    </a>
                                    <span class="badge">${experiment.workflows.size()}</span>
                                </h4>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <c:forEach items="${experiment.workflows}" var="workflow">
                                            <li class="list-group-item"><a href="<c:url value="/experiments/workflows/${workflow.id}"/>">${workflow.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingTwo">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                        Institutions                                
                                    </a>
                                    <span class="badge">${experiment.institutions.size()}</span>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <c:forEach items="${experiment.institutions}" var="institution">
                                            <li class="list-group-item"><a href="<c:url value="/institutions/${institution.id}"/>">${institution.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingFour">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="true" aria-controls="collapseFour">
                                        Research Groups
                                    </a>
                                    <span class="badge">${experiment.researchGroups.size()}</span>
                                </h4>
                            </div>
                            <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <c:forEach items="${experiment.researchGroups}" var="researchGroup">
                                            <li class="list-group-item"><a href="<c:url value="/researchGroups/${researchGroup.id}"/>">${researchGroup.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingOne">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Researchers
                                    </a>
                                    <span class="badge">${experiment.researchers.size()}</span>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <c:forEach items="${experiment.researchers}" var="researcher">
                                            <li class="list-group-item"><a href="<c:url value="/researchers/${researcher.id}"/>">${researcher.displayName}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>



                    </div>
                </div>                
                <br/>
                <spring:url value="/experiments" var="urlExperiments" />
                <spring:url value="/experiments/${experiment.id}/update" var="urlUpdate" />
                <spring:url value="/experiments/${experiment.id}/workflows/add" var="urlAddWorkflow" />
                <spring:url value="/experiments/${experiment.id}/addProvenance" var="urlAddProvenance" />
                <spring:url value="/experiments/${experiment.id}/experimentPhaseReport/add" var="urlExperimentPhaseReport" />
                <nav class="navbar navbar-inverse">
                    <div>
                        <ul class="nav navbar-nav navbar-left">
                            <button onclick="location.href = '${urlExperiments}'" class="btn btn-link">
                                <span class="glyphicon glyphicon-arrow-left"></span> Back
                            </button>                            
                        </ul>
                    </div>
                </nav>
            </div>
        </jsp:body>
    </t:layout-app>