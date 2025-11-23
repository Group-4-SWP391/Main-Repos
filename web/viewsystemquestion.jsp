<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Câu hỏi hệ thống</title>
    <style>
        /* Modern UI Styling */
        :root {
            --primary-color: #2596be;
            --success-color: #198754;
            --card-shadow: 0 2px 8px rgba(0,0,0,0.08);
            --card-shadow-hover: 0 4px 16px rgba(0,0,0,0.12);
        }

        /* Table Styling */
        .modern-table {
            width: 100%;
            margin-bottom: 0;
        }

        .modern-table thead {
            background: linear-gradient(135deg, var(--primary-color) 0%, #1a7a9e 100%);
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

        /* Button Styling */
        .btn-back {
            background: #6c757d;
            color: white !important;
            text-decoration: none;
            border-color: #6c757d;
            padding: 0.5rem 1.25rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
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
            background: #1a7a9e;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37,150,190,0.3);
        }

        /* Question and Answer cells */
        .question-cell {
            max-width: 400px;
        }

        .question-text {
            color: #495057;
            line-height: 1.6;
        }

        .answer-cell {
            max-width: 400px;
        }

        .answer-text {
            color: #28a745;
            font-weight: 500;
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

        /* Animation */
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

        /* Responsive */
        @media (max-width: 768px) {
            .modern-table {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<%
List<QuestionBank> qbs = (List<QuestionBank>)session.getAttribute("questionList");
session.setAttribute("backlink", "teacher.jsp");
%>
<div class="container-fluid py-5 mb-5 page-header" style="background: linear-gradient(135deg, #2596be 0%, #1a7a9e 100%);">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-white animated slideInDown">
                    <i class="fas fa-database mr-3"></i>Câu hỏi hệ thống
                </h1>
                <h3 class="text-white animated slideInDown">Kho câu hỏi được hệ thống cung cấp</h3>
            </div>
        </div>
    </div>
</div>
<main id="main" class="main" style="margin-left: 0">
    <section class="section" style="margin: auto;justify-content: center">
        <div class="container">
            <div class="mb-4 animated-item">
                <a href="questionbank.jsp" class="btn-back">
                    <i class="fas fa-arrow-left"></i>
                    <span>Trở về</span>
                </a>
            </div>
            
            <div class="exam-card animated-item">
                <div class="card-body">
                    <%
                    if(qbs != null && qbs.size() > 0){
                    %>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="mb-0">
                            <i class="fas fa-list-alt mr-2 text-primary"></i>
                            Danh sách câu hỏi (<span class="text-primary"><%=qbs.size()%></span> câu)
                        </h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table modern-table">
                            <thead>
                                <tr>
                                    <th style="width: 5%;">
                                        <i class="fas fa-hashtag"></i>
                                    </th>
                                    <th style="width: 45%;">
                                        <i class="fas fa-question-circle mr-2"></i>Câu hỏi
                                    </th>
                                    <th style="width: 35%;">
                                        <i class="fas fa-check-circle mr-2"></i>Câu trả lời
                                    </th>
                                    <th style="width: 15%; text-align: center;">
                                        <i class="fas fa-cog mr-2"></i>Tác vụ
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                String context;
                                String answer;
                                for(int i = 0; i < qbs.size(); i++){
                                    QuestionBank qb = qbs.get(i);
                                    if(qb.getQuestionContext().length() > 40) 
                                        context = qb.getQuestionContext().substring(0, 40) + "...";
                                    else context = qb.getQuestionContext();
                                    if(qb.getChoiceCorrect().length() > 60) 
                                        answer = qb.getChoiceCorrect().substring(0, 60) + "...";
                                    else answer = qb.getChoiceCorrect(); 
                                %>
                                <tr class="animated-item" style="animation-delay: <%=(i * 0.05)%>s;">
                                    <td class="text-center">
                                        <span class="badge bg-light text-dark" style="font-size: 1rem; font-weight: 600;">
                                            <%=(i + 1)%>
                                        </span>
                                    </td>
                                    <td class="question-cell">
                                        <p class="question-text mb-0">
                                            <i class="fas fa-quote-left text-muted mr-2" style="font-size: 0.75rem;"></i>
                                            <%=context%>
                                        </p>
                                    </td>
                                    <td class="answer-cell">
                                        <p class="answer-text mb-0">
                                            <i class="fas fa-check-circle mr-2"></i>
                                            <%=answer%>
                                        </p>
                                    </td>
                                    <td class="text-center">
                                        <form action="ViewQuestionDetail" method="POST" style="margin: 0;">
                                            <input type="hidden" name="questionID" value="<%=qb.getQuestionId()%>">
                                            <button type="submit" class="btn-view-detail">
                                                <i class="fas fa-eye"></i>
                                                <span>Chi tiết</span>
                                            </button>
                                        </form>     
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <%
                      }
                      else{
                    %>
                    <div class="empty-state">
                        <i class="fas fa-inbox text-muted mb-3" style="font-size: 4rem; opacity: 0.5;"></i>
                        <h3>Chưa có câu hỏi nào trong hệ thống!</h3>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </section>
</main>

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
        var scrollpos = localStorage.getItem('scrollpos');
        if (scrollpos)
            window.scrollTo(0, scrollpos);
    });

    window.onbeforeunload = function (e) {
        localStorage.setItem('scrollpos', window.scrollY);
    };
</script>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
