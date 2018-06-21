<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Researcher
    </jsp:attribute>


    <jsp:attribute name="stylesheets">
        <link rel="stylesheet"
              href="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.css"/>">
        <style type="text/css">
            .bld {
                font-weight: bold;
            }
        </style>
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/d3.v3.min.js" />"></script>
        <script type="text/javascript"
        src="<c:url value="/resources/theme-eseco/custom/eseco-visualization/eseco-visualization.js" />"></script>
        <script type="text/javascript">
            // Get JSON Data for visualizations
            var researcherKeywordsJson = JSON.parse('${researcherKeywordsJSON}');

            /***********************************************/
            /* KEYWORDS VISUALIZATION                      */
            /***********************************************/
            // WordCount
            function showKeywordsVisualization() {
                var width = $("#box-chart-keywords").css("width");
                width = width.replace("px", "");
                var wordCountData = mountDataToWordCount(researcherKeywordsJson);
                drawWordCount(wordCountData, "#box-chart-keywords", width);
            }
            ;

            function mountDataToWordCount(itemData) {
                var wordCountData = [];

                $.each(itemData, function (i, keyword) {
                    var foundKeywordInList = false;
                    $.each(wordCountData, function (i, keywordInList) {
                        if (keywordInList.text === keyword.name) {
                            foundKeywordInList = true;
                            if (keywordInList.size <= 60) {
                                keywordInList.size += 5;
                            }
                        }
                    });
                    if (!foundKeywordInList) {
                        wordCountData.push({
                            "text": keyword.name,
                            "size": 15
                        })
                    }
                });

                return wordCountData;
            }

            showKeywordsVisualization();
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/researchers"/>"><i class="fa fa-street-view"></i> Researchers</a></li>
            <li class="active"><a href="<c:url value="/researchers/${researcher.id}"/>">View</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="container-fluid">
            <c:if test="${not empty msg}">
                <div class="alert alert-${css} alert-dismissible margin-10-top" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <strong>${msg}</strong>
                </div>
            </c:if>

            <h2>Researcher Detail</h2>

            <div class="row">
                <div class="col-xs-12 col-sm-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Basic Info</h3>
                        </div>
                        <div class="panel-body">
                            <ul class="list-group lst-data-value">
                                <li class="list-group-item">
                                    <span>Id</span>
                                    <span>${researcher.id}</span>
                                </li>
                                <li class="list-group-item">
                                    <span>Name</span>
                                    <span>${researcher.displayName}</span>
                                </li>
                                <li class="list-group-item">
                                    <span>Photo</span>
                                    <span><img src="${researcher.photo}" class="img-rounded img-responsive" alt=""
                                               style="max-width: 200px;"></span>
                                </li>
                                <li class="list-group-item">
                                    <span>Academic Status</span>
                                    <span>${researcher.academicStatus}</span>
                                </li>
                                <li class="list-group-item">
                                    <span>Title</span>
                                    <span>${researcher.title}</span>
                                </li>
                                <li class="list-group-item">
                                    <span>Institutions</span>
                                    <span>
                                        <c:forEach var="institution" items="${researcher.institutions}">
                                            ${institution.name},
                                        </c:forEach>
                                    </span>
                                </li>
                                <li class="list-group-item">
                                    <span>Disciplines</span>
                                    <span>
                                        <c:forEach var="discipline" items="${researcher.disciplines}">
                                            ${discipline.name},
                                        </c:forEach>
                                    </span>
                                </li>
                                <li class="list-group-item">
                                    <span>Research Interests</span>
                                    <span>
                                        <c:forEach var="interest" items="${researcher.researchInterests}">
                                            ${interest.name},
                                        </c:forEach>
                                    </span>
                                </li>
                                <li class="list-group-item">
                                    <span>Mendeley Id</span>
                                    <span>${researcher.mendeleyId}</span>
                                </li>
                                <li class="list-group-item">
                                    <span>Kepler Id</span>
                                    <span>${researcher.keplerId}</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12 col-sm-6">









                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Keywords Cloud</h3>
                        </div>
                        <div class="panel-body">
                            <div id="box-chart-keywords"></div>


                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <a href="#collapseRatingsVisualization" class="collapsed" role="button"
                                   data-toggle="collapse">
                                    Keywords List <i class="fa fa-plus-circle"></i>
                                </a>
                            </h3>
                        </div>
                        <div id="collapseRatingsVisualization" class="panel-collapse collapse out">

                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Keyword</th>
                                        <th class="text-center" style="width:100px;">Year</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty researcher.researchKeywords}">
                                            <c:forEach var="keyword" items="${researcher.researchKeywords}">
                                                <tr>
                                                    <td>${keyword.name}</td>
                                                    <td class="text-center">${keyword.year}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td class="text-center" colspan="2">
                                                    No keywords found
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>


            <br/>
            <spring:url value="/profile" var="urlProfile"/>
            <spring:url value="/researchers/${researcher.id}/update" var="urlUpdate"/>
            <nav class="navbar navbar-inverse">
                <div>
                    <ul class="nav navbar-nav navbar-left">
                        <button onclick="location.href = '${urlProfile}'" class="btn btn-link"><span
                                class="glyphicon glyphicon-arrow-left"></span> Back
                        </button>
                        <c:if test="${researcher.agent.user.id == sessionScope.logged_user.id}">
                            <button onclick="location.href = '${urlUpdate}'" class="btn btn-link"><span
                                    class="glyphicon glyphicon-refresh"></span> Update
                            </button>
                        </c:if>
                    </ul>
                </div>
            </nav>
        </div>
    </jsp:body>
</t:layout-app>