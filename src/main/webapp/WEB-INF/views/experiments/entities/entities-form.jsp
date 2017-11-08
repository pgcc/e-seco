<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Entity
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript">
            function showOtherFields(myRadio) {
                if (myRadio.value === "DATA") {
                    document.getElementById("datavalue").setAttribute("class", "form-group");
                    document.getElementById("datatype").setAttribute("class", "form-group");

                    document.getElementById("documentvalue").setAttribute("class", "form-group hidden");
                    document.getElementById("documentlink").setAttribute("class", "form-group hidden");
                }
                if (myRadio.value === "DOCUMENT") {
                    document.getElementById("datavalue").setAttribute("class", "form-group hidden");
                    document.getElementById("datatype").setAttribute("class", "form-group hidden");

                    document.getElementById("documentvalue").setAttribute("class", "form-group");
                    document.getElementById("documentlink").setAttribute("class", "form-group");
                }
            }
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a class="fa fa-street-view" href="<c:url value="/experiments"/>"> Experiments</a></li>
            <li><a href="<c:url value="/experiments/entities"/>"> Entities</a></li>
                <c:choose>
                    <c:when test="${entityForm['new']}">
                    <li><a href="<c:url value="/experiments/entities/add"/>">Add</a></li>
                    </c:when>
                    <c:otherwise>
                    <li><a href="<c:url value="/experiments/entities/${entityForm['id']}/update"/>">Update</a></li>
                    </c:otherwise>
                </c:choose>

        </ol>
    </jsp:attribute>


    <jsp:body>

        <div class="container-fluid">

            <c:choose>
                <c:when test="${entityForm['new']}">
                    <h2>Add Entity</h2>
                </c:when>
                <c:otherwise>
                    <h2>Update Entity</h2>
                </c:otherwise>
            </c:choose>
            <br />

            <spring:url value="/experiments/entities" var="experimentEntitiesUrl" />

            <f:form class="form form-horizontal" method="post" modelAttribute="entityForm" 
                    action="${experimentEntitiesUrl}">

                <f:hidden path="id" />

                <spring:bind path="name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <f:input path="name" class="form-control" rows="5" id="name" placeholder="Name" />
                            <f:errors path="name" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="kind">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Kind</label>
                        <div class="col-sm-10">
                            <c:choose>
                                <c:when test="${entityForm['new']}">
                                    <f:radiobuttons path="kind" items="${kindList}" itemLabel="name" element="label class='radio-inline'" onchange="showOtherFields(this)"/>
                                </c:when>
                                <c:otherwise>
                                    <f:radiobuttons path="kind" items="${kindList}" itemLabel="name" element="label class='radio-inline'" onchange="showOtherFields(this)" disabled="true"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="author.displayName">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Author</label>
                        <div class="col-sm-10">
                            <f:input path="author.displayName" class="form-control" id="author" placeholder="Author" disabled="true"/>
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="data.value">
                    <div id="datavalue" class="form-group ${status.error ? 'has-error' : ''} ${entityForm['kind']=='DATA'? '' : 'hidden'}">
                        <label class="col-sm-2 control-label">Value</label>
                        <div class="col-sm-10">
                            <f:textarea path="data.value" class="form-control" rows="5" id="value" placeholder="Value"/>
                            <f:errors path="data.value" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="data.type">
                    <div id="datatype" class="form-group ${status.error ? 'has-error' : ''} ${entityForm['kind']=='DATA'? '' : 'hidden'}">
                        <label class="col-sm-2 control-label">Type</label>
                        <div class="col-sm-10">
                            <f:input path="data.type" class="form-control" id="type" placeholder="Type" />
                            <f:errors path="data.type" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="document.value">
                    <div id="documentvalue" class="form-group ${status.error ? 'has-error' : ''} ${entityForm['kind']=='DOCUMENT'? '' : 'hidden'}">
                        <label class="col-sm-2 control-label">Value</label>
                        <div class="col-sm-10">
                            <f:textarea path="document.value" class="form-control" rows="5" id="value" placeholder="Value" />
                            <f:errors path="document.value" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <spring:bind path="document.link">
                    <div id="documentlink" class="form-group ${status.error ? 'has-error' : ''} ${entityForm['kind']=='DOCUMENT'? '' : 'hidden'}" >
                        <label class="col-sm-2 control-label">Link</label>
                        <div class="col-sm-10">
                            <f:input path="document.link" class="form-control" id="link" placeholder="Link" />
                            <f:errors path="document.link" class="control-label" />
                        </div>
                    </div>
                </spring:bind>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${entityForm['new']}">
                                <button type="submit" cc:when test="${entityForm['new']}" 
                                        class="btn btn-primary pull-right">Save</button>
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