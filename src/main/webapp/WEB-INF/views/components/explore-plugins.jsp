<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Components Explorer - Plugins
    </jsp:attribute>


    <jsp:attribute name="stylesheets">
        <style type="text/css">
            .sort {
                border: none;
                color: #286090;
                background-color: #fff;
            }

            .sort:after {
                display: inline-block;
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
                border-bottom: 5px solid transparent;
                content: "";
                position: relative;
                top: -10px;
                right: -5px;
            }

            .sort.asc:after {
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
                border-top: 5px solid #286090;
                content: "";
                position: relative;
                top: 4px;
                right: -5px;
            }

            .sort.desc:after {
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
                border-bottom: 5px solid #286090;
                content: "";
                position: relative;
                top: -4px;
                right: -5px;
            }
        </style>
    </jsp:attribute>


    <jsp:attribute name="javascripts">
        <script type="text/javascript" src="<c:url value="/resources/theme-eseco/plugins/list.js" />"></script>
        <script type="text/javascript">
            // Table Search
            var options = {
                valueNames: ['component_name', 'component_author']
            };

            var componentsList = new List('components', options);
        </script>
    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/components"/>"><i class="fa fa-street-view"></i> Components</a></li>
            <li><a href="<c:url value="#"/>">Explorer</a></li>
            <li><a href="<c:url value="/components/plugins"/>">Plugins</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Components Explorer - Plugins</h2>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">List of Plugins</h3>
                    </div>
                    <div class="panel-body">
                        <div id="components">
                            <div class="row">
                                <div class="col-xs-12 col-sm-6">
                                    &nbsp;
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <input class="search form-control" placeholder="Search">
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>
                                            <button class="sort" data-sort="component_name">Name</button>
                                        </th>
                                        <th style="width:130px;">
                                            <button class="sort" data-sort="component_author">Author</button>
                                        </th>
                                        <th class="text-center" style="width:130px;">Date Created</th>
                                        <th class="text-center" style="width:60px;">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody class="list">
                                    <c:forEach var="plugin" items="${plugins_list}">
                                        <tr>
                                            <td class="component_name"><c:out value="${plugin.component.name}"/></td>
                                            <td class="component_author"><c:out
                                                    value="${plugin.component.author.agent.name}"/></td>
                                            <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd"
                                                                                    value="${plugin.component.dateCreated}"/></td>
                                            <td>
                                                <a class="btn btn-xs btn-primary"
                                                   href="<c:url value="/components/details/1/${plugin.component.id}"/>">Explore</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>