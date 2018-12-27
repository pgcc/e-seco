<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO View Data Source: ${dataSource.name}
    </jsp:attribute>


    <jsp:attribute name="stylesheets">
        <style type="text/css">
            .table-hover tbody tr:hover td {
                background-color: Lavender;
            }
        </style>
    </jsp:attribute>


    <jsp:attribute name="javascripts">

    </jsp:attribute>


    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/dataSources/"/>">Data Sources</a></li>
            <li><a href="<c:url value="/experiments/dataSources/${dataSource.id}"/>">View: ${dataSource.name}</a></li>
        </ol>
    </jsp:attribute>


    <jsp:body>
        <div class="row">
            <div class="col-xs-12">
                <h2>Details: <strong>${dataSource.name}</strong></h2>

                <div class="row">
                    <div class="col-xs-12 col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Basic Info</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="list-group lst-data-value">
                                    <li class="list-group-item">
                                        <span>Id</span>
                                        <span>${dataSource.id}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Name</span>
                                        <span>${dataSource.name}</span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Author</span>
                                        <span><a href="<c:url value="/agents/${dataSource.author.agent.id}"/>"
                                                 target="_blank">${dataSource.author.displayName} <i
                                                class="fa fa-external-link"></i></a></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Date Created</span>
                                        <span><fmt:formatDate pattern="yyyy-MM-dd"
                                                              value="${dataSource.dateCreated}"/></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Date Last Updated</span>
                                        <c:choose>
                                            <c:when test="${not empty dataSource.dateUpdated}">
                                                <span><fmt:formatDate pattern="yyyy-MM-dd"
                                                                      value="${dataSource.dateUpdated}"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>Never Updated</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-12 col-sm-8">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Providers and Parameters</h3>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <c:forEach var="dataSourceProvider" items="${dataSource.providers}">
                                        <div class="col-xs-12 col-sm-4">
                                            <strong>${dataSourceProvider.dataProvider.name}</strong>
                                            <ul>
                                                <c:forEach var="dataSourceProviderParameter"
                                                           items="${dataSourceProvider.parameters}">
                                                    <li>
                                                        <span><em>${dataSourceProviderParameter.dataProviderParameter.name}</em></span>
                                                        <span>: ${dataSourceProviderParameter.valueString}</span>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">AA</h3>
                            </div>
                            <div class="panel-body">

                                <table class="table table-hover table-bordered">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Property</th>
                                        <th>Value</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Global Horizontal Irradiance center value (mean)</td>
                                        <td>215</td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Global Horizontal Irradiance 10th percentile value (low scenario)</td>
                                        <td>84</td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Global Horizontal Irradiance 90th percentile value (high scenario)</td>
                                        <td>408</td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>Direct Normal Irradiance center value (mean)</td>
                                        <td>28</td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>Direct Normal Irradiance 10th percentile value (low scenario)</td>
                                        <td>2</td>
                                    </tr>
                                    <tr>
                                        <td>6</td>
                                        <td>Direct Normal Irradiance 90th percentile value (high scenario)</td>
                                        <td>93</td>
                                    </tr>
                                    <tr>
                                        <td>7</td>
                                        <td>Diffuse Horizontal Irradiance
                                        </td>
                                        <td>213
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>8</td>
                                        <td>Air Temperature</td>
                                        <td>12</td>
                                    </tr>
                                    <tr>
                                        <td>9</td>
                                        <td>Diffuse Horizontal Irradiance
                                        </td>
                                        <td>213
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>10</td>
                                        <td>Apparent Temperature</td>
                                        <td>14.98</td>
                                    </tr>
                                    <tr>
                                        <td>11</td>
                                        <td>Instantaneous Temperature</td>
                                        <td>15.56</td>
                                    </tr>
                                    <tr>
                                        <td>12</td>
                                        <td>Dew Point</td>
                                        <td>11.94</td>
                                    </tr>
                                    <tr>
                                        <td>13</td>
                                        <td>Humidity</td>
                                        <td>11.94</td>
                                    </tr>
                                    <tr>
                                        <td>14</td>
                                        <td>Pressure</td>
                                        <td>1016.63</td>
                                    </tr>
                                    <tr>
                                        <td>15</td>
                                        <td>Wind Speed</td>
                                        <td>2.87</td>
                                    </tr>
                                    <tr>
                                        <td>16</td>
                                        <td>Wind Gust</td>
                                        <td>5.28</td>
                                    </tr>
                                    <tr>
                                        <td>17</td>
                                        <td>Wind Bearing</td>
                                        <td>26</td>
                                    </tr>
                                    <tr>
                                        <td>18</td>
                                        <td>Cloud Cover</td>
                                        <td>0.29</td>
                                    </tr>
                                    <tr>
                                        <td>19</td>
                                        <td>UV Index</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>20</td>
                                        <td>Visibility</td>
                                        <td>16.09</td>
                                    </tr>
                                    <tr>
                                        <td>21</td>
                                        <td>Ozone</td>
                                        <td>272.28</td>
                                    </tr>
                                    <tr>
                                        <td>22</td>
                                        <td>Rain Intensity</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>23</td>
                                        <td>Rain Probability</td>
                                        <td>0</td>
                                    </tr>

                                    <tr>
                                        <td>24</td>
                                        <td>Zenith
                                        </td>
                                        <td>49
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>25</td>
                                        <td>Azimuth
                                        </td>
                                        <td>22
                                        </td>
                                    </tr>


                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>

                    <div class="col-xs-12 col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">BB</h3>
                            </div>
                            <div class="panel-body">

                                <table class="table">
                                    <tr>
                                        <td>uses standard</td>
                                        <td>W/m^2</td>
                                    </tr>
                                    <tr>
                                        <td>from data provider</td>
                                        <td>Solcast</td>
                                    </tr>
                                    <tr>
                                        <td>measured by sensor</td>
                                        <td>pyranometer</td>
                                    </tr>
                                    <tr>
                                        <td>has spectral range</td>
                                        <td>300nm &#8208; 30000nm</td>
                                    </tr>
                                    <tr>
                                        <td>has view angle</td>
                                        <td>180°</td>
                                    </tr>
                                    <tr>
                                        <td>has definition</td>
                                        <td> "is the total amount of shortwave radiation
                                            received<br>from above by a surface horizontal to the ground"
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </jsp:body>
</t:layout-app>