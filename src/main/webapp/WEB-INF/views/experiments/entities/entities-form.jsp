<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
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

                    document.getElementById("documentlink").setAttribute("class", "form-group hidden");
                }
                if (myRadio.value === "DOCUMENT") {
                    document.getElementById("datavalue").setAttribute("class", "form-group hidden");
                    document.getElementById("datatype").setAttribute("class", "form-group hidden");

                    document.getElementById("documentlink").setAttribute("class", "form-group");
                }
            }
            ;
            function fileSelected(myInput) {
                document.getElementById("file").setAttribute("value", myInput.value);
            }
            ;
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
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
            <c:if test="${not empty msg}">
                <div class="alert alert-${css} alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <strong>${msg}</strong>
                </div>
            </c:if>

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
            <spring:url value="/experiments/entities/upload" var="experimentUploadUrl" />
            <f:form class="form form-horizontal" method="post" modelAttribute="entityForm" 
                    enctype="multipart/form-data" action="${experimentEntitiesUrl}">

                <f:hidden path="id" />

                <spring:bind path="name">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <f:input path="name" class="form-control" id="name" placeholder="Name" />
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
                            <f:errors path="kind" class="control-label" />
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

                <spring:bind path="data.type">
                    <div id="datatype" class="form-group ${status.error ? 'has-error' : ''} ${entityForm['kind']=='DATA'? '' : 'hidden'}">
                        <label class="col-sm-2 control-label">Type</label>
                        <div class="col-sm-10">
                            <f:input path="data.type" class="form-control" id="type" placeholder="Type" />
                            <f:errors path="data.type" class="control-label" />
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

                <spring:url value="/experiments/entities/choosefile" var="chooseFileUrl"/>
                <spring:bind path="document.file">
                    <div id="documentlink" class="form-group ${status.error ? 'has-error' : ''} ${entityForm['kind']=='DOCUMENT'? '' : 'hidden'}" >
                        <label class="col-sm-2 control-label">File</label>
                        <div class="col-sm-10">
                            <c:choose>
                                <c:when test="${entityForm['new']}">
                                    <div class="input-group">
                                        <span class="input-group-btn">
                                            <button class="btn btn-primary" type="button" onclick="$('#fileToUpload').click()">Choose</button>
                                        </span>
                                        <f:input id="file" path="document.file" class="form-control" placeholder="File URL"/>
                                    </div>
                                    <f:errors path="document.file" class="control-label" />
                                </c:when>
                                <c:otherwise>
                                    <div class="input-group">
                                        <span class="input-group-btn">
                                            <button class="btn btn-primary" disabled="true" type="button" >Choose</button>
                                        </span>                                        
                                        <f:input path="document.file" disabled="true" class="form-control" id="link" placeholder="File URL"/>
                                    </div>
                                </c:otherwise>
                            </c:choose>

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
                <input type="file" id="fileToUpload" name="fileToUpload" style="visibility: hidden;" onchange="fileSelected(this)" />
            </f:form>


        </div>
    </jsp:body>
</t:layout-app>