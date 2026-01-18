<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/header.jsp" />
<c:import url="/common/navbar.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/adventure.css' />">

<!-- Header Section -->
<section class="hotels-header">
    <div class="container">
        <h1 data-translate="bookBtn">Book Your Perfect Adventure</h1>
        <p>Find the best accommodations in Okayama for every budget and preference</p>
    </div>
</section>

<!-- Search Section -->
<section class="search-section">
    <div class="container">
        <form class="search-form" id="hotel-search-form">
            <div class="form-group">
                <label class="form-label">Check-in Date</label>
                <input type="date" class="form-input" id="checkin-date" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Check-out Date</label>
                <input type="date" class="form-input" id="checkout-date" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Person</label>
                <select class="form-input" id="guests">
                    <option value="1">1 Person</option>
                    <option value="2" selected>2 Person</option>
                    <option value="3">3 Person</option>
                    <option value="4">4 Person</option>
                    <option value="5">5+ Person</option>
                </select>
            </div>
            
        </form>
    </div>
</section>

<!-- Filters Section -->
<!-- <section class="filters-section">
    <div class="container">
        <div class="filter-controls">
            <button class="filter-btn active" data-filter="all">All Hotels</button>
            <button class="filter-btn" data-filter="luxury">Luxury</button>
            <button class="filter-btn" data-filter="business">Business</button>
            <button class="filter-btn" data-filter="budget">Budget</button>
            <button class="filter-btn" data-filter="ryokan">Ryokan</button>
        </div>
    </div>
</section> -->

<!-- Hotels Grid -->
<section class="section">
    <div class="container">
        <div class="hotels-grid" id="hotels-grid">
            <!-- Hotel ANA Crowne Plaza -->
            <div class="hotel-card" data-category="luxury business" data-name="ANA Crowne Plaza">
                <img src="<c:url value='/assets/img/resources/hotel/Panoramic.png' />" alt="Panoramic Views" class="hotel-image">
                <div class="hotel-content">
                    <div class="hotel-header">
                        <h3 class="hotel-name">Panoramic Views from the Castle Keep</h3>
                        <div class="hotel-rating">
                            
                        </div>
                    </div>
                    
                  
                    <div class="hotel-price">
                        <div class="availability"></div>
                        <div class="price-info">
                            <!-- <div class="price-amount">¥12,000</div> -->
                            <div class="price-period"></div>
                        </div>
                    </div>
                    <button class="book-btn" onclick="openBookingModal('ana-hotel')" data-translate="bookNow">Book Now</button>
                </div>
            </div>
            
            <!-- Hotel Granvia Okayama -->
            <div class="hotel-card" data-category="luxury business" data-name="Hotel Granvia">
                <img src="<c:url value='/assets/img/resources/hotel/cycling.png' />" alt="Cycling" class="hotel-image">
                <div class="hotel-content">
                    <div class="hotel-header">
                        <h3 class="hotel-name">Cycling and Walking along the River</h3>
                        <div class="hotel-rating">
                            
                        </div>
                    </div>
                    
                    
                    <div class="hotel-price">
                        <div class="availability"></div>
                        <div class="price-info">
                            <!-- <div class="price-amount">¥15,000</div> -->
                            <div class="price-period"></div>
                        </div>
                    </div>
                    <button class="book-btn" onclick="openBookingModal('granvia-hotel')" data-translate="bookNow">Book Now</button>
                </div>
            </div>
            
            <!-- Okayama Koraku Hotel -->
            <div class="hotel-card" data-category="business budget" data-name="Koraku Hotel">
                <img src="<c:url value='/assets/img/resources/hotel/garden.png' />" alt="Exploring" class="hotel-image">
                <div class="hotel-content">
                    <div class="hotel-header">
                        <h3 class="hotel-name">Exploring Japan's Top Garden</h3>
                        <div class="hotel-rating">
                            
                        </div>
                    </div>
                   
                    <div class="hotel-price">
                        <div class="availability"></div>
                        <div class="price-info">
                            <!-- <div class="price-amount">¥8,500</div> -->
                            <div class="price-period"></div>
                        </div>
                    </div>
                    <button class="book-btn" onclick="openBookingModal('koraku-hotel')" data-translate="bookNow">Book Now</button>
                </div>
            </div>
            
            <!-- Tsurugata Ryokan -->
            <div class="hotel-card" data-category="ryokan luxury" data-name="Tsurugata Ryokan">
                <img src="<c:url value='/assets/img/resources/hotel/kimono.png' />" alt="Kimono" class="hotel-image">
                <div class="hotel-content">
                    <div class="hotel-header">
                        <h3 class="hotel-name">Kimono</h3>
                        <div class="hotel-rating">
                            
                        </div>
                    </div>
                
                   
                    <div class="hotel-price">
                        <div class="availability"></div>
                        <div class="price-info">
                            <!-- <div class="price-amount">¥25,000</div> -->
                            <div class="price-period"></div>
                        </div>
                    </div>
                    <button class="book-btn" onclick="openBookingModal('tsurugata-ryokan')" data-translate="bookNow">Book Now</button>
                </div>
            </div>
            
            <!-- Daiwa Roynet Hotel -->
           
            
       
           
        </div>
    </div>
</section>

<!-- Booking Modal -->
<div id="booking-modal" class="modal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeBookingModal()">&times;</button>
        <div class="booking-modal-body">
            <h2>Book your Adventure</h2>
            
            <!-- Booking Steps -->
            <div class="booking-steps">
                <div class="step active" id="step-1">1</div>
                <div class="step" id="step-2">2</div>
                <div class="step" id="step-3">3</div>
                <div class="step" id="step-4">4</div>
            </div>
            
            <!-- Step 1: Room Selection -->
            <div class="booking-form active" id="form-step-1">
                <h3>Thank you</h3>
                <div class="room-selection">
                    <div class="room-option" onclick="selectRoom(this, 'Standard', 12000)">
                        <div class="room-header">
                            <span class="room-name"></span>
                            <!-- <span class="room-price">¥12,000/night</span> -->
                        </div>
                        <p>Select here to Book</p>
                    </div>
                    
                    <!-- <div class="room-option" onclick="selectRoom(this, 'Deluxe', 15000)">
                        <div class="room-header">
                            <span class="room-name">Deluxe Room</span>
                        </div>
                        <p>Spacious room with premium amenities and beautiful garden or castle views.</p>
                    </div> -->
                    
                    <!-- <div class="room-option" onclick="selectRoom(this, 'Suite', 25000)">
                        <div class="room-header">
                            <span class="room-name">Executive Suite</span>
                            
                        </div>
                        <p>Luxurious suite with separate living area, perfect for extended stays.</p>
                    </div> -->
                </div>
                
                <div class="btn-group">
                    <button class="btn-secondary" onclick="closeBookingModal()">Cancel</button>
                    <button class="book-btn" onclick="nextStep(2)" disabled id="next-step-1">Next Step</button>
                </div>
            </div>
            
            <!-- Step 2: Guest Details -->
            <div class="booking-form" id="form-step-2">
                <h3>Person Information</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">First Name *</label>
                        <input type="text" class="form-input" required id="first-name">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Last Name *</label>
                        <input type="text" class="form-input" required id="last-name">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Email Address *</label>
                        <input type="email" class="form-input" required id="email">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Phone Number *</label>
                        <input type="tel" class="form-input" required id="phone">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Special Requests</label>
                    <textarea class="form-input" rows="3" placeholder="Any special requests or requirements..."></textarea>
                </div>
                
                <div class="btn-group">
                    <button class="btn-secondary" onclick="previousStep(1)">Previous</button>
                    <button class="book-btn" onclick="nextStep(3)">Next Step</button>
                </div>
            </div>
            
            <!-- Step 3: Booking Summary -->
            <div class="booking-form" id="form-step-3">
                <h3></h3>
                <div class="booking-summary">
                    <div class="summary-row">
                        <span></span>
                        <!-- <span id="summary-hotel">ANA Crowne Plaza Okayama</span> -->
                    </div>
                    <div class="summary-row">
                        <span></span>
                        <!-- <span id="summary-checkin">March 15, 2025</span> -->
                    </div>
                    <div class="summary-row">
                        <span></span>
                        <!-- <span id="summary-checkout">March 18, 2025</span> -->
                    </div>
                    <div class="summary-row">
                        <span></span>
                        <!-- <span id="summary-room">Deluxe Room</span> -->
                    </div>
                    <div class="summary-row">
                        <span></span>
                        <!-- <span id="summary-nights">3</span> -->
                    </div>
                    <div class="summary-row">
                        <span>person:</span>
                        <span id="summary-guests">2</span>
                    </div>
                    <div class="summary-row">
                        <!-- <span>Room Rate:</span> -->
                        
                    </div>
                    <div class="summary-row summary-total">
                        <!-- <span>Total Amount:</span> -->
                        
                    </div>
                </div>
                
                <div class="payment-section">
                    <h4>Secure Payment</h4>
                    <p>Your payment information is protected with industry-standard encryption.</p>
                    <div class="payment-icons">
                        <span>💳</span>
                        <span>🔒</span>
                        <span>🛡️</span>
                    </div>
                    <p><strong>Payment Integration Placeholder</strong></p>
                    <p>Secure payment gateway would be integrated here with support for major credit cards, PayPal, and other payment methods.</p>
                </div>
                
                <div class="btn-group">
                    <button class="btn-secondary" onclick="previousStep(2)">Previous</button>
                    <button class="book-btn" onclick="nextStep(4)">Confirm Booking</button>
                </div>
            </div>
            
            <!-- Step 4: Confirmation -->
            <div class="booking-form" id="form-step-4">
                <div style="text-align: center; padding: 2rem;">
                    <div style="font-size: 4rem; margin-bottom: 1rem;">✅</div>
                    <h3>Booking Confirmed!</h3>
                    <p>Thank you for your reservation. You will receive a confirmation email shortly.</p>
                    
                    <div style="background: var(--soft-cream); padding: 1.5rem; border-radius: var(--border-radius); margin: 2rem 0;">
                        <h4>Booking Reference: OKA-2025-001</h4>
                        <p>Confirmation email sent to: <span id="confirmation-email">guest@email.com</span></p>
                        <p>Check-in instructions and hotel contact details will be provided in your confirmation email.</p>
                    </div>
                    
                    <div class="btn-group" style="justify-content: center;">
                        <button class="book-btn" onclick="closeBookingModal()">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value='assets/js/adventure.js' />"></script>

<c:import url="/common/footer.jsp" />

