<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }

        header {
            background: #2c3e50;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header a {
            color: white;
            text-decoration: none;
            background: #e74c3c;
            padding: 6px 12px;
            border-radius: 4px;
        }

        .container {
            display: flex;
            height: calc(100vh - 60px);
        }

        aside {
            width: 220px;
            background: #34495e;
            color: white;
            padding-top: 20px;
        }

        aside a {
            display: block;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
        }

        aside a:hover {
            background: #2c3e50;
        }

        main {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
        }

        .card-row {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            padding: 20px;
            flex: 1;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
        }

        th {
            background: #ecf0f1;
        }

        tr:hover {
            background: #f1f7ff;
        }

        .actions a,
        .actions button {
            margin-right: 5px;
            padding: 5px 8px;
            border: none;
            border-radius: 3px;
            text-decoration: none;
            color: white;
            cursor: pointer;
            font-size: 13px;
        }

        .edit { background: #3498db; }
        .edit:hover { background: #2e86c1; }

        .delete { background: #e74c3c; }
        .delete:hover { background: #cb4335; }

        .detail { background: #8e44ad; }
        .detail:hover { background: #732d91; }

        .add-btn {
            background: #2ecc71;
            color: white;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            margin-left: 10px;
        }

        .section {
            margin-bottom: 40px;
        }

        input[type="text"], input[type="date"] {
            padding: 6px;
            margin-bottom: 10px;
        }
        
        /* Modal Improvements */
		.modal {
		    display: none;
		    position: fixed;
		    top: 0; left: 0;
		    width: 100%; height: 100%;
		    background: rgba(0,0,0,0.6);
		    z-index: 1000;
		    transition: all 0.3s ease;
		}
		
		.modal-content {
		    background: #fff;
		    width: 450px;
		    max-width: 90%;
		    margin: 80px auto;
		    padding: 25px 30px;
		    border-radius: 10px;
		    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
		    position: relative;
		    animation: slideIn 0.3s ease-out;
		}
		
		@keyframes slideIn {
		    from { transform: translateY(-50px); opacity: 0; }
		    to { transform: translateY(0); opacity: 1; }
		}
		
		.modal-content h3 {
		    margin-top: 0;
		    text-align: center;
		    color: #2c3e50;
		    font-size: 22px;
		    margin-bottom: 20px;
		}
		
		.close-modal {
		    position: absolute;
		    top: 12px;
		    right: 18px;
		    font-size: 25px;
		    color: #999;
		    cursor: pointer;
		    transition: 0.2s;
		}
		
		.close-modal:hover {
		    color: #e74c3c;
		}
		
		.form-group {
		    margin-bottom: 15px;
		    display: flex;
		    flex-direction: column;
		}
		
		.form-group label {
		    font-weight: 600;
		    margin-bottom: 5px;
		    color: #34495e;
		}
		
		.form-group input,
		.form-group select {
		    padding: 10px 12px;
		    border-radius: 6px;
		    border: 1px solid #ccc;
		    font-size: 14px;
		    transition: border-color 0.2s;
		}
		
		.form-group input:focus,
		.form-group select:focus {
		    border-color: #3498db;
		    outline: none;
		}
		
		.form-row {
		    display: flex;
		    gap: 15px;
		}
		
		.modal-actions {
		    text-align: right;
		    margin-top: 20px;
		}
		
		.btn-save {
		    background: #2ecc71;
		    color: white;
		    padding: 8px 18px;
		    border-radius: 5px;
		    border: none;
		    cursor: pointer;
		    font-weight: 600;
		    transition: 0.2s;
		}
		
		.btn-save:hover {
		    background: #27ae60;
		}
		
		.btn-cancel {
		    background: #e74c3c;
		    color: white;
		    padding: 8px 18px;
		    border-radius: 5px;
		    border: none;
		    cursor: pointer;
		    margin-left: 10px;
		    transition: 0.2s;
		}
		
		.btn-cancel:hover {
		    background: #c0392b;
		}
   
    </style>
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
						       onclick='openBookingModal({
						           bookingId: "${b.bookingId}",
						           userId: "${b.userId}",
						           userName: "${b.userName}",
						           bookingDate: "${b.bookingDate}",
						           visitorCount: "${b.visitorCount}",
						           totalAmount: "${b.totalAmount}",
						           places: ${b.bookingPlaces}  // JSON array of booked places
						       })'>
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

<script>

	//FILTER TABLE
	function filterTable(tableId, keyword) {
	    keyword = keyword.toLowerCase();
	    const rows = document.getElementById(tableId).rows;
	    for (let i = 1; i < rows.length; i++) {
	        rows[i].style.display =
	            rows[i].innerText.toLowerCase().includes(keyword) ? "" : "none";
	    }
	}
	
	// FILTER BOOKINGS BY DATE
	function filterBookingByDate(date) {
	    const rows = document.getElementById("bookingsTable").rows;
	    for (let i = 1; i < rows.length; i++) {
	        rows[i].style.display =
	            rows[i].cells[2].innerText.includes(date) ? "" : "none";
	    }
	}
	
	// OPEN MODAL FOR ADD USER
	function openAddUserModal() {
	    document.getElementById('modalTitle').innerText = "Add User";
	    document.getElementById('formAction').value = "insert";
	    document.getElementById('userId').value = "";
	    
	    // Name & Email editable
	    document.getElementById('userName').value = "";
	    document.getElementById('userName').removeAttribute("readonly");
	    document.getElementById('email').value = "";
	    document.getElementById('email').removeAttribute("readonly");

	    // Password placeholder for ADD
	    const passwordInput = document.getElementById('password');
	    passwordInput.value = "";
	    passwordInput.placeholder = "Enter password"; 

	    // Role & Status defaults
	    document.getElementById('role').value = "VISITOR";
	    document.getElementById('status').value = "ACTIVE";

	    document.getElementById('userModal').style.display = "block";
	}

	// OPEN MODAL FOR EDIT USER
	function openEditUserModal(id, name, email, role, status) {
	    document.getElementById('modalTitle').innerText = "Reset User / Update Role";
	    document.getElementById('formAction').value = "update";
	    document.getElementById('userId').value = id;

	    // Name & Email are readonly
	    document.getElementById('userName').value = name;
	    document.getElementById('userName').setAttribute("readonly", true);
	    document.getElementById('email').value = email;
	    document.getElementById('email').setAttribute("readonly", true);

	    // Password placeholder for EDIT
	    const passwordInput = document.getElementById('password');
	    passwordInput.value = "";
	    passwordInput.placeholder = "Leave blank to keep current password"; 

	    // Role & Status
	    document.getElementById('role').value = role;
	    document.getElementById('status').value = status;

	    document.getElementById('userModal').style.display = "block";
	}
	
	// CLOSE MODAL
	function closeUserModal() {
	    document.getElementById('userModal').style.display = "none";
	}
	
	// CLOSE MODAL ON OUTSIDE CLICK
	window.onclick = function(event) {
	    const modal = document.getElementById('userModal');
	    if (event.target === modal) closeUserModal();
	}
	
	// OPTIONAL: CLOSE MODAL ON ESC KEY
	window.addEventListener('keydown', function(e) {
	    if (e.key === "Escape") closeUserModal();
	});
	
	// OPEN MODAL FOR ADD PLACE
    function openAddPlaceModal() {
        document.getElementById('placeModalTitle').innerText = "Add Place";
        document.getElementById('placeFormAction').value = "insert";
        document.getElementById('placeId').value = "";
        document.getElementById('placeCode').value = "";
        document.getElementById('placeName').value = "";
        document.getElementById('description').value = "";
        document.getElementById('pricePerPerson').value = "";
        document.getElementById('statusPlace').value = "AVAILABLE";
        document.getElementById('imagePreview').style.display = "none";
        document.getElementById('imagePreview').src = "";
        document.getElementById('image').value = "";
        document.getElementById('placeModal').style.display = "block";
    }

    // OPEN MODAL FOR EDIT PLACE
    function openEditPlaceModal(place) {
        document.getElementById('placeModalTitle').innerText = "Edit Place";
        document.getElementById('placeFormAction').value = "update";
        document.getElementById('placeId').value = place.placeId;
        document.getElementById('placeCode').value = place.placeCode;
        document.getElementById('placeName').value = place.placeName;
        document.getElementById('description').value = place.description;
        document.getElementById('pricePerPerson').value = place.pricePerPerson;
        document.getElementById('statusPlace').value = place.status;

        if(place.imageUrl) {
            document.getElementById('imagePreview').src = place.imageUrl;
            document.getElementById('imagePreview').style.display = "block";
        } else {
            document.getElementById('imagePreview').style.display = "none";
            document.getElementById('imagePreview').src = "";
        }

        document.getElementById('image').value = "";
        document.getElementById('placeModal').style.display = "block";
    }

    // IMAGE PREVIEW
    function previewPlaceImage(event) {
        const preview = document.getElementById('imagePreview');
        preview.src = URL.createObjectURL(event.target.files[0]);
        preview.style.display = "block";
    }

    // CLOSE MODAL
    function closePlaceModal() {
        document.getElementById('placeModal').style.display = "none";
    }

    // CLOSE MODAL ON OUTSIDE CLICK
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('placeModal');
        if(event.target === modal) closePlaceModal();
    });

    // ESC key to close modal
    window.addEventListener('keydown', function(e) {
        if(e.key === "Escape") closePlaceModal();
    });

 // OPEN BOOKING DETAIL MODAL
    function openBookingModal(booking) {
        document.getElementById('modalBookingUser').innerText = booking.userName || booking.userId;
        document.getElementById('modalBookingDate').innerText = booking.bookingDate;
        document.getElementById('modalBookingVisitors').innerText = booking.visitorCount;
        document.getElementById('modalBookingTotal').innerText = "$" + booking.totalAmount;

        // Clear previous list
        const ul = document.getElementById('modalBookingPlaces');
        ul.innerHTML = "";

        if (booking.places && booking.places.length > 0) {
            booking.places.forEach(place => {
                const li = document.createElement("li");
                li.innerText = place.placeName + " ($" + place.pricePerPerson + ")";
                ul.appendChild(li);
            });
        } else {
            ul.innerHTML = "<li>N/A</li>";
        }

        document.getElementById('bookingModal').style.display = "block";
    }

    // CLOSE MODAL
    function closeBookingModal() {
        document.getElementById('bookingModal').style.display = "none";
    }

    // CLOSE ON OUTSIDE CLICK
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('bookingModal');
        if (event.target === modal) closeBookingModal();
    });

    // ESC KEY CLOSE
    window.addEventListener('keydown', function(e) {
        if (e.key === "Escape") closeBookingModal();
    });



</script>


</body>
</html>
