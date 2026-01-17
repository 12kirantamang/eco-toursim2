
        let selectedRoom = null;
        let currentStep = 1;
        
        // Initialize date inputs with default values
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            const nextWeek = new Date(today);
            nextWeek.setDate(nextWeek.getDate() + 4);
            
            document.getElementById('checkin-date').value = tomorrow.toISOString().split('T')[0];
            document.getElementById('checkout-date').value = nextWeek.toISOString().split('T')[0];
            
            // Filter functionality
            const filterBtns = document.querySelectorAll('.filter-btn');
            const hotelCards = document.querySelectorAll('.hotel-card');
            
            filterBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    filterBtns.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    
                    const filter = this.dataset.filter;
                    
                    hotelCards.forEach(card => {
                        if (filter === 'all' || card.dataset.category.includes(filter)) {
                            card.style.display = 'block';
                            anime({
                                targets: card,
                                opacity: [0, 1],
                                translateY: [20, 0],
                                duration: 500,
                                easing: 'easeOutQuad'
                            });
                        } else {
                            anime({
                                targets: card,
                                opacity: 0,
                                translateY: -20,
                                duration: 300,
                                easing: 'easeInQuad',
                                complete: function() {
                                    card.style.display = 'none';
                                }
                            });
                        }
                    });
                });
            });
        });
        
        // Booking modal functions
        function openBookingModal(hotelId) {
            const modal = document.getElementById('booking-modal');
            modal.classList.add('active');
            document.body.style.overflow = 'hidden';
            
            // Reset form
            resetBookingForm();
            
            // Update hotel name in summary
            const hotelCards = document.querySelectorAll('.hotel-card');
            hotelCards.forEach(card => {
                if (card.dataset.name.toLowerCase().includes(hotelId.replace('-', ' '))) {
                    const hotelName = card.querySelector('.hotel-name').textContent;
                    document.getElementById('summary-hotel').textContent = hotelName;
                }
            });
        }
        
        function closeBookingModal() {
            const modal = document.getElementById('booking-modal');
            modal.classList.remove('active');
            document.body.style.overflow = 'auto';
            resetBookingForm();
        }
        
        function resetBookingForm() {
            currentStep = 1;
            selectedRoom = null;
            
            // Reset steps
            document.querySelectorAll('.step').forEach(step => {
                step.classList.remove('active', 'completed');
            });
            document.getElementById('step-1').classList.add('active');
            
            // Reset forms
            document.querySelectorAll('.booking-form').forEach(form => {
                form.classList.remove('active');
            });
            document.getElementById('form-step-1').classList.add('active');
            
            // Reset room selection
            document.querySelectorAll('.room-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            document.getElementById('next-step-1').disabled = true;
        }
        
        function selectRoom(element, roomType, price) {
            // Remove selection from all rooms
            document.querySelectorAll('.room-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            // Select clicked room
            element.classList.add('selected');
            selectedRoom = { type: roomType, price: price };
            
            // Enable next button
            document.getElementById('next-step-1').disabled = false;
            
            // Update summary
            document.getElementById('summary-room').textContent = roomType + ' Room';
            updateBookingSummary();
        }
        
        function nextStep(step) {
            // Validate current step
            if (step === 2 && !validateGuestDetails()) {
                return;
            }
            
            // Update steps
            document.getElementById(`step-${currentStep}`).classList.remove('active');
            document.getElementById(`step-${currentStep}`).classList.add('completed');
            document.getElementById(`step-${step}`).classList.add('active');
            
            // Update forms
            document.getElementById(`form-step-${currentStep}`).classList.remove('active');
            document.getElementById(`form-step-${step}`).classList.add('active');
            
            currentStep = step;
            
            // Update summary if moving to step 3
            if (step === 3) {
                updateBookingSummary();
            }
            
            // Handle confirmation step
            if (step === 4) {
                const email = document.getElementById('email').value;
                document.getElementById('confirmation-email').textContent = email;
            }
        }
        
        function previousStep(step) {
            // Update steps
            document.getElementById(`step-${currentStep}`).classList.remove('active');
            document.getElementById(`step-${step}`).classList.remove('completed');
            document.getElementById(`step-${step}`).classList.add('active');
            
            // Update forms
            document.getElementById(`form-step-${currentStep}`).classList.remove('active');
            document.getElementById(`form-step-${step}`).classList.add('active');
            
            currentStep = step;
        }
        
        function validateGuestDetails() {
            const firstName = document.getElementById('first-name').value;
            const lastName = document.getElementById('last-name').value;
            const email = document.getElementById('email').value;
            const phone = document.getElementById('phone').value;
            
            if (!firstName || !lastName || !email || !phone) {
                alert('Please fill in all required fields.');
                return false;
            }
            
            if (!validateEmail(email)) {
                alert('Please enter a valid email address.');
                return false;
            }
            
            return true;
        }
        
        function updateBookingSummary() {
            const checkin = document.getElementById('checkin-date').value;
            const checkout = document.getElementById('checkout-date').value;
            const guests = document.getElementById('guests').value;
            
            if (checkin && checkout && selectedRoom) {
                const checkinDate = new Date(checkin);
                const checkoutDate = new Date(checkout);
                const nights = Math.ceil((checkoutDate - checkinDate) / (1000 * 60 * 60 * 24));
                
                document.getElementById('summary-checkin').textContent = new Date(checkin).toLocaleDateString();
                document.getElementById('summary-checkout').textContent = new Date(checkout).toLocaleDateString();
                document.getElementById('summary-nights').textContent = nights;
                document.getElementById('summary-guests').textContent = guests;
                document.getElementById('summary-rate').textContent = `¥${selectedRoom.price.toLocaleString()} × ${nights} nights`;
                document.getElementById('summary-total').textContent = `¥${(selectedRoom.price * nights).toLocaleString()}`;
            }
        }
        
        // Close modal when clicking outside
        window.addEventListener('click', function(e) {
            if (e.target.classList.contains('modal')) {
                closeBookingModal();
            }
        });
        
        // Close modal with Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                const modal = document.getElementById('booking-modal');
                if (modal.classList.contains('active')) {
                    closeBookingModal();
                }
            }
        });
        
        // Update dates when changed
        document.getElementById('checkin-date').addEventListener('change', updateBookingSummary);
        document.getElementById('checkout-date').addEventListener('change', updateBookingSummary);
        // Function to collect all booking data
function getBookingData() {
    return {
        hotelName: document.getElementById('summary-hotel').textContent,
        checkin: document.getElementById('checkin-date').value,
        checkout: document.getElementById('checkout-date').value,
        guests: document.getElementById('guests').value.split(' ')[0],
        roomType: selectedRoom.type,
        roomPrice: selectedRoom.price,
        firstName: document.getElementById('first-name').value,
        lastName: document.getElementById('last-name').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value,
        // Calculate nights for the backend, or let the backend do it
        nights: Math.ceil((new Date(document.getElementById('checkout-date').value) - new Date(document.getElementById('checkin-date').value)) / (1000 * 60 * 60 * 24)),
    };
}

function nextStep(step) {
    // ... existing validation and step logic ...

    // --- Backend Integration Point ---
    if (step === 4) {
        // Prevent going to the confirmation screen immediately
        // document.getElementById(`form-step-${currentStep}`).classList.remove('active');
        
        const bookingData = getBookingData();
        
        // Use the Fetch API to send data to the backend
        fetch('/api/book-hotel', { // This is the **correct path** for the backend
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(bookingData),
        })
        .then(response => {
            if (!response.ok) {
                // If the server returns an error status
                throw new Error('Booking failed due to a server error.');
            }
            return response.json(); // Assuming the backend returns a JSON response
        })
        .then(data => {
            // Success: Update the confirmation email and then show the confirmation step
            const email = document.getElementById('email').value;
            document.getElementById('confirmation-email').textContent = email;
            
            // Now proceed to the final step (which was step 4 in the original code)
            document.getElementById(`form-step-${currentStep}`).classList.remove('active');
            document.getElementById(`form-step-4`).classList.add('active');
            currentStep = 4;
            
            // You can use `data.reference` if the backend returns a real reference number
            // document.getElementById('confirmation-ref').textContent = data.reference;
            
        })
        .catch(error => {
            // Handle network errors or server-reported errors
            console.error('Booking error:', error);
            alert('Booking could not be completed. Please try again.');
        });
        
        // DO NOT change to step 4 here, let the 'then' block handle it on success
    } else {
        // ... existing logic to advance steps 1, 2, and 3 ...
        
        // Update steps
        document.getElementById(`step-${currentStep}`).classList.remove('active');
        document.getElementById(`step-${currentStep}`).classList.add('completed');
        document.getElementById(`step-${step}`).classList.add('active');
        
        // Update forms
        document.getElementById(`form-step-${currentStep}`).classList.remove('active');
        document.getElementById(`form-step-${step}`).classList.add('active');
        
        currentStep = step;
        
        // Update summary if moving to step 3
        if (step === 3) {
            updateBookingSummary();
        }
    }
}
    