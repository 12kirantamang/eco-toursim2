<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<footer class="footer">
    <div class="footer-container">

        <!-- Brand -->
        <div class="footer-col">
            <h4>Discover Okayama</h4>
            <p>Your gateway to experiencing the beauty and culture of Okayama, Japan.</p>
        </div>

        <!-- Quick Links -->
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <!-- THIS IS THE HOME LINK -->
                <li><a href="index.html" data-translate="aboutTitle"><i class="fas fa-home"></i> Home</a></li>

                <li><a href="#about"><i class="fas fa-info-circle"></i> About</a></li>
                <li><a href="attractions.html"><i class="fas fa-map-marked-alt"></i> Attractions</a></li>
                <li><a href="adventure.html"><i class="fas fa-mountain"></i> Adventure</a></li>
                <li><a href="contact.html"><i class="fas fa-envelope"></i> Contact</a></li>
            </ul>
        </div>

        <!-- Social -->
        <div class="footer-col">
            <h4>Follow Us</h4>
            <ul class="social-links">
                <li><a href="#"><i class="fab fa-facebook"></i></a></li>
                <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                <li><a href="#"><i class="fab fa-youtube"></i></a></li>
            </ul>
        </div>

    </div>

    <div class="footer-bottom">
        <p>&copy; <span id="year"></span> Discover Okayama. All rights reserved.</p>
    </div>
</footer>


    <!-- Scripts -->
	<script src="<c:url value='assets/js/main.js' />"></script>
    <script>
    	document.getElementById("year").textContent = new Date().getFullYear();
	</script>
    
</body>
</html>

