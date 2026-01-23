<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .table-container { max-height: 600px; overflow-y: auto; }
        table tbody tr:hover { background-color: #e0f2fe; }
        table thead th { position: sticky; top: 0; background-color: #1e3a8a; z-index: 10; }
    </style>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-900 text-white p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-2xl font-bold"><i class="fas fa-calendar-check"></i> Manage Bookings</h1>
        <nav class="flex space-x-4 items-center">
            <a href="<c:url value='/admin/dashboard' />" class="hover:text-blue-200">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="<c:url value='/admin/places' />" class="hover:text-blue-200">
                <i class="fas fa-map-marked-alt"></i> Places
            </a>
            <a href="<c:url value='/admin/users' />" class="hover:text-blue-200">
                <i class="fas fa-users"></i> Users
            </a>
            <span class="border-l border-blue-700 h-6"></span>
            <span>Welcome, ${sessionScope.user.userName}</span>
            <a href="<c:url value='/auth?action=logout' />" 
               class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded">
               <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </nav>
    </div>
</header>

<main class="container mx-auto p-6">
    
    <!-- Action Bar -->
    <div class="bg-white p-4 rounded-lg shadow-md mb-6">
        <h2 class="text-xl font-semibold text-gray-800">Bookings Management</h2>
        <p class="text-gray-600 text-sm">View and manage all user bookings</p>
    </div>

    <!-- Search Bar -->
    <div class="bg-white p-4 rounded-lg shadow-md mb-6">
        <input type="text" 
               id="searchInput" 
               placeholder="🔍 Search by booking ID, user ID, date, or amount..." 
               class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
               onkeyup="filterTable()">
    </div>

    <!-- Bookings Table -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
        <div class="table-container">
            <table class="min-w-full" id="bookingsTable">
                <thead>
                    <tr class="bg-blue-900 text-white">
                        <th class="p-4 text-left">Booking ID</th>
                        <th class="p-4 text-left">User ID</th>
                        <th class="p-4 text-left">Booking Date</th>
                        <th class="p-4 text-left">Time Slot</th>
                        <th class="p-4 text-left">Visitors</th>
                        <th class="p-4 text-left">Total Amount (¥)</th>
                        <th class="p-4 text-left">Created At</th>
                        <th class="p-4 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty bookings}">
                            <tr>
                                <td colspan="8" class="p-8 text-center text-gray-500">
                                    <i class="fas fa-calendar-times text-4xl mb-3 block"></i>
                                    No bookings found.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="booking" items="${bookings}">
                                <tr class="border-b hover:bg-blue-50 transition">
                                    <td class="p-4 font-mono font-semibold text-blue-600">
                                        <i class="fas fa-ticket-alt"></i> #${booking.bookingId}
                                    </td>
                                    <td class="p-4 font-mono">#${booking.userId}</td>
                                    <td class="p-4">
                                        <i class="fas fa-calendar text-gray-500"></i>
                                        ${booking.bookingDate}
                                    </td>
                                    <td class="p-4 text-sm">
                                        <i class="fas fa-clock text-gray-500"></i>
                                        ${booking.timeSlot}
                                    </td>
                                    <td class="p-4">
                                        <i class="fas fa-users text-gray-500"></i>
                                        ${booking.visitorCount}
                                    </td>
                                    <td class="p-4 font-bold text-green-600">
                                        ¥<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" />
                                    </td>
                                    <td class="p-4 text-sm text-gray-600">
                                        <fmt:formatDate value="${booking.createdAt}" pattern="MMM dd, yyyy HH:mm" />
                                    </td>
                                    <td class="p-4">
                                        <div class="flex justify-center space-x-2">
                                            <form action="<c:url value='/admin/bookings' />" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                <button type="submit" 
                                                        class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-sm"
                                                        title="Delete Booking"
                                                        onclick="return confirm('Are you sure you want to delete this booking? This will also delete all associated booking places.')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Summary Stats -->
    <div class="grid grid-cols-4 gap-6 mt-6">
        <div class="bg-blue-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-calendar-check text-4xl text-blue-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-blue-800">${bookings.size()}</h3>
            <p class="text-gray-600">Total Bookings</p>
        </div>
        <div class="bg-green-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-yen-sign text-4xl text-green-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-green-800">
                ¥<fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00" />
            </h3>
            <p class="text-gray-600">Total Revenue</p>
        </div>
        <div class="bg-purple-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-users text-4xl text-purple-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-purple-800">
                ${totalVisitors}
            </h3>
            <p class="text-gray-600">Total Visitors</p>
        </div>
        <div class="bg-yellow-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-calculator text-4xl text-yellow-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-yellow-800">
                ¥<fmt:formatNumber value="${averageBooking}" pattern="#,##0.00" />
            </h3>
            <p class="text-gray-600">Average Booking</p>
        </div>
    </div>

    <!-- Booking Trends Chart Placeholder -->
    <div class="bg-white rounded-lg shadow-md p-6 mt-6">
        <h3 class="text-lg font-semibold text-gray-800 mb-4">
            <i class="fas fa-chart-line"></i> Booking Insights
        </h3>
        <div class="grid grid-cols-2 gap-6">
            <div class="border-l-4 border-blue-500 pl-4">
                <p class="text-gray-600 text-sm">Most Popular Time Slot</p>
                <p class="text-xl font-bold text-gray-800">
                    ${popularTimeSlot}
                </p>
            </div>
            <div class="border-l-4 border-green-500 pl-4">
                <p class="text-gray-600 text-sm">Highest Single Booking</p>
                <p class="text-xl font-bold text-green-600">
                    ¥<fmt:formatNumber value="${maxBooking}" pattern="#,##0.00" />
                </p>
            </div>
        </div>
    </div>

</main>

<script>
    function filterTable() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toUpperCase();
        const table = document.getElementById('bookingsTable');
        const tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) {
            const td = tr[i].getElementsByTagName('td');
            let found = false;
            
            for (let j = 0; j < td.length; j++) {
                if (td[j]) {
                    const txtValue = td[j].textContent || td[j].innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        found = true;
                        break;
                    }
                }
            }
            
            tr[i].style.display = found ? '' : 'none';
        }
    }
</script>

</body>
</html>
