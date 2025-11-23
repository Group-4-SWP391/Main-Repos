<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<jsp:include page="header.jsp"></jsp:include>
    <style>
        /* Modern UI Styling */
        :root {
            --primary-color: #0d6efd;
            --danger-color: #dc3545;
            --success-color: #198754;
            --warning-color: #ffc107;
            --light-bg: #f8f9fa;
            --card-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
            --card-shadow-hover: 0 0.5rem 1rem rgba(0,0,0,0.15);
        }

        /* Action Bar Styling */
        .action-bar {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            margin-bottom: 1.5rem;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }

        .action-bar .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 0.5rem 1.25rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: 1px solid transparent;
        }

        .action-bar .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-back {
            background: #6c757d;
            color: white !important;
            text-decoration: none;
            border-color: #6c757d;
        }

        .btn-back:hover {
            background: #5a6268;
            border-color: #545b62;
        }

        .btn-add {
            background: var(--success-color);
            color: white;
            border-color: var(--success-color);
        }

        .btn-add:hover {
            background: #146c43;
            border-color: #146c43;
        }

        .btn-edit-time {
            background: var(--warning-color);
            color: #000;
            border-color: var(--warning-color);
        }

        .btn-edit-time:hover {
            background: #ffcd39;
            border-color: #ffcd39;
        }

        .btn-edit-price {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        .btn-edit-price:hover {
            background: #0b5ed7;
            border-color: #0b5ed7;
        }

        .btn-edit-difficulty {
            background: #6f42c1;
            color: white;
            border-color: #6f42c1;
        }

        .btn-edit-difficulty:hover {
            background: #5a32a3;
            border-color: #5a32a3;
        }
        
        /* Difficulty Badge Styling */
        .difficulty-badge-easy {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .difficulty-badge-medium {
            background: linear-gradient(135deg, #ffc107 0%, #ff9800 100%);
            color: #000;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .difficulty-badge-hard {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .btn-change-difficulty {
            background: #6f42c1;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-change-difficulty:hover {
            background: #5a32a3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(111,66,193,0.3);
        }

        /* Card Styling */
        .exam-card {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: box-shadow 0.3s ease;
        }

        .exam-card:hover {
            box-shadow: var(--card-shadow-hover);
        }

        .card-body {
            padding: 2rem;
        }

        /* Table Styling */
        .modern-table {
            width: 100%;
            margin-bottom: 0;
        }

        .modern-table thead {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0b5ed7 100%);
        }

        .modern-table thead th {
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: 0.5px;
            padding: 1.25rem 1rem;
            border: none;
        }

        .modern-table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid #e9ecef;
        }

        .modern-table tbody tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .modern-table tbody td {
            padding: 1.25rem 1rem;
            vertical-align: middle;
        }

        /* Question Cell Styling */
        .question-cell {
            max-width: 300px;
        }

        .question-text {
            color: #495057;
            line-height: 1.6;
            margin: 0;
        }

        .question-img {
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .question-img:hover {
            transform: scale(1.05);
        }

        /* Answer Cell Styling */
        .answer-cell {
            max-width: 350px;
        }

        .answer-text {
            color: #28a745;
            font-weight: 500;
        }

        /* Action Buttons in Table */
        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
            justify-content: center;
        }

        .btn-view-detail {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-view-detail:hover {
            background: #0b5ed7;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(13,110,253,0.3);
        }

        .btn-delete {
            background: var(--danger-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-delete:hover {
            background: #bb2d3b;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220,53,69,0.3);
        }

        /* Modal Improvements */
        .modal {
            z-index: 1050 !important;
        }
        
        .modal-backdrop {
            z-index: 1040 !important;
            background-color: rgba(0,0,0,0.5) !important;
        }

        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            z-index: 1051 !important;
            position: relative;
        }

        .modal-header {
            border-radius: 16px 16px 0 0;
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .modal-title {
            font-weight: 600;
            font-size: 1.25rem;
        }

        .modal-body {
            padding: 2rem;
        }

        .modal-footer {
            padding: 1.5rem;
            border-top: 1px solid #e9ecef;
        }
        
        /* Ensure modal is visible */
        .modal.show {
            display: block !important;
        }
        
        .modal.fade.show {
            opacity: 1 !important;
        }
        
        /* Fix modal positioning */
        .modal {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
            height: 100% !important;
            overflow: auto !important;
        }
        
        .modal-dialog {
            margin: 1.75rem auto !important;
            position: relative !important;
            z-index: 1051 !important;
        }
        
        /* Ensure modal content is visible */
        .modal-content {
            position: relative !important;
            z-index: 1052 !important;
            background-color: #fff !important;
        }
        
        /* Fix backdrop */
        body.modal-open {
            overflow: hidden !important;
        }
        
        body.modal-open .modal-backdrop {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
            height: 100% !important;
            z-index: 1040 !important;
            background-color: rgba(0,0,0,0.5) !important;
        }

        /* Form Styling */
        .form-group-modern {
            margin-bottom: 1.5rem;
        }

        .form-label-modern {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control-modern {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control-modern:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,0.1);
        }

        .form-select-modern {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-select-modern:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,0.1);
        }

        /* Time Input Styling */
        .time-input-group {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .time-input-item {
            flex: 1;
            text-align: center;
        }

        .time-input-label {
            display: block;
            font-weight: 600;
            color: #6c757d;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .time-input-field {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1.5rem;
            font-weight: 600;
            text-align: center;
            transition: all 0.3s ease;
        }

        .time-input-field:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,0.1);
        }

        /* Header Edit Button */
        .edit-title-btn {
            background: rgba(255,255,255,0.2);
            border: 2px solid rgba(255,255,255,0.5);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            margin-left: 1rem;
            cursor: pointer;
        }

        .edit-title-btn:hover {
            background: rgba(255,255,255,0.3);
            border-color: rgba(255,255,255,0.8);
            transform: scale(1.1);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
        }

        .empty-state h3 {
            color: #6c757d;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: #adb5bd;
            font-size: 1.125rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .action-bar {
                flex-direction: column;
            }

            .action-bar .btn {
                width: 100%;
                justify-content: center;
            }

            .action-buttons {
                flex-direction: column;
                width: 100%;
            }

            .btn-view-detail,
            .btn-delete {
                width: 100%;
                justify-content: center;
            }

            .modern-table {
                font-size: 0.875rem;
            }

            .time-input-group {
                flex-direction: column;
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animated-item {
            animation: fadeIn 0.5s ease forwards;
        }

        /* Badge Styling */
        .badge-modern {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .badge-free {
            background: #d4edda;
            color: #155724;
        }

        .badge-paid {
            background: #fff3cd;
            color: #856404;
        }

        /* Icon spacing utility */
        .me-1 { margin-right: 0.25rem; }
        .me-2 { margin-right: 0.5rem; }
        .mb-0 { margin-bottom: 0; }
        .mb-3 { margin-bottom: 1rem; }
        .mb-4 { margin-bottom: 1.5rem; }
        .mt-2 { margin-top: 0.5rem; }
        .py-3 { padding-top: 1rem; padding-bottom: 1rem; }
        .d-block { display: block; }
        .d-flex { display: flex; }

        /* Page header styling */
        .page-header h3 {
            font-size: 1.25rem;
            font-weight: 400;
            margin-top: 1rem;
        }

        /* Smooth scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Loading animation for images */
        img {
            object-fit: cover;
        }

        /* Back to top button enhancement */
        .back-to-top {
            position: fixed;
            visibility: hidden;
            opacity: 0;
            right: 15px;
            bottom: 15px;
            z-index: 996;
            background: var(--primary-color);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            transition: all 0.4s;
            box-shadow: 0 4px 12px rgba(13,110,253,0.3);
        }

        .back-to-top:hover {
            background: #0b5ed7;
            transform: translateY(-5px);
        }

        .back-to-top.active {
            visibility: visible;
            opacity: 1;
        }

        /* Print styles */
        @media print {
            .action-bar,
            .btn,
            .back-to-top {
                display: none !important;
            }
        }
    </style>
    <script>
        var container = document.getElementById("tagID");
        if (container) {
            var tag = container.getElementsByClassName("tag");
            var current = container.getElementsByClassName("active");
            if (current.length > 0) {
                current[0].className = current[0].className.replace(" active", "");
            }
        }
    </script>

<%
if(session.getAttribute("examID") != null){
int examID = (Integer)session.getAttribute("examID");
Exam currentExam = new ExamDAO().getExamByID(examID);
List<QuestionBank> qbs = new ExamDAO().getAllQuestionByExamID(examID);
session.setAttribute("backlink", "viewallquestion.jsp");
Users user = (Users)session.getAttribute("currentUser");
String backlink = "ViewAllExamTeacher.jsp";
if(user.getRole() == 1) backlink = "view-all-exam.jsp";
int hour = currentExam.getTimer() / 3600;
int minute = (currentExam.getTimer() % 3600) / 60;
%>
<div class="container-fluid bg-primary py-5 mb-5 page-header">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-white animated slideInDown">
                    <%=currentExam.getExamName()%>
                    <button data-toggle="modal" data-target="#editname" class="edit-title-btn">
                        <i class="fas fa-pen"></i>
                    </button>
                </h1>
                <div class="modal fade" id="editname" tabindex="-1" role="dialog" aria-labelledby="threadModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <form action="ChangeExamName" method="POST">
                                <div class="modal-header bg-primary text-white">
                                    <h5 class="modal-title" id="threadModalLabel">
                                        <i class="fas fa-edit me-2"></i>Đổi tên đề thi
                                    </h5>
                                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close" style="opacity: 1;">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="examID" value="<%=examID%>"/>
                                    <div class="form-group-modern">
                                        <label for="examName" class="form-label-modern">
                                            <i class="fas fa-file-alt me-2"></i>Tên đề thi:
                                        </label>
                                        <input type="text" id="examName" name="examName" class="form-control-modern" 
                                               value="<%=currentExam.getExamName()%>" required 
                                               placeholder="Nhập tên đề thi...">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-light" data-dismiss="modal">
                                        <i class="fas fa-times me-2"></i>Huỷ
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-check me-2"></i>Đổi tên
                                    </button>
                                </div>
                            </form>
                        </div> 
                    </div>                        
                </div> 
                <h3 class="text-white animated slideInDown">Dưới đây là danh sách những câu hỏi trong bài kiểm tra <%=currentExam.getExamName()%></h3>
            </div>
        </div>
    </div>
</div>
<main id="main" class="main" style="margin-left: 0">
    <section class="section" style="margin: auto;justify-content: center">
        <div class="row">
            <div class="col-lg-12">
                <div class="action-bar animated-item">
                    <% if (user.getRole() == 1) { %>
                    <a href="view-all-exam.jsp" class="btn btn-back">
                        <i class="fas fa-arrow-left"></i>
                        <span>Trở về</span>
                    </a>
                    <% } else { %>
                    <a href="ViewAllExamTeacher.jsp" class="btn btn-back">
                        <i class="fas fa-arrow-left"></i>
                        <span>Trở về</span>
                    </a>
                    <% } %>
                    
                    <form action="PassDataExamAdd" method="POST" onsubmit="notifyNotApproved(<%= examID %>)" style="margin: 0;">
                        <input type="hidden" name="examID" value="<%= examID %>" />
                        <button class="btn btn-add" type="submit">
                            <i class="fas fa-plus-circle"></i>
                            <span>Thêm câu hỏi</span>
                        </button>
                    </form>
                    
                    <button class="btn btn-edit-time" data-toggle="modal" data-target="#editTime">
                        <i class="fas fa-clock"></i>
                        <span>Thay đổi thời gian</span>
                    </button>
                    
                    <button class="btn btn-edit-price" data-toggle="modal" data-target="#editPrice">
                        <i class="fas fa-coins"></i>
                        <span>Thay đổi giá tiền</span>
                    </button>
                    
                    <button class="btn btn-edit-difficulty" data-toggle="modal" data-target="#editDifficulty">
                        <i class="fas fa-signal"></i>
                        <span>Thay đổi độ khó</span>
                    </button>
                </div>
                <div class="modal fade" id="editTime" tabindex="-1" role="dialog" aria-labelledby="threadModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <form action="ChangeExamTime" method="POST">
                                <div class="modal-header bg-warning">
                                    <h5 class="modal-title" id="threadModalLabel">
                                        <i class="fas fa-clock me-2"></i>Đổi thời gian làm bài
                                    </h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="examID" value="<%=examID%>"/>
                                    <div class="form-group-modern">
                                        <label class="form-label-modern">
                                            <i class="fas fa-hourglass-half me-2"></i>Tổng thời gian làm bài:
                                        </label>
                                        <div class="time-input-group">
                                            <div class="time-input-item">
                                                <label class="time-input-label">
                                                    <i class="fas fa-clock"></i> Giờ
                                                </label>
                                                <input type="number" name="examHours" min="0" max="24" 
                                                       value="<%=hour%>" required class="time-input-field"
                                                       placeholder="0">
                                            </div>
                                            <div class="time-input-item">
                                                <label class="time-input-label">
                                                    <i class="fas fa-stopwatch"></i> Phút
                                                </label>
                                                <input type="number" name="examMinutes" min="0" max="59" 
                                                       value="<%=minute%>" required class="time-input-field"
                                                       placeholder="0">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-light" data-dismiss="modal">
                                        <i class="fas fa-times me-2"></i>Huỷ
                                    </button>
                                    <button type="submit" class="btn btn-warning">
                                        <i class="fas fa-check me-2"></i>Đổi thời gian
                                    </button>
                                </div>
                            </form>
                        </div> 
                    </div>                        
                </div> 

                <div class="modal fade" id="editPrice" tabindex="-1" role="dialog" aria-labelledby="threadModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <form action="UpdatePriceExam" method="POST" onsubmit="notifyNotApproved(<%= examID %>)">
                                <div class="modal-header bg-primary text-white">
                                    <h5 class="modal-title" id="threadModalLabel">
                                        <i class="fas fa-coins me-2"></i>Đổi giá tiền bài kiểm tra
                                    </h5>
                                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close" style="opacity: 1;">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="examID" value="<%=examID%>"/>
                                    <div class="form-group-modern">
                                        <label class="form-label-modern">
                                            <i class="fas fa-tag me-2"></i>Giá tiền bài kiểm tra:
                                        </label>
                                        <select class="form-select-modern" id="validationDefault04" name="price" required>
                                            <option value="0" selected>
                                                <i class="fas fa-gift"></i> Miễn phí
                                            </option>
                                            <option value="10">
                                                <i class="fas fa-coins"></i> 10 coin
                                            </option>
                                            <option value="20">
                                                <i class="fas fa-coins"></i> 20 coin
                                            </option>
                                            <option value="30">
                                                <i class="fas fa-coins"></i> 30 coin
                                            </option>                   
                                        </select>
                                        <small class="text-muted mt-2 d-block">
                                            <i class="fas fa-info-circle me-1"></i>Chọn giá tiền phù hợp cho bài kiểm tra của bạn
                                        </small>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-light" data-dismiss="modal">
                                        <i class="fas fa-times me-2"></i>Huỷ
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-check me-2"></i>Đổi giá tiền
                                    </button>
                                </div>
                            </form>
                        </div> 
                    </div>                        
                </div>

                <div class="modal fade" id="editDifficulty" tabindex="-1" role="dialog" aria-labelledby="difficultyModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <form action="ChangeExamDifficulty" method="POST" onsubmit="notifyNotApproved(<%= examID %>)">
                                <div class="modal-header text-white" style="background: linear-gradient(135deg, #6f42c1 0%, #5a32a3 100%);">
                                    <h5 class="modal-title" id="difficultyModalLabel">
                                        <i class="fas fa-signal me-2"></i>Thay đổi độ khó bài kiểm tra
                                    </h5>
                                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close" style="opacity: 1;">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="examID" value="<%=examID%>"/>
                                    <div class="form-group-modern">
                                        <label class="form-label-modern">
                                            <i class="fas fa-signal me-2"></i>Chọn độ khó mới cho bài kiểm tra:
                                        </label>
                                        <%
                                        int examDifficulty = currentExam.getDifficultyLevel();
                                        String examDifficultyBadgeClass = "";
                                        String examDifficultyText = "";
                                        String examDifficultyIcon = "";
                                        if(examDifficulty == 1) {
                                            examDifficultyBadgeClass = "difficulty-badge-easy";
                                            examDifficultyText = "Dễ";
                                            examDifficultyIcon = "fa-smile";
                                        } else if(examDifficulty == 2) {
                                            examDifficultyBadgeClass = "difficulty-badge-medium";
                                            examDifficultyText = "Vừa";
                                            examDifficultyIcon = "fa-meh";
                                        } else {
                                            examDifficultyBadgeClass = "difficulty-badge-hard";
                                            examDifficultyText = "Khó";
                                            examDifficultyIcon = "fa-frown";
                                        }
                                        %>
                                        <select class="form-select-modern" name="difficultyLevel" required>
                                            <option value="1" <%=examDifficulty == 1 ? "selected" : ""%>>Dễ</option>
                                            <option value="2" <%=examDifficulty == 2 ? "selected" : ""%>>Vừa</option>
                                            <option value="3" <%=examDifficulty == 3 ? "selected" : ""%>>Khó</option>
                                        </select>
                                        <small class="text-muted mt-2 d-block">
                                            <i class="fas fa-info-circle me-1"></i>Độ khó hiện tại: 
                                            <span class="<%=examDifficultyBadgeClass%>" style="font-size: 0.8rem;">
                                                <i class="fas <%=examDifficultyIcon%>"></i>
                                                <%=examDifficultyText%>
                                            </span>
                                        </small>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-light" data-dismiss="modal">
                                        <i class="fas fa-times me-2"></i>Hủy
                                    </button>
                                    <button type="submit" class="btn text-white" style="background: linear-gradient(135deg, #6f42c1 0%, #5a32a3 100%);">
                                        <i class="fas fa-check me-2"></i>Thay đổi độ khó
                                    </button>
                                </div>
                            </form>
                        </div> 
                    </div>                        
                </div>

                <div class="exam-card animated-item">
                    <div class="card-body">
                        <%
                        if(qbs.size() > 0){
                        %>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4 class="mb-0">
                                <i class="fas fa-list-alt me-2 text-primary"></i>
                                Danh sách câu hỏi (<span class="text-primary"><%=qbs.size()%></span> câu)
                            </h4>
                            <div class="badge-modern <%=currentExam.getPrice() == 0 ? "badge-free" : "badge-paid"%>">
                                <i class="fas <%=currentExam.getPrice() == 0 ? "fa-gift" : "fa-coins"%> me-1"></i>
                                <%=currentExam.getPrice() == 0 ? "Miễn phí" : currentExam.getPrice() + " coin"%>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table modern-table">
                                <thead>
                                    <tr>
                                        <th style="width: 5%;">
                                            <i class="fas fa-hashtag"></i>
                                        </th>
                                        <th style="width: 40%;">
                                            <i class="fas fa-question-circle me-2"></i>Câu hỏi
                                        </th>
                                        <th style="width: 40%;">
                                            <i class="fas fa-check-circle me-2"></i>Câu trả lời đúng
                                        </th>
                                        <th style="width: 20%; text-align: center;">
                                            <i class="fas fa-cog me-2"></i>Tác vụ
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                <!--bai dang-->
                                <%
                                String context;
                                String answer;
                                for(int i = 0; i < qbs.size(); i++){
                                    QuestionBank qb = qbs.get(i);
                                    if(qb.getQuestionContext().length() > 40){ 
                                        context = qb.getQuestionContext().substring(0, 40) + "...";
                                    }
                                    else if(qb.getQuestionContext().length() == 0){
                                        context = qb.getQuestionImg();
                                    }
                                    else context = qb.getQuestionContext();
                                    if(qb.getChoiceCorrect().startsWith("uploads/docreader")){
                                        answer = qb.getChoiceCorrect();
                                    }
                                    else{
                                        if(qb.getChoiceCorrect().length() > 60) 
                                            answer = qb.getChoiceCorrect().substring(0, 60) + "...";
                                        else answer = qb.getChoiceCorrect();
                                    }
                                    String modalId = "threadModal" + i;
                                %>
                                <tr class="animated-item" style="animation-delay: <%=(i * 0.05)%>s;">
                                    <td class="text-center">
                                        <span class="badge bg-light text-dark" style="font-size: 1rem; font-weight: 600;">
                                            <%=(i + 1)%>
                                        </span>
                                    </td>
                                    <%
                                    if(context.startsWith("uploads/docreader")){
                                    %>
                                    <td class="question-cell">
                                        <img src="<%=context%>" class="question-img" width="120" height="auto" alt="Question Image"/>
                                    </td>
                                    <%
                                        }
                                    else{
                                    %>
                                    <td class="question-cell">
                                        <p class="question-text mb-0">
                                            <i class="fas fa-quote-left text-muted me-2" style="font-size: 0.75rem;"></i>
                                            <%=context%>
                                        </p>
                                    </td>
                                    <%
                                        }
                                    %>
                                    <%
                                    if(answer.startsWith("uploads/docreader")){
                                    %>
                                    <td class="answer-cell">
                                        <img src="<%=answer%>" class="question-img" width="150" height="auto" alt="Answer Image"/>
                                    </td>
                                    <%
                                        }
                                    else{
                                    %>
                                    <td class="answer-cell">
                                        <p class="answer-text mb-0">
                                            <i class="fas fa-check-circle me-2"></i>
                                            <%=answer%>
                                        </p>
                                    </td>
                                    <%
                                        }
                                    %>
                                    <td>
                                        <div class="action-buttons">
                                            <form action="ViewQuestionDetail" method="POST" style="margin: 0;">
                                                <input type="hidden" name="questionID" value="<%=qb.getQuestionId()%>">
                                                <button type="submit" class="btn-view-detail">
                                                    <i class="fas fa-eye"></i>
                                                    <span>Chi tiết</span>
                                                </button>
                                            </form>
                                            <button class="btn-delete" type="button" data-toggle="modal" data-target="#<%= modalId %>">
                                                <i class="fas fa-trash-alt"></i>
                                                <span>Xoá</span>
                                            </button>
                                        </div>

                                        <!-- Modal for deleting question -->
                                        <div class="modal fade" id="<%= modalId %>" tabindex="-1" role="dialog" aria-labelledby="threadModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <form action="DeleteQuestionInExam" method="POST">
                                                        <input type="hidden" name="examID" value="<%=examID%>">
                                                        <input type="hidden" name="questionID" value="<%=qb.getQuestionId()%>">
                                                        <div class="modal-header bg-danger text-white">
                                                            <h5 class="modal-title" id="threadModalLabel">
                                                                <i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa câu hỏi
                                                            </h5>
                                                            <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close" style="opacity: 1;">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="text-center py-3">
                                                                <i class="fas fa-trash-alt text-danger mb-3" style="font-size: 3rem;"></i>
                                                                <p class="mb-0" style="font-size: 1.1rem; color: #495057;">
                                                                    Bạn có chắc chắn muốn xóa câu hỏi <strong>số <%=(i + 1)%></strong> khỏi đề thi này không?
                                                                </p>
                                                                <p class="text-muted mt-2 mb-0" style="font-size: 0.9rem;">
                                                                    <i class="fas fa-info-circle me-1"></i>Hành động này không thể hoàn tác!
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-light" data-dismiss="modal">
                                                                <i class="fas fa-times me-2"></i>Hủy
                                                            </button>
                                                            <button type="submit" class="btn btn-danger">
                                                                <i class="fas fa-trash me-2"></i>Xóa câu hỏi
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div> 
                                            </div>                        
                                        </div>      




                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                                <!--ket thuc bai dang-->
                                </tbody>
                            </table>
                        </div>
                        <%
                          }
                          else{
                        %>
                        <div class="empty-state">
                            <i class="fas fa-inbox text-muted mb-3" style="font-size: 4rem; opacity: 0.5;"></i>
                            <h3>Chưa có câu hỏi nào!</h3>
                            <p>Hãy thêm câu hỏi đầu tiên cho đề thi của bạn</p>
                            <form action="PassDataExamAdd" method="POST" onsubmit="notifyNotApproved(<%= examID %>)" style="margin-top: 1.5rem;">
                                <input type="hidden" name="examID" value="<%= examID %>" />
                                <button class="btn btn-add" type="submit">
                                    <i class="fas fa-plus-circle"></i>
                                    <span>Thêm câu hỏi đầu tiên</span>
                                </button>
                            </form>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>

            </div>
        </div>
    </section>

</main><!-- End #main -->

<!-- Vendor JS Files -->
<script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendor/chart.js/chart.umd.js"></script>
<script src="assets/vendor/echarts/echarts.min.js"></script>
<script src="assets/vendor/quill/quill.js"></script>
<script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="assets/vendor/tinymce/tinymce.min.js"></script>
<script src="assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="assets/js/main.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"></script>
<script>
    document.addEventListener("DOMContentLoaded", function (event) {
        // Restore scroll position
        var scrollpos = localStorage.getItem('scrollpos');
        if (scrollpos)
            window.scrollTo(0, scrollpos);

        // Back to top button
        let backtotop = document.querySelector('.back-to-top');
        if (backtotop) {
            const toggleBacktotop = () => {
                if (window.scrollY > 100) {
                    backtotop.classList.add('active');
                } else {
                    backtotop.classList.remove('active');
                }
            }
            window.addEventListener('scroll', toggleBacktotop);
            toggleBacktotop();
        }

        // Add smooth animations to table rows
        const tableRows = document.querySelectorAll('.modern-table tbody tr');
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        tableRows.forEach(row => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(20px)';
            row.style.transition = 'all 0.5s ease';
            observer.observe(row);
        });

        // Form validation enhancement
        const forms = document.querySelectorAll('form[action*="Change"], form[action*="Update"]');
        forms.forEach(form => {
            form.addEventListener('submit', function(e) {
                console.log('Form submitting:', this.action);
                const submitBtn = this.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                }
            });
        });
        
        // Specific handler for difficulty form
        const difficultyForm = document.querySelector('form[action="ChangeExamDifficulty"]');
        if (difficultyForm) {
            difficultyForm.addEventListener('submit', function(e) {
                console.log('Difficulty form submitting');
                const difficultyLevel = this.querySelector('select[name="difficultyLevel"]').value;
                const examID = this.querySelector('input[name="examID"]').value;
                console.log('Difficulty Level:', difficultyLevel, 'Exam ID:', examID);
                
                // Validate before submit
                if (!difficultyLevel || !examID) {
                    e.preventDefault();
                    alert('Vui lòng chọn độ khó!');
                    return false;
                }
            });
        }
        
        // Try to use Bootstrap modal if available
        if (typeof jQuery !== 'undefined' && jQuery.fn.modal) {
            jQuery('[data-toggle="modal"]').on('click', function() {
                const target = jQuery(this).data('target');
                if (target) {
                    jQuery(target).modal('show');
                }
            });
        }

        // Image lazy loading
        const images = document.querySelectorAll('img');
        images.forEach(img => {
            img.addEventListener('load', function() {
                this.style.opacity = '1';
            });
            img.style.opacity = '0';
            img.style.transition = 'opacity 0.3s ease';
        });
        
        // Fix modal display issues - Enhanced version
        function showModal(modalId) {
            const modal = document.querySelector(modalId);
            if (modal) {
                // Remove any existing backdrops
                const existingBackdrops = document.querySelectorAll('.modal-backdrop');
                existingBackdrops.forEach(b => b.remove());
                
                // Create new backdrop
                const backdrop = document.createElement('div');
                backdrop.className = 'modal-backdrop fade show';
                backdrop.style.zIndex = '1040';
                document.body.appendChild(backdrop);
                
                // Show modal
                modal.style.display = 'block';
                modal.style.zIndex = '1050';
                modal.classList.add('show');
                document.body.classList.add('modal-open');
                
                // Force reflow
                modal.offsetHeight;
                
                // Fade in
                setTimeout(() => {
                    modal.style.opacity = '1';
                }, 10);
            }
        }
        
        function hideModal(modalId) {
            const modal = document.querySelector(modalId);
            if (modal) {
                modal.style.opacity = '0';
                setTimeout(() => {
                    modal.style.display = 'none';
                    modal.classList.remove('show');
                    document.body.classList.remove('modal-open');
                    const backdrop = document.querySelector('.modal-backdrop');
                    if (backdrop) {
                        backdrop.remove();
                    }
                }, 150);
            }
        }
        
        // Handle modal open buttons
        document.querySelectorAll('[data-toggle="modal"]').forEach(button => {
            button.addEventListener('click', function(e) {
                e.preventDefault();
                const targetId = this.getAttribute('data-target');
                console.log('Modal button clicked, target:', targetId);
                if (targetId) {
                    showModal(targetId);
                }
            });
        });
        
        // Specific handler for difficulty button
        const difficultyBtn = document.querySelector('[data-target="#editDifficulty"]');
        if (difficultyBtn) {
            difficultyBtn.addEventListener('click', function(e) {
                console.log('Difficulty button clicked');
                e.preventDefault();
                const modal = document.querySelector('#editDifficulty');
                if (modal) {
                    console.log('Modal found, showing...');
                    showModal('#editDifficulty');
                } else {
                    console.error('Modal #editDifficulty not found!');
                }
            });
        }
        
        // Handle modal close buttons
        document.querySelectorAll('[data-dismiss="modal"]').forEach(button => {
            button.addEventListener('click', function(e) {
                e.preventDefault();
                const modal = this.closest('.modal');
                if (modal) {
                    hideModal('#' + modal.id);
                }
            });
        });
        
        // Close modal when clicking on backdrop
        document.addEventListener('click', function(e) {
            if (e.target.classList.contains('modal-backdrop')) {
                const openModal = document.querySelector('.modal.show');
                if (openModal) {
                    hideModal('#' + openModal.id);
                }
            }
        });
    });

    window.onbeforeunload = function (e) {
        localStorage.setItem('scrollpos', window.scrollY);
    };

    function notifyNotApproved(examID) {
        fetch('NotApprovedExamServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `examID=${examID}`
        }).then(response => response.text())
                .then(result => console.log("Exam status updated: " + result))
                .catch(error => console.error("Error updating exam status: ", error));
    }
</script>
<%
    }
%>
<jsp:include page="footer.jsp"></jsp:include>

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
