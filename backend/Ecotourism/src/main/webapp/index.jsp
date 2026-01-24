<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentLocale" value="${sessionScope.locale != null ? sessionScope.locale : pageContext.request.locale}" />
<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="resources.messages" />

<c:import url="/common/header.jsp" />
<c:import url="/common/navbar.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/main.css' />">

<!-- Hero Section -->
<section class="hero" role="banner">
    <div class="hero-background" aria-hidden="true"></div>
    <div class="hero-overlay" aria-hidden="true"></div>
    
    <div class="hero-content">
        <h1 class="hero-title"><fmt:message key="home.hero.title" /></h1>
        <h6 class="hero-subtitle"><fmt:message key="home.hero.subtitle" /></h6>
        
        <div class="hero-buttons">
            <a href="<c:url value='/places' />" class="btn btn-primary">
                <span>🗾</span>
                <span><fmt:message key="home.hero.explore" /></span>
            </a>
            <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'VISITOR'}">
                <a href="<c:url value='/bookings?action=new' />" class="btn btn-secondary">
                    <span>📅</span>
                    <span><fmt:message key="nav.bookNow" /></span>
                </a>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <a href="<c:url value='/login.jsp' />" class="btn btn-secondary">
                    <span>🔑</span>
                    <span><fmt:message key="home.hero.loginToBook" /></span>
                </a>
            </c:if>
        </div>
    </div>
</section>

<!-- About Okayama Section -->
<section id="about" class="section">
    <div class="container">
        <div class="section-header fade-in-up">
            <h2><fmt:message key="home.about.title" /></h2>
            <p><fmt:message key="home.about.description" /></p>
        </div>
        
        <div class="about-content fade-in-up">
            <div class="about-text">
                <h3>A City of History and Beauty</h3>
                <p>Okayama Castle, famously known as "Crow Castle" due to its distinctive black exterior, stands as a testament to Japan's feudal era. Built in 1597, the castle offers panoramic views of the city and houses fascinating exhibits about samurai culture.</p>
                
                <h3>Garden Paradise</h3>
                <p>Adjacent to the castle lies Korakuen Garden, one of Japan's three most beautiful landscape gardens. Created in 1700, this expansive garden features pristine lawns, tranquil ponds, and traditional tea houses.</p>
                
                <h3>Modern Comforts</h3>
                <p>Today, Okayama offers world-class accommodations, exceptional dining experiences, and easy access to major transportation hubs, making it the perfect base for exploring Western Japan.</p>
            </div>
            
            <div class="about-gallery">
                <img src="https://kimi-web-img.moonshot.cn/img/okayama-castle.jp/f8f26d02ac7a4b0558ea3f395c811990e9cb30dd.jpg" alt="Okayama Castle Black Exterior" class="about-image">
                <img src="https://kimi-web-img.moonshot.cn/img/www.2aussietravellers.com/0bba775c81e3107cab70067d3c1d2658520a098a.jpg" alt="Korakuen Garden Landscape" class="about-image">
                <img src="https://kimi-web-img.moonshot.cn/img/thumbs.dreamstime.com/c1da3ba251f746fafb704438bd92a5c67fc02247.jpg" alt="Okayama City Skyline" class="about-image">
                <img src="https://kimi-web-img.moonshot.cn/img/thumbs.dreamstime.com/1dace1457e86fbd60ebd3a435ea5365ba2af3ef7.jpg" alt="Kurashiki Historical Quarter" class="about-image">
            </div>
        </div>
    </div>
</section>

<!-- Featured Attractions Section -->
<section class="section attractions-preview">
    <div class="container">
        <div class="section-header fade-in-up">
            <h2><fmt:message key="home.attractions.title" /></h2>
            <p><fmt:message key="home.attractions.subtitle" /></p>
        </div>
        
        <div class="grid grid-3 fade-in-up">
            <c:choose>
                <c:when test="${not empty featuredPlaces}">
                    <c:forEach var="place" items="${featuredPlaces}">
                        <div class="card">
                            <c:choose>
                                <c:when test="${not empty place.imageUrl}">
                                    <img src="<c:url value='/${place.imageUrl}' />" alt="${place.placeName}" class="card-image">
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:url value='/assets/img/placeholder.jpg' />" alt="${place.placeName}" class="card-image">
                                </c:otherwise>
                            </c:choose>
                            <div class="card-content">
                                <h3 class="card-title">${place.placeName}</h3>
                                <p class="card-description">${place.description}</p>
                                <div class="card-meta">
                                    <span>💴 ¥<fmt:formatNumber value="${place.pricePerPerson}" pattern="#,##0.00" /></span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="card">
                        <img src="https://kimi-web-img.moonshot.cn/img/okayama-castle.jp/f8f26d02ac7a4b0558ea3f395c811990e9cb30dd.jpg" alt="Okayama Castle" class="card-image">
                        <div class="card-content">
                            <h3 class="card-title">Okayama Castle</h3>
                            <p class="card-description">The iconic "Crow Castle" with its distinctive black exterior and rich history dating back to 1597.</p>
                            <div class="card-meta">
                                <span>🏯 Historical</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <img src="https://kimi-web-img.moonshot.cn/img/www.2aussietravellers.com/0bba775c81e3107cab70067d3c1d2658520a098a.jpg" alt="Korakuen Garden" class="card-image">
                        <div class="card-content">
                            <h3 class="card-title">Korakuen Garden</h3>
                            <p class="card-description">One of Japan's three most beautiful landscape gardens, featuring pristine lawns and tranquil ponds.</p>
                            <div class="card-meta">
                                <span>🌸 Nature</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <img src="https://kimi-web-img.moonshot.cn/img/thumbs.dreamstime.com/1dace1457e86fbd60ebd3a435ea5365ba2af3ef7.jpg" alt="Kurashiki Bikan" class="card-image">
                        <div class="card-content">
                            <h3 class="card-title">Kurashiki Bikan</h3>
                            <p class="card-description">A preserved historical quarter with traditional architecture and charming canals.</p>
                            <div class="card-meta">
                                <span>🏘️ Cultural</span>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div style="text-align: center; margin-top: 3rem;">
            <a href="<c:url value='/places' />" class="btn btn-primary">
                <fmt:message key="home.attractions.viewAll">
                    <fmt:param value="${not empty totalPlaces ? totalPlaces : ''}" />
                </fmt:message>
            </a>
        </div>
    </div>
</section>

<!-- Local Food Section -->
<section id="food" class="section">
    <div class="container">
        <div class="section-header fade-in-up">
            <h2><fmt:message key="home.food.title" /></h2>
            <p><fmt:message key="home.food.subtitle" /></p>
        </div>
        
        <div class="food-grid fade-in-up">
            <div class="food-card">
                <img src="<c:url value='/assets/img/resources/barazushi-dish.png' />" alt="Okayama Barazushi" class="food-image">
                <h3><fmt:message key="food.barazushi.title" /></h3>
                <p><fmt:message key="food.barazushi.description" /></p>
            </div>
            
            <div class="food-card">
                <img src="<c:url value='/assets/img/momo.png' />" alt="Okayama White Peaches" class="food-image">
                <h3><fmt:message key="food.whitePeaches.title" /></h3>
                <p><fmt:message key="food.whitePeaches.description" /></p>
            </div>
            
            <div class="food-card">
                <img src="<c:url value='/assets/img/kibi.png' />" alt="Kibi Dango" class="food-image">
                <h3><fmt:message key="food.kibiDango.title" /></h3>
                <p><fmt:message key="food.kibiDango.description" /></p>
            </div>
            
            <div class="food-card">
                <img src="<c:url value='/assets/img/Yakisoba.png' />" alt="Hiruzen Yakisoba" class="food-image">
                <h3><fmt:message key="food.yakisoba.title" /></h3>
                <p><fmt:message key="food.yakisoba.description" /></p>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="section testimonials">
    <div class="container">
        <div class="section-header fade-in-up">
            <h2><fmt:message key="home.testimonials.title" /></h2>
            <p><fmt:message key="home.testimonials.subtitle" /></p>
        </div>
        
        <div class="grid grid-3 fade-in-up">
            <div class="testimonial-card">
                <p class="testimonial-quote">"Okayama Castle was absolutely breathtaking! The black exterior is so unique, and the views from the top were incredible. Korakuen Garden was like stepping into a painting."</p>
                <p class="testimonial-author">Sarah Chen</p>
                <div class="testimonial-rating">★★★★★</div>
            </div>
            
            <div class="testimonial-card">
                <p class="testimonial-quote">"The local food exceeded all expectations! The Barazushi was fresh and flavorful, and the white peaches were the sweetest I've ever tasted. A culinary paradise!"</p>
                <p class="testimonial-author">Michael Rodriguez</p>
                <div class="testimonial-rating">★★★★★</div>
            </div>
            
            <div class="testimonial-card">
                <p class="testimonial-quote">"Perfect blend of history and modern comfort. The hotels were excellent, transportation was convenient, and the local people were incredibly welcoming. Can't wait to return!"</p>
                <p class="testimonial-author">Emma Thompson</p>
                <div class="testimonial-rating">★★★★★</div>
            </div>
        </div>
    </div>
</section>

<script src="<c:url value='assets/js/main.js' />"></script>

<c:import url="/common/footer.jsp" />

