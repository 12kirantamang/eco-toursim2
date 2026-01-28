<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!-- Navigation -->
<nav class="navbar" role="navigation" aria-label="Main navigation">
    <div class="nav-container">
        <a href="#" class="logo" data-translate="siteTitle">Discover Okayama</a>
        <!-- ham menu -->
        <input type="checkbox" id="menu-toggle" class="menu-toggle">
    <label for="menu-toggle" class="hamburger">
        <span></span>
        <span></span>
        <span></span>
    </label>
        
        <ul class="nav-links">
		    <li><a href="<c:url value='/auth' />" data-translate="homeTitle">Home</a></li>
		    
		    <li><a href="<c:url value='/index.jsp#about' />" data-translate="aboutTitle">About</a></li>
		    
		    <li><a href="<c:url value='/attractions.jsp' />" data-translate="attractionsTitle">Attractions</a></li>
		    
		    <li><a href="<c:url value='/adventure' />" data-translate="adventureTitle">Adventure</a></li>
		    
		    <li><a href="<c:url value='/index.jsp#food' />" data-translate="foodTitle">Food</a></li>
		    <li><a href="<c:url value='/index.jsp#events' />" data-translate="eventsTitle">Events</a></li>
		    
		    <li><a href="<c:url value='/contact.jsp' />" data-translate="contactTitle">Contact</a></li>

		    <c:choose>
		        <c:when test="${empty sessionScope.user}">
		            <li><a href="<c:url value='/login.jsp' />" data-translate="login">Login</a></li>
		            <li><a href="<c:url value='/register.jsp' />" data-translate="register">Register</a></li>
		        </c:when>
		
		        <c:otherwise>
		            <li><a href="<c:url value='/auth?action=logout' />">Logout</a></li>
		        </c:otherwise>
		    </c:choose>
		</ul>
        
        <!-- <div class="language-selector">
            <button class="language-btn" aria-label="Select language">
                <img src="resources/icons/flag-en.png" alt="" class="language-flag current-flag" width="20" height="15">
                <span class="current-lang">English</span>
                <span aria-hidden="true">▼</span>
            </button>
            <div class="language-dropdown" role="menu">
                <div class="language-option" data-lang="en" role="menuitem">
                    <img src="resources/icons/flag-en.png" alt="" class="language-flag" width="20" height="15">
                    <span>English</span>
                </div>
                <div class="language-option" data-lang="ja" role="menuitem">
                    <img src="resources/icons/flag-ja.png" alt="" class="language-flag" width="20" height="15">
                    <span>日本語</span>
                </div>
                <div class="language-option" data-lang="ne" role="menuitem">
                    <img src="resources/icons/flag-ne.png" alt="" class="language-flag" width="20" height="15">
                    <span>नेपाली</span>
                </div>
                <div class="language-option" data-lang="my" role="menuitem">
                    <img src="resources/icons/flag-my.png" alt="" class="language-flag" width="20" height="15">
                    <span>မြန်မာ</span>
                </div>
                <div class="language-option" data-lang="vi" role="menuitem">
                    <img src="resources/icons/flag-vi.png" alt="" class="language-flag" width="20" height="15">
                    <span>Tiếng Việt</span>
                </div>
            </div>
        </div> -->
    </div>
</nav>