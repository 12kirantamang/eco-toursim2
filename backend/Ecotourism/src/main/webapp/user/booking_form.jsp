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
    .booking-form-container {
        max-width: 800px;
        margin: 40px auto;
        padding: 20px;
    }
    
    .form-header {
        text-align: center;
        margin-bottom: 40px;
    }
    
    .form-header h1 {
        font-size: 2.5rem;
        color: #2c3e50;
        margin-bottom: 10px;
    }
    
    .form-header p {
        color: #7f8c8d;
        font-size: 1.1rem;
    }
    
    .booking-form {
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        padding: 40px;
    }
    
    .form-group {
        margin-bottom: 25px;
    }
    
    .form-label {
        display: block;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 8px;
        font-size: 1rem;
    }
    
    .form-label i {
        margin-right: 8px;
        color: #3498db;
    }
    
    .required {
        color: #e74c3c;
        margin-left: 3px;
    }
    
    .form-control {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #ecf0f1;
        border-radius: 5px;
        font-size: 1rem;
        transition: border-color 0.3s ease;
        box-sizing: border-box;
    }
    
    .form-control:focus {
        outline: none;
        border-color: #3498db;
    }
    
    .form-help {
        font-size: 0.85rem;
        color: #7f8c8d;
        margin-top: 5px;
        display: block;
    }
    
    .places-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 15px;
        margin-top: 10px;
    }
    
    .place-checkbox {
        position: relative;
    }
    
    .place-checkbox input[type="checkbox"] {
        position: absolute;
        opacity: 0;
    }
    
    .place-label {
        display: block;
        padding: 15px;
        border: 2px solid #ecf0f1;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        background: white;
    }
    
    .place-checkbox input[type="checkbox"]:checked + .place-label {
        border-color: #3498db;
        background: #ebf5fb;
    }
    
    .place-name {
        font-weight: 600;
        color: #2c3e50;
        display: block;
        margin-bottom: 5px;
    }
    
    .place-price {
        color: #27ae60;
        font-weight: 600;
        font-size: 1.1rem;
    }
    
    .calculation-section {
        background: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-top: 20px;
    }
    
    .calculation-title {
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 15px;
        font-size: 1.1rem;
    }
    
    .calculation-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        color: #7f8c8d;
    }
    
    .calculation-total {
        display: flex;
        justify-content: space-between;
        font-size: 1.3rem;
        font-weight: 700;
        color: #2c3e50;
        padding-top: 15px;
        border-top: 2px solid #dee2e6;
        margin-top: 15px;
    }
    
    .total-amount {
        color: #27ae60;
    }
    
    .btn {
        display: inline-block;
        padding: 14px 30px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: 600;
        font-size: 1.1rem;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
    }
    
    .btn-primary {
        background: #3498db;
        color: white;
        width: 100%;
    }
    
    .btn-primary:hover {
        background: #2980b9;
        transform: translateY(-2px);
    }
    
    .btn-secondary {
        background: #95a5a6;
        color: white;
        margin-right: 10px;
    }
    
    .btn-secondary:hover {
        background: #7f8c8d;
    }
    
    .form-actions {
        display: flex;
        gap: 15px;
        margin-top: 30px;
    }
    
    .error-message {
        background: #f8d7da;
        color: #721c24;
        padding: 15px 20px;
        border-radius: 5px;
        margin-bottom: 20px;
        border-left: 4px solid #f5c6cb;
    }
    
    .success-message {
        background: #d4edda;
        color: #155724;
        padding: 15px 20px;
        border-radius: 5px;
        margin-bottom: 20px;
        border-left: 4px solid #c3e6cb;
    }
</style>

<div class="booking-form-container">
    <div class="form-header">
        <h1><fmt:message key="${not empty booking ? 'booking.titleEdit' : 'booking.title'}" /></h1>
        <p><fmt:message key="${not empty booking ? 'booking.subtitleEdit' : 'booking.subtitle'}" /></p>
    </div>
    
    <c:if test="${not empty error}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>
    
    <c:if test="${not empty success}">
        <div class="success-message">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
    </c:if>
    
    <form action="<c:url value='/bookings' />" method="post" class="booking-form" id="bookingForm">
        
        <!-- Hidden field for editing -->
        <c:if test="${not empty booking}">
            <input type="hidden" name="bookingId" value="${booking.bookingId}">
        </c:if>
        
        <!-- Booking Date -->
        <div class="form-group">
            <label for="bookingDate" class="form-label">
                <i class="fas fa-calendar"></i>
                <fmt:message key="booking.date" /> <span class="required">*</span>
            </label>
            <input type="date" 
                   id="bookingDate" 
                   name="bookingDate" 
                   class="form-control" 
                   required
                   min="${minDate}"
                   value="${not empty booking ? booking.bookingDate : param.bookingDate}">
            <small class="form-help"><fmt:message key="booking.date.help" /></small>
        </div>
        
        <!-- Time Slot -->
        <div class="form-group">
            <label for="timeSlot" class="form-label">
                <i class="fas fa-clock"></i>
                <fmt:message key="booking.timeSlot" /> <span class="required">*</span>
            </label>
            <select id="timeSlot" name="timeSlot" class="form-control" required>
                <option value=""><fmt:message key="booking.timeSlot.select" /></option>
                <option value="09:00-11:00" ${(not empty booking && booking.timeSlot == '09:00-11:00') || param.timeSlot == '09:00-11:00' ? 'selected' : ''}><fmt:message key="booking.timeSlot.morning" /></option>
                <option value="11:00-13:00" ${(not empty booking && booking.timeSlot == '11:00-13:00') || param.timeSlot == '11:00-13:00' ? 'selected' : ''}><fmt:message key="booking.timeSlot.lateMorning" /></option>
                <option value="13:00-15:00" ${(not empty booking && booking.timeSlot == '13:00-15:00') || param.timeSlot == '13:00-15:00' ? 'selected' : ''}><fmt:message key="booking.timeSlot.afternoon" /></option>
                <option value="15:00-17:00" ${(not empty booking && booking.timeSlot == '15:00-17:00') || param.timeSlot == '15:00-17:00' ? 'selected' : ''}><fmt:message key="booking.timeSlot.lateAfternoon" /></option>
            </select>
            <small class="form-help"><fmt:message key="booking.timeSlot.help" /></small>
        </div>
        
        <!-- Visitor Count -->
        <div class="form-group">
            <label for="visitorCount" class="form-label">
                <i class="fas fa-users"></i>
                <fmt:message key="booking.visitors" /> <span class="required">*</span>
            </label>
            <input type="number" 
                   id="visitorCount" 
                   name="visitorCount" 
                   class="form-control" 
                   min="1" 
                   max="50"
                   required
                   value="${not empty booking ? booking.visitorCount : (param.visitorCount != null ? param.visitorCount : 1)}">
            <small class="form-help"><fmt:message key="booking.visitors.help" /></small>
        </div>
        
        <!-- Places Selection -->
        <div class="form-group">
            <label class="form-label">
                <i class="fas fa-map-marker-alt"></i>
                <fmt:message key="booking.places" /> <span class="required">*</span>
            </label>
            <small class="form-help"><fmt:message key="booking.places.help" /></small>
            
            <div class="places-grid">
                <c:forEach var="place" items="${places}">
                    <div class="place-checkbox">
                        <input type="checkbox" 
                               id="place_${place.placeId}" 
                               name="placeIds" 
                               value="${place.placeId}"
                               data-price="${place.pricePerPerson}"
                               class="place-check"
                               ${not empty selectedPlaceIds && selectedPlaceIds.contains(place.placeId) ? 'checked' : ''}>
                        <label for="place_${place.placeId}" class="place-label">
                            <span class="place-name">${place.placeName}</span>
                            <span class="place-price">¥<fmt:formatNumber value="${place.pricePerPerson}" pattern="#,##0.00" /></span>
                        </label>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <!-- Calculation Summary -->
        <div class="calculation-section">
            <div class="calculation-title">
                <i class="fas fa-calculator"></i> <fmt:message key="booking.summary" />
            </div>
            <div class="calculation-row">
                <span><fmt:message key="booking.summary.places" /></span>
                <span id="selectedPlacesCount">0</span>
            </div>
            <div class="calculation-row">
                <span><fmt:message key="booking.summary.visitors" /></span>
                <span id="displayVisitorCount">1</span>
            </div>
            <div class="calculation-row">
                <span><fmt:message key="booking.summary.pricePerPerson" /></span>
                <span id="pricePerPerson">¥0.00</span>
            </div>
            <div class="calculation-total">
                <span><fmt:message key="booking.summary.total" /></span>
                <span class="total-amount" id="displayTotalAmount">¥0.00</span>
            </div>
        </div>
        
        <!-- Hidden field for total amount -->
        <input type="hidden" id="totalAmount" name="totalAmount" value="0">
        
        <!-- Form Actions -->
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-check"></i> <fmt:message key="${not empty booking ? 'booking.update' : 'booking.confirm'}" />
            </button>
        </div>
    </form>
</div>

<c:import url="/common/footer.jsp" />

<script>
    // Set minimum date to today
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('bookingDate').setAttribute('min', today);
    
    // Calculate total amount
    function calculateTotal() {
        const visitorCount = parseInt(document.getElementById('visitorCount').value) || 1;
        const checkboxes = document.querySelectorAll('.place-check:checked');
        let totalPrice = 0;
        
        checkboxes.forEach(checkbox => {
            const price = parseFloat(checkbox.getAttribute('data-price')) || 0;
            totalPrice += price;
        });
        
        const totalAmount = totalPrice * visitorCount;
        
        // Update display
        document.getElementById('selectedPlacesCount').textContent = checkboxes.length;
        document.getElementById('displayVisitorCount').textContent = visitorCount;
        document.getElementById('pricePerPerson').textContent = '¥' + totalPrice.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('displayTotalAmount').textContent = '¥' + totalAmount.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('totalAmount').value = totalAmount.toFixed(2);
    }
    
    // Event listeners
    document.getElementById('visitorCount').addEventListener('input', calculateTotal);
    document.querySelectorAll('.place-check').forEach(checkbox => {
        checkbox.addEventListener('change', calculateTotal);
    });
    
    // Form validation
    document.getElementById('bookingForm').addEventListener('submit', function(e) {
        const checkboxes = document.querySelectorAll('.place-check:checked');
        if (checkboxes.length === 0) {
            e.preventDefault();
            alert('Please select at least one place to visit');
            return false;
        }
        
        const totalAmount = parseFloat(document.getElementById('totalAmount').value);
        if (totalAmount <= 0) {
            e.preventDefault();
            alert('Invalid booking amount');
            return false;
        }
    });
    
    // Initial calculation
    calculateTotal();
</script>

<script src="<c:url value='/assets/js/main.js' />"></script>
</body>
</html>
