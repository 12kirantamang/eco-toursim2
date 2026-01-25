<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentLocale" value="${sessionScope.locale != null ? sessionScope.locale : pageContext.request.locale}" />
<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="resources.messages" />

<footer class="footer">
    <div class="footer-container">

        <!-- Brand -->
        <div class="footer-col">
            <h4><fmt:message key="footer.title" /></h4>
            <p><fmt:message key="footer.description" /></p>
        </div>

        <!-- Quick Links -->
        <div class="footer-col">
            <h4><fmt:message key="footer.quickLinks" /></h4>
            <ul>
                <li><a href="home#about"><i class="fas fa-info-circle"></i> <fmt:message key="footer.about" /></a></li>
                <li><a href="places"><i class="fas fa-map-marked-alt"></i> <fmt:message key="footer.attractions" /></a></li>
                <li><a href="contact"><i class="fas fa-envelope"></i> <fmt:message key="footer.contact" /></a></li>
            </ul>
        </div>

    </div>

    <div class="footer-bottom">
        <p>&copy; <span id="year"></span> <fmt:message key="footer.copyright" /></p>
    </div>
</footer>


    <!-- Scripts -->
	<script src="<c:url value='assets/js/main.js' />"></script>
    <script>
    	document.getElementById("year").textContent = new Date().getFullYear();
	</script>
    
</body>
</html>

