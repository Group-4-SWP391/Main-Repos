<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<%@ page import="model.QuestionBank" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<jsp:include page="header.jsp"></jsp:include>
<script>
        var container = document.getElementById("tagID");
        if (container) {
            var tag = container.getElementsByClassName("tag");
            var current = container.getElementsByClassName("active");
            if (current.length > 0) {
                current[0].className = current[0].className.replace(" active", "");
            }
            if (tag.length > 2) {
                tag[2].className += " active";
            }
        }
    </script>
    <style>
        /* Modern Result Page Styling */
        body {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            padding-top: 3rem;
            padding-bottom: 3rem;
        }

        h2 {
            color: white;
            font-weight: 700;
            text-shadow: 2px 4px 8px rgba(0,0,0,0.2);
            margin-bottom: 2rem;
        }

        /* Result Card */
        .result-card {
            background: white;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideUp 0.6s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Result Header */
        .result-header {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            padding: 2.5rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .result-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: pulse 4s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .result-header h3 {
            color: white;
            font-weight: 700;
            font-size: 2rem;
            margin: 0;
            position: relative;
            z-index: 1;
        }

        /* Result Body */
        .result-body {
            padding: 3rem 2.5rem;
        }

        /* Score Display */
        .score-display {
            text-align: center;
            margin-bottom: 3rem;
        }

        .score-circle {
            width: 200px;
            height: 200px;
            margin: 0 auto 1.5rem;
            border-radius: 50%;
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 40px rgba(37,150,190,0.4);
            animation: scaleIn 0.8s ease;
        }

        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }

        .score-value {
            font-size: 4rem;
            font-weight: 800;
            color: white;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .score-label {
            font-size: 1.25rem;
            color: #6c757d;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        /* Stats */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 1.5rem;
            border-radius: 16px;
            text-align: center;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border-color: #2596be;
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 0.75rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 0.875rem;
            color: #6c757d;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-action:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.25);
            text-decoration: none;
        }

        .btn-retry {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            color: white;
        }

        .btn-back {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            color: white;
        }

        .btn-detail {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .result-body {
                padding: 2rem 1.5rem;
            }

            .score-circle {
                width: 160px;
                height: 160px;
            }

            .score-value {
                font-size: 3rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-action {
                width: 100%;
                justify-content: center;
            }
        }

        /* Success/Fail indicator */
        .result-badge {
            display: inline-block;
            padding: 0.5rem 1.5rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .result-badge.success {
            background: #d4edda;
            color: #155724;
        }

        .result-badge.warning {
            background: #fff3cd;
            color: #856404;
        }

        .result-badge.danger {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
<%
if(session.getAttribute("resultID") != null){
int resultID = (Integer)session.getAttribute("resultID");
int examID = (Integer)session.getAttribute("examID");
Exam exam = new ExamDAO().getExamByID(examID);
Result result = new StudentExamDAO().getResultByID(resultID);
Tests test = (Tests)session.getAttribute("test");
new StudentExamDAO().updateTestTime(test.getTestID(), 0);

// Calculate percentage
double percentage = (double)result.getRightAnswer() / result.getTotalQuestion() * 100;
String badgeClass = percentage >= 80 ? "success" : percentage >= 50 ? "warning" : "danger";
String badgeText = percentage >= 80 ? "Xuất sắc!" : percentage >= 50 ? "Đạt yêu cầu" : "Cần cố gắng";
String badgeIcon = percentage >= 80 ? "fa-trophy" : percentage >= 50 ? "fa-thumbs-up" : "fa-book";
%>
<div class="container">
        <h2 style="text-align: center">
            <i class="fas fa-clipboard-check mr-3"></i>Kết quả bài kiểm tra
        </h2>
        
        <div class="result-card">
            <div class="result-header">
                <h3>
                    <i class="fas fa-graduation-cap mr-3"></i>
                    <%=exam.getExamName()%>
                </h3>
            </div>
            
            <div class="result-body">
                <div class="score-display">
                    <span class="result-badge <%=badgeClass%>">
                        <i class="fas <%=badgeIcon%> mr-2"></i><%=badgeText%>
                    </span>
                    <div class="score-circle">
                        <div class="score-value"><%=result.getScore()%></div>
                    </div>
                    <div class="score-label">Điểm số của bạn</div>
                </div>

                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-check-circle" style="color: #28a745;"></i>
                        </div>
                        <div class="stat-value"><%=result.getRightAnswer()%></div>
                        <div class="stat-label">Câu đúng</div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-times-circle" style="color: #dc3545;"></i>
                        </div>
                        <div class="stat-value"><%=result.getTotalQuestion() - result.getRightAnswer()%></div>
                        <div class="stat-label">Câu sai</div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-list-ol" style="color: #2596be;"></i>
                        </div>
                        <div class="stat-value"><%=result.getTotalQuestion()%></div>
                        <div class="stat-label">Tổng số câu</div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-percentage" style="color: #ffc107;"></i>
                        </div>
                        <div class="stat-value"><%=String.format("%.1f", percentage)%>%</div>
                        <div class="stat-label">Tỷ lệ đúng</div>
                    </div>
                </div>

                <div class="action-buttons">
                    <a href="ExamDetail?examID=<%=examID%>" class="btn-action btn-retry">
                        <i class="fas fa-redo-alt"></i>
                        <span>Làm lại</span>
                    </a>
                    <a href="testhistory.jsp" class="btn-action btn-back">
                        <i class="fas fa-arrow-left"></i>
                        <span>Lịch sử thi</span>
                    </a>
                    <a href="PassDataResultDetail?testID=<%=test.getTestID()%>" class="btn-action btn-detail">
                        <i class="fas fa-eye"></i>
                        <span>Xem chi tiết</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <%
        }
    %>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
