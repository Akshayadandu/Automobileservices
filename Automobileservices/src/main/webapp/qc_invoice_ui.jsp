<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QC Invoice Entry</title>
<style>
* {
	box-sizing: border-box;
	font-family: "Segoe UI", Arial, sans-serif;
}

body {
	margin: 0;
	background: linear-gradient(135deg, #e8f1ff, #f5f9ff);
	color: #1e293b;
}

.header {
	height: 85px;
	background: #ffffff;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 30px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
}

.logo {
	display: flex;
	align-items: center;
	gap: 14px;
}

.logo img {
	height: 65px;
	max-width: 200px;
	object-fit: contain;
}

.logo strong {
	font-size: 20px;
	color: #1e40af;
	font-weight: 600;
}

.header-right {
	display: flex;
	align-items: center;
	gap: 30px;
}

.timer {
	font-weight: 600;
	font-size: 15px;
	color: #2563eb;
}

.logout {
	background: #2563eb;
	color: #fff;
	border: none;
	padding: 10px 22px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
}

.main {
	padding: 20px;
}

.top-section {
	display: flex;
	gap: 20px;
	height: calc(100vh - 180px);
}

.form-box {
	width: 25%;
	background: #ffffff;
	padding: 22px;
	border-radius: 12px;
	box-shadow: 0 15px 30px rgba(37, 99, 235, 0.15);
	overflow-y: auto;
}

.form-box h3 {
	margin-bottom: 18px;
	color: #1d4ed8;
}

.form-group {
	margin-bottom: 14px;
}

.form-group label {
	font-size: 13px;
	font-weight: 600;
	display: block;
	margin-bottom: 5px;
}

.form-group input {
	width: 100%;
	padding: 10px;
	border-radius: 6px;
	border: 1px solid #c7d2fe;
}

.footer-actions {
	display: flex;
	gap: 12px;
	margin-top: 18px;
}

.action-btn {
	background: #2563eb;
	color: white;
	border: none;
	padding: 8px 18px;
	border-radius: 8px;
	font-size: 13px;
	cursor: pointer;
}

/* IMAGE BOX */
.image-box {
	width: 75%;
	background: #ffffff;
	border-radius: 12px;
	box-shadow: 0 15px 30px rgba(37, 99, 235, 0.15);
	position: relative;
	display: flex;
	flex-direction: column;
	overflow: visible;
}

/* IMAGE CONTAINER */
.image-container {
	flex: 1;
	overflow: auto;
	position: relative;
	background: #f8fafc;
	border: 2px dashed #cbd5e1;
	border-radius: 8px;
	margin: 10px;
}

/* INVOICE ID BADGE */
.invoice-id-badge {
	position: absolute;
	top: 10px;
	left: 10px;
	background: rgba(37, 99, 235, 0.95);
	color: #fff;
	padding: 6px 10px;
	border-radius: 6px;
	font-size: 12px;
	font-weight: 600;
	z-index: 10;
	width: fit-content;
}

/* IMAGE WRAPPER */
.image-wrapper {
	position: relative;
	display: inline-block;
	padding: 20px;
}

/* IMAGE STYLES */
.invoice-img {
	display: block;
	transform-origin: 0 0;
	transition: transform 0.2s ease;
	cursor: move;
	user-select: none;
	-webkit-user-drag: none;
	max-width: none;
}

/* ZOOM CONTROLS */
.zoom-controls {
	position: absolute;
	bottom: 18px;
	right: 20px;
	display: flex;
	gap: 8px;
	z-index: 50;
	background: rgba(255, 255, 255, 0.95);
	padding: 10px;
	border-radius: 10px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
	border: 1px solid #e2e8f0;
}

.zoom-btn {
	width: 42px;
	height: 42px;
	border-radius: 8px;
	background: #2563eb;
	color: white;
	font-size: 20px;
	font-weight: bold;
	border: none;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.2s ease;
}

.zoom-btn:hover:not(:disabled) {
	background: #1d4ed8;
	transform: translateY(-2px);
}

.zoom-btn:active {
	transform: translateY(0);
}

.zoom-btn:disabled {
	background: #94a3b8;
	cursor: not-allowed;
	opacity: 0.6;
}

.zoom-display {
	display: flex;
	align-items: center;
	padding: 0 12px;
	font-weight: 700;
	color: #1e293b;
	font-size: 15px;
	min-width: 70px;
	justify-content: center;
	background: #f1f5f9;
	border-radius: 6px;
	border: 1px solid #cbd5e1;
}

/* DRAGGABLE IMAGE */
.draggable {
	cursor: grab;
}

.draggable:active {
	cursor: grabbing;
}

.table-box {
	margin-top: 25px;
	background: #ffffff;
	padding: 15px;
	border-radius: 12px;
	box-shadow: 0 15px 30px rgba(37, 99, 235, 0.15);
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 900px;
}

th {
	background: #2563eb;
	color: white;
	padding: 10px;
	font-size: 14px;
}

td {
	border: 1px solid #e2e8f0;
	padding: 8px;
}

td input {
	width: 100%;
	padding: 7px;
	border-radius: 4px;
	border: 1px solid #c7d2fe;
}

td input:disabled {
	background-color: #e5e7eb;
	color: #475569;
	font-weight: 600;
	cursor: not-allowed;
}

.action-cell {
	display: flex;
	gap: 6px;
	justify-content: center;
}

.row-btn {
	background: #2563eb;
	color: white;
	border: none;
	padding: 6px 10px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 12px;
}

input[type=number]::-webkit-inner-spin-button,
input[type=number]::-webkit-outer-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

input[type=number] {
    -moz-appearance: textfield;
}

/* STATUS BADGES */
.status-badge {
	display: inline-block;
	padding: 5px 10px;
	border-radius: 5px;
	font-size: 12px;
	font-weight: 600;
	margin-left: 10px;
}

.status-completed {
	background: #16a34a;
	color: white;
}

.status-skipped {
	background: #dc2626;
	color: white;
}

/* CHECKBOX STYLE */
.checkbox-group {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-top: 10px;
}

.checkbox-group input[type="checkbox"] {
	width: 18px;
	height: 18px;
	accent-color: #2563eb;
}

.checkbox-group label {
	font-size: 13px;
	font-weight: 600;
	color: #1e293b;
	cursor: pointer;
}

/* SKIP MODAL */
.skip-overlay {
	display: none;
	position: fixed;
	inset: 0;
	background: rgba(15, 23, 42, 0.55);
	backdrop-filter: blur(4px);
	z-index: 9999;
	align-items: center;
	justify-content: center;
}

.skip-card {
	width: 380px;
	background: #ffffff;
	border-radius: 14px;
	box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
	overflow: hidden;
	animation: pop 0.25s ease-out;
}

@keyframes pop {
	from { transform: scale(0.9); opacity: 0; }
	to { transform: scale(1); opacity: 1; }
}

.skip-header {
	background: #2563eb;
	color: #fff;
	padding: 14px 18px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.skip-header h3 {
	margin: 0;
	font-size: 16px;
}

.skip-close {
	cursor: pointer;
	font-size: 22px;
	line-height: 1;
}

.skip-body {
	padding: 20px;
}

.skip-body .form-group {
	margin-bottom: 16px;
}

.skip-body input, .skip-body textarea {
	width: 100%;
	padding: 10px;
	border-radius: 8px;
	border: 1px solid #c7d2fe;
	font-family: inherit;
}

.skip-body textarea {
	min-height: 80px;
	resize: vertical;
}

.skip-footer {
	padding: 16px 20px;
	display: flex;
	gap: 12px;
}

.skip-footer button {
	flex: 1;
	padding: 10px;
	border-radius: 8px;
	border: none;
	cursor: pointer;
	font-weight: 600;
}

.btn-confirm {
	background: #2563eb;
	color: #fff;
}

.btn-confirm:hover {
	background: #1e40af;
}

.btn-cancel {
	background: #e5e7eb;
	color: #334155;
}

.btn-cancel:hover {
	background: #cbd5f5;
}

.skip-error {
	color: #dc2626;
	font-size: 13px;
	display: none;
	margin-top: 5px;
}

/* MESSAGES */
.success-msg {
	background: #d4edda;
	color: #155724;
	padding: 10px;
	border-radius: 5px;
	margin-bottom: 15px;
	border: 1px solid #c3e6cb;
}

.error-msg {
	background: #f8d7da;
	color: #721c24;
	padding: 10px;
	border-radius: 5px;
	margin-bottom: 15px;
	border: 1px solid #f5c6cb;
}

/* RESPONSIVE */
@media (max-width: 1200px) {
	.top-section {
		flex-direction: column;
		height: auto;
	}
	.form-box, .image-box {
		width: 100%;
	}
	.image-box {
		height: 500px;
	}
}

@media (max-width: 768px) {
	.row-btn {
		padding: 5px 8px;
		font-size: 11px;
	}
	th, td {
		font-size: 12px;
	}
	.zoom-controls {
		bottom: 10px;
		right: 10px;
		padding: 8px;
		gap: 5px;
	}
	.zoom-btn {
		width: 35px;
		height: 35px;
		font-size: 16px;
	}
	.zoom-display {
		min-width: 60px;
		font-size: 13px;
		padding: 0 8px;
	}
}
</style>
</head>

<body>
	<div class="header">
		<div class="logo">
			<img src="<%=request.getContextPath()%>/images/dreams-soft-logo.jpeg">
			<strong>Dreams Soft Solutions</strong>
		</div>
		<div class="header-right">
			<div class="timer" id="timer">Time: --</div>
			<div class="user-info">
				Welcome, <strong><%=session.getAttribute("username")%></strong>
			</div>
			<a href="logout"><button class="logout">Logout</button></a>
		</div>
	</div>

	<div class="main">
		<%
		// Show messages
		String success = request.getParameter("success");
		String error = request.getParameter("error");

		if (success != null) {
		%>
		<div class="success-msg">
			<%=success%>
		</div>
		<%
		}
		if (error != null) {
		%>
		<div class="error-msg">
			<%=error%>
		</div>
		<%
		}
		%>

		<%
		String user = (String) session.getAttribute("username");
		String mode = (String) session.getAttribute("mode");

		/* ❌ Not logged in */
		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		/* ❌ Trying to access QC directly */
		if (!"qc".equals(mode)) {
			response.sendRedirect("home.jsp?error=Unauthorized+QC+access");
			return;
		}
		%>

		<%
		String qcUser = (String) session.getAttribute("username");
		Integer imageId = null;
		String imagePath = null;
		String vcStatus = null;
		
		String[] itemNo = null;
		String[] itemName = null;
		String[] qty = null;
		String[] price = null;
		String[] cgst = null;
		String[] sgst = null;
		String[] total = null;

		if (qcUser == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		try {
			com.db.Dbconnection db = new com.db.Dbconnection();
			java.sql.Connection con = db.getConnection();

			PreparedStatement ps = null;
			ResultSet rs = null;

			/* =====================================================
			   1️⃣ LOAD ALREADY ASSIGNED QC IMAGE (REFRESH SAFE)
			   ===================================================== */
			ps = con.prepareStatement(
				"SELECT image_id, image_path, status FROM invoice_images " +
				"WHERE assigned_to_qc = ? AND status = 'qc_in_progress' LIMIT 1");
			ps.setString(1, qcUser);
			rs = ps.executeQuery();

			if (rs.next()) {
				imageId = rs.getInt("image_id");
				imagePath = rs.getString("image_path");
				vcStatus = rs.getString("status");
			}

			rs.close();
			ps.close();

			/* =====================================================
			   2️⃣ IF NONE ASSIGNED → FETCH NEW COMPLETED IMAGE
			   ===================================================== */
			if (imageId == null) {
				ps = con.prepareStatement(
					"SELECT image_id, image_path, status FROM invoice_images " +
					"WHERE status IN ('completed', 'skipped') AND assigned_to_qc IS NULL " +
					"ORDER BY verify_end_time LIMIT 1");
				rs = ps.executeQuery();

				if (rs.next()) {
					imageId = rs.getInt("image_id");
					imagePath = rs.getString("image_path");
					vcStatus = rs.getString("status");

					PreparedStatement ups = con.prepareStatement(
						"UPDATE invoice_images SET assigned_to_qc=?, status='qc_in_progress' " +
						"WHERE image_id=? AND assigned_to_qc IS NULL");
					ups.setString(1, qcUser);
					ups.setInt(2, imageId);
					ups.executeUpdate();
					ups.close();
				}

				rs.close();
				ps.close();
			}

			/* =====================================================
			   3️⃣ LOAD ITEMS ONLY IF IMAGE EXISTS
			   ===================================================== */
			if (imageId != null) {
				ps = con.prepareStatement(
					"SELECT item_no, item_name, quantity, price, cgst, sgst, item_total " +
					"FROM invoice_details WHERE image_id=? LIMIT 1"
				);
				ps.setInt(1, imageId);
				rs = ps.executeQuery();

				if (rs.next()) {
					itemNo   = rs.getString("item_no").split(",");
					itemName = rs.getString("item_name").split(",");
					qty      = rs.getString("quantity").split(",");
					price    = rs.getString("price").split(",");
					cgst     = rs.getString("cgst").split(",");
					sgst     = rs.getString("sgst").split(",");
					total    = rs.getString("item_total").split(",");
				}

				rs.close();
				ps.close();
			}

			con.close();

			session.setAttribute("imageId", imageId);
			session.setAttribute("imagePath", imagePath);
			session.setAttribute("vcStatus", vcStatus);

		} catch (Exception e) {
			out.println("<div class='error-msg'>Error: " + e.getMessage() + "</div>");
		}

		if (imagePath == null) {
		%>
		<div style="text-align: center; padding: 50px;">
			<h2>No invoices to process</h2>
			<p>All invoices have been processed.</p>
			<p>click on logout</p>
		</div>
		<%
			return;
		}
		%>

		<form id="invoiceForm" method="post" action="QcSubmitServlet">
			<input type="hidden" name="imageId" value="<%= imageId %>">
			<input type="hidden" name="actionType" id="actionType">
			<input type="hidden" name="tlUsername" id="tlUsername">
			<input type="hidden" name="tlPassword" id="tlPassword">
			<input type="hidden" name="skipReasonHidden" id="skipReasonHidden">
			
			<div class="top-section">
				<div class="form-box">
					<h3>QC Invoice Details</h3>
					<div class="form-group">
						<label>Vendor Name</label>
						<input type="text" name="vendorName" class="freeze-field" required>
					</div>
					<div class="form-group">
						<label>Invoice Number</label>
						<input type="text" name="invoiceNumber" class="freeze-field" required>
					</div>
					<div class="form-group">
						<label>Invoice Issue Date</label>
						<input type="text" name="invoiceDate" class="freeze-field" required>
					</div>
					<div class="form-group">
						<label>P.O.#</label>
						<input type="text" name="poNumber" class="freeze-field" required>
					</div>
					<div class="form-group">
						<label>Invoice Total (&#8377;)</label>
						<input type="text" name="invoiceTotal" class="freeze-field" required>
					</div>
					
					<div class="checkbox-group">
						<input type="checkbox" id="imgNotClearChk" onclick="toggleSkipbtn()">
						<label for="imgNotClearChk">Please select "Image is not clear" before skipping.</label>
					</div>
					
					<div class="footer-actions">
						<button class="action-btn" type="button" onclick="editForm(this)">Edit</button>
						<button class="action-btn" type="button" id="Skipbtn" onclick="openSkipModal()" disabled>Skip</button>
						<button type="submit" class="action-btn" name="actionStatus" value="submit">Submit</button>
					</div>
				</div>

				<div class="image-box">
					<!-- Image Container with Scroll -->
					<div class="image-container">
						<!-- Invoice ID Badge -->
						<div class="invoice-id-badge">
							Invoice ID: <%= imageId %>
							<% if ("completed".equals(vcStatus)) { %>
								<span class="status-badge status-completed">VC COMPLETED</span>
							<% } else if ("skipped".equals(vcStatus)) { %>
								<span class="status-badge status-skipped">VC SKIPPED</span>
							<% } %>
						</div>
						
						<!-- Image Wrapper -->
						<div class="image-wrapper">
							<!-- Invoice Image -->
							<img id="invoiceImage"
								src="<%= request.getContextPath() %>/invoice_images/<%= imagePath %>"
								class="invoice-img draggable" alt="Invoice"
								onerror="this.src='<%= request.getContextPath() %>/images/sample-invoice.png'">
						</div>
					</div>
					<!-- Zoom Controls -->
					<div class="zoom-controls">
						<button type="button" class="zoom-btn" id="zoomOutBtn" onclick="zoomOut()">-</button>
						<div class="zoom-display" id="zoomLevelDisplay">100%</div>
						<button type="button" class="zoom-btn" id="zoomInBtn" onclick="zoomIn()">+</button>
					</div>
				</div>
			</div>

			<div class="table-box">
			
				<table id="invoiceTable">
				
					
					<thead>
						<tr>
							<th>Item No</th>
							<th>Item Name</th>
							<th>Quantity</th>
							<th>Price (&#8377;)</th>
							<th>CGST (%)</th>
							<th>SGST (%)</th>
							<th>Total (&#8377;)</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (itemName != null) {
							for (int i = 0; i < itemName.length; i++) {
						%>
						<tr class="item-row">
							<td><input class="itemNo" type="number" name="itemNo[]" value="<%= itemNo[i] %>" disabled></td>
							<td><input class="itemName" type="text" name="itemName[]" value="<%= itemName[i] %>" disabled></td>
							<td><input class="quantity" type="number" name="quantity[]" value="<%= qty[i] %>" oninput="calculateRowTotal(this)" disabled></td>
							<td><input class="price" type="number" name="itemPrice[]" value="<%= price[i]%>" oninput="calculateRowTotal(this)" disabled></td>
							<td><input class="itemCGST" type="number" name="itemCGST[]" value="<%=cgst[i]%>" oninput="calculateRowTotal(this)" disabled></td>
							<td><input class="itemSGST" type="number" name="itemSGST[]" value="<%= sgst[i]%>" oninput="calculateRowTotal(this)" disabled></td>
							<td><input class="itemTotal" type="number" name="itemTotal[]" value="<%=total[i] %>" readonly disabled></td>
							<td class="action-cell">
								<button type="button" class="row-btn" onclick="addRow(this)">Add</button>
								<button type="button" class="row-btn" onclick="editRow(this)">Edit</button>
								<button type="button" class="row-btn" onclick="deleteRow(this)">Delete</button>
							</td>
						</tr>
						<%
							}
						} else {
						%>
						<tr class="item-row">
							<td><input class="itemNo" type="number" name="itemNo[]" placeholder="001"></td>
							<td><input class="itemName" type="text" name="itemName[]" placeholder="Item Description"></td>
							<td><input class="quantity" type="number" name="quantity[]" placeholder="0" oninput="calculateRowTotal(this)"></td>
							<td><input class="price" type="number" name="itemPrice[]" placeholder="0.00" oninput="calculateRowTotal(this)"></td>
							<td><input class="itemCGST" type="number" name="itemCGST[]" placeholder="0" oninput="calculateRowTotal(this)"></td>
							<td><input class="itemSGST" type="number" name="itemSGST[]" placeholder="0" oninput="calculateRowTotal(this)"></td>
							<td><input class="itemTotal" type="number" name="itemTotal[]" readonly></td>
							<td class="action-cell">
								<button type="button" class="row-btn" onclick="addRow(this)">Add</button>
								<button type="button" class="row-btn" onclick="editRow(this)">Edit</button>
								<button type="button" class="row-btn" onclick="deleteRow(this)">Delete</button>
							</td>
						</tr>
						<%
						}
						%>
						<tr id="subTotalRow">
							<td colspan="6" style="text-align: right; font-weight: 600;">Sub Total</td>
							<td><input id="subTotal" name="subTotal" readonly></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>

	<!-- Skip Modal -->
	<div id="skipModal" class="skip-overlay">
		<div class="skip-card">
			<div class="skip-header">
				<h3>Skip Authentication</h3>
				<span class="skip-close" onclick="closeSkipModal()">&times;</span>
			</div>
			<div class="skip-body">
				<div class="form-group">
					<label>Reason for Skip</label>
					<textarea id="skipReason" rows="3" placeholder="Enter reason after TL approval" disabled></textarea>
				</div>
				<div class="form-group">
					<label>Username</label>
					<input type="text" id="skipUsername" placeholder="Enter username">
				</div>
				<div class="form-group">
					<label>Password</label>
					<input type="password" id="skipPassword" placeholder="Enter password">
				</div>
				<div id="skipError" class="skip-error">Invalid username or password</div>
			</div>
			<div class="skip-footer">
				<button class="btn-confirm" type="button" id="confirmSkipBtn" onclick="validateSkip()">
					Confirm Skip
				</button>
				<button class="btn-cancel" type="button" onclick="closeSkipModal()">
					Cancel
				</button>
			</div>
		</div>
	</div>

	<script>
	// ========== ZOOM FUNCTIONALITY ==========
	let zoomLevel = 1;
	const MIN_ZOOM = 0.3;
	const MAX_ZOOM = 3;

	function zoomIn() {
	    const img = document.getElementById("invoiceImage");
	    if (!img) {
	        alert("Image not found");
	        return;
	    }
	    
	    if (zoomLevel < MAX_ZOOM) {
	        zoomLevel += 0.1;
	        zoomLevel = Math.min(zoomLevel, MAX_ZOOM);
	        img.style.transform = "scale(" + zoomLevel + ")";
	        updateZoomDisplay();
	        updateZoomButtons();
	    }
	}

	function zoomOut() {
	    const img = document.getElementById("invoiceImage");
	    if (!img) {
	        alert("Image not found");
	        return;
	    }
	    
	    if (zoomLevel > MIN_ZOOM) {
	        zoomLevel -= 0.1;
	        zoomLevel = Math.max(zoomLevel, MIN_ZOOM);
	        img.style.transform = "scale(" + zoomLevel + ")";
	        updateZoomDisplay();
	        updateZoomButtons();
	    }
	}

	function updateZoomDisplay() {
	    const display = document.getElementById('zoomLevelDisplay');
	    if (display) {
	        display.textContent = Math.round(zoomLevel * 100) + '%';
	    }
	}

	function updateZoomButtons() {
	    const zoomInBtn = document.getElementById('zoomInBtn');
	    const zoomOutBtn = document.getElementById('zoomOutBtn');
	    
	    if (zoomInBtn) {
	        zoomInBtn.disabled = zoomLevel >= MAX_ZOOM;
	        zoomInBtn.style.opacity = zoomLevel >= MAX_ZOOM ? '0.5' : '1';
	    }
	    
	    if (zoomOutBtn) {
	        zoomOutBtn.disabled = zoomLevel <= MIN_ZOOM;
	        zoomOutBtn.style.opacity = zoomLevel <= MIN_ZOOM ? '0.5' : '1';
	    }
	}

	// Mouse wheel zoom
	function setupMouseWheelZoom() {
	    const container = document.querySelector('.image-container');
	    if (!container) return;
	    
	    container.addEventListener('wheel', function(e) {
	        if (e.ctrlKey) {
	            e.preventDefault();
	            if (e.deltaY < 0) {
	                zoomIn();
	            } else {
	                zoomOut();
	            }
	        }
	    }, { passive: false });
	}

	// Initialize zoom
	function initZoom() {
	    updateZoomDisplay();
	    updateZoomButtons();
	    setupMouseWheelZoom();
	}

	// ========== TABLE FUNCTIONS ==========
	function calculateRowTotal(el) {
		const row = el.closest("tr");
		const qty = parseFloat(row.querySelector(".quantity").value) || 0;
		const price = parseFloat(row.querySelector(".price").value) || 0;
		const cgst = parseFloat(row.querySelector(".itemCGST").value) || 0;
		const sgst = parseFloat(row.querySelector(".itemSGST").value) || 0;

		const baseAmount = qty * price;
		const gstAmount = baseAmount * (cgst + sgst) / 100;
		const total = baseAmount + gstAmount;

		row.querySelector(".itemTotal").value = total.toFixed(2);
		calculateSubTotal();
	}

	function calculateSubTotal() {
		let sum = 0;
		document.querySelectorAll("#invoiceTable .item-row").forEach(row => {
			const val = parseFloat(row.cells[6].children[0].value) || 0;
			sum += val;
		});
		document.getElementById("subTotal").value = sum.toFixed(2);
	}

	function addRow(btn) {
		const row = btn.closest("tr");
		const inputs = row.querySelectorAll("input");

		for (let i of inputs) {
			if (!i.value.trim()) {
				alert("Fill all fields before adding");
				return;
			}
		}

		inputs.forEach(i => i.disabled = true);

		const newRow = row.cloneNode(true);
		newRow.classList.add("item-row");

		newRow.querySelectorAll("input").forEach(i => {
			i.value = "";
			i.disabled = false;
		});

		const table = document.getElementById("invoiceTable");
		const subtotalRow = document.getElementById("subTotalRow");

		subtotalRow.remove();
		table.appendChild(newRow);
		table.appendChild(subtotalRow);
	}

	function deleteRow(button) {
		const row = button.closest("tr");
		const totalItemRows = document.querySelectorAll(".row-btn[onclick^='deleteRow']").length;

		if (totalItemRows <= 1) {
			alert("At least one item row is required.");
			return;
		}

		row.remove();
		calculateSubTotal();

		const rows = document.querySelectorAll("tr.item-row");
		rows.forEach(r => {
			const addBtn = r.querySelector("button[onclick^='addRow']");
			if (addBtn) addBtn.disabled = false;
		});
	}

	function editRow(btn) {
		const row = btn.closest(".item-row");
		const inputs = row.querySelectorAll("input");

		if (btn.innerText === "Edit") {
			inputs.forEach(i => {
				if (!i.classList.contains("itemTotal")) {
					i.disabled = false;
				}
			});
			btn.innerText = "Save";
			btn.style.background = "#16a34a";
		} else {
			inputs.forEach(i => i.disabled = true);
			btn.innerText = "Edit";
			btn.style.background = "#2563eb";
			calculateSubTotal();
		}
	}

	function editForm(btn) {
		const freezeInputs = document.querySelectorAll(".freeze-field");

		if (btn.innerText === "Edit") {
			freezeInputs.forEach(i => i.disabled = true);
			btn.innerText = "Save";
			btn.style.background = "#16a34a";
		} else {
			freezeInputs.forEach(i => i.disabled = false);
			btn.innerText = "Edit";
			btn.style.background = "#2563eb";
		}
	}

	// ========== SKIP FUNCTIONALITY ==========
	function toggleSkipbtn() {
		const chk = document.getElementById("imgNotClearChk");
		const Skipbtn = document.getElementById("Skipbtn");
		Skipbtn.disabled = !chk.checked;
	}

	function openSkipModal() {
		const chk = document.getElementById("imgNotClearChk");

		if (!chk.checked) {
			alert("Please click on the 'Image is not clear' checkbox before skipping.");
			return;
		}

		document.getElementById("skipModal").style.display = "flex";
	}

	function closeSkipModal() {
		document.getElementById("skipModal").style.display = "none";
		document.getElementById("skipUsername").value = "";
		document.getElementById("skipPassword").value = "";
		document.getElementById("skipReason").value = "";
		document.getElementById("skipReason").disabled = true;
		document.getElementById("skipError").style.display = "none";
		
		// Reset button action
		const btn = document.getElementById("confirmSkipBtn");
		btn.onclick = validateSkip;
	}

	function validateSkip() {
		const user = document.getElementById("skipUsername").value.trim();
		const pass = document.getElementById("skipPassword").value.trim();
		const reasonBox = document.getElementById("skipReason");
		const err = document.getElementById("skipError");
		const btn = document.getElementById("confirmSkipBtn");

		if (!user || !pass) {
			err.innerText = "Enter TL credentials";
			err.style.display = "block";
			return;
		}

		// ✅ STATIC TL CHECK
		if (user === "dreams" && pass === "dreams") {
			err.style.display = "none";

			// 🔓 enable reason
			reasonBox.disabled = false;
			reasonBox.focus();

			// 🔁 CHANGE BUTTON ACTION
			btn.onclick = confirmQcSkip;

			alert("TL authenticated. Please enter reason.");
		} else {
			err.innerText = "Invalid TL credentials";
			err.style.display = "block";
		}
	}

	function confirmQcSkip() {
		const reason = document.getElementById("skipReason").value.trim();
		const user = document.getElementById("skipUsername").value.trim();
		const pass = document.getElementById("skipPassword").value.trim();

		if (!reason) {
			alert("Reason is mandatory for QC Skip");
			return;
		}

		// hidden fields
		document.getElementById("actionType").value = "qcSkip";
		document.getElementById("tlUsername").value = user;
		document.getElementById("tlPassword").value = pass;
		document.getElementById("skipReasonHidden").value = reason;

		// 🔥 CHANGE ACTION TO QC SKIP SERVLET
		const form = document.getElementById("invoiceForm");
		form.action = "QcSkipServlet";
		form.submit();
	}

	// ========== FORM VALIDATION ==========
	document.getElementById("invoiceForm").addEventListener("submit", function (e) {
		document.getElementById("actionType").value = "submit";
		
		// enable disabled inputs before submit
		this.querySelectorAll("input:disabled").forEach(i => i.disabled = false);

		/* ===== DATE VALIDATION ===== */
		const dateInput = document.querySelectorAll(".form-box .freeze-field")[2].value.trim();

		if (!dateInput) {
			alert("Please enter Invoice Issue Date.");
			e.preventDefault();
			return;
		}

		const datePattern = /^(\d{2})-(\d{2})-(\d{4})$/;
		if (!datePattern.test(dateInput)) {
			alert("Invoice Date must be in DD-MM-YYYY format.");
			e.preventDefault();
			return;
		}

		const parts = dateInput.split("-");
		const enteredDate = new Date(parts[2], parts[1] - 1, parts[0]);

		if (
			enteredDate.getDate() != parts[0] ||
			enteredDate.getMonth() != parts[1] - 1 ||
			enteredDate.getFullYear() != parts[2]
		) {
			alert("Invalid Invoice Date.");
			e.preventDefault();
			return;
		}

		const today = new Date();
		today.setHours(0, 0, 0, 0);

		if (enteredDate > today) {
			alert("Invoice Date cannot be a future date.");
			e.preventDefault();
			return;
		}

		/* ===== TOTAL VALIDATION ===== */
		const invoiceTotal = parseFloat(document.querySelectorAll(".form-box .freeze-field")[4].value);
		const subTotal = parseFloat(document.getElementById("subTotal").value);

		if (isNaN(invoiceTotal) || isNaN(subTotal)) {
			alert("Invoice Total and Item totals are required.");
			e.preventDefault();
			return;
		}

		if (invoiceTotal.toFixed(2) !== subTotal.toFixed(2)) {
			alert(
				"Invoice Total and Item Sub Total must match.\n\n" +
				"Invoice Total: ₹" + invoiceTotal.toFixed(2) + "\n" +
				"Sub Total: ₹" + subTotal.toFixed(2)
			);
			e.preventDefault();
			return;
		}

		// ✅ All validations passed → submit allowed
	});

	// ========== INITIALIZATION ==========
	document.addEventListener("DOMContentLoaded", function() {
	    calculateSubTotal();
	    startTimer();
	    
	    // Initialize zoom display and buttons
	    updateZoomDisplay();
	    updateZoomButtons();
	    
	    // Initialize zoom after image loads
	    const img = document.getElementById('invoiceImage');
	    if (img.complete) {
	        initZoom();
	    } else {
	        img.addEventListener('load', initZoom);
	    }
	    
	    // Auto-focus vendor name
	    setTimeout(() => {
	        const vendorName = document.getElementById("vendorName");
	        if (vendorName) vendorName.focus();
	    }, 100);
	});
	// Auto release on unload
	window.addEventListener("beforeunload", function () {
		navigator.sendBeacon("<%=request.getContextPath()%>/qcAutoRelease");
	});
	</script>
</body>
</html>