<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<ul>
    <li>
        <a href="<c:url value="/agents"/>">
            <i class="fa fa-th"></i> Agents
        </a>
    </li>            
    <li>
        <a href="<c:url value="/researchers"/>">
            <i class="fa fa-users"></i> Researchers
        </a>
    </li> 
    
    <li>
        <a href="<c:url value="/agents/developers"/>">
            <i class="fa fa-users"></i> Developers
        </a>
    </li> 

</ul>