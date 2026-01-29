<!DOCTYPE html>
<html>
<head>
    <title>Home</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

body {
    height: 100vh;
    display: flex;
    flex-direction: column;

    background:
        linear-gradient(rgba(255,255,255,0.85), rgba(255,255,255,0.85)),
        url("images/dreams-soft-logo.jpeg");

    background-repeat: no-repeat;
    background-position: center;
    background-size: 150vmin;   /* ✅ same look on all screens */
    background-attachment: fixed;
}

        /* Header */
        .header {
            height: 70px;
            background: linear-gradient(to right, #0b5ed7, #198754);
            display: flex;
            align-items: center;
            padding: 0 30px;
            color: white;
        }

        .logo {
            height: 45px;
            margin-right: 15px;
        }

        .title {
            font-size: 22px;
            font-weight: bold;
        }

        /* Main Content */
        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .box-container {
            display: flex;
            gap: 50px;
        }

        .box {
            width: 220px;
            height: 160px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.3s;
        }

        .box:hover {
            transform: translateY(-8px);
        }

        .btn {
            width: 150px;
            padding: 14px;
            font-size: 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            color: white;
            background: #0b5ed7;
        }

        /* Footer */
        .footer {
            height: 40px;
            background: linear-gradient(to right, #0b5ed7, #198754);
            text-align: center;
            line-height: 40px;
            color: black;
            font-size: 14px;
        }
    </style>
</head>

<body>

<!-- Header -->
<div class="header">
    <img src="images/dreams-soft-logo.jpeg" class="logo" alt="Logo">
    <div class="title">Dreams Soft Solutions</div>
</div>

<!-- Main Content -->
<div class="content">
    <div class="box-container">

        <!-- VERIFY -->
        <div class="box">
            <form action="<%=request.getContextPath()%>/home" method="get">
                <input type="hidden" name="action" value="verify">
                <button class="btn" type="submit">Verify</button>
            </form>
        </div>

        <!-- QC -->
        <div class="box">
            <form action="<%=request.getContextPath()%>/home" method="get">
                <input type="hidden" name="action" value="qc">
                <button class="btn" type="submit">QC</button>
            </form>
        </div>

    </div>
</div>

<!-- Footer -->
<div class="footer">
    © 2026 Dreams Soft Solutions
</div>

</body>
</html>
