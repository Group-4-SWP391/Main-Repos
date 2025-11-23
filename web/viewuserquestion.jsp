<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<jsp:include page="header.jsp"></jsp:include>
<style>
        /* Modern UI Styling */
        :root {
            --primary-color: #2596be;
            --primary-light: #e0f2f7;
            --primary-hover: #1a7a9e;
            --danger-color: #dc3545;
            --success-color: #198754;
            --card-shadow: 0 2px 8px rgba(0,0,0,0.08);
            --card-shadow-hover: 0 4px 16px rgba(0,0,0,0.12);
        }

        /* Action Bar */
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
        }

        .btn-add {
            background: var(--success-color);
            color: white;
            border-color: var(--success-color);
        }

        .btn-add:hover {
            background: #146c43;
        }

        /* Table Styling */
        .modern-table {
            width: 100%;
            margin-bottom: 0;
        }

        .modern-table thead {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9e 100%);
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

        /* Question Cell */
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
            max-width: 120px;
            height: auto;
        }

        .question-img:hover {
            transform: scale(1.05);
        }

        /* Answer Cell */
        .answer-cell {
            max-width: 300px;
        }

        .answer-text {
            color: #28a745;
            font-weight: 500;
        }

        /* Action Buttons */
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
            background: #1a7a9e;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37,150,190,0.3);
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

        /* Modal */
        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        .modal-header {
            border-radius: 16px 16px 0 0;
            padding: 1.5rem;
        }

        .modal-header.bg-danger {
            background: linear-gradient(135deg, var(--danger-color) 0%, #bb2d3b 100%) !important;
        }

        /* Badge */
        .badge-subject {
            background: #e7f3ff;
            color: #0066cc;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
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

            .question-img {
                max-width: 100px;
            }
        }

        .me-1 { margin-right: 0.25rem; }
        .me-2 { margin-right: 0.5rem; }
        .me-3 { margin-right: 1rem; }
        .mb-0 { margin-bottom: 0; }
        .mb-3 { margin-bottom: 1rem; }
        .mb-4 { margin-bottom: 1.5rem; }
        .py-3 { padding-top: 1rem; padding-bottom: 1rem; }
        
        /* Override Bootstrap Primary Color */
        .bg-primary {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9e 100%) !important;
        }
        
        .text-primary {
            color: #2596be !important;
        }
</style>

<%
Users user = (Users)session.getAttribute("currentUser");
List<QuestionBank> qbs = new ExamDAO().getAllUserQuestionsByID(user.getUserID());
session.setAttribute("backlink", "viewuserquestion.jsp");
%>
<div class="container-fluid bg-primary py-5 mb-5 page-header">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-white animated slideInDown">
                    Câu hỏi của bạn
                </h1>
                <h3 class="text-white animated slideInDown">Dưới đây là danh sách những câu hỏi của bạn </h3>
            </div>
        </div>
    </div>
</div>
<main id="main" class="main" style="margin-left: 0">
    <section class="section" style="margin: auto;justify-content: center">
        <div class="container">
            <div class="action-bar animated-item">
                <a href="questionbank.jsp" class="btn btn-back">
                    <i class="fas fa-arrow-left"></i>
                    <span>Trở về</span>
                </a>
                <form action="PassDataQuestionAdd" method="POST" style="margin: 0;">
                    <input type="hidden" name="subjectID" value="subjectID"/>
                    <button class="btn btn-add" type="submit">
                        <i class="fas fa-plus-circle"></i>
                        <span>Thêm câu hỏi</span>
                    </button>
                </form>
            </div>
            
            <div class="exam-card animated-item">
                <div class="card-body">
                        <%
                        if(qbs.size() > 0){
                        %>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4 class="mb-0">
                                <i class="fas fa-list-alt mr-2 text-primary"></i>
                                Câu hỏi của bạn (<span class="text-primary"><%=qbs.size()%></span> câu)
                            </h4>
                        </div>
                        <div class="table-responsive">
                            <table class="table modern-table">
                                <thead>
                                    <tr>
                                        <th style="width: 5%;">
                                            <i class="fas fa-hashtag"></i>
                                        </th>
                                        <th style="width: 30%;">
                                            <i class="fas fa-question-circle mr-2"></i>Câu hỏi
                                        </th>
                                        <th style="width: 30%;">
                                            <i class="fas fa-check-circle mr-2"></i>Câu trả lời
                                        </th>
                                        <th style="width: 15%;">
                                            <i class="fas fa-book mr-2"></i>Môn học
                                        </th>
                                        <th style="width: 20%; text-align: center;">
                                            <i class="fas fa-cog mr-2"></i>Tác vụ
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                <!--bai dang-->
                                <%
                                String context;
                                String answer;
                                String subjectName;
                                int rowNum = 1;
                                for(int i = qbs.size() - 1; i >= 0; i--){
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
                                    
                                    subjectName = new SubjectDAO().getSubjectNameById(qb.getSubjectId());
                                %>
                                <tr class="animated-item" style="animation-delay: <%=(rowNum * 0.05)%>s;">
                                    <td class="text-center">
                                        <span class="badge bg-light text-dark" style="font-size: 1rem; font-weight: 600;">
                                            <%=rowNum%>
                                        </span>
                                    </td>
                                    <%
                                    if(context.startsWith("uploads/docreader")){
                                    %>
                                    <td class="question-cell">
                                        <img src="<%=context%>" class="question-img" alt="Question Image"/>
                                    </td>
                                    <%
                                        }
                                    else{
                                    %>
                                    <td class="question-cell">
                                        <p class="question-text">
                                            <i class="fas fa-quote-left text-muted mr-2" style="font-size: 0.75rem;"></i>
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
                                        <img src="<%=answer%>" class="question-img" alt="Answer Image"/>
                                    </td>
                                    <%
                                        }
                                    else{
                                    %>
                                    <td class="answer-cell">
                                        <p class="answer-text mb-0">
                                            <i class="fas fa-check-circle mr-2"></i>
                                            <%=answer%>
                                        </p>
                                    </td>
                                    <%
                                        }
                                    %>
                                    <td class="text-center">
                                        <span class="badge-subject">
                                            <i class="fas fa-book-open mr-1"></i>
                                            <%= subjectName %>
                                        </span>
                                    </td>
                                    
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

                                        <div class="modal fade" id="<%= modalId %>" tabindex="-1" role="dialog" aria-labelledby="threadModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <form action="DeleteQuestionInBank" method="POST">
                                                        <input type="hidden" name="questionID" value="<%=qb.getQuestionId()%>">
                                                        <input type="hidden" name="subjectID" value="<%=qb.getSubjectId()%>">
                                                        <div class="modal-header bg-danger text-white">
                                                            <h5 class="modal-title" id="threadModalLabel">
                                                                <i class="fas fa-exclamation-triangle mr-2"></i>Xác nhận xóa câu hỏi
                                                            </h5>
                                                            <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close" style="opacity: 1;">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="text-center py-3">
                                                                <i class="fas fa-trash-alt text-danger mb-3" style="font-size: 3rem;"></i>
                                                                <p class="mb-0" style="font-size: 1.1rem; color: #495057;">
                                                                    Bạn có chắc chắn muốn xóa câu hỏi <strong>số <%=rowNum%></strong> không?
                                                                </p>
                                                                <p class="text-muted mt-2 mb-0" style="font-size: 0.9rem;">
                                                                    <i class="fas fa-info-circle mr-1"></i>Hành động này không thể hoàn tác!
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-light" data-dismiss="modal">
                                                                <i class="fas fa-times mr-2"></i>Hủy
                                                            </button>
                                                            <button type="submit" class="btn btn-danger">
                                                                <i class="fas fa-trash mr-2"></i>Xóa câu hỏi
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div> 
                                            </div>                        
                                        </div>      
                                    </td>
                                </tr>
                                <%
                                    rowNum++;
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
                            <h3>Bạn chưa tạo câu hỏi nào!</h3>
                            <p class="text-muted">Hãy thêm câu hỏi đầu tiên của bạn</p>
                        </div>
                        <%
                            }
                        %>
                        <!--ket thuc bai dang-->
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
            var scrollpos = localStorage.getItem('scrollpos');
            if (scrollpos)
                window.scrollTo(0, scrollpos);
        });

        window.onbeforeunload = function (e) {
            localStorage.setItem('scrollpos', window.scrollY);
        };

</script>

<jsp:include page="footer.jsp"></jsp:include>
