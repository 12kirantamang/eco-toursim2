<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/header.jsp"/>
<c:import url="/common/navbar.jsp"/>

<link rel="stylesheet" href="<c:url value='/assets/css/adventure2.css'/>">


<!-- ================= HEADER ================= -->
<section class="adventure-header">
    <h1>Book Your Perfect Adventure</h1>
    <p>Discover unforgettable experiences in Okayama</p>
</section>

<!-- ================= PLACES GRID ================= -->
<section class="section">
    <div class="container">

        <form id="bookingForm" method="post" action="<c:url value='/bookings'/>">

            <div class="places-grid">
                <c:forEach var="place" items="${places}">
                    <c:if test="${place.status eq 'AVAILABLE'}">

                        <div class="place-card">

                            <img src="<c:url value='/assets/img/resources/uploads/${place.imageUrl}'/>"
                                 alt="${place.placeName}">

                            <div class="place-content">

                                <!-- SELECT PLACE CHECKBOX -->
                                <label class="select-place">
                                    <input type="checkbox"
                                           name="placeIds"
                                           value="${place.placeId}"
                                           data-price="${place.pricePerPerson}"
                                           onchange="calculateTotal()">
                                    Select
                                </label>

                                <h3>${place.placeName}</h3>
                                <p class="desc">${place.description}</p>

                                <div class="price">
                                    $${place.pricePerPerson} / person
                                </div>

                            </div>
                        </div>

                    </c:if>
                </c:forEach>
            </div>

            <!-- ================= BOOKING PANEL ================= -->
            <div class="booking-panel">

                <div class="form-group">
                    <label>Date</label>
                    <input type="date" name="bookingDate" required min="<%= java.time.LocalDate.now() %>">
                </div>

                <div class="form-group">
                    <label>Time Slot</label>
                    <select name="timeSlot" required>
                        <option value="">Select</option>
                        <option value="09:00-12:00">09:00 - 12:00</option>
                        <option value="13:00-16:00">13:00 - 16:00</option>
                        <option value="17:00-20:00">17:00 - 20:00</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Visitors</label>
                    <input type="number"
                           id="visitorCount"
                           name="visitorCount"
                           min="1"
                           value="1"
                           onchange="calculateTotal()">
                </div>

                <!-- TOTAL -->
                <div class="total-box">
                    Total Amount: $<span id="totalDisplay">0</span>
                    <input type="hidden" id="totalAmount" name="totalAmount">
                </div>

                <!-- BOOK BUTTON -->
                <c:choose>
				    <c:when test="${empty sessionScope.user}">
				        <button type="button" class="book-btn disabled" onclick="goLogin()">
				            Login to Book
				        </button>
				    </c:when>
				    <c:otherwise>
				        <button type="button" class="book-btn" onclick="submitBooking()">
				            Book Selected Adventures
				        </button>
				    </c:otherwise>
				</c:choose>

            </div>

        </form>
    </div>
</section>

<!-- ================= SCRIPT ================= -->
<script>
function calculateTotal() {
    const checkboxes = document.querySelectorAll("input[name='placeIds']:checked");
    const visitors = parseInt(document.getElementById("visitorCount").value || 1);
    let sum = 0;

    checkboxes.forEach(cb => {
        sum += parseFloat(cb.dataset.price);
    });

    const total = sum * visitors;

    document.getElementById("totalDisplay").innerText = total;
    document.getElementById("totalAmount").value = total;
}

function submitBooking() {
    const selected = document.querySelectorAll("input[name='placeIds']:checked");
    const bookingDate = document.querySelector("input[name='bookingDate']").value;
    const timeSlot = document.querySelector("select[name='timeSlot']").value;
    const visitorCount = document.getElementById("visitorCount").value;
    const totalAmount = document.getElementById("totalAmount").value;

    if (selected.length === 0) {
        alert("Please select at least one adventure.");
        return;
    }

    if (!bookingDate) {
        alert("Please select booking date.");
        return;
    }

    if (!timeSlot) {
        alert("Please select time slot.");
        return;
    }

    if (visitorCount < 1) {
        alert("Visitor count must be at least 1.");
        return;
    }

    if (totalAmount <= 0) {
        alert("Total amount is invalid.");
        return;
    }

    if (!confirm(
        "Confirm Booking?\n\n" +
        "Adventures: " + selected.length + "\n" +
        "Visitors: " + visitorCount + "\n" +
        "Total: $" + totalAmount
    )) {
        return;
    }

    // Submit the form to BookingServlet
    document.getElementById("bookingForm").submit();
}

function goLogin() {
    alert("Please login first.");
    window.location.href = "<c:url value='/login.jsp'/>";
}

</script>

<c:import url="/common/footer.jsp"/>
