/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.UserDAO;
import DAO.UserIPHistoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Users;


public class LoginServlet extends HttpServlet {

    private static final String SUCCESS_USER = "Home";
    private static final String SUCCESS_ADMIN = "admin.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("elearning-html-template/login.html");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            UserDAO userDAO = new UserDAO();
            String hassPassword = userDAO.hashPassword(password);
            System.out.println(email);
            System.out.println(password);

            String status = userDAO.checkLogin(email, hassPassword);
            System.out.println("🔐 [LoginServlet] Login attempt - Email: " + email);
            System.out.println("🔐 [LoginServlet] Password hash: " + hassPassword);
            System.out.println("🔐 [LoginServlet] Login status: " + status);
            
            if (status != null) {
                // Lấy địa chỉ IP của người dùng
                String userIP = request.getRemoteAddr();
                System.out.println("🌐 [LoginServlet] User IP: " + userIP);

                // Lưu thông tin người dùng vào session
                int role = userDAO.getUserType(email);
                Users user = userDAO.findByEmail(email);
                int userID = user.getUserID();
                
                System.out.println("👤 [LoginServlet] User found - ID: " + userID + ", Role: " + role + ", Banned: " + user.isBan());

                // Kiểm tra nếu user bị ban
                if (user.isBan()) {
                    System.out.println("⛔ [LoginServlet] User is banned, redirecting to banned.jsp");
                    response.sendRedirect("banned.jsp");
                    return;
                }

                // Kiểm tra lịch sử địa chỉ IP
                System.out.println("📊 [LoginServlet] Checking IP history...");
                UserIPHistoryDAO ipHistoryDAO = new UserIPHistoryDAO();
                List<String> ipHistory = ipHistoryDAO.getUserIPHistory(userID);

                // Kiểm tra ipCount
                int ipCount = ipHistory.size();
                System.out.println("📊 [LoginServlet] IP Count: " + ipCount + ", IPs: " + ipHistory);

                // Kiểm tra nếu đã có 3 IP khác nhau và IP hiện tại không nằm trong danh sách
                if (ipCount >= 3 && !ipHistory.contains(userIP)) {
                    // Ban tài khoản vì đăng nhập từ IP thứ 4
                    System.out.println("⛔ [LoginServlet] Too many IPs (>=3), banning user...");
                    ipHistoryDAO.setBanStatus(userID, true);
                    response.sendRedirect("banned.jsp");
                    return;
                }

                // Lưu IP nếu là IP mới
                if (!ipHistory.contains(userIP)) {
                    System.out.println("💾 [LoginServlet] New IP detected, saving to database...");
                    ipHistoryDAO.addUserIP(userID, userIP);
                    System.out.println("✅ [LoginServlet] IP saved successfully");
                } else {
                    System.out.println("ℹ️ [LoginServlet] IP already exists, skipping save");
                }

                // Tạo session cho user
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                session.setMaxInactiveInterval(3600 * 4); // 4 giờ
                System.out.println("✅ [LoginServlet] Session created successfully");

                // Redirect dựa vào role
                if (role == 3 || role == 2) {
                    // Người dùng thường hoặc giáo viên
                    System.out.println("➡️ [LoginServlet] Redirecting to Home");
                    response.sendRedirect("Home");
                } else if (role == 1) {
                    // Quản trị viên (admin)
                    System.out.println("➡️ [LoginServlet] Redirecting to admin.jsp");
                    response.sendRedirect("admin.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Wrong email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
