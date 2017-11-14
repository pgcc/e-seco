<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Researcher
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/researchers"/>"><i class="fa fa-street-view"></i> Researchers</a></li>
            <li class="active" ><a href="<c:url value="/researchers/${researcher.id}"/>">View</a></li>
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
            <br/>
            <h2>Researcher Detail</h2>

            <div class="panel panel-default">

                <div class="panel-body">
                    <div class="row">
                        <label class="col-sm-2">ID</label>
                        <div class="col-sm-10">${researcher.id}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Name</label>
                        <div class="col-sm-10">${researcher.displayName}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Photo</label>
                        <div class="col-sm-10">
                            <img src="${researcher.photo}" class="img-rounded img-responsive" alt="" style="max-width: 200px;">
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Academic Status</label>
                        <div class="col-sm-10">${researcher.academicStatus}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Title</label>
                        <div class="col-sm-10">${researcher.title}</div>
                    </div>                    

                    <div class="row">
                        <label class="col-sm-2">Institutions</label>
                        <div class="col-sm-10">
                            <c:forEach var="institution" items="${researcher.institutions}">
                                ${institution.name},
                            </c:forEach>                    
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Disciplines</label>
                        <div class="col-sm-10">
                            <c:forEach var="discipline" items="${researcher.disciplines}">
                                ${discipline.name},
                            </c:forEach>                    
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Research Interests</label>
                        <div class="col-sm-10">
                            <c:forEach var="interest" items="${researcher.researchInterests}">
                                ${interest.name},
                            </c:forEach>                    
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Mendeley Id</label>
                        <div class="col-sm-10">${researcher.mendeleyId}</div>
                    </div>

                    <div class="row">
                        <label class="col-sm-2">Kepler Id</label>
                        <div class="col-sm-10">${researcher.keplerId}</div>
                    </div>

                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingTwo">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                        Research Groups                                
                                    </a>
                                    <span class="badge">${researcher.researchGroups.size()}</span>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                <div class="panel-body">
                                    <ul class="list-group" >
                                        <c:forEach items="${researcher.researchGroups}" var="group">
                                            <li class="list-group-item"><a href="<c:url value="/researchGroups/${group.id}"/>">${group.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br/>
            <spring:url value="/profile" var="urlProfile" />
            <spring:url value="/researchers/${researcher.id}/update" var="urlUpdate" />
            <nav class="navbar navbar-inverse">
                <div>
                    <ul class="nav navbar-nav navbar-left">
                        <button onclick="location.href = '${urlProfile}'" class="btn btn-link"><span class="glyphicon glyphicon-arrow-left"></span> Back</button>
                        <button onclick="location.href = '${urlUpdate}'" class="btn btn-link"><span class="glyphicon glyphicon-refresh"></span> Update</button>
                    </ul>
                </div>
            </nav>
        </div>
    </jsp:body>
</t:layout-app>