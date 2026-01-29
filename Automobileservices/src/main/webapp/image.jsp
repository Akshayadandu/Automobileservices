<!DOCTYPE html>
<html>
<head>
    <title>Upload Invoice PDF</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            height: 100vh;
            background: linear-gradient(135deg, #4e73df, #1cc88a);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .upload-box {
            background: #ffffff;
            width: 420px;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
            text-align: center;
        }

        .upload-box h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .upload-box input[type="file"] {
            width: 100%;
            padding: 12px;
            border: 2px dashed #4e73df;
            border-radius: 6px;
            margin-bottom: 20px;
            cursor: pointer;
            background: #f8f9fc;
        }

        .upload-box input[type="submit"] {
            width: 100%;
            background: #4e73df;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .upload-box input[type="submit"]:hover {
            background: #2e59d9;
        }

        .note {
            margin-top: 15px;
            font-size: 13px;
            color: #666;
        }
    </style>

</head>
<body>

<div class="upload-box">
    <h2>Upload Invoice PDF</h2>

    <form action="UploadPdfServlet" method="post" enctype="multipart/form-data">
        <input type="file" name="pdfFile" accept="application/pdf" required>
        <input type="submit" value="Upload PDF">
    </form>

    <div class="note">
        Only PDF files are allowed
    </div>
</div>

</body>
</html>
