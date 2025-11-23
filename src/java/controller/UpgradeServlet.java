/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import java.util.Calendar;
import model.Users;

public class UpgradeServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpgradeServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpgradeServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("currentUser");

        if (user != null) {
            try {
                // Lấy giá trị gói từ form (đảm bảo form JSP gửi đúng name="selectedPackage")
                int selectedPackagePrice = Integer.parseInt(request.getParameter("selectedPackage")); 
                int userBalance = user.getBalance();
                
                // Kiểm tra số dư
                if (userBalance >= selectedPackagePrice) {
                    // Tính toán số dư mới
                    int newBalance = userBalance - selectedPackagePrice;

                    // Tính ngày hết hạn dựa trên gói giá
                    Calendar calendar = Calendar.getInstance();
                    if (selectedPackagePrice == 100) { // Gói Cơ bản
                        calendar.add(Calendar.MONTH, 1);
                    } else if (selectedPackagePrice == 250) { // Gói VIP Pro
                        calendar.add(Calendar.MONTH, 3);
                    } else {
                        // Xử lý nếu gói không hợp lệ (ví dụ: redirect lỗi)
                        response.sendRedirect("error.jsp?msg=InvalidPackage");
                        return;
                    }
                    
                    Date expirationDate = new Date(calendar.getTimeInMillis());

                    // Cập nhật Database
                    UserDAO userDAO = new UserDAO();
                    
                    // 1. Trừ tiền và nâng cấp user hiện tại
                    boolean isUpdated = userDAO.updateUserRoleAndBalance(user.getUserID(), newBalance, 2, expirationDate);
                    
                    if (isUpdated) {
                        // 2. Cộng tiền cho Admin (ID = 1) - Tùy chọn logic kinh doanh
                        userDAO.addMoneyToBalance(selectedPackagePrice, 1);

                        // 3. CẬP NHẬT LẠI SESSION (QUAN TRỌNG)
                        user.setBalance(newBalance);
                        user.setRole(2);
                        user.setExpirationDate(expirationDate);
                        session.setAttribute("currentUser", user); // Lưu đè user mới vào session

                        // Chuyển hướng thành công
                        response.sendRedirect("updateDone.jsp");
                    } else {
                        request.setAttribute("errorMessage", "Lỗi hệ thống khi nâng cấp. Vui lòng thử lại.");
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                    }
                } else {
                    // Số dư không đủ
                    request.setAttribute("errorMessage", "Số dư không đủ. Vui lòng nạp thêm.");
                    request.getRequestDispatcher("recharge.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
