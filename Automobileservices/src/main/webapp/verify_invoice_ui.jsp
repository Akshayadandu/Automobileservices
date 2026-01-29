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
}

.form-box {
	width: 25%;
	background: #ffffff;
	padding: 22px;
	border-radius: 12px;
	box-shadow: 0 15px 30px rgba(37, 99, 235, 0.15);
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

.image-box {
	width: 75%;
	background: #ffffff;
	border-radius: 12px;
	box-shadow: 0 15px 30px rgba(37, 99, 235, 0.15);
	position: relative;
	overflow: hidden;
	min-height: 340px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.invoice-img {
	max-width: 90%;
	max-height: 90%;
	transition: transform 0.2s ease-in-out;
	border: 1px solid #ddd;
}

.zoom-controls {
	position: absolute;
	bottom: 20px;
	left: 50%;
	transform: translateX(-50%);
	display: flex;
	gap: 50px;
}

.zoom-btn {
	width: 44px;
	height: 44px;
	border-radius: 50%;
	background: #2563eb;
	color: #ffffff;
	font-size: 24px;
	font-weight: bold;
	border: none;
	cursor: pointer;
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
/* ð Frozen input look */
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

@media ( max-width : 1200px) {
	.top-section {
		flex-direction: column;
	}
	.form-box, .image-box {
		width: 100%;
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
        String imagePath = null;
        Integer imageId = null;
        String timeTaken = "0.00";
        if (username == null) {
            response.sendRedirect("login.jsp");
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
				<a href="login.jsp">go to login</a>
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
						<label>Invoice Total (â¹)</label> <input type="number"
							name="invoiceTotal" id="invoiceTotal" step="0.01"
							onchange="calculateSubTotal();">
					</div>
					<div style="margin-top: 10px;">
						<input type="checkbox" id="imgNotClearChk"
							onclick="toggleSkipBtn()"> <label for="imgNotClearChk"
							style="font-size: 13px; font-weight: 600;">Image is not
							clear</label>
					</div>


					<div class="footer-actions">
						<!-- ===== SKIP BUTTON (ONLY CHANGE: disabled REMOVED) ===== -->
						<button class="action-btn" type="button" id="skipBtn"
							onclick="skipInvoice()">Skip</button>
						<button type="button" class="action-btn" id="holdBtn"
							onclick="toggleHold()">Hold</button>
						<button type="submit" name="actionStatus" value="submit"
							class="action-btn">Submit</button>

					</div>
				</div>

				<div class="image-box">
					<img id="invoiceImage"
						src="<%= request.getContextPath() %>/invoice_images/<%= imagePath %>"
						class="invoice-img" alt="Invoice"
						onerror="this.src='<%= request.getContextPath() %>/images/sample-invoice.png'">

					<div class="zoom-controls">
						<button type="button" class="zoom-btn" onclick="zoomIn()">+</button>
						<button type="button" class="zoom-btn" onclick="zoomOut()">-</button>
					</div>

					<div
						style="position: absolute; top: 10px; left: 10px; background: rgba(37, 99, 235, 0.9); color: white; padding: 5px 10px; border-radius: 5px; font-size: 12px;">
						Invoice ID:
						<%= imageId %>
					</div>
				</div>
			</div>

			<div class="table-box">
				<table id="invoiceTable">
					<thead>
						<tr>
							<th>Item No</th>
							<th>Item Name</th>
							<th>Price (â¹)</th>
							<th>Quantity</th>
							<th>CGST (%)</th>
							<th>SGST (%)</th>
							<th>Total (â¹)</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<tr class="item-row">
							<td><input type="text" name="itemNo[]" class="itemNo"
								placeholder="001"></td>
							<td><input type="text" name="itemName[]" class="itemName"
								placeholder="Item description"></td>
							<td><input type="number" name="itemPrice[]"
								class="itemPrice" step="0.01" placeholder="0.00"
								onchange="calculateRowTotal(this)"></td>
							<td><input type="number" name="quantity[]" class="quantity"
								step="001" placeholder="0" oninput="calculateRowTotal(this)"></td>
							<td><input type="number" name="itemCGST[]" class="itemCGST"
								step="0.01" placeholder="9" onchange="calculateRowTotal(this)"></td>
							<td><input type="number" name="itemSGST[]" class="itemSGST"
								step="0.01" placeholder="9" onchange="calculateRowTotal(this)"></td>
							<td><input type="number" name="itemTotal[]"
								class="itemTotal" step="0.01" placeholder="0.00" readonly></td>
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
	<div id="toast"></div>
	<script>
let zoomLevel = 1;

let timerInterval = null;
let startTime = null;
let elapsedBeforeHold = 0; // in milliseconds
let isOnHold = false; 

// ===== START / RESUME TIMER =====
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

// ===== STOP / PAUSE TIMER =====
function stopTimer() {
    clearInterval(timerInterval);
    elapsedBeforeHold += new Date() - startTime;
}

// Zoom functions
function zoomIn() {
    zoomLevel += 0.1;
    document.getElementById("invoiceImage").style.transform = `scale(${zoomLevel})`;
}

function zoomOut() {
    if (zoomLevel > 0.5) {
        zoomLevel -= 0.1;
        document.getElementById("invoiceImage").style.transform = `scale(${zoomLevel})`;
    }
}
/* ===== ADD ROW ===== */
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
    newRow.className = "item-row"; // â force class

    newRow.querySelectorAll("input").forEach(i => {
        i.value = "";
        i.disabled = false;
    });

    // â enable ALL buttons
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

    // Count delete buttons = item rows
    const totalItemRows =
        document.querySelectorAll(".row-btn[onclick^='deleteRow']").length;

    if (totalItemRows <= 1) {
        alert("At least one item row is required.");
        return;
    }

    row.remove();
    calculateSubTotal();

    // â RE-ENABLE Add button on the last remaining row
    const rows = document.querySelectorAll("tr.item-row");
    rows.forEach(r => {
        const addBtn = r.querySelector("button[onclick^='addRow']");
        if (addBtn) addBtn.disabled = false;
    });
}

/* ===== EDIT / SAVE ===== */
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

// Calculate row total
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

/* ===== SUBTOTAL ===== */
function calculateSubTotal() {
    let sum = 0;
    document.querySelectorAll(".itemTotal").forEach(t => {
        const v = parseFloat(t.value);
        if (!isNaN(v)) sum += v;
    });
    document.getElementById("subTotal").value = sum.toFixed(2);
}
document.getElementById("verifyForm").addEventListener("submit", function (e) {
	const dateInput = document.getElementById("invoiceDate").value.trim();

	// 1️⃣ Mandatory check
	if (!dateInput) {
	    alert("Please enter Invoice Issue Date.");
	    e.preventDefault();
	    return;
	}

	// 2️⃣ Format check: dd-mm-yyyy
	const datePattern = /^(\d{2})-(\d{2})-(\d{4})$/;
	if (!datePattern.test(dateInput)) {
	    alert("Invoice Date must be in DD-MM-YYYY format.");
	    e.preventDefault();
	    return;
	}

	// 3️⃣ Convert to Date object
	const parts = dateInput.split("-");
	const enteredDate = new Date(parts[2], parts[1] - 1, parts[0]);

	// 4️⃣ Invalid date check (like 32-13-2025)
	if (
	    enteredDate.getDate() != parts[0] ||
	    enteredDate.getMonth() != parts[1] - 1 ||
	    enteredDate.getFullYear() != parts[2]
	) {
	    alert("Invalid Invoice Date.");
	    e.preventDefault();
	    return;
	}

	// 5️⃣ Future date restriction
	const today = new Date();
	today.setHours(0, 0, 0, 0);

	if (enteredDate > today) {
	    alert("Invoice Date cannot be a future date.");
	    e.preventDefault();
	    return;
	}


    // enable disabled inputs first
    this.querySelectorAll("input:disabled").forEach(i => i.disabled = false);

    const invoiceTotal = parseFloat(
        document.querySelector("input[name='invoiceTotal']").value
    );

    const subTotal = parseFloat(
        document.getElementById("subTotal").value
    );

    if (isNaN(invoiceTotal) || isNaN(subTotal)) {
        alert("Invoice Total and Item totals are required.");
        e.preventDefault();
        return;
    }

    if (invoiceTotal.toFixed(2) !== subTotal.toFixed(2)) {
        alert(
            "Invoice Total and Item Sub Total must match.\n\n" +
            "Invoice Total: â¹" + invoiceTotal.toFixed(2) + "\n" +
            "Items Total: â¹" + subTotal.toFixed(2)
        );
        e.preventDefault();
        return;
    }

    // â allow submit
});

// Skip invoice

/* ✅ Skip enable/disable */
function toggleSkipBtn() {
    const chk = document.getElementById("imgNotClearChk");
    const skipBtn = document.getElementById("skipBtn");
    skipBtn.disabled = !chk.checked;

}

/* ✅ Skip action */
/* ===== SKIP ACTION (UNCHANGED LOGIC, THIS SHOWS POPUP) ===== */
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

/* ✅ TOP POPUP */
function showTopPopup(message, subMessage, isError) {
    const popup = document.getElementById("topPopup");
    document.getElementById("topPopupMsg").textContent = message || "";
    document.getElementById("topPopupSub").textContent = subMessage || "";

    if (isError) popup.classList.add("error");
    else popup.classList.remove("error");

    popup.style.display = "block";
    setTimeout(() => popup.style.display = "none", 2500);
}

// Hold invoice

  function toggleHold() {
    const holdBtn = document.getElementById("holdBtn");
    const inputs = document.querySelectorAll("input, select, textarea, button");

    if (!isOnHold) {
        // ===== HOLD =====
        stopTimer();

        inputs.forEach(el => {
            if (el.id !== "holdBtn") {
                el.disabled = true;
            }
        });

        holdBtn.innerText = "Unhold";
        holdBtn.style.background = "#16a34a"; // green
        isOnHold = true;

    } else {
       
        startTimer();

        inputs.forEach(el => el.disabled = false);

        holdBtn.innerText = "Hold";
        holdBtn.style.background = "#2563eb"; // blue
        isOnHold = false;
    }
}
  
   

// Auto-calculate on load
document.addEventListener("DOMContentLoaded", function() {
    calculateSubTotal();
    startTimer(); 
});
  // ❌ functions not defined yet

</script>

</body>
</html>