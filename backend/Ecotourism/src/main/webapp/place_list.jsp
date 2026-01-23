<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentLocale" value="${sessionScope.locale != null ? sessionScope.locale : pageContext.request.locale}" />
<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="resources.messages" />

<c:import url="/common/header.jsp" />
<c:import url="/common/navbar.jsp" />

<style>
    .places-container {
        max-width: 1200px;
        margin: 40px auto;
        padding: 20px;
    }
    
    .page-header {
        text-align: center;
        margin-bottom: 40px;
    }
    
    .page-header h1 {
        font-size: 2.5rem;
        color: #2c3e50;
        margin-bottom: 10px;
    }
    
    .page-header p {
        color: #7f8c8d;
        font-size: 1.1rem;
    }
    
    .places-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 30px;
        margin-top: 30px;
    }
    
    .place-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .place-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.15);
    }
    
    .place-image {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }
    
    .place-content {
        padding: 20px;
    }
    
    .place-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 10px;
    }
    
    .place-code {
        color: #7f8c8d;
        font-size: 0.9rem;
        margin-bottom: 10px;
    }
    
    .place-description {
        color: #555;
        line-height: 1.6;
        margin-bottom: 15px;
    }
    
    .place-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 15px;
        border-top: 1px solid #ecf0f1;
    }
    
    .place-price {
        font-size: 1.3rem;
        font-weight: 600;
        color: #27ae60;
    }
    
    .btn {
        display: inline-block;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: 500;
        transition: all 0.3s ease;
    }
    
    .btn-primary {
        background: #3498db;
        color: white;
    }
    
    .btn-primary:hover {
        background: #2980b9;
    }
    
    .empty-state {
        text-align: center;
        padding: 60px 20px;
    }
    
    .empty-state i {
        font-size: 4rem;
        color: #bdc3c7;
        margin-bottom: 20px;
    }
    
    .empty-state h2 {
        color: #7f8c8d;
        margin-bottom: 10px;
    }
</style>

<div class="places-container">
    <div class="page-header">
        <h1><fmt:message key="places.title" /></h1>
        <p><fmt:message key="places.subtitle" /></p>
    </div>
    
    <c:choose>
        <c:when test="${empty places}">
            <div class="empty-state">
                <i class="fas fa-map-marked-alt"></i>
                <h2><fmt:message key="places.empty.title" /></h2>
                <p><fmt:message key="places.empty.subtitle" /></p>
            </div>
        </c:when>
        
        <c:otherwise>
            <div class="places-grid">
                <c:forEach var="place" items="${places}">
                    <div class="place-card">
                        <c:choose>
                            <c:when test="${not empty place.imageUrl}">
                                <img src="<c:url value='/${place.imageUrl}' />" alt="${place.placeName}" class="place-image">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/assets/img/placeholder.jpg' />" alt="${place.placeName}" class="place-image">
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="place-content">
                            <h3 class="place-title">${place.placeName}</h3>
                            <p class="place-code"><i class="fas fa-tag"></i> ${place.placeCode}</p>
                            <p class="place-description">${place.description}</p>
                            
                            <div class="place-footer">
                                <div class="place-price">
                                    <i class="fas fa-yen-sign"></i>
                                    <fmt:formatNumber value="${place.pricePerPerson}" pattern="#,##0.00" />
                                    <span style="font-size: 0.9rem; color: #7f8c8d;"><fmt:message key="home.attractions.perPerson" /></span>
                                </div>
                                
                                <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'VISITOR'}">
                                    <a href="<c:url value='/bookings?action=new' />" class="btn btn-primary">
                                        <i class="fas fa-calendar-check"></i> <fmt:message key="places.bookNow" />
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<c:import url="/common/footer.jsp" />
