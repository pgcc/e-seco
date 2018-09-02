<%@page contentType="text/html;charset=ISO-8859-1" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:layout-app>
    <jsp:attribute name="title">
        E-SECO Data Source
    </jsp:attribute>


    <jsp:attribute name="stylesheets">

    </jsp:attribute>

    <jsp:attribute name="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="<c:url value="/experiments"/>"><i class="fa fa-street-view"></i> Experiments</a></li>
            <li><a href="<c:url value="/experiments/dataSources/"/>">Data Sources</a></li>
            <li><a href="<c:url value="/experiments/dataSources/${dataSource.id}"/>">View</a></li>
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

            <h2>Data Source Detail</h2>
            <br/>

            <div class="table-responsive col-xs-12 col-md-6">
                <style type="text/css">
                    .table-hover tbody tr:hover td {
                        background-color: Lavender;
                    }
                </style>
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


            <div class="panel panel-default col-xs-12 col-md-6">
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
    </jsp:body>
</t:layout-app>