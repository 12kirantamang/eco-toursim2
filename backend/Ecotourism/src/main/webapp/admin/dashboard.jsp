<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="<c:url value='../assets/css/dashboard.css' />">
    <title>Admin Dashboard</title>

</head>

<body>

<header>
    <h1>Admin Dashboard</h1>
    <a href="<c:url value='/auth?action=logout'/>">Logout</a>
</header>

<div class="container">

    <!-- SIDEBAR -->
    <aside>
        <a href="#dashboard">Dashboard</a>
        <a href="#users">Users</a>
        <a href="#places">Places</a>
        <a href="#bookings">Bookings</a>
    </aside>

    <!-- MAIN -->
    <main>

        <!-- DASHBOARD -->
        <section id="dashboard" class="section">
            <h2>Dashboard</h2>
            <div class="card-row">
                <div class="card"><b>Total Users</b><br>${totalUsers}</div>
                <div class="card"><b>Total Places</b><br>${totalPlaces}</div>
                <div class="card"><b>Total Bookings</b><br>${totalBookings}</div>
            </div>
        </section>

        <!-- USERS -->
        <section id="users" class="section">
            <h2>Users</h2>

            <input type="text" placeholder="Search users..."
                   onkeyup="filterTable('usersTable', this.value)">

			<button type="button" class="add-btn" onclick="openAddUserModal()">+ Add User</button>

            <table id="usersTable">
                <tr>
                    <th>ID</th><th>Name</th><th>Email</th>
                    <th>Role</th><th>Status</th><th>Actions</th>
                </tr>

                <c:forEach var="u" items="${users}">
                    <tr>
                        <td>${u.userId}</td>
                        <td>${u.userName}</td>
                        <td>${u.email}</td>
                        <td>${u.role}</td>
                        <td>${u.status}</td>
                        <td class="actions">
                            <!-- Inside <td class="actions"> for edit -->
							<a href="javascript:void(0);" class="edit"
							   onclick="openEditUserModal('${u.userId}', '${u.userName}', '${u.email}', '${u.role}', '${u.status}')">
							    Edit
							</a>

                            <form action="<c:url value='/admin/users'/>"
                                  method="post" style="display:inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${u.userId}">
                                <button class="delete"
                                        onclick="return confirm('Delete user?')">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </section>
        
        <!-- USER MODAL -->
		<div id="userModal" class="modal">
		    <div class="modal-content">
		        <h3 id="modalTitle">Add User</h3>
		
		        <form id="userForm" method="post" action="${pageContext.request.contextPath}/admin/users">
		            <input type="hidden" name="action" id="formAction" value="insert">
		            <input type="hidden" name="userId" id="userId">
		            
		            <!-- Add redirect section -->
    				<input type="hidden" name="redirectSection" value="users">
		
		            <div class="form-group">
		                <label for="userName">Name</label>
		                <input type="text" name="userName" id="userName" placeholder="Enter full name" required>
		            </div>
		
		            <div class="form-group">
		                <label for="email">Email</label>
		                <input type="email" name="email" id="email" placeholder="Enter email" required>
		            </div>
		
		            <div class="form-group">
		                <label for="password">Password</label>
		                <input type="password" name="password" id="password" placeholder="Leave blank to keep old password">
		            </div>
		
		            <div class="form-row">
		                <div class="form-group">
		                    <label for="role">Role</label>
		                    <select name="role" id="role">
		                        <option value="VISITOR">VISITOR</option>
		                        <option value="ADMIN">ADMIN</option>
		                    </select>
		                </div>
		
		                <div class="form-group">
		                    <label for="status">Status</label>
		                    <select name="status" id="status">
		                        <option value="ACTIVE">ACTIVE</option>
		                        <option value="BLOCKED">BLOCK</option>
		                    </select>
		                </div>
		            </div>
		
		            <div class="modal-actions">
		                <button type="submit" class="btn-save">Save</button>
		                <button type="button" class="btn-cancel" onclick="closeUserModal()">Cancel</button>
		            </div>
		        </form>
		
		        <span class="close-modal" onclick="closeUserModal()">&times;</span>
		    </div>
		</div>

        <!-- PLACES -->
        <section id="places" class="section">
            <h2>Places</h2>

            <input type="text" placeholder="Search places..."
                   onkeyup="filterTable('placesTable', this.value)">

            <!-- Add Place Button -->
			<a href="javascript:void(0);" class="add-btn" onclick="openAddPlaceModal()">+ Add Place</a>
							
            <table id="placesTable">
                <tr>
                    <th>ID</th><th>Code</th><th>Name</th>
                    <th>Image</th><th>Price</th><th>Status</th><th>Actions</th>
                </tr>

                <c:forEach var="p" items="${places}">
                    <tr>
                        <td>${p.placeId}</td>
                        <td>${p.placeCode}</td>
                        <td>${p.placeName}</td>
                        <td>
                            <c:if test="${not empty p.imageUrl}">
                                <img src="<c:url value='/assets/img/resources/uploads/${p.imageUrl}'/>"
                                     style="width:60px;height:40px;object-fit:cover;">
                            </c:if>
                            <c:if test="${empty p.imageUrl}">N/A</c:if>
                        </td>
                        <td>$${p.pricePerPerson}</td>
                        <td>${p.status}</td>
                        <td class="actions">
                            
							<a class="edit" href="javascript:void(0);"
							   onclick='openEditPlaceModal({
							       placeId: "${p.placeId}",
							       placeCode: "${p.placeCode}",
							       placeName: "${p.placeName}",
							       description: "${p.description}",
							       pricePerPerson: "${p.pricePerPerson}",
							       status: "${p.status}",
							       imageUrl: "<c:url value='/assets/img/resources/uploads/${p.imageUrl}'/>"
							   })'>
							   Edit
							</a>
							
							<form action="<c:url value='/admin/places'/>"
							      method="post" style="display:inline">
							    <input type="hidden" name="action" value="delete">
							    <input type="hidden" name="id" value="${p.placeId}">
							    <button class="delete"
							            onclick="return confirm('Delete place?')">
							        Delete
							    </button>
							</form>

                        </td>
                    </tr>
                </c:forEach>
            </table>
        </section>
        
        <!-- PLACE MODAL -->
		<div id="placeModal" class="modal">
		    <div class="modal-content">
		        <h3 id="placeModalTitle">Add Place</h3>
		
		        <form id="placeForm" method="post" enctype="multipart/form-data"
		              action="${pageContext.request.contextPath}/admin/places">
		            <input type="hidden" name="action" id="placeFormAction" value="insert">
		            <input type="hidden" name="placeId" id="placeId">
		            <input type="hidden" name="redirectSection" value="places">
		
		            <div class="form-group">
		                <label for="placeCode">Place Code</label>
		                <input type="text" name="placeCode" id="placeCode" placeholder="Enter place code" required>
		            </div>
		
		            <div class="form-group">
		                <label for="placeName">Place Name</label>
		                <input type="text" name="placeName" id="placeName" placeholder="Enter place name" required>
		            </div>
		
		            <div class="form-group">
		                <label for="description">Description</label>
		                <textarea name="description" id="description" placeholder="Enter place description"
		                          rows="3" style="resize:none;"></textarea>
		            </div>
		
		            <div class="form-group">
		                <label for="pricePerPerson">Price Per Person</label>
		                <input type="number" name="pricePerPerson" id="pricePerPerson" placeholder="Enter price" required min="0">
		            </div>
		
		            <div class="form-row">
		                <div class="form-group">
		                    <label for="statusPlace">Status</label>
		                    <select name="status" id="statusPlace">
		                        <option value="AVAILABLE">AVAILABLE</option>
		                        <option value="UNAVAILABLE">UNAVAILABLE</option>
		                    </select>
		                </div>
		
		                <div class="form-group">
		                    <label for="image">Image</label>
		                    <input type="file" name="image" id="image" accept="image/*" onchange="previewPlaceImage(event)">
		                    <img id="imagePreview" src="" alt="Preview" style="display:none; width:120px; margin-top:5px; border-radius:5px;"/>
		                </div>
		            </div>
		
		            <div class="modal-actions">
		                <button type="submit" class="btn-save">Save</button>
		                <button type="button" class="btn-cancel" onclick="closePlaceModal()">Cancel</button>
		            </div>
		        </form>
		
		        <span class="close-modal" onclick="closePlaceModal()">&times;</span>
		    </div>
		</div>
		        
        <!-- BOOKINGS -->
        <section id="bookings" class="section">
            <h2>Bookings</h2>

            <input type="date" onchange="filterBookingByDate(this.value)">

            <table id="bookingsTable">
                <tr>
                    <th>ID</th><th>User</th><th>Date</th>
                    <th>Visitors</th><th>Total</th><th>Action</th>
                </tr>

                <c:forEach var="b" items="${bookings}">
                    <tr>
                        <td>${b.bookingId}</td>
                        <td>${b.userName}</td>
                        <td>${b.bookingDate}</td>
                        <td>${b.visitorCount}</td>
                        <td>$${b.totalAmount}</td>
						<td class="actions">
						    <!-- Detail button (opens modal) -->
						    <a class="detail" href="javascript:void(0);"
							   data-user-name="${b.userName}"
							   data-booking-date="${b.bookingDate}"
							   data-visitors="${b.visitorCount}"
							   data-total="${b.totalAmount}"
							   data-places='${fn:escapeXml(b.bookingPlacesJson)}'
							   onclick="openBookingModalFromElement(this)">
							   Detail
							</a>
						
						    <!-- Delete button -->
						    <form action="<c:url value='/admin/bookings'/>" method="post" style="display:inline">
						        <input type="hidden" name="action" value="delete">
						        <input type="hidden" name="bookingId" value="${b.bookingId}">
						        <button class="delete" onclick="return confirm('Delete this booking?')">Delete</button>
						    </form>
						</td>

                    </tr>
                </c:forEach>
            </table>
        </section>
        
        <!-- BOOKING DETAIL MODAL -->
		<div id="bookingModal" class="modal">
		    <div class="modal-content">
		        <h3>Booking Details</h3>
		
		        <div class="form-group">
		            <label>User:</label>
		            <span id="modalBookingUser"></span>
		        </div>
		
		        <div class="form-group">
		            <label>Booking Date:</label>
		            <span id="modalBookingDate"></span>
		        </div>
		
		        <div class="form-group">
		            <label>Visitors:</label>
		            <span id="modalBookingVisitors"></span>
		        </div>
		
		        <div class="form-group">
		            <label>Total Amount:</label>
		            <span id="modalBookingTotal"></span>
		        </div>
		
		        <div class="form-group">
		            <label>Booked Places:</label>
		            <ul id="modalBookingPlaces"></ul>
		        </div>
		
		        <div class="modal-actions">
		            <button type="button" class="btn-cancel" onclick="closeBookingModal()">Close</button>
		        </div>
		
		        <span class="close-modal" onclick="closeBookingModal()">&times;</span>
		    </div>
		</div>
        
    </main>
</div>


<script src="<c:url value='../assets/js/dashboard.js' />"></script>


</body>
</html>
