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
}
</style>
</head>

<body>


	<%
	HttpSession session1 = request.getSession();

	String vendorname = session1 != null && session1.getAttribute("vendorname") != null
			? session1.getAttribute("vendorname").toString()
			: "";
	String invoiceno = session1 != null && session1.getAttribute("invoicenumber") != null
			? session1.getAttribute("invoicenumber").toString()
			: "";
	String issuedate = session1 != null && session1.getAttribute("invoiceissuedate") != null
			? session1.getAttribute("invoiceissuedate").toString()
			: "";
	String pono = session1 != null && session1.getAttribute("poNo") != null ? session1.getAttribute("poNo").toString() : "";
	String total = session1 != null && session1.getAttribute("total") != null
			? session1.getAttribute("total").toString()
			: "";
	String imagePath = session1 != null && session1.getAttribute("imagePath") != null
			? session1.getAttribute("imagePath").toString()
			: "";

	String itemno = session1 != null && session1.getAttribute("itemno") != null
			? session1.getAttribute("itemno").toString()
			: "";
	String itemname = session1 != null && session1.getAttribute("itemname") != null
			? session1.getAttribute("itemname").toString()
			: "";
	String quantity = session1 != null && session1.getAttribute("quantity") != null
			? session1.getAttribute("quantity").toString()
			: "";
	String price = session1 != null && session1.getAttribute("price") != null
			? session1.getAttribute("price").toString()
			: "";
	String cgst = session1 != null && session1.getAttribute("cgst") != null ? session1.getAttribute("cgst").toString() : "";
	String sgst = session1 != null && session1.getAttribute("sgst") != null ? session1.getAttribute("sgst").toString() : "";
	String itemtotal = session1 != null && session1.getAttribute("itemtotal") != null
			? session1.getAttribute("itemtotal").toString()
			: "";
	%>



		<div class="header">
			<div class="logo">
				<img src="<%= request.getContextPath() %>/images/dreams-soft-logo.jpeg">
				<strong>Dreams Soft Solutions</strong>
			</div>
			<div class="header-right">
       			 <div class="timer" id="timer">Time: --</div>
      			  <div class="user-info">Welcome, <strong><%= session.getAttribute("username") %></strong></div>
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
       // String imagePath = null;
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
        <p><a href="login.jsp">go to login</a></p>
    </div>
    <%
            return;
        }
    %>
    
		<form id="invoiceForm">
		        <input type="hidden" name="imageId" value="<%= imageId %>">
			<div class="top-section">

				<div class="form-box" id="">
					<h3>QC Invoice Details</h3>
					<div class="form-group">
						<label>Vendor Name</label><input type="text" class="freeze-field"
							required>
					</div>
					<div class="form-group">
						<label>Invoice Number</label><input type="text"
							class="freeze-field" required>
					</div>
					<div class="form-group">
						<label>Invoice Issue Date</label><input type="text"
							class="freeze-field" required>
					</div>
					<div class="form-group">
						<label>P.O.#</label><input type="text" class="freeze-field"
							required>
					</div>
					<div class="form-group">
						<label>Invoice Total</label><input type="text"
							class="freeze-field" required>
					</div>
					<div class="checkbox-group">
						<input type="checkbox" id="imgNotClearChk"
							onclick="toggleSkipBtn()"> Image is not clear <label
							style="font-size: 14px;"> </label>

					</div>
					<div class="footer-actions">
						<button class="action-btn" type="button" onclick="edit(this)">Save</button>
				        <button class="action-btn" type="button" id="skipBtn" disabled onclick="openSkipModal()">Skip</button>
						<button class="action-btn" type="submit" onclick="submitform()">Submit</button>
					</div>

				</div>

				<div class="image-box">
					<%
					if (!imagePath.equals("")) {
					%>
					<img id="invoiceImage" src="<%=request.getContextPath()%>"
						class="invoice-img">
					<%
					} else {
					%>
					<h3>No Image Found</h3>
					<%
					}
					%>
					<div class="zoom-controls">
						<button class="zoom-btn" type="button" onclick="zoomIn()">+</button>
						<button class="zoom-btn" type="button" onclick="zoomOut()">&#8722;</button>
					</div>
				</div>

			</div>

			<div class="table-box">
				<table id="invoiceTable">
					<tr>
						<th>Item No</th>
						<th>Item Name</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>CGST (%)</th>
						<th>SGST (%)</th>
						<th>Total</th>
						<th>Action</th>
					</tr>
					<tr class="item-row">
						<td><input class="itemNo" type="number" placeholder="001"
							value="<%=itemno%>" disabled></td>
						<td><input class="itemName" type="text"
							placeholder="Item Description" value="<%=itemname%>" disabled></td>
						<td><input class="quantity" type="number" placeholder="00"
							value="<%=quantity%>" oninput="calculateRowTotal(this)" disabled></td>
						<td><input class="price" type="number" placeholder="0.00"
							value="<%=price%>" oninput="calculateRowTotal(this)" disabled></td>
						<td><input class="itemCGST" type="number" placeholder="0.00%"
							value="<%=cgst%>" oninput="calculateRowTotal(this)" disabled></td>
						<td><input class="itemSGST" type="number" placeholder="0.00%"
							value="<%=sgst%>" oninput="calculateRowTotal(this)" disabled></td>
						<td><input class="itemTotal" type="number" placeholder="0.00"
							value="<%=itemtotal%>" disabled></td>
						<td>
							<button type="button" class="row-btn" onclick="addRow(this)">Add</button>
							<button type="button" class="row-btn" onclick="editRow(this)">Edit</button>
							<button type="button" class="row-btn" onclick="deleteRow(this)">Delete</button>
						</td>
					</tr>
					<tr id="subTotalRow">
						<td colspan="6" style="text-align: right; font-weight: 600;">Sub
							Total</td>
						<td><input id="subTotal" readonly></td>
						<td></td>
					</tr>

				</table>
			</div>

		</div>
		<!-- Skip Login Modal -->
<div id="skipModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
     background:rgba(0,0,0,0.5); align-items:center; justify-content:center; z-index:9999;">

    <div style="background:#fff; padding:25px; width:360px; border-radius:12px; position:relative;">

        <!-- ❌ Close Button -->
        <span onclick="closeSkipModal()"
              style="position:absolute; top:12px; right:15px;
                     font-size:22px; cursor:pointer; color:#64748b;">
            &times;
        </span>

        <h3 style="margin-top:0;">Skip Authentication</h3>

        <div class="form-group">
            <label>Username</label>
            <input type="text" id="skipUsername" placeholder="Enter username" value="dreams">
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" id="skipPassword" placeholder="Enter password" value="dreams">
        </div>

        <p id="skipError" style="color:red; font-size:13px; display:none;">
            Invalid username or password
        </p>

        <div style="display:flex; gap:12px; margin-top:18px;">
            <button type="button" class="action-btn" onclick="validateSkip()">Confirm</button>
            <button type="button" class="action-btn" onclick="closeSkipModal()">Cancel</button>
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

	function toggleSkipBtn() {
	    var chk = document.getElementById("imgNotClearChk");
	    var skipBtn = document.getElementById("skipBtn");
	    skipBtn.disabled = !chk.checked;
	}

	function skip() {
		alert("skipped");
	}

	function openSkipModal() {
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

	    if (user === "dreams" && pass === "dreams") {
	        closeSkipModal();
	        alert("Skip authorized successfully");
	    } else {
	        document.getElementById("skipError").style.display = "block";
	    }
	}

	/* =====================================================
	   SUBMIT VALIDATION (DATE + TOTAL CHECK)
	   ===================================================== */
	document.getElementById("invoiceForm").addEventListener("submit", function (e) {

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