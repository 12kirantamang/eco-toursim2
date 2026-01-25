<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentLocale" value="${sessionScope.locale != null ? sessionScope.locale : pageContext.request.locale}" />
<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="resources.messages" />

<c:import url="/common/header.jsp" />
<c:import url="/common/navbar.jsp" />

<style>
    .bookings-container {
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
    
    .btn {
        display: inline-block;
        padding: 12px 24px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: 500;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
    }
    
    .btn-primary {
        background: #3498db;
        color: white;
    }
    
    .btn-primary:hover {
        background: #2980b9;
    }
    
    .btn-warning {
        background: #f39c12;
        color: white;
    }
    
    .btn-warning:hover {
        background: #e67e22;
    }
    
    .btn-danger {
        background: #e74c3c;
        color: white;
    }
    
    .btn-danger:hover {
        background: #c0392b;
    }
    
    .btn-sm {
        padding: 8px 16px;
        font-size: 0.9rem;
    }
    
    .booking-actions {
        display: flex;
        gap: 10px;
        margin-top: 20px;
        padding-top: 15px;
        border-top: 1px solid #ecf0f1;
    }
    
    .bookings-grid {
        display: grid;
        gap: 20px;
        margin-top: 30px;
    }
    
    .booking-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 25px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .booking-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.15);
    }
    
    .booking-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 2px solid #ecf0f1;
    }
    
    .booking-id {
        font-size: 1.2rem;
        font-weight: 600;
        color: #2c3e50;
    }
    
    .booking-status {
        padding: 5px 15px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 500;
    }
    
    .status-confirmed {
        background: #d4edda;
        color: #155724;
    }
    
    .status-pending {
        background: #fff3cd;
        color: #856404;
    }
    
    .status-cancelled {
        background: #f8d7da;
        color: #721c24;
    }
    
    .booking-details {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        margin-bottom: 15px;
    }
    
    .detail-item {
        display: flex;
        flex-direction: column;
    }
    
    .detail-label {
        font-size: 0.85rem;
        color: #7f8c8d;
        margin-bottom: 5px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .detail-value {
        font-size: 1rem;
        color: #2c3e50;
        font-weight: 500;
    }
    
    .detail-value.amount {
        font-size: 1.3rem;
        color: #27ae60;
        font-weight: 600;
    }
    
    .booking-places {
        margin-top: 20px;
        padding-top: 15px;
        border-top: 1px solid #ecf0f1;
    }
    
    .places-title {
        font-size: 0.9rem;
        color: #7f8c8d;
        margin-bottom: 10px;
        font-weight: 600;
    }
    
    .places-list {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }
    
    .place-tag {
        background: #3498db;
        color: white;
        padding: 5px 12px;
        border-radius: 15px;
        font-size: 0.85rem;
    }
    
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    
    .empty-state i {
        font-size: 4rem;
        color: #bdc3c7;
        margin-bottom: 20px;
    }
    
    .empty-state h3 {
        font-size: 1.5rem;
        color: #7f8c8d;
        margin-bottom: 15px;
    }
    
    .error-message {
        background: #f8d7da;
        color: #721c24;
        padding: 15px 20px;
        border-radius: 5px;
        margin-bottom: 20px;
        border-left: 4px solid #f5c6cb;
    }
</style>

<div class="bookings-container">
    <div class="page-header">
        <h1><fmt:message key="bookings.title" /></h1>
        <a href="<c:url value='/bookings?action=new' />" class="btn btn-primary">
            <i class="fas fa-plus"></i> <fmt:message key="bookings.new" />
        </a>
    </div>
    
    <c:if test="${not empty error}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>
    
    <c:choose>
        <c:when test="${empty bookings}">
            <div class="empty-state">
                <i class="fas fa-calendar-times"></i>
                <h3><fmt:message key="bookings.empty.title" /></h3>
                <p><fmt:message key="bookings.empty.subtitle" /></p>
                <a href="<c:url value='/bookings?action=new' />" class="btn btn-primary" style="margin-top: 20px;">
                    <fmt:message key="bookings.new" />
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="bookings-grid">
                <c:forEach var="booking" items="${bookings}">
                    <div class="booking-card">
                        <div class="booking-header">
                            <span class="booking-id">
                                <i class="fas fa-ticket-alt"></i> <fmt:message key="bookings.id" /> #${booking.bookingId}
                            </span>
                            <span class="booking-status status-confirmed">
                                <i class="fas fa-check-circle"></i> <fmt:message key="bookings.status" />
                            </span>
                        </div>
                        
                        <div class="booking-details">
                            <div class="detail-item">
                                <span class="detail-label">
                                    <i class="fas fa-calendar"></i> <fmt:message key="bookings.date" />
                                </span>
                                <span class="detail-value">
                                    ${booking.bookingDate}
                                </span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="detail-label">
                                    <i class="fas fa-clock"></i> <fmt:message key="bookings.timeSlot" />
                                </span>
                                <span class="detail-value">${booking.timeSlot}</span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="detail-label">
                                    <i class="fas fa-users"></i> <fmt:message key="bookings.visitors" />
                                </span>
                                <span class="detail-value">${booking.visitorCount}</span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="detail-label">
                                    <i class="fas fa-yen-sign"></i> <fmt:message key="bookings.totalAmount" />
                                </span>
                                <span class="detail-value amount">¥<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></span>
                            </div>
                        </div>
                        
                        <div class="booking-places">
                            <div class="places-title">
                                <i class="fas fa-map-marker-alt"></i> <fmt:message key="bookings.placesIncluded" />
                            </div>
                            <div class="places-list">
                                <c:forEach var="place" items="${booking.places}">
                                    <span class="place-tag">${place.placeName}</span>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <div class="booking-actions">
                            <a href="<c:url value='/bookings?action=edit&id=${booking.bookingId}' />" 
                               class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> <fmt:message key="bookings.edit" />
                            </a>
                            <fmt:message key="bookings.deleteConfirm" var="deleteConfirmMsg" />
                            <a href="<c:url value='/bookings?action=delete&id=${booking.bookingId}' />" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('${deleteConfirmMsg}');">
                                <i class="fas fa-trash"></i> <fmt:message key="bookings.delete" />
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<c:import url="/common/footer.jsp" />

<script src="<c:url value='/assets/js/main.js' />"></script>
</body>
</html>
