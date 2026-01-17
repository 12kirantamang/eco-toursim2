
        // Initialize map
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize Leaflet map
            const map = L.map('map').setView([34.6617, 133.9350], 13);
            
            // Add OpenStreetMap tiles
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors'
            }).addTo(map);
            
            // Add marker for Okayama Tourism Center
            const marker = L.marker([34.6617, 133.9350]).addTo(map);
            marker.bindPopup('<b>Okayama Tourism Center</b><br>1-1 Ekimotomachi, Kita Ward<br>Okayama, 700-0024, Japan');
            
            // Contact form submission
            document.getElementById('contact-form').addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Get form data
                const formData = new FormData(this);
                const data = Object.fromEntries(formData);
                
                // Simulate form submission
                const submitBtn = this.querySelector('.submit-btn');
                const originalText = submitBtn.textContent;
                
                submitBtn.textContent = 'Sending...';
                submitBtn.disabled = true;
                
                setTimeout(() => {
                    alert('Thank you for your message! We will get back to you within 24 hours.');
                    this.reset();
                    submitBtn.textContent = originalText;
                    submitBtn.disabled = false;
                }, 2000);
            });
            
            // Newsletter form submission
            document.getElementById('newsletter-form').addEventListener('submit', function(e) {
                e.preventDefault();
                
                const email = document.getElementById('newsletter-email').value;
                
                if (validateEmail(email)) {
                    alert('Thank you for subscribing to our newsletter!');
                    this.reset();
                } else {
                    alert('Please enter a valid email address.');
                }
            });
        });
        
        // Form validation helper
        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }
    