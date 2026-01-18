<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .table-container { max-height: 300px; overflow-y: auto; }
        table tbody tr:hover { background-color: #e0f2fe; }
        table thead th { position: sticky; top: 0; background-color: #f3f4f6; }
    </style>
</head>
<body class="bg-gray-100 font-sans">

<header class="bg-blue-600 text-white p-4 flex justify-between items-center">
    <h1 class="text-xl font-bold">Admin Dashboard</h1>
    <nav>
        <ul class="flex space-x-4 items-center">
            <li><span>Welcome, Admin</span></li>
            <li>
                <a href="<c:url value='/auth?action=logout' />" 
                   class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">
                   Logout
                </a>
            </li>
        </ul>
    </nav>
</header>

<main class="p-6 space-y-8">

<!-- Users Section -->
<section class="bg-white p-4 rounded shadow">
    <h2 class="text-lg font-semibold mb-4">Users</h2>
    <input type="text" placeholder="Search Users..." onkeyup="filterTable('usersTable', this.value)" class="mb-2 p-2 border rounded w-full">
    <div class="table-container">
        <table class="min-w-full border border-gray-300" id="usersTable">
            <thead class="bg-gray-200">
                <tr>
                    <th class="p-2 border">User ID</th>
                    <th class="p-2 border">User Name</th>
                    <th class="p-2 border">Email</th>
                    <th class="p-2 border">Role</th>
                    <th class="p-2 border">Status</th>
                    <th class="p-2 border">Created At</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td class="p-2 border">${user.userId}</td>
                        <td class="p-2 border">${user.userName}</td>
                        <td class="p-2 border">${user.email}</td>
                        <td class="p-2 border">${user.role}</td>
                        <td class="p-2 border">${user.status}</td>
                        <td class="p-2 border">${user.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<!-- Places Section -->
<section class="bg-white p-4 rounded shadow">
    <h2 class="text-lg font-semibold mb-4">Places</h2>
    <input type="text" placeholder="Search Places..." onkeyup="filterTable('placesTable', this.value)" class="mb-2 p-2 border rounded w-full">
    <div class="table-container">
        <table class="min-w-full border border-gray-300" id="placesTable">
            <thead class="bg-gray-200">
                <tr>
                    <th class="p-2 border">Place ID</th>
                    <th class="p-2 border">Place Code</th>
                    <th class="p-2 border">Place Name</th>
                    <th class="p-2 border">Image</th> <!-- NEW -->
                    <th class="p-2 border">Price Per Visitor</th>
                    <th class="p-2 border">Status</th>
                    <th class="p-2 border">Created At</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="place" items="${places}">
                    <tr>
                        <td class="p-2 border">${place.placeId}</td>
                        <td class="p-2 border">${place.placeCode}</td>
                        <td class="p-2 border">${place.placeName}</td>
                        <td class="p-2 border">
                            <c:if test="${not empty place.imageUrl}">
                                <img src="<c:url value='/assets/img/uploads/${place.imageUrl}' />" alt="${place.placeName}" class="h-16 w-16 object-cover rounded">
                            </c:if>
                            <c:if test="${empty place.imageUrl}">
                                N/A
                            </c:if>
                        </td>
                        <td class="p-2 border">$${place.pricePerPerson}</td>
                        <td class="p-2 border">${place.status}</td>
                        <td class="p-2 border">${place.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</section>


<!-- Bookings Section -->
<section class="bg-white p-4 rounded shadow">
    <h2 class="text-lg font-semibold mb-4">Bookings</h2>
    <input type="text" placeholder="Search Bookings..." onkeyup="filterTable('bookingsTable', this.value)" class="mb-2 p-2 border rounded w-full">
    <div class="table-container">
        <table class="min-w-full border border-gray-300" id="bookingsTable">
            <thead class="bg-gray-200">
                <tr>
                    <th class="p-2 border">Booking ID</th>
                    <th class="p-2 border">User ID</th>
                    <th class="p-2 border">Booking Date</th>
                    <th class="p-2 border">Time Slot</th>
                    <th class="p-2 border">Visitor Count</th>
                    <th class="p-2 border">Total Amount</th>
                    <th class="p-2 border">Created At</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="booking" items="${bookings}">
                    <tr>
                        <td class="p-2 border">${booking.bookingId}</td>
                        <td class="p-2 border">${booking.userId}</td>
                        <td class="p-2 border">${booking.bookingDate}</td>
                        <td class="p-2 border">${booking.timeSlot}</td>
                        <td class="p-2 border">${booking.visitorCount}</td>
                        <td class="p-2 border">$${booking.totalAmount}</td>
                        <td class="p-2 border">${booking.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<!-- BookingPlaces Section -->
<section class="bg-white p-4 rounded shadow">
    <h2 class="text-lg font-semibold mb-4">Booking Places</h2>
    <input type="text" placeholder="Search Booking Places..." onkeyup="filterTable('bookingPlacesTable', this.value)" class="mb-2 p-2 border rounded w-full">
    <div class="table-container">
        <table class="min-w-full border border-gray-300" id="bookingPlacesTable">
            <thead class="bg-gray-200">
                <tr>
                    <th class="p-2 border">BookingPlace ID</th>
                    <th class="p-2 border">Booking ID</th>
                    <th class="p-2 border">Place ID</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bp" items="${bookingPlaces}">
                    <tr>
                        <td class="p-2 border">${bp.bookingPlaceId}</td>
                        <td class="p-2 border">${bp.bookingId}</td>
                        <td class="p-2 border">${bp.placeId}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</section>

</main>

<script>
    function filterTable(tableId, searchValue) {
        const filter = searchValue.toUpperCase();
        const table = document.getElementById(tableId);
        const tr = table.getElementsByTagName("tr");
        for (let i = 1; i < tr.length; i++) {
            let tdArr = tr[i].getElementsByTagName("td");
            let txtValue = "";
            for (let j = 0; j < tdArr.length; j++) {
                txtValue += tdArr[j].textContent || tdArr[j].innerText;
            }
            tr[i].style.display = txtValue.toUpperCase().indexOf(filter) > -1 ? "" : "none";
        }
    }
</script>

</body>
</html>
