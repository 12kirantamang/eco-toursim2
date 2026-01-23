<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentLocale" value="${sessionScope.locale != null ? sessionScope.locale : pageContext.request.locale}" />
<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="resources.messages" />

<c:import url="/common/header.jsp" />
<c:import url="/common/navbar.jsp" />

<style>
    .contact-container {
        max-width: 1200px;
        margin: 40px auto;
        padding: 20px;
    }
    
    .page-header {
        text-align: center;
        margin-bottom: 50px;
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
    
    .contact-content {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 40px;
        margin-top: 30px;
    }
    
    @media (max-width: 768px) {
        .contact-content {
            grid-template-columns: 1fr;
        }
    }
    
    .contact-form {
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .contact-info {
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    .form-label {
        display: block;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 8px;
    }
    
    .form-control {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 1rem;
        transition: border-color 0.3s;
    }
    
    .form-control:focus {
        outline: none;
        border-color: #3498db;
    }
    
    textarea.form-control {
        resize: vertical;
        min-height: 120px;
    }
    
    .btn {
        display: inline-block;
        padding: 12px 30px;
        background: #3498db;
        color: white;
        border: none;
        border-radius: 5px;
        font-weight: 500;
        cursor: pointer;
        transition: background 0.3s;
        font-size: 1rem;
    }
    
    .btn:hover {
        background: #2980b9;
    }
    
    .info-item {
        display: flex;
        align-items: flex-start;
        margin-bottom: 25px;
        padding-bottom: 25px;
        border-bottom: 1px solid #ecf0f1;
    }
    
    .info-item:last-child {
        border-bottom: none;
        padding-bottom: 0;
        margin-bottom: 0;
    }
    
    .info-icon {
        width: 50px;
        height: 50px;
        background: #3498db;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        font-size: 1.5rem;
        margin-right: 20px;
        flex-shrink: 0;
    }
    
    .info-content h3 {
        color: #2c3e50;
        margin-bottom: 8px;
        font-size: 1.2rem;
    }
    
    .info-content p {
        color: #555;
        line-height: 1.6;
        margin: 0;
    }
    
    .success-message {
        background: #d4edda;
        color: #155724;
        padding: 15px 20px;
        border-radius: 5px;
        margin-bottom: 20px;
        border-left: 4px solid #c3e6cb;
    }
    
    .map-container {
        margin-top: 40px;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .map-container iframe {
        width: 100%;
        height: 400px;
        border: none;
    }
</style>

<div class="contact-container">
    <div class="page-header">
        <h1><fmt:message key="contact.title" /></h1>
        <p><fmt:message key="contact.subtitle" /></p>
    </div>
    
    <c:if test="${not empty param.success}">
        <div class="success-message">
            <i class="fas fa-check-circle"></i> <fmt:message key="contact.success" />
        </div>
    </c:if>
    
    <c:if test="${not empty param.error}">
        <div class="error-message" style="background: #f8d7da; color: #721c24; padding: 15px 20px; border-radius: 5px; margin-bottom: 20px; border-left: 4px solid #f5c6cb;">
            <i class="fas fa-exclamation-circle"></i> <fmt:message key="contact.error" />
        </div>
    </c:if>
    
    <div class="contact-content">
        <!-- Contact Form -->
        <div class="contact-form">
            <h2 style="margin-bottom: 20px; color: #2c3e50;"><fmt:message key="contact.form.title" /></h2>
            <form action="<c:url value='/contact' />" method="post">
                <div class="form-group">
                    <label for="name" class="form-label">
                        <i class="fas fa-user"></i> <fmt:message key="contact.form.name" /> *
                    </label>
                    <input type="text" id="name" name="name" class="form-control" required placeholder="">
                </div>
                
                <div class="form-group">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope"></i> <fmt:message key="contact.form.email" /> *
                    </label>
                    <input type="email" id="email" name="email" class="form-control" required placeholder="">
                </div>
                
                <div class="form-group">
                    <label for="subject" class="form-label">
                        <i class="fas fa-tag"></i> <fmt:message key="contact.form.subject" /> *
                    </label>
                    <input type="text" id="subject" name="subject" class="form-control" required placeholder="">
                </div>
                
                <div class="form-group">
                    <label for="message" class="form-label">
                        <i class="fas fa-comment"></i> <fmt:message key="contact.form.message" /> *
                    </label>
                    <textarea id="message" name="message" class="form-control" required placeholder=""></textarea>
                </div>
                
                <button type="submit" class="btn">
                    <i class="fas fa-paper-plane"></i> <fmt:message key="contact.form.send" />
                </button>
            </form>
        </div>
        
        <!-- Contact Information -->
        <div class="contact-info">
            <h2 style="margin-bottom: 30px; color: #2c3e50;"><fmt:message key="contact.info.title" /></h2>
            
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div class="info-content">
                    <h3><fmt:message key="contact.info.address" /></h3>
                    <p>Okayama Tourism Office<br>
                    2-1-1 Omote-cho, Kita-ku<br>
                    Okayama City, Okayama 700-0822<br>
                    Japan</p>
                </div>
            </div>
            
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-phone"></i>
                </div>
                <div class="info-content">
                    <h3><fmt:message key="contact.info.phone" /></h3>
                    <p>+81 86-803-1332<br>
                    Monday - Friday: 9:00 AM - 6:00 PM<br>
                    Saturday: 10:00 AM - 4:00 PM</p>
                </div>
            </div>
            
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="info-content">
                    <h3><fmt:message key="contact.info.email" /></h3>
                    <p>info@okayama-ecotourism.jp<br>
                    bookings@okayama-ecotourism.jp<br>
                    support@okayama-ecotourism.jp</p>
                </div>
            </div>
            
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="info-content">
                    <h3><fmt:message key="contact.info.hours" /></h3>
                    <p>Monday - Friday: 9:00 AM - 6:00 PM<br>
                    Saturday: 10:00 AM - 4:00 PM<br>
                    Sunday & Holidays: Closed</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Map Section -->
    <div class="map-container">
        <iframe 
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d26191.475087891757!2d133.91666897431643!3d34.66166679999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3551e57e8c8fffff%3A0xf0a6dda5e7c6b5c4!2sOkayama%20Castle!5e0!3m2!1sen!2sjp!4v1642000000000!5m2!1sen!2sjp" 
            allowfullscreen="" 
            loading="lazy">
        </iframe>
    </div>
</div>

<c:import url="/common/footer.jsp" />
