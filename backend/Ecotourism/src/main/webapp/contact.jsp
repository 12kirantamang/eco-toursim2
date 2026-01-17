<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/header.jsp" />
<c:import url="/common/navbar.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/contact.css' />">

<!-- Header Section -->
<section class="contact-header">
    <div class="container">
        <h1 data-translate="contactTitle">Contact Us</h1>
        <p>We're here to help make your Okayama experience unforgettable</p>
    </div>
</section>

<!-- Contact Content -->
<section class="section">
    <div class="container">
        <div class="contact-content">
            <!-- Contact Information -->
            <div class="contact-info">
                <h3>Get in Touch</h3>
                
                <div class="contact-item">
                    <div class="contact-icon">📍</div>
                    <div class="contact-details">
                        <h4>Visit Our Office</h4>
                        <p>Okayama Tourism Center<br>
                        1-1 Ekimotomachi, Kita Ward<br>
                        Okayama, 700-0024, Japan</p>
                    </div>
                </div>
                
                <div class="contact-item">
                    <div class="contact-icon">📞</div>
                    <div class="contact-details">
                        <h4>Phone Support</h4>
                        <p>Main: +81-86-222-2912<br>
                        Toll-free (Japan): 0120-789-123<br>
                        Emergency: +81-90-1234-5678</p>
                    </div>
                </div>
                
                <div class="contact-item">
                    <div class="contact-icon">✉️</div>
                    <div class="contact-details">
                        <h4>Email Support</h4>
                        <p>General: info@okayama-tourism.jp<br>
                        Bookings: bookings@okayama-tourism.jp<br>
                        Emergency: emergency@okayama-tourism.jp</p>
                    </div>
                </div>
                
                <div class="contact-item">
                    <div class="contact-icon">🌐</div>
                    <div class="contact-details">
                        <h4>Online Support</h4>
                        <p>Live Chat: Available 24/7<br>
                        WhatsApp: +81-80-1234-5678<br>
                        WeChat: OkayamaTourism</p>
                    </div>
                </div>
                
                <div class="hours-section">
                    <h4>Business Hours</h4>
                    <div class="hours-grid">
                        <div class="hours-item">
                            <div class="hours-day">Monday - Friday</div>
                            <div class="hours-time">9:00 AM - 6:00 PM</div>
                        </div>
                        <div class="hours-item">
                            <div class="hours-day">Saturday</div>
                            <div class="hours-time">9:00 AM - 5:00 PM</div>
                        </div>
                        <div class="hours-item">
                            <div class="hours-day">Sunday</div>
                            <div class="hours-time">10:00 AM - 4:00 PM</div>
                        </div>
                        <div class="hours-item">
                            <div class="hours-day">Holidays</div>
                            <div class="hours-time">10:00 AM - 4:00 PM</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Contact Form -->
            <div class="contact-form">
                <h3>Send Us a Message</h3>
                <form id="contact-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="first-name">First Name *</label>
                            <input type="text" id="first-name" class="form-input" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="last-name">Last Name *</label>
                            <input type="text" id="last-name" class="form-input" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="email">Email Address *</label>
                            <input type="email" id="email" class="form-input" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="phone">Phone Number</label>
                            <input type="tel" id="phone" class="form-input">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="inquiry-type">Inquiry Type</label>
                        <select id="inquiry-type" class="form-select">
                            <option value="general">General Information</option>
                            <option value="booking">Hotel Booking</option>
                            <option value="attractions">Attractions & Tours</option>
                            <option value="emergency">Emergency Assistance</option>
                            <option value="feedback">Feedback & Suggestions</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="preferred-language">Preferred Response Language</label>
                        <select id="preferred-language" class="form-select">
                            <option value="en">English</option>
                            <option value="ja">日本語</option>
                            <option value="ne">नेपाली</option>
                            <option value="my">မြန်မာ</option>
                            <option value="vi">Tiếng Việt</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="subject">Subject *</label>
                        <input type="text" id="subject" class="form-input" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="message">Message *</label>
                        <textarea id="message" class="form-textarea" required placeholder="Please provide details about your inquiry..."></textarea>
                    </div>
                    
                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>
        </div>
        
        <!-- Map Section -->
        <div class="map-section">
            <h3 style="text-align: center; margin-bottom: 2rem;">Find Us in Okayama</h3>
            <div class="map-container" id="map"></div>
        </div>
    </div>
</section>

<!-- Newsletter Section -->
<section class="newsletter-section">
    <div class="container">
        <div class="section-header">
            <h3>Stay Updated</h3>
            <p>Subscribe to our newsletter for the latest travel tips, events, and special offers in Okayama</p>
        </div>
        
        <form class="newsletter-form" id="newsletter-form">
            <div class="newsletter-input">
                <input type="email" placeholder="Enter your email address" required id="newsletter-email">
                <button type="submit">Subscribe</button>
            </div>
            <p style="font-size: 0.875rem; color: var(--secondary-text); margin-top: 1rem;">
                We respect your privacy. Unsubscribe at any time.
            </p>
        </form>
    </div>
</section>


<script src="<c:url value='/assets/js/contact.js' />"></script>

<c:import url="/common/footer.jsp" />

