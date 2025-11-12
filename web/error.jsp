<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Lỗi Đăng Nhập</title>
</head>
<body>
    <h1>Đã xảy ra lỗi</h1>
    <p>Có vấn đề xảy ra trong quá trình xử lý đăng nhập của bạn. Vui lòng thử lại sau.</p>
    <% 
        // Hiển thị thông báo lỗi đã được đặt vào request attribute (nếu có)
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
            out.println("<p>Chi tiết: " + errorMessage + "</p>");
        }
    %>
    <p><a href="login.jsp">Quay lại trang Đăng nhập</a></p>
</body>
</html>