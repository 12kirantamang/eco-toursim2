<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/header.jsp" />
<c:import url="/common/navbar.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/attractions.css' />">

<!-- Header Section -->
<section class="attractions-header">
    <div class="container">
        <h1 data-translate="attractionsTitle">Must-Visit Attractions</h1>
        <p>Discover the rich cultural heritage and natural beauty of Okayama</p>
    </div>
</section>

<!-- Filter Controls -->
<section class="section">
    <div class="container">
        <div class="filter-controls">
            <button class="filter-btn active" data-filter="all">All Attractions</button>
            <button class="filter-btn" data-filter="historical">Historical</button>
            <button class="filter-btn" data-filter="nature">Nature</button>
            <button class="filter-btn" data-filter="cultural">Cultural</button>
            <button class="filter-btn" data-filter="modern">Modern</button>
        </div>
        
        <!-- Attractions Grid -->
        <div class="attractions-grid" id="attractions-grid">
            <!-- Okayama Castle -->
            <div class="attraction-card" data-category="historical cultural" data-name="Okayama Castle">
                <img src="https://kimi-web-img.moonshot.cn/img/okayama-castle.jp/f8f26d02ac7a4b0558ea3f395c811990e9cb30dd.jpg" alt="Okayama Castle" class="attraction-image">
                <div class="attraction-content">
                    <h3 class="attraction-title">Okayama Castle</h3>
                    <p class="attraction-description">The iconic "Crow Castle" with its distinctive black exterior, offering panoramic views and rich samurai history.</p>
                    <div class="attraction-meta">
                        <span class="attraction-type">Historical</span>
                        <span class="attraction-rating">★★★★★</span>
                    </div>
                    <button class="btn btn-secondary" onclick="openModal('castle-modal')" data-translate="learnMore">Learn More</button>
                </div>
            </div>
            
            <!-- Korakuen Garden -->
            <div class="attraction-card" data-category="nature cultural" data-name="Korakuen Garden">
                <img src="https://kimi-web-img.moonshot.cn/img/www.2aussietravellers.com/0bba775c81e3107cab70067d3c1d2658520a098a.jpg" alt="Korakuen Garden" class="attraction-image">
                <div class="attraction-content">
                    <h3 class="attraction-title">Korakuen Garden</h3>
                    <p class="attraction-description">One of Japan's three most beautiful landscape gardens, featuring pristine lawns and tranquil ponds.</p>
                    <div class="attraction-meta">
                        <span class="attraction-type">Nature</span>
                        <span class="attraction-rating">★★★★★</span>
                    </div>
                    <button class="btn btn-secondary" onclick="openModal('garden-modal')" data-translate="learnMore">Learn More</button>
                </div>
            </div>
            
            <!-- Kurashiki Bikan -->
            <div class="attraction-card" data-category="cultural historical" data-name="Kurashiki Bikan">
                <img src="https://kimi-web-img.moonshot.cn/img/thumbs.dreamstime.com/1dace1457e86fbd60ebd3a435ea5365ba2af3ef7.jpg" alt="Kurashiki Bikan" class="attraction-image">
                <div class="attraction-content">
                    <h3 class="attraction-title">Kurashiki Bikan Historical Quarter</h3>
                    <p class="attraction-description">A preserved historical district with traditional architecture, charming canals, and museums.</p>
                    <div class="attraction-meta">
                        <span class="attraction-type">Cultural</span>
                        <span class="attraction-rating">★★★★☆</span>
                    </div>
                    <button class="btn btn-secondary" onclick="openModal('kurashiki-modal')" data-translate="learnMore">Learn More</button>
                </div>
            </div>
            
            <!-- Okayama Prefectural Museum -->
            <div class="attraction-card" data-category="cultural modern" data-name="Prefectural Museum">
                <img src="https://kimi-web-img.moonshot.cn/img/7enews.net/1d41f052c97b092fdef57f3e3d02462691f72f.webp" alt="Okayama Museum" class="attraction-image">
                <div class="attraction-content">
                    <h3 class="attraction-title">Okayama Prefectural Museum</h3>
                    <p class="attraction-description">Comprehensive collection showcasing Okayama's history, art, and cultural heritage.</p>
                    <div class="attraction-meta">
                        <span class="attraction-type">Cultural</span>
                        <span class="attraction-rating">★★★★☆</span>
                    </div>
                    <button class="btn btn-secondary" onclick="openModal('museum-modal')" data-translate="learnMore">Learn More</button>
                </div>
            </div>
            
            <!-- Kibitsu Shrine -->
            <div class="attraction-card" data-category="historical cultural" data-name="Kibitsu Shrine">
                <img src="https://kimi-web-img.moonshot.cn/img/place.matcha-jp.com/149a9f2be3945259b8204d1e61b8e1ef522631f2.webp" alt="Kibitsu Shrine" class="attraction-image">
                <div class="attraction-content">
                    <h3 class="attraction-title">Kibitsu Shrine</h3>
                    <p class="attraction-description">Ancient Shinto shrine dedicated to the legend of Momotaro, featuring unique architectural elements.</p>
                    <div class="attraction-meta">
                        <span class="attraction-type">Historical</span>
                        <span class="attraction-rating">★★★★☆</span>
                    </div>
                    <button class="btn btn-secondary" onclick="openModal('shrine-modal')" data-translate="learnMore">Learn More</button>
                </div>
            </div>
            
            <!-- Handayama Botanical Garden -->
            <div class="attraction-card" data-category="nature modern" data-name="Botanical Garden">
                <img src="https://kimi-web-img.moonshot.cn/img/en.japantravel.com/f350e6155c7dcf20b730b7ecdc6135836b52e361.jpg" alt="Botanical Garden" class="attraction-image">
                <div class="attraction-content">
                    <h3 class="attraction-title">Handayama Botanical Garden</h3>
                    <p class="attraction-description">Beautiful botanical garden with seasonal flowers, panoramic city views, and walking trails.</p>
                    <div class="attraction-meta">
                        <span class="attraction-type">Nature</span>
                        <span class="attraction-rating">★★★★☆</span>
                    </div>
                    <button class="btn btn-secondary" onclick="openModal('botanical-modal')" data-translate="learnMore">Learn More</button>
                </div>
            </div>
            
            <!-- Bizen Pottery Village -->
            <div class="attraction-card" data-category="cultural historical" data-name="Bizen Pottery">
                <img src="https://kimi-web-img.moonshot.cn/img/boutiquejapan.com/da861d180c6d02cad971b0de725fbcfc4d98375a.jpg" alt="Bizen Pottery" class="attraction-image">
                <div class="attraction-content">
                    <h3 class="attraction-title">Bizen Pottery Village</h3>
                    <p class="attraction-description">Traditional pottery village where you can observe artisans creating famous Bizen-yaki ceramics.</p>
                    <div class="attraction-meta">
                        <span class="attraction-type">Cultural</span>
                        <span class="attraction-rating">★★★★☆</span>
                    </div>
                    <button class="btn btn-secondary" onclick="openModal('pottery-modal')" data-translate="learnMore">Learn More</button>
                </div>
            </div>
            
            <!-- Yumeji Art Museum -->
            <div class="attraction-card" data-category="cultural modern" data-name="Yumeji Museum">
                <img src="https://kimi-web-img.moonshot.cn/img/thumbs.dreamstime.com/cbb0644c9d799500f6d0b95970a15fd45fa0d0f0.jpg" alt="Yumeji Museum" class="attraction-image">
                <div class="attraction-content">
                    <h3 class="attraction-title">Yumeji Art Museum</h3>
                    <p class="attraction-description">Museum dedicated to the works of Yumeji Takehisa, featuring romantic Taisho-era art and exhibitions.</p>
                    <div class="attraction-meta">
                        <span class="attraction-type">Cultural</span>
                        <span class="attraction-rating">★★★☆☆</span>
                    </div>
                    <button class="btn btn-secondary" onclick="openModal('yumeji-modal')" data-translate="learnMore">Learn More</button>
                </div>
            </div>
            
            <!-- Asahi River Promenade -->
            <div class="attraction-card" data-category="nature modern" data-name="Asahi River">
                <img src="https://kimi-web-img.moonshot.cn/img/thumbs.dreamstime.com/d14ce803e35cb2555a542f8ce3f56cfb339f3e44.jpg" alt="Asahi River" class="attraction-image">
                <div class="attraction-content">
                    <h3 class="attraction-title">Asahi River Promenade</h3>
                    <p class="attraction-description">Scenic riverside walking path connecting major attractions, perfect for leisurely strolls and cycling.</p>
                    <div class="attraction-meta">
                        <span class="attraction-type">Nature</span>
                        <span class="attraction-rating">★★★☆☆</span>
                    </div>
                    <button class="btn btn-secondary" onclick="openModal('river-modal')" data-translate="learnMore">Learn More</button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Modals for detailed information -->
<div id="castle-modal" class="modal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('castle-modal')">&times;</button>
        <img src="https://kimi-web-img.moonshot.cn/img/okayama-castle.jp/f8f26d02ac7a4b0558ea3f395c811990e9cb30dd.jpg" alt="Okayama Castle" class="modal-image">
        <div class="modal-body">
            <h2>Okayama Castle</h2>
            <p><strong>History:</strong> Built in 1597 by Ukita Hideie, Okayama Castle earned its nickname "Crow Castle" (烏城, Ujō) due to its distinctive black exterior walls made of lacquered wooden planks.</p>
            <p><strong>Highlights:</strong> The castle features six interior floors despite its three-story exterior appearance. The top floor offers panoramic views of Okayama city and Korakuen Garden.</p>
            <p><strong>Features:</strong> Inside, visitors can explore exhibits about samurai culture, try on traditional costumes, and learn about the castle's reconstruction after World War II.</p>
            <p><strong>Access:</strong> 15-minute streetcar ride from Okayama Station, then a short walk.</p>
            <p><strong>Hours:</strong> 9:00 AM - 5:00 PM (last admission 4:30 PM)</p>
            <p><strong>Admission:</strong> ¥300 for adults</p>
        </div>
    </div>
</div>

<div id="garden-modal" class="modal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('garden-modal')">&times;</button>
        <img src="https://kimi-web-img.moonshot.cn/img/www.2aussietravellers.com/0bba775c81e3107cab70067d3c1d2658520a098a.jpg" alt="Korakuen Garden" class="modal-image">
        <div class="modal-body">
            <h2>Korakuen Garden</h2>
            <p><strong>History:</strong> Created in 1700 by Ikeda Tsunamasa, this garden is considered one of Japan's three most beautiful landscape gardens alongside Kenrokuen in Kanazawa and Kairakuen in Mito.</p>
            <p><strong>Design:</strong> The garden follows the traditional Japanese stroll garden style, featuring expansive lawns, tranquil ponds, traditional tea houses, and carefully curated seasonal plantings.</p>
            <p><strong>Seasonal Beauty:</strong> Cherry blossoms in spring, lush greenery in summer, vibrant foliage in autumn, and serene snow-covered landscapes in winter.</p>
            <p><strong>Features:</strong> Sasa-bune (bamboo boat) area, Ume-no-hashi (plum blossom bridge), Yuushien Garden, and traditional tea houses.</p>
            <p><strong>Access:</strong> Adjacent to Okayama Castle, easily accessible on foot.</p>
            <p><strong>Hours:</strong> 7:30 AM - 6:00 PM (varies by season)</p>
            <p><strong>Admission:</strong> ¥400 for adults</p>
        </div>
    </div>
</div>

<!-- Additional modals would follow the same pattern -->

<script src="<c:url value='assets/js/attractions.js' />"></script>

<c:import url="/common/footer.jsp" />
