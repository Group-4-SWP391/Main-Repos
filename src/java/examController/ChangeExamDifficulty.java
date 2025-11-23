/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package examController;

import DAO.ExamDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class ChangeExamDifficulty extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int difficultyLevel = Integer.parseInt(request.getParameter("difficultyLevel"));
        int examID = Integer.parseInt(request.getParameter("examID"));
        
        // Validate difficulty level
        if (difficultyLevel < 1 || difficultyLevel > 3) {
            HttpSession session = request.getSession();
            session.setAttribute("examID", examID);
            response.sendRedirect("viewallquestion.jsp?error=invalid_difficulty");
            return;
        }
        
        // Update difficulty level
        ExamDAO examDAO = new ExamDAO();
        boolean success = examDAO.changeExamDifficulty(examID, difficultyLevel);
        
        // Set examID in session to maintain context
        HttpSession session = request.getSession();
        session.setAttribute("examID", examID);
        
        if (success) {
            // Success - redirect with success message
            response.sendRedirect("viewallquestion.jsp?success=difficulty_updated");
        } else {
            // Failed - redirect with error message
            response.sendRedirect("viewallquestion.jsp?error=difficulty_update_failed");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Change Exam Difficulty Level";
    }// </editor-fold>

}

