<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Researcher Profile
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            $("#btn-search-dblp").on("click", function () {
                alert("Not implemeted yet!");
            });

            $("#btn-search-researchgate").on("click", function () {
                alert("Not implemeted yet!");
            });
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/profile"/>"><i class="fa fa-street-view"></i> User Profile</a></li>
                <c:choose>
                    <c:when test="${researcherForm['new']}">
                    <li><a href="<c:url value="/researchers/add"/>">Add</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/researchers/${researcherForm['id']}/update"/>">Update</a></li>
                    </c:otherwise>
                </c:choose>
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

            <c:choose>
                <c:when test="${researcherForm['new']}">
                    <h2>Add Researcher</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Researcher</h2>
                </c:otherwise>
            </c:choose>
            <br/>

            <c:url var="mendeleySearch" value="/researchers/mendeleySearch"/>
            <f:form class="form form-horizontal" method="get" action="${mendeleySearch}"
                    modelAttribute="researcherForm">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">E-mail</label>
                    <div class="col-sm-10">
                        <f:input path="agent.user.email" class="form-control" type="email"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-10 col-sm-offset-2">
                        <f:button type="submit" class="btn btn-primary">Mendeley Search</f:button>
                        <f:button type="button" class="btn btn-primary" id="btn-search-dblp">DBLP Search</f:button>
                        <f:button type="button" class="btn btn-primary" id="btn-search-researchgate">ResearchGate Search</f:button>
                        </div>
                    </div>
            </f:form>
            <c:url var="register" value="/researchers"/>
            <f:form class="form form-horizontal" method="post" action="${register}" modelAttribute="researcherForm">
                <spring:bind path="photo">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Photo URL</label>
                        <div class="col-sm-10">
                            <f:input path="photo" class="form-control" type="text"/>
                        </div>
                    </div>
                </spring:bind>
                <div class="form-group">
                    <div class="col-sm-10 col-sm-offset-2">
                        <img src="${researcherForm['photo']}" class="img-rounded img-responsive center-block" alt=""
                             style="max-width: 200px;">
                    </div>
                </div>

                <spring:bind path="displayName">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Display Name</label>
                        <div class="col-sm-10">
                            <f:input path="displayName" class="form-control" type="text"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="title">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Title</label>
                        <div class="col-sm-10">
                            <f:input path="title" class="form-control" type="text"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="academicStatus">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Academic Status</label>
                        <div class="col-sm-10">
                            <f:input path="academicStatus" class="form-control" type="text"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="researchInterests">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Research Interests</label>
                        <div class="col-sm-10">
                            <f:select path="researchInterests" items="${interestsList}" multiple="true" size="3"
                                      class="form-control" itemLabel="name" itemValue="id"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="disciplines">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Disciplines</label>
                        <div class="col-sm-10">
                            <f:select path="disciplines" items="${disciplinesList}" multiple="true" size="3"
                                      itemLabel="name" itemValue="id" class="form-control"/>
                            <f:errors path="disciplines" class="control-label"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="institutions">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Institutions</label>
                        <div class="col-sm-10">
                            <f:select path="institutions" items="${institutionsList}" multiple="true" size="3"
                                      class="form-control" itemLabel="name" itemValue="id"/>
                            <f:errors path="institutions" class="control-label"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="lattesId">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Lattes</label>
                        <div class="col-sm-10">
                            <f:input path="lattesId" class="form-control" type="text"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="researchgateId">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">ResearchGate</label>
                        <div class="col-sm-10">
                            <f:input path="researchgateId" class="form-control" type="text"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="mendeleyId">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Mendeley</label>
                        <div class="col-sm-10">
                            <f:input path="mendeleyId" class="form-control" type="text"/>
                        </div>
                    </div>
                </spring:bind>
                             
                <spring:bind path="keplerId">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Kepler</label>
                        <div class="col-sm-10">
                            <f:input path="keplerId" class="form-control" type="text"/>
                        </div>
                    </div>
                </spring:bind>

                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${researcherForm['new']}">
                                <button type="submit" cc:when test="${researcherForm['new']}"
                                        class="btn btn-primary pull-right">Add
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" class="btn btn-primary pull-right">Update</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </f:form>
        </div>
    </jsp:body>
</t:layout-app>