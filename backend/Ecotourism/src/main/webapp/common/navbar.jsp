<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentLocale" value="${sessionScope.locale != null ? sessionScope.locale : pageContext.request.locale}" />
<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="resources.messages" />
    
<!-- Navigation -->
<nav class="navbar" role="navigation" aria-label="Main navigation">
    <div class="nav-container">
        <a href="<c:url value='/home' />" class="logo"><fmt:message key="app.title" /></a>
        <!-- ham menu -->
        <input type="checkbox" id="menu-toggle" class="menu-toggle">
    <label for="menu-toggle" class="hamburger">
        <span></span>
        <span></span>
        <span></span>
    </label>
        
        <ul class="nav-links">
		    <li><a href="<c:url value='/home' />"><fmt:message key="nav.home" /></a></li>
		    
		    <li><a href="<c:url value='/home#about' />"><fmt:message key="nav.about" /></a></li>
		    
		    <li><a href="<c:url value='/places' />"><fmt:message key="nav.attractions" /></a></li>
		    
		    <li><a href="<c:url value='/contact.jsp' />"><fmt:message key="nav.contact" /></a></li>
		    
		    <!-- Book Now Link - Conditional visibility -->
		    <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'VISITOR'}">
		        <li><a href="<c:url value='/bookings?action=new' />" class="book-now-link"><i class="fas fa-ticket-alt"></i> <fmt:message key="nav.bookNow" /></a></li>
		    </c:if>

		    <c:choose>
		        <c:when test="${empty sessionScope.user}">
		            <li><a href="<c:url value='/login.jsp' />"><fmt:message key="nav.login" /></a></li>
		            <li><a href="<c:url value='/register.jsp' />"><fmt:message key="nav.register" /></a></li>
		        </c:when>
		
		        <c:otherwise>
		            <li><a href="<c:url value='/bookings' />"><i class="fas fa-calendar-check"></i> <fmt:message key="nav.myBookings" /></a></li>
		            <li><a href="<c:url value='/auth?action=logout' />"><fmt:message key="nav.logout" /></a></li>
		        </c:otherwise>
		    </c:choose>
		    
		    <!-- Language Selector -->
		    <li class="language-selector">
		        <c:choose>
		            <c:when test="${currentLocale.language == 'ja'}">
		                <a href="<c:url value='/changeLanguage?lang=en' />" class="language-btn" title="English">
		                    <i class="fas fa-globe"></i> EN
		                </a>
		            </c:when>
		            <c:otherwise>
		                <a href="<c:url value='/changeLanguage?lang=ja' />" class="language-btn" title="日本語">
		                    <i class="fas fa-globe"></i> 日本語
		                </a>
		            </c:otherwise>
		        </c:choose>
		    </li>
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
      

<style>
    .language-selector .language-btn {
        display: flex;
        align-items: center;
        gap: 5px;
        padding: 8px 12px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 5px;
        transition: background 0.3s;
        text-decoration: none;
        color: inherit;
    }
    
    .language-selector .language-btn:hover {
        background: rgba(255, 255, 255, 0.2);
    }
</style>          </div>
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