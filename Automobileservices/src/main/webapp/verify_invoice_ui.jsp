<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify Invoice Entry</title>
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

@media ( max-width : 1200px) {
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

@media ( max-width : 768px) {
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
	}
	.zoom-btn {
		width: 35px;
		height: 35px;
		font-size: 16px;
	}
}

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
</style>
</head>

<body>

	<div class="header">
		<div class="logo">
			<img
				src="<%= request.getContextPath() %>/images/dreams-soft-logo.jpeg">
			<strong>Dreams Soft Solutions</strong>
		</div>
		<div class="header-right">
			<div class="timer" id="timer">Time: 00:00:00</div>
			<div class="user-info">
				Welcome, <strong><%= session.getAttribute("username") %></strong>
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
			<%= success %>
		</div>
		<% 
        }
        if (error != null) {
    %>
		<div class="error-msg">
			<%= error %>
		</div>
		<% 
        }
    %>

		<% 
        String username = (String) session.getAttribute("username");
		String mode = (String) session.getAttribute("mode");
		
        String imagePath = null;
        Integer imageId = null;
        String timeTaken = "0.00";
        
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if ("qc".equals(mode)) {
            response.sendRedirect("home.jsp?error=Finish+QC+first");
            return;
        }
        
        try {
            com.db.Dbconnection db = new com.db.Dbconnection();
            java.sql.Connection conn = db.getConnection();
            
            // Get image for user
            String sql = "SELECT image_id, image_path FROM invoice_images WHERE assigned_to_user = ? AND status = 'in_progress' LIMIT 1";
            java.sql.PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            java.sql.ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                imageId = rs.getInt("image_id");
                imagePath = rs.getString("image_path");
                int totalSeconds = rs.getInt("verify_duration_seconds");
                if (rs.wasNull()) {
                    totalSeconds = 0;
                }

                int minutes = totalSeconds / 60;
                int secondsLeft = totalSeconds % 60;

                timeTaken = minutes + "." + String.format("%02d", secondsLeft);
            } else {
                // Assign new image
                String assignSql = "SELECT image_id, image_path FROM invoice_images WHERE status = 'pending' LIMIT 1";
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet assignRs = stmt.executeQuery(assignSql);
                
                if (assignRs.next()) {
                    imageId = assignRs.getInt("image_id");
                    imagePath = assignRs.getString("image_path");
                    
                    // Assign to user
                    String updateSql = "UPDATE invoice_images SET assigned_to_user = ?, status = 'in_progress', verify_start_time = NOW() WHERE image_id = ?";
                    java.sql.PreparedStatement updatePs = conn.prepareStatement(updateSql);
                    updatePs.setString(1, username);
                    updatePs.setInt(2, imageId);
                    updatePs.executeUpdate();
                    updatePs.close();
                }
                assignRs.close();
                stmt.close();
            }
            rs.close();
            ps.close();
            conn.close();
            
        } catch (Exception e) {
            out.println("<div class='error-msg'>Error: " + e.getMessage() + "</div>");
        }
        
        if (imagePath == null) {
    %>
		<div style="text-align: center; padding: 50px;">
			<h2>No invoices to process</h2>
			<p>All invoices have been processed.</p>
			<p>
				click on logout 
			</p>
		</div>
		<%
            return;
        }
    %>

		<form id="verifyForm" method="post" action="SimpleVerifyServlet">
			<input type="hidden" name="imageId" value="<%= imageId %>">

			<div class="top-section">
				<div class="form-box">
					<h3>Verify Invoice Details</h3>

					<div class="form-group">
						<label>Vendor Name *</label> <input type="text" name="vendorName"
							id="vendorName" required>
					</div>

					<div class="form-group">
						<label>Invoice Number *</label> <input type="text"
							name="invoiceNumber" id="invoiceNumber" required>
					</div>

					<div class="form-group">
						<label>Invoice Issue Date</label> <input type="text"
							name="invoiceDate" id="invoiceDate">
					</div>

					<div class="form-group">
						<label>P.O.#</label> <input type="text" name="poNumber"
							id="poNumber">
					</div>

					<div class="form-group">
						<label>Invoice Total (&#8377;)</label> <input type="number"
							name="invoiceTotal" id="invoiceTotal" step="0.01"
							onchange="calculateSubTotal();">
					</div>
					<div style="margin-top: 10px;">
						<input type="checkbox" id="imgNotClearChk"
							onclick="toggleSkipbtn()"> <label for="imgNotClearChk"
							style="font-size: 13px; font-weight: 600;">Please select "Image is not clear" before skipping.</label>
					</div>


					<div class="footer-actions">
						<button class="action-btn" type="button" id="Skipbtn"
							onclick="skipInvoice()">Skip</button>
						<button type="button" class="action-btn" id="holdBtn"
							onclick="toggleHold()">Hold</button>
						<button type="submit" name="actionStatus" value="submit"
							class="action-btn">Submit</button>

					</div>
				</div>

				<div class="image-box">
					<div class="image-container">
						<div class="invoice-id-badge">
							Invoice ID: <%= imageId %>
						</div>
						
						<div class="image-wrapper">
							<img id="invoiceImage"
								src="<%= request.getContextPath() %>/invoice_images/<%= imagePath %>"
								class="invoice-img draggable" alt="Invoice"
								onerror="this.src='<%= request.getContextPath() %>/images/sample-invoice.png'">
						</div>
					</div>
							<div class="zoom-controls">
						<button type="button" class="zoom-btn" id="zoomOutBtn" onclick="zoomOut()">-</button>
						<div class="zoom-display" id="zoomLevelDisplay">25%</div>
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
						<tr class="item-row">
							<td><input type="text" name="itemNo[]" class="itemNo"
								placeholder="001"></td>
							<td><input type="text" name="itemName[]" class="itemName"
								placeholder="Item description"></td>
								<td><input type="number" name="quantity[]" class="quantity"
								step="001" placeholder="00" oninput="calculateRowTotal(this)"></td>
							<td><input type="number" name="itemPrice[]"
								class="itemPrice" step="0.00" placeholder="0.00"
								oninput="calculateRowTotal(this)"></td>
							<td><input type="number" name="itemCGST[]" class="itemCGST"
								step="0.01" placeholder="0.00%" oninput="calculateRowTotal(this)"></td>
							<td><input type="number" name="itemSGST[]" class="itemSGST"
								step="0.01" placeholder="0.00%" oninput="calculateRowTotal(this)"></td>
							<td><input type="number" name="itemTotal[]"
								class="itemTotal" step="0.00" placeholder="0.00" readonly></td>
							<td class="action-cell">
								<button type="button" class="row-btn" onclick="addRow(this)">Add</button>
								<button type="button" class="row-btn" onclick="editRow(this)">Edit</button>
								<button type="button" class="row-btn" onclick="deleteRow(this)">Delete</button>
							</td>
						</tr>
						<tr id="subtotalRow">
							<td colspan="6" style="text-align: right; font-weight: 600;">
								Sub Total</td>
							<td><input type="text" id="subTotal" name="subTotal"
								readonly style="font-weight: 700; background: #e5e7eb;">
							</td>
							<td></td>
						</tr>

					</tbody>
				</table>
			</div>
		</form>
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
// ========== TIMER FUNCTIONS ==========
let timerInterval = null;
let startTime = null;
let elapsedBeforeHold = 0;
let isOnHold = false;

function startTimer() {
    startTime = new Date();
    timerInterval = setInterval(function () {
        const now = new Date();
        const diff = elapsedBeforeHold + (now - startTime);
        const hours = Math.floor(diff / 3600000);
        const minutes = Math.floor((diff % 3600000) / 60000);
        const seconds = Math.floor((diff % 60000) / 1000);
        document.getElementById("timer").textContent =
            "Time: " +
            String(hours).padStart(2, "0") + ":" +
            String(minutes).padStart(2, "0") + ":" +
            String(seconds).padStart(2, "0");
    }, 1000);
}

function stopTimer() {
    clearInterval(timerInterval);
    elapsedBeforeHold += new Date() - startTime;
}

// ========== TABLE FUNCTIONS ==========
function addRow(btn) {
    const row = btn.closest(".item-row");
    const inputs = row.querySelectorAll("input");
    
    for (let i of inputs) {
        if (!i.value.trim()) {
            alert("Fill all fields before adding.");
            return;
        }
        i.disabled = true;
    }
    
    btn.disabled = true;
    
    const newRow = row.cloneNode(true);
    newRow.className = "item-row";
    
    newRow.querySelectorAll("input").forEach(i => {
        i.value = "";
        i.disabled = false;
    });
    
    newRow.querySelectorAll(".row-btn").forEach(b => b.disabled = false);
    
    const table = document.getElementById("invoiceTable");
    const subtotalRow = document.getElementById("subtotalRow");
    
    subtotalRow.remove();
    table.appendChild(newRow);
    table.appendChild(subtotalRow);
    
    calculateSubTotal();
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
        inputs.forEach(i => i.disabled = false);
        btn.innerText = "Save";
        btn.style.background = "#16a34a";
    } else {
        inputs.forEach(i => i.disabled = true);
        btn.innerText = "Edit";
        btn.style.background = "#2563eb";
        calculateSubTotal();
    }
}

function calculateRowTotal(input) {
    const row = input.closest("tr");
    const price = parseFloat(row.querySelector(".itemPrice").value) || 0;
    const quantity = parseFloat(row.querySelector(".quantity").value) || 0;
    const cgst = parseFloat(row.querySelector(".itemCGST").value) || 0;
    const sgst = parseFloat(row.querySelector(".itemSGST").value) || 0;
    
    const baseAmount = price * quantity;
    const gstAmount = baseAmount * (cgst + sgst) / 100;
    const total = baseAmount + gstAmount;
    
    row.querySelector(".itemTotal").value = total.toFixed(2);
    calculateSubTotal();
}

function calculateSubTotal() {
    let sum = 0;
    document.querySelectorAll(".itemTotal").forEach(t => {
        const v = parseFloat(t.value);
        if (!isNaN(v)) sum += v;
    });
    document.getElementById("subTotal").value = sum.toFixed(2);
}

// ========== FORM VALIDATION ==========
document.getElementById("verifyForm").addEventListener("submit", function (e) {
	const dateInput = document.getElementById("invoiceDate").value.trim();
	
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
	
    this.querySelectorAll("input:disabled").forEach(i => i.disabled = false);
    
    const invoiceTotal = parseFloat(document.querySelector("input[name='invoiceTotal']").value);
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
            "Items Total: ₹" + subTotal.toFixed(2)
        );
        e.preventDefault();
        return;
    }
});

// ========== SKIP INVOICE ==========
function toggleSkipbtn() {
    const chk = document.getElementById("imgNotClearChk");
    const Skipbtn = document.getElementById("Skipbtn");
    Skipbtn.disabled = !chk.checked;
}

function skipInvoice() {
    const chk = document.getElementById("imgNotClearChk");
    
    if (!chk.checked) {
        alert("Please click on the 'Image is not clear' checkbox before skipping.");
        return;
    }
    
    const reason = prompt("Reason for skipping this invoice:");
    if (reason === null) return;
    
    const form = document.createElement("form");
    form.method = "post";
    form.action = "SimpleVerifyServlet";
    
    const imgInput = document.createElement("input");
    imgInput.type = "hidden";
    imgInput.name = "imageId";
    imgInput.value = "<%= imageId %>";
    form.appendChild(imgInput);
    
    const actionInput = document.createElement("input");
    actionInput.type = "hidden";
    actionInput.name = "actionStatus";
    actionInput.value = "skip";
    form.appendChild(actionInput);
    
    const reasonInput = document.createElement("input");
    reasonInput.type = "hidden";
    reasonInput.name = "reason";
    reasonInput.value = reason;
    form.appendChild(reasonInput);
    
    document.body.appendChild(form);
    form.submit();
}

// ========== HOLD FUNCTION ==========
function toggleHold() {
    const holdBtn = document.getElementById("holdBtn");
    const inputs = document.querySelectorAll("input, select, textarea, button");
    
    if (!isOnHold) {
        // HOLD
        stopTimer();
        
        inputs.forEach(el => {
            if (el.id !== "holdBtn") {
                el.disabled = true;
            }
        });
        
        holdBtn.innerText = "Unhold";
        holdBtn.style.background = "#16a34a";
        isOnHold = true;
        
    } else {
        // UNHOLD
        startTimer();
        
        inputs.forEach(el => el.disabled = false);
        
        holdBtn.innerText = "Hold";
        holdBtn.style.background = "#2563eb";
        isOnHold = false;
    }
}
//========== INITIALIZATION ==========
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
    navigator.sendBeacon("<%=request.getContextPath()%>/autoRelease");
});

// Debug function (remove in production)
function debugZoom() {
    const img = document.getElementById('invoiceImage');
    console.log('Zoom Level:', zoomLevel);
    console.log('Transform:', img.style.transform);
    console.log('Image dimensions:', img.width, 'x', img.height);
}
</script>

</body>
</html>