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
	padding: 10px;
	border-radius: 8px;
	cursor: pointer;
	flex: 1;
}

.image-box {
	width: 75%;
	background: #ffffff;
	border-radius: 12px;
	box-shadow: 0 15px 30px rgba(37, 99, 235, 0.15);
	position: relative;
	min-height: 340px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.invoice-img {
	max-width: 100%;
	max-height: 100%;
	transition: transform 0.2s ease-in-out;
}

.zoom-controls {
	position: absolute;
	bottom: 20px;
	left: 50%;
	transform: translateX(-50%);
	display: flex;
	gap: 40px;
}

.zoom-btn {
	width: 44px;
	height: 44px;
	border-radius: 50%;
	background: #2563eb;
	color: #fff;
	font-size: 24px;
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

td:last-child {
	display: flex;
	gap: 6px;
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

input:disabled {
	background-color: #e5e7eb;
	color: #475569;
	font-weight: 600;
	cursor: not-allowed;
}

.timer {
	font-weight: 600;
	font-size: 15px;
	color: #2563eb;
}

.checkbox-group {
	display: flex;
	align-items: center;
	gap: 10px;
}

.checkbox-group input {
	width: 18px;
	height: 18px;
	accent-color: #2563eb;
}

.item-row[readonly] {
	background-color: #f1f5f9;
	color: #475569;
	font-weight: 600;
	cursor: not-allowed;
} /* ===== Skip Modal Design ===== */
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

@
keyframes pop {from { transform:scale(0.9);
	opacity: 0;
}

to {
	transform: scale(1);
	opacity: 1;
}

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

.skip-body input {
	width: 100%;
	padding: 10px;
	border-radius: 8px;
	border: 1px solid #c7d2fe;
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
}

input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

input[type=number] {
	-moz-appearance: textfield;
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



java.util.List<com.model.InvoiceDetailsModel> qcItems = new java.util.ArrayList<>();

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
    session.setAttribute("qcItems", qcItems);
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
			<div class="form-box" id="">
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
						<label>Invoice Total(&#8377;)</label><input type="text"
							name="invoiceTotal" class="freeze-field" required>
					</div>
					<div style="margin-top: 10px;">
						<input type="checkbox" id="imgNotClearChk"
							onclick="toggleSkipbtn()"> <label for="imgNotClearChk"
							style="font-size: 13px; font-weight: 600;">Please select "Image is not clear" before skipping.</label>
					
					</div>
					<div class="footer-actions">
						<button class="action-btn" type="button" onclick="edit(this)">Save</button>
						<button class="action-btn" type="button" id="Skipbtn"onclick="openSkipModal()">Skip</button>
						<button type="submit" class="action-btn">Submit</button>
					</div>

				</div>

				<div class="image-box">
					<img id="invoiceImage"
     src="<%=request.getContextPath()%>/invoice_images/<%= imagePath %>"
     class="invoice-img">
					
					
					<div class="zoom-controls">
						<button class="zoom-btn" type="button" onclick="zoomIn()">+</button>
						<button class="zoom-btn" type="button" onclick="zoomOut()">&#8722;</button>
					</div>
					<div style="
    position: absolute;
    top: 10px;
    left: 10px;
    display: flex;
    gap: 8px;
    align-items: center;
">

    <span style="
        background: rgba(37, 99, 235, 0.9);
        color: white;
        padding: 5px 10px;
        border-radius: 5px;
        font-size: 12px;
    ">
        Invoice ID: <%= imageId %>
    </span>

    <% if ("completed".equals(vcStatus)) { %>
        <span style="
            background: #16a34a;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 600;
        ">
            VC COMPLETED
        </span>
    <% } else if ("skipped".equals(vcStatus)) { %>
        <span style="
            background: #dc2626;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 600;
        ">
            VC SKIPPED
        </span>
    <% } %>

</div>

				</div>

			</div>

			<div class="table-box">
				<table id="invoiceTable">
					<tr>
						<th>Item No</th>
						<th>Item Name</th>
						<th>Quantity</th>
						<th>Price(&#8377;)</th>
						<th>CGST (%)</th>
						<th>SGST (%)</th>
						<th>Total(&#8377;)</th>
						<th>Action</th>
					</tr>
<%
if (itemName != null) {
    for (int i = 0; i < itemName.length; i++) {
%>

    <!-- EXISTING ROW (UNCHANGED) -->
    <tr class="item-row">
        <td><input class="itemNo" type="number" name="itemNo[]" value="<%= itemNo[i] %>"disabled></td>
        <td><input class="itemName" type="text" name="itemName[]" value="<%= itemName[i] %>"disabled></td>
        <td><input class="quantity" type="number" name="quantity[]" value="<%= qty[i] %>" oninput="calculateRowTotal(this)" disabled></td>
        <td><input class="price" type="number" name="itemPrice[]" value="<%= price[i]%>" oninput="calculateRowTotal(this)" disabled></td>
        <td><input class="itemCGST" type="number" name="itemCGST[]" value="<%=cgst[i]%>" oninput="calculateRowTotal(this)" disabled></td>
        <td><input class="itemSGST" type="number" name="itemSGST[]" value="<%= sgst[i]%>" oninput="calculateRowTotal(this)" disabled></td>
        <td><input class="itemTotal" type="number" name="itemTotal[]" value="<%=total[i] %>" readonly disabled></td>
        <td>
            <button type="button" class="row-btn" onclick="addRow(this)">Add</button>
            <button type="button" class="row-btn" onclick="editRow(this)">Edit</button>
            <button type="button" class="row-btn" onclick="deleteRow(this)">Delete</button>
        </td>
    </tr>
 
<%
    }
} else {
%>

    <!-- ✅ DEFAULT EMPTY ROW FOR QC -->
    <tr class="item-row">
        <td><input class="itemNo" type="number" name="itemNo[]" placeholder="001"></td>
        <td><input class="itemName" type="text" name="itemName[]" placeholder="Item Description"></td>
        <td><input class="quantity" type="number" name="quantity[]" placeholder="0" oninput="calculateRowTotal(this)"></td>
        <td><input class="price" type="number" name="itemPrice[]" placeholder="0.00" oninput="calculateRowTotal(this)"></td>
        <td><input class="itemCGST" type="number" name="itemCGST[]" placeholder="0" oninput="calculateRowTotal(this)"></td>
        <td><input class="itemSGST" type="number" name="itemSGST[]" placeholder="0" oninput="calculateRowTotal(this)"></td>
        <td><input class="itemTotal" type="number" name="itemTotal[]" readonly></td>
        <td>
            <button type="button" class="row-btn" onclick="addRow(this)">Add</button>
            <button type="button" class="row-btn" onclick="editRow(this)">Edit</button>
            <button type="button" class="row-btn" onclick="deleteRow(this)">Delete</button>
        </td>
    </tr>
<%
}
%>

					<tr id="subTotalRow">
						<td colspan="6" style="text-align: right; font-weight: 600;">Sub
							Total</td>
						<td><input id="subTotal" name="subTotal" readonly></td>
						<td></td>
					</tr>
              
				</table>
			</div>
	</div>
	<div id="skipModal" class="skip-overlay">

		<div class="skip-card">

			<div class="skip-header">
				<h3>Skip Authentication</h3>
				<span class="skip-close" onclick="closeSkipModal()">&times;</span>
			</div>

			<div class="skip-body">
			<div class="form-group">
    <label>Reason for Skip</label>
    <textarea id="skipReason"
              rows="3"
              placeholder="Enter reason after TL approval"
              disabled
              style="width:100%;padding:10px;border-radius:8px;border:1px solid #c7d2fe;"></textarea>
</div>
			
				<div class="form-group">
					<label>Username</label> <input type="text" id="skipUsername"
						placeholder="Enter username">
				</div>

				<div class="form-group">
					<label>Password</label> <input type="password" id="skipPassword"
						placeholder="Enter password">
				</div>

				<div id="skipError" class="skip-error">Invalid username or
					password</div>
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
	</form>

	<script>
	function calculateRowTotal(el) {
	    const row = el.closest("tr");

	    const qty   = parseFloat(row.querySelector(".quantity").value) || 0;
	    const price = parseFloat(row.querySelector(".price").value) || 0;
	    const cgst  = parseFloat(row.querySelector(".itemCGST").value) || 0;
	    const sgst  = parseFloat(row.querySelector(".itemSGST").value) || 0;

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

	    const totalItemRows =
	        document.querySelectorAll(".row-btn[onclick^='deleteRow']").length;

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

	function edit(btn) {
	    const freezeInputs = document.querySelectorAll(".freeze-field");

	    if (btn.innerText === "Save") {
	        freezeInputs.forEach(i => i.disabled = true);
	        btn.innerText = "Edit";
	        btn.style.background = "#16a34a";
	    } else {
	        freezeInputs.forEach(i => i.disabled = false);
	        btn.innerText = "Save";
	        btn.style.background = "#2563eb";
	    }
	}

	window.onload = function() {
	    document.querySelectorAll(".item-row").forEach(row => {
	        calculateRowTotal(row.cells[2].children[0]);
	    });
	};

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

	function toggleSkipbtn() {
	    var chk = document.getElementById("imgNotClearChk");
	    var Skipbtn = document.getElementById("Skipbtn");
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
	    document.getElementById("skipError").style.display = "none";
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


	/* =====================================================
	   SUBMIT VALIDATION (DATE + TOTAL CHECK)
	   ===================================================== */
	document.getElementById("invoiceForm").addEventListener("submit", function (e) {

		 document.getElementById("actionType").value = "submit";
	    // enable disabled inputs before submit
	    this.querySelectorAll("input:disabled").forEach(i => i.disabled = false);

	    /* ===== DATE VALIDATION (FROM VERIFY JSP – UNCHANGED) ===== */
	    const dateInput =
	        document.querySelectorAll(".form-box .freeze-field")[2].value.trim();

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

	    /* ===== TOTAL VALIDATION (ALREADY WORKING) ===== */
	    const invoiceTotal =
	        parseFloat(document.querySelectorAll(".form-box .freeze-field")[4].value);
	    const subTotal =
	        parseFloat(document.getElementById("subTotal").value);

	    if (isNaN(invoiceTotal) || isNaN(subTotal)) {
	        alert("Invoice Total and Item totals are required.");
	        e.preventDefault();
	        return;
	    }

	    if (invoiceTotal.toFixed(2) !== subTotal.toFixed(2)) {
	        alert(
	            "Invoice Total and Item Sub Total must match.\n\n" +
	            "Invoice Total: " + invoiceTotal.toFixed(2) + "\n" +
	            "Sub Total: " + subTotal.toFixed(2)
	        );
	        e.preventDefault();
	        return;
	    }

	    // ✅ All validations passed → submit allowed
	});
</script>

</body>
</html>