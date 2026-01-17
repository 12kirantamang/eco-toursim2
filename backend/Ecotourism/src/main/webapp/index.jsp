<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/header.jsp" />
<c:import url="/common/navbar.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/main.css' />">

<!-- Hero Section -->
<section class="hero" role="banner">
    <div class="hero-background" aria-hidden="true"></div>
    <div class="hero-overlay" aria-hidden="true"></div>
    
    <div class="hero-content">
        <h1 class="hero-title" data-translate="heroTitle">Experience the Beauty of Okayama</h1>
        <p class="hero-subtitle" data-translate="heroSubtitle">Where tradition meets modern charm in the Land of Sunshine</p>
        
        <div class="hero-buttons">
            <a href="<c:url value='/attractions.jsp' />" class="btn btn-primary" data-translate="exploreBtn">
                <span>🗾</span>
                <span data-translate="exploreBtn">Explore Attractions</span>
            </a>
            <!-- <a href="hotels.html" class="btn btn-secondary" data-translate="bookBtn">
                <span>🏨</span>
                <span data-translate="bookBtn">Book Hotels</span>
            </a> -->
        </div>
    </div>
</section>

<!-- About Okayama Section -->
<section id="about" class="section">
    <div class="container">
        <div class="section-header fade-in-up">
            <h2 data-translate="aboutTitle">About Okayama</h2>
            <p data-translate="aboutText">Okayama, known as the 'Land of Sunshine,' is home to the iconic Crow Castle and stunning Korakuen Garden. This historic city seamlessly blends traditional Japanese culture with modern amenities, offering visitors an authentic experience of Japan's rich heritage.</p>
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
            <h2 data-translate="attractionsTitle">Must-Visit Attractions</h2>
            <p>Discover the rich cultural heritage and natural beauty of Okayama</p>
        </div>
        
        <div class="grid grid-3 fade-in-up">
            <div class="card">
                <img src="https://kimi-web-img.moonshot.cn/img/okayama-castle.jp/f8f26d02ac7a4b0558ea3f395c811990e9cb30dd.jpg" alt="Okayama Castle" class="card-image">
                <div class="card-content">
                    <h3 class="card-title">Okayama Castle</h3>
                    <p class="card-description">The iconic "Crow Castle" with its distinctive black exterior and rich history dating back to 1597.</p>
                    <div class="card-meta">
                        <span>🏯 Historical</span>
                        <!-- <span>★★★★★</span> -->
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
                        <!-- <span>★★★★★</span> -->
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
                        <!-- <span>★★★★☆</span> -->
                    </div>
                </div>
            </div>
        </div>
        
        <div style="text-align: center; margin-top: 3rem;">
            <a href="<c:url value='/attractions.jsp' />" class="btn btn-primary" data-translate="viewAll">View All Attractions</a>
        </div>
    </div>
</section>

<!-- Local Food Section -->
<section id="food" class="section">
    <div class="container">
        <div class="section-header fade-in-up">
            <h2 data-translate="foodTitle">Local Cuisine</h2>
            <p>Taste the authentic flavors of Okayama's rich culinary heritage</p>
        </div>
        
        <div class="food-grid fade-in-up">
            <div class="food-card">
                <img src="<c:url value='/img/resources/barazushi-dish.png' />" alt="Okayama Barazushi" class="food-image">
                <h3>Barazushi</h3>
                <p>A colorful scattered sushi dish featuring fresh seafood and seasonal vegetables from the Seto Inland Sea.</p>
            </div>
            
            <div class="food-card">
                <img src="<c:url value='/img/momo.png' />" alt="Okayama White Peaches" class="food-image">
                <h3>White Peaches</h3>
                <p>Okayama's famous white peaches, known for their exceptional sweetness and delicate texture.</p>
            </div>
            
            <div class="food-card">
                <img src="<c:url value='/img/kibi.png' />" alt="Kibi Dango" class="food-image">
                <h3>Kibi Dango</h3>
                <p>Traditional millet dumplings associated with the legend of Momotaro, the Peach Boy.</p>
            </div>
            
            <div class="food-card">
                <img src="<c:url value='/img/Yakisoba.png' />" alt="Hiruzen Yakisoba" class="food-image">
                <h3>Hiruzen Yakisoba</h3>
                <p>Local stir-fried noodles with chicken, cabbage, and special miso sauce featuring apple and garlic.</p>
            </div>
        </div>
    </div>
</section>

<!-- Events Section -->
<section id="events" class="section">
    <div class="container">
        <div class="section-header fade-in-up">
            <h2 data-translate="eventsTitle">Upcoming Events</h2>
            <p>Join in the celebration of Okayama's vibrant cultural festivals</p>
        </div>
        
        <div class="splide events-carousel fade-in-up" id="events-carousel">
            <div class="splide__track">
                <ul class="splide__list">
                    <li class="splide__slide">
                        <div class="event-card">
                            <div class="event-date">Mar 2025</div>
                            <h3>Cherry Blossom Festival</h3>
                            <p>Celebrate the arrival of spring with hanami parties in Korakuen Garden. Experience traditional tea ceremonies and cultural performances under blooming cherry trees.</p>
                            <a href="#" class="btn btn-primary">RSVP</a>
                        </div>
                    </li>
                    
                    <li class="splide__slide">
                        <div class="event-card">
                            <div class="event-date">Jul 2025</div>
                            <h3>Summer Fantasy Garden</h3>
                            <p>Evening illumination event in Korakuen Garden with extended hours until 9:30 PM. Enjoy the magical atmosphere of traditional lanterns and modern lighting.</p>
                            <a href="#" class="btn btn-primary">RSVP</a>
                        </div>
                    </li>
                    
                    <li class="splide__slide">
                        <div class="event-card">
                            <div class="event-date">Oct 2025</div>
                            <h3>Autumn Moon Viewing</h3>
                            <p>Traditional tsukimi ceremony celebrating the harvest moon. Experience Japanese cultural traditions with poetry readings and seasonal foods.</p>
                            <a href="#" class="btn btn-primary">RSVP</a>
                        </div>
                    </li>
                    
                    <li class="splide__slide">
                        <div class="event-card">
                            <div class="event-date">Nov 2025</div>
                            <h3>Chrysanthemum Convention</h3>
                            <p>Annual chrysanthemum exhibition showcasing intricate floral arrangements and traditional Japanese gardening techniques.</p>
                            <a href="#" class="btn btn-primary">RSVP</a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="section testimonials">
    <div class="container">
        <div class="section-header fade-in-up">
            <h2 data-translate="testimonialsTitle">Traveler Reviews</h2>
            <p>Hear what visitors say about their Okayama experience</p>
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

