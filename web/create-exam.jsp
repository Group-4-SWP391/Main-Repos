<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="header.jsp"></jsp:include>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
    /* --- 1. Cấu trúc chính --- */
    body {
        background-color: #f0f2f5;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .main-container {
        max-width: 1200px;
        margin: 30px auto;
        padding: 0 15px;
    }

    /* --- 2. Cột trái: Thông tin cài đặt (Sticky) --- */
    .exam-settings-card {
        background: white;
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        position: sticky;
        top: 20px; /* Cố định khi cuộn trang */
        z-index: 100;
    }

    .form-label {
        font-weight: 600;
        color: #344767;
        margin-bottom: 8px;
        font-size: 0.9rem;
    }

    .form-control, .form-select {
        border-radius: 10px;
        padding: 10px 15px;
        border: 1px solid #dee2e6;
        font-size: 0.95rem;
    }

    .form-control:focus, .form-select:focus {
        border-color: #06BBCC;
        box-shadow: 0 0 0 0.2rem rgba(6, 187, 204, 0.25);
    }

    .input-group-text {
        border-radius: 0 10px 10px 0;
        background-color: #f8f9fa;
        color: #6c757d;
        border: 1px solid #dee2e6;
    }
    
    /* --- 3. Cột phải: Danh sách câu hỏi --- */
    .question-list-container {
        padding-bottom: 50px;
        overflow: visible !important;
    }
    
    .col-lg-8 {
        overflow: visible !important;
    }

    /* Card câu hỏi */
    .question-item-card {
        background: white;
        border-radius: 12px;
        padding: 15px 20px;
        margin-bottom: 15px;
        border: 1px solid #edf2f7;
        transition: all 0.25s ease;
        cursor: pointer;
        position: relative;
        box-shadow: 0 2px 5px rgba(0,0,0,0.02);
    }

    .question-item-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 15px rgba(0,0,0,0.08);
        border-color: #bfebf0;
    }

    /* Checkbox ẩn, style card khi được chọn */
    .q-checkbox {
        position: absolute;
        top: 15px;
        right: 15px;
        width: 22px;
        height: 22px;
        z-index: 10;
        cursor: pointer;
        accent-color: #06BBCC;
    }

    .question-item-card.selected {
        border: 2px solid #06BBCC;
        background-color: #f4fdfe;
    }

    .q-content {
        padding-right: 35px; /* Chừa chỗ cho checkbox */
        font-size: 0.95rem;
        color: #333;
        margin-bottom: 10px;
        line-height: 1.5;
    }
    
    .q-img-preview {
        max-height: 80px;
        border-radius: 6px;
        border: 1px solid #eee;
        margin-top: 8px;
        display: block;
    }

    /* --- 4. Badges & Buttons --- */
    .badge-level {
        font-size: 0.75rem;
        padding: 5px 10px;
        border-radius: 20px;
        font-weight: 600;
    }
    
    .btn-primary-custom {
        background: linear-gradient(135deg, #06BBCC 0%, #049aa9 100%);
        border: none;
        color: white;
        padding: 12px;
        border-radius: 10px;
        font-weight: 600;
        width: 100%;
        transition: all 0.3s;
    }
    
    .btn-primary-custom:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(6, 187, 204, 0.3);
        color: white;
    }

    .btn-outline-custom {
        border: 2px solid #06BBCC;
        color: #06BBCC;
        background: white;
        padding: 10px;
        border-radius: 10px;
        font-weight: 600;
        width: 100%;
        transition: all 0.3s;
    }

    .btn-outline-custom:hover {
        background: #06BBCC;
        color: white;
    }

    .modal-header { background: #06BBCC; color: white; }
    .modal-content { border-radius: 15px; border: none; overflow: hidden; }
    
    /* Difficulty Filter Dropdown */
    .dropdown {
        position: relative;
        z-index: 1000;
    }
    
    .dropdown-menu {
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        border-radius: 12px;
        padding: 8px;
        min-width: 220px;
        z-index: 1050;
        position: absolute !important;
        will-change: transform;
    }
    
    .dropdown-item {
        border-radius: 8px;
        padding: 10px 15px;
        margin-bottom: 4px;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
    }
    
    .dropdown-item:hover {
        background-color: #f0f9ff;
        color: #06BBCC;
        transform: translateX(5px);
    }
    
    .dropdown-item.active {
        background: linear-gradient(135deg, #06BBCC 0%, #049aa9 100%);
        color: white;
    }
    
    .dropdown-item.active:hover {
        background: linear-gradient(135deg, #049aa9 0%, #037d8a 100%);
        transform: translateX(0);
    }
    
    .btn-outline-primary {
        border: 2px solid #06BBCC;
        color: #06BBCC;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-outline-primary:hover {
        background: #06BBCC;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(6, 187, 204, 0.3);
    }
    
    /* Fix overflow issues */
    .main-container {
        overflow: visible !important;
    }
    
    .row {
        overflow: visible !important;
    }
    
    /* Ensure dropdown is always on top */
    .dropdown.show .dropdown-menu {
        display: block;
        animation: dropdownFadeIn 0.2s ease;
    }
    
    @keyframes dropdownFadeIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>

<%
if(session.getAttribute("subjectID") != null){
    int subjectID = (Integer)session.getAttribute("subjectID");
    Subjects subject = new ExamDAO().getSubjectByID(subjectID);
    List<QuestionBank> qbs = (List<QuestionBank>)session.getAttribute("questionList");
%>

<div class="main-container">
    <div class="mb-4">
        <a href="choosesubject.jsp" class="text-decoration-none text-secondary fw-bold">
            <i class="bi bi-arrow-left-circle-fill me-2 text-primary"></i>Trở về chọn môn
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger shadow-sm rounded-3 mb-4">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
        </div>
    </c:if>

    <form method="POST" action="CreateExam" id="createExamForm">
        <div class="row g-4">
            
            <div class="col-lg-4">
                <div class="exam-settings-card">
                    <h4 class="text-primary fw-bold mb-1">Cấu hình bài thi</h4>
                    <p class="text-muted small mb-4">Môn học: <strong><%=subject.getSubjectName()%></strong></p>
                    
                    <div class="mb-3">
                        <label class="form-label">Tên bài kiểm tra</label>
                        <div class="input-group">
                            <span class="input-group-text border-end-0 bg-white"><i class="bi bi-pencil text-primary"></i></span>
                            <input type="text" class="form-control border-start-0 ps-0" id="examName" name="examName" required placeholder="VD: Kiểm tra 15 phút...">
                        </div>
                    </div>

                    <div class="row g-2 mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Giá tiền</label>
                            <div class="input-group">
                                <input type="number" class="form-control" name="price" min="0" value="0" required placeholder="0">
                                <span class="input-group-text bg-light">Coin</span>
                            </div>
                            <div class="form-text text-muted small" style="font-size: 0.7rem; margin-top: 3px;">Nhập 0 để miễn phí</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Mức độ <span class="text-danger">*</span></label>
                            <select class="form-select" name="difficultyLevel" required>
                                <option value="1">🟢 Dễ</option>
                                <option value="2" selected>🟡 Vừa</option>
                                <option value="3">🔴 Khó</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Thời gian làm bài</label>
                        <div class="row g-2">
                            <div class="col-6">
                                <div class="input-group">
                                    <input type="number" min="0" class="form-control text-center" name="examHours" placeholder="0" required>
                                    <span class="input-group-text bg-light">Giờ</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <input type="number" min="0" class="form-control text-center" name="examMinutes" placeholder="0" required>
                                    <span class="input-group-text bg-light">Phút</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr class="text-muted opacity-25 my-4">

                    <input type="hidden" name="subjectID" value="<%=subject.getSubjectID()%>">
                    
                    <button type="submit" class="btn-primary-custom mb-3">
                        <i class="bi bi-check2-circle me-2"></i> Hoàn tất tạo bài
                    </button>
                    
                    <button type="button" class="btn-outline-custom" data-bs-toggle="modal" data-bs-target="#randomExamModal">
                        <i class="bi bi-magic me-2"></i> Tạo đề ngẫu nhiên
                    </button>
                </div>
            </div>

            <div class="col-lg-8" style="overflow: visible !important;">
                <div class="d-flex justify-content-between align-items-center mb-3" style="position: relative; z-index: 100;">
                    <div>
                        <h5 class="fw-bold text-dark mb-1">Ngân hàng câu hỏi</h5>
                        <small class="text-muted">Đã tìm thấy <strong id="questionCount"><%=qbs != null ? qbs.size() : 0%></strong> câu hỏi khả dụng</small>
                    </div>
                    
                    <!-- Filter by Difficulty -->
                    <div class="dropdown" style="position: relative;">
                        <% 
                            String difficultyFilter = request.getParameter("difficultyFilter");
                            if(difficultyFilter == null) difficultyFilter = "all";
                            String filterDisplay = "Tất cả mức độ";
                            if(difficultyFilter.equals("1")) filterDisplay = "🟢 Dễ";
                            else if(difficultyFilter.equals("2")) filterDisplay = "🟡 Vừa";
                            else if(difficultyFilter.equals("3")) filterDisplay = "🔴 Khó";
                        %>
                        <button class="btn btn-outline-primary dropdown-toggle" type="button" id="difficultyDropdown" data-bs-toggle="dropdown" aria-expanded="false" style="border-radius: 25px; padding: 8px 20px;">
                            <i class="bi bi-funnel me-2"></i><%= filterDisplay %>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0" aria-labelledby="difficultyDropdown" style="border-radius: 12px;">
                            <li><a class="dropdown-item <%= difficultyFilter.equals("all") ? "active" : "" %>" href="?difficultyFilter=all">
                                <i class="bi bi-list-ul me-2"></i>Tất cả mức độ
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item <%= difficultyFilter.equals("1") ? "active" : "" %>" href="?difficultyFilter=1">
                                <span class="badge bg-success me-2">Dễ</span> Câu hỏi dễ
                            </a></li>
                            <li><a class="dropdown-item <%= difficultyFilter.equals("2") ? "active" : "" %>" href="?difficultyFilter=2">
                                <span class="badge bg-warning text-dark me-2">Vừa</span> Câu hỏi vừa
                            </a></li>
                            <li><a class="dropdown-item <%= difficultyFilter.equals("3") ? "active" : "" %>" href="?difficultyFilter=3">
                                <span class="badge bg-danger me-2">Khó</span> Câu hỏi khó
                            </a></li>
                        </ul>
                    </div>
                </div>

                <div class="question-list-container">
                    <%
                    if (qbs != null && qbs.size() > 0) {
                        // Lọc câu hỏi theo độ khó
                        List<QuestionBank> filteredQbs = new ArrayList<>();
                        for(QuestionBank qb : qbs) {
                            if(difficultyFilter.equals("all") || 
                               (difficultyFilter.equals("1") && qb.getDifficultyLevel() == 1) ||
                               (difficultyFilter.equals("2") && qb.getDifficultyLevel() == 2) ||
                               (difficultyFilter.equals("3") && qb.getDifficultyLevel() == 3)) {
                                filteredQbs.add(qb);
                            }
                        }
                        
                        if(filteredQbs.size() == 0) {
                    %>
                            <div class="text-center py-5 bg-white rounded-3 shadow-sm">
                                <i class="bi bi-funnel-fill display-1 text-muted opacity-25"></i>
                                <p class="mt-3 text-muted fw-bold">Không tìm thấy câu hỏi nào với mức độ này.</p>
                                <a href="?" class="btn btn-outline-primary btn-sm mt-2">
                                    <i class="bi bi-arrow-counterclockwise me-1"></i>Xem tất cả
                                </a>
                            </div>
                    <%
                        } else {
                    %>
                            <script>
                                document.getElementById('questionCount').textContent = <%= filteredQbs.size() %>;
                            </script>
                    <%
                            for(int i = filteredQbs.size() - 1; i >= 0; i--){
                                QuestionBank qb = filteredQbs.get(i);
                            String context = qb.getQuestionContext();
                            String answer = qb.getChoiceCorrect();
                            String modalId = "modalDetail" + qb.getQuestionId();
                            
                            String displayContext = (context != null && context.length() > 120) ? context.substring(0, 120) + "..." : context;
                            if(displayContext == null || displayContext.isEmpty()) displayContext = "(Câu hỏi dạng hình ảnh)";
                            
                            int level = qb.getDifficultyLevel();
                            String badgeClass = "bg-secondary";
                            String levelText = "N/A";
                            if(level == 1) { badgeClass = "bg-success"; levelText = "Dễ"; }
                            else if(level == 2) { badgeClass = "bg-warning text-dark"; levelText = "Vừa"; }
                            else if(level == 3) { badgeClass = "bg-danger"; levelText = "Khó"; }
                    %>
                    
                    <div class="question-item-card" onclick="toggleSelect(this)">
                        <input type="checkbox" class="q-checkbox form-check-input" name="selectedQuestions" value="<%=qb.getQuestionId()%>" onclick="event.stopPropagation(); toggleCardStyle(this);">
                        
                        <div class="d-flex align-items-center mb-2">
                            <span class="badge badge-level <%=badgeClass%> me-2"><%=levelText%></span>
                            <small class="text-muted fw-bold">#<%=filteredQbs.size() - i%></small>
                        </div>

                        <div class="q-content">
                            <%= displayContext %>
                            <% 
                            if(context != null && (context.startsWith("uploads/docreader") || qb.getQuestionImg() != null)) { 
                                String imgSrc = context.startsWith("uploads") ? context : qb.getQuestionImg();
                                if(imgSrc != null && !imgSrc.isEmpty()) {
                            %>
                                <img src="<%=imgSrc%>" class="q-img-preview">
                            <%  } 
                            } %>
                        </div>

                        <div class="d-flex justify-content-between align-items-center border-top pt-2 mt-2">
                            <div class="text-success small">
                                <i class="bi bi-check-circle-fill me-1"></i> 
                                <strong>Đáp án:</strong> 
                                <% if(answer != null && answer.startsWith("uploads/docreader")) { %>
                                    <span class="text-muted fst-italic">[Hình ảnh]</span>
                                <% } else { %>
                                    <%= (answer != null && answer.length() > 40) ? answer.substring(0, 40) + "..." : answer %>
                                <% } %>
                            </div>
                            <button type="button" class="btn btn-sm btn-light text-primary fw-bold" data-bs-toggle="modal" data-bs-target="#<%=modalId%>" onclick="event.stopPropagation();">
                                Xem chi tiết
                            </button>
                        </div>
                    </div>

                    <div class="modal fade" id="<%=modalId%>" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Chi tiết câu hỏi #<%=filteredQbs.size() - i%></h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <h6 class="fw-bold text-primary">Nội dung câu hỏi:</h6>
                                        <p class="fs-5"><%=qb.getQuestionContext()%></p>
                                        <% if(qb.getQuestionImg() != null) { %>
                                            <div class="text-center bg-light p-2 rounded">
                                                <img src="<%=qb.getQuestionImg()%>" class="img-fluid rounded" style="max-height: 250px;">
                                            </div>
                                        <% } %>
                                    </div>
                                    
                                    <hr>
                                    
                                    <div class="row g-3 mb-3">
                                        <% 
                                        String[] choices = {qb.getChoice1(), qb.getChoice2(), qb.getChoice3(), qb.getChoiceCorrect()};
                                        String[] labels = {"A", "B", "C", "D"};
                                        for(int k=0; k<3; k++) { 
                                            String c = choices[k];
                                            if(c != null) {
                                        %>
                                        <div class="col-md-6">
                                            <div class="p-2 border rounded bg-light h-100">
                                                <span class="fw-bold text-secondary"><%=labels[k]%>:</span>
                                                <% if(c.startsWith("uploads/docreader")) { %>
                                                    <img src="<%=c%>" style="max-height:40px;">
                                                <% } else { %>
                                                    <%=c%>
                                                <% } %>
                                            </div>
                                        </div>
                                        <% } } %>
                                    </div>

                                    <div class="alert alert-success d-flex align-items-center">
                                        <i class="bi bi-check-circle-fill fs-4 me-2"></i>
                                        <div>
                                            <strong>Đáp án đúng:</strong>
                                            <% if(qb.getChoiceCorrect().startsWith("uploads/docreader")) { %>
                                                <img src="<%=qb.getChoiceCorrect()%>" style="max-height:40px;">
                                            <% } else { %>
                                                <%=qb.getChoiceCorrect()%>
                                            <% } %>
                                        </div>
                                    </div>

                                    <% if(qb.getExplain() != null && !qb.getExplain().isEmpty()) { %>
                                        <div class="bg-light p-3 rounded border border-info">
                                            <strong class="text-info"><i class="bi bi-lightbulb me-1"></i> Giải thích:</strong>
                                            <p class="mb-0 mt-1"><%=qb.getExplain()%></p>
                                            <% if(qb.getExplainImg() != null) { %>
                                                <img src="<%=qb.getExplainImg()%>" class="mt-2 img-fluid rounded" style="max-height: 150px;">
                                            <% } %>
                                        </div>
                                    <% } %>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% 
                            }
                        }
                    } else { 
                    %>
                        <div class="text-center py-5 bg-white rounded-3 shadow-sm">
                            <i class="bi bi-inbox display-1 text-muted opacity-25"></i>
                            <p class="mt-3 text-muted fw-bold">Chưa có câu hỏi nào trong ngân hàng.</p>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </form>
</div>

<div class="modal fade" id="randomExamModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="CreateRandomExam" method="POST">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-shuffle me-2"></i>Tạo đề ngẫu nhiên</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <% if(qbs != null && qbs.size() > 0){ int max = qbs.size(); %>
                        <input type="hidden" name="subjectID" value="<%=subjectID%>"/>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên đề thi</label>
                            <input type="text" class="form-control" name="examName" required placeholder="Nhập tên đề thi...">
                        </div>

                        <div class="row mb-3">
                            <div class="col-6">
                                <label class="form-label fw-bold">Giá tiền</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" name="price" min="0" value="0" required placeholder="0">
                                    <span class="input-group-text">Coin</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <label class="form-label fw-bold">Độ khó</label>
                                <select class="form-select" name="difficultyLevel" required>
                                    <option value="1">Dễ</option>
                                    <option value="2" selected>Vừa</option>
                                    <option value="3">Khó</option>
                                </select>
                            </div>
                        </div>

                        <label class="form-label fw-bold">Thời gian làm bài</label>
                        <div class="input-group mb-3">
                            <input type="number" name="examHours" min="0" class="form-control text-center" required placeholder="Giờ">
                            <span class="input-group-text">:</span>
                            <input type="number" name="examMinutes" min="0" class="form-control text-center" required placeholder="Phút">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold d-flex justify-content-between">
                                <span>Số lượng câu hỏi</span>
                                <span class="text-muted small fw-normal">(Tối đa: <%=max%>)</span>
                            </label>
                            <div class="input-group input-group-lg">
                                <button class="btn btn-outline-secondary" type="button" onclick="stepDown()">
                                    <i class="bi bi-dash-lg"></i>
                                </button>
                                <input type="number" id="numQ" name="numQuestions" class="form-control text-center fw-bold text-primary" min="1" max="<%=max%>" value="1" required>
                                <button class="btn btn-outline-secondary" type="button" onclick="stepUp()">
                                    <i class="bi bi-plus-lg"></i>
                                </button>
                            </div>
                            <div class="form-text small mt-2">Hệ thống sẽ lấy ngẫu nhiên số lượng câu hỏi này từ ngân hàng.</div>
                        </div>

                        <script>
                            // Hàm xử lý tăng giảm số lượng
                            function stepUp() {
                                var input = document.getElementById('numQ');
                                var max = <%=max%>;
                                if (parseInt(input.value) < max) {
                                    input.stepUp();
                                }
                            }
                            
                            function stepDown() {
                                var input = document.getElementById('numQ');
                                if (parseInt(input.value) > 1) {
                                    input.stepDown();
                                }
                            }
                        </script>
                        <% } else { %>
                        <div class="text-center">
                            <p class="text-danger mb-0">Ngân hàng câu hỏi trống, không thể tạo đề ngẫu nhiên!</p>
                        </div>
                    <% } %>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                    <% if(qbs != null && qbs.size() > 0){ %>
                        <button type="submit" class="btn btn-primary fw-bold">Xác nhận tạo</button>
                    <% } %>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Script xử lý chọn thẻ (Card)
    function toggleSelect(card) {
        var checkbox = card.querySelector('.q-checkbox');
        checkbox.checked = !checkbox.checked;
        toggleCardStyle(checkbox);
    }

    function toggleCardStyle(checkbox) {
        var card = checkbox.closest('.question-item-card');
        if (checkbox.checked) {
            card.classList.add('selected');
        } else {
            card.classList.remove('selected');
        }
    }
</script>

<%
    }
%>

<jsp:include page="footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>