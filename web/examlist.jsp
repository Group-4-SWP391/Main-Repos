<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<%@page import="java.util.concurrent.TimeUnit" %>
<jsp:include page="header.jsp"></jsp:include>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var container = document.getElementById("tagID");
        if (container) {
            var current = container.getElementsByClassName("active");
            if (current.length > 0) {
                current[0].className = current[0].className.replace(" active", "");
            }
            var tag = container.getElementsByClassName("tag");
            if (tag.length > 2) tag[2].className += " active";
        }
    });
</script>

<style>
    /* 1. Nền tảng chung */
    body {
        background-color: #e0f2f7; /* Màu nền xanh nhạt đồng bộ */
    }
    
    /* 2. Thanh công cụ (Filter, Search, PageSize) */
    .toolbar-container {
        background-color: #ffffff;
        border-radius: 15px;
        padding: 15px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        margin-bottom: 30px;
    }

    .form-control-custom, .btn-custom, .form-select-custom {
        border-radius: 25px; /* Bo tròn dạng viên thuốc */
        height: 45px;
    }

    .btn-custom {
        padding-left: 25px;
        padding-right: 25px;
        font-weight: 600;
    }

    /* 3. Dropdown Filter */
    .dropdown-toggle::after {
        vertical-align: middle;
    }
    
    /* 4. Card Bài Kiểm Tra */
    .course-item {
        border-radius: 15px;
        overflow: hidden;
        transition: transform 0.3s, box-shadow 0.3s;
        border: none;
        height: 100%; /* Đảm bảo chiều cao bằng nhau */
        display: flex;
        flex-direction: column;
    }

    .course-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    }

    .course-img-wrapper {
        position: relative;
        height: 200px; /* Chiều cao cố định cho ảnh */
        overflow: hidden;
    }
    
    .course-img-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .course-content {
        flex-grow: 1;
        padding: 20px;
        text-align: center;
        background: white;
    }

    /* 5. Giá tiền và thông tin */
    .price-badge {
        font-weight: 700;
        font-size: 1.1rem;
    }
    .text-green { color: #28a745 !important; }
    .text-primary-custom { color: #06BBCC !important; }

    /* 5.5. Difficulty Badges - Modern Style */
    .difficulty-badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 7px 18px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.85rem;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
        border: 2px solid transparent;
        text-transform: uppercase;
    }

    .difficulty-badge:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.18);
    }

    /* Easy Level - Green Gradient */
    .difficulty-easy {
        background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        color: white !important;
        border-color: #11998e;
    }

    .difficulty-easy:hover {
        background: linear-gradient(135deg, #0d7a6f 0%, #2dd164 100%);
        box-shadow: 0 4px 16px rgba(17, 153, 142, 0.4);
    }

    /* Medium Level - Orange/Yellow Gradient */
    .difficulty-medium {
        background: linear-gradient(135deg, #f39c12 0%, #f1c40f 100%);
        color: #ffffff !important;
        border-color: #f39c12;
        text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    }

    .difficulty-medium:hover {
        background: linear-gradient(135deg, #e67e22 0%, #f39c12 100%);
        box-shadow: 0 4px 16px rgba(243, 156, 18, 0.4);
    }

    /* Hard Level - Red Gradient */
    .difficulty-hard {
        background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
        color: white !important;
        border-color: #eb3349;
    }

    .difficulty-hard:hover {
        background: linear-gradient(135deg, #c92a3a 0%, #e03e2f 100%);
        box-shadow: 0 4px 16px rgba(235, 51, 73, 0.4);
    }

    /* Unknown/N/A Level - Gray */
    .difficulty-unknown {
        background: linear-gradient(135deg, #95a5a6 0%, #bdc3c7 100%);
        color: white !important;
        border-color: #95a5a6;
    }

    /* Modal Difficulty Badge - Slightly Larger */
    .modal-body .difficulty-badge {
        padding: 8px 16px;
        font-size: 0.95rem;
    }

    /* Badge Container - Better Spacing */
    .badges-container {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        align-items: center;
    }

    /* Responsive - Smaller on mobile */
    @media (max-width: 576px) {
        .difficulty-badge {
            font-size: 0.75rem;
            padding: 6px 12px;
        }
    }

    /* 6. Pagination */
    .page-link {
        border-radius: 50% !important;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 5px;
        border: none;
        color: #333;
    }
    .page-item.active .page-link {
        background-color: #06BBCC;
        color: white;
    }
</style>

<%
    if(session.getAttribute("subjectID") != null){
        Users user = (Users)session.getAttribute("currentUser");
        int subjectID = (Integer)session.getAttribute("subjectID");
        Subjects subject = new ExamDAO().getSubjectByID(subjectID);
%>

<div class="container-xxl py-5">
    <div class="container">
        <a class="btn btn-primary btn-custom mb-4" href="choosesubjectstudent.jsp">
            <i class="bi bi-arrow-left me-2"></i> Trở về
        </a>

        <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
            <h6 class="section-title bg-white text-center text-primary px-3 rounded-pill d-inline-block">Môn <%=subject.getSubjectName()%></h6>
            <h1 class="mb-5 mt-2">Danh sách bài kiểm tra</h1>
        </div>

        <div class="toolbar-container wow fadeInUp" data-wow-delay="0.2s">
            <div class="row g-3 align-items-center">
                
                <div class="col-md-3">
                    <div class="dropdown w-100">
                        <% 
                            String displayFilter = "Tất cả bài kiểm tra";
                            String filter = request.getParameter("filter") != null ? request.getParameter("filter") : "all";
                            String searchParam = request.getParameter("search") != null ? request.getParameter("search") : "";
                            if (filter.equals("free")) displayFilter = "Miễn phí";
                            else if (filter.equals("paid")) displayFilter = "Trả phí";
                            else if (filter.equals("purchased")) displayFilter = "Đã mua";
                        %>
                        <button class="btn btn-outline-primary w-100 form-control-custom dropdown-toggle text-start d-flex justify-content-between align-items-center" type="button" id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <span><i class="bi bi-funnel me-2"></i> <%= displayFilter %></span>
                        </button>
                        <ul class="dropdown-menu w-100 border-0 shadow" aria-labelledby="filterDropdown">
                            <li><a class="dropdown-item" href="?filter=all&search=<%=searchParam%>">Tất cả bài kiểm tra</a></li>
                            <li><a class="dropdown-item" href="?filter=free&search=<%=searchParam%>">Miễn phí</a></li>
                            <li><a class="dropdown-item" href="?filter=paid&search=<%=searchParam%>">Trả phí</a></li>
                            <li><a class="dropdown-item" href="?filter=purchased&search=<%=searchParam%>">Đã mua</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-6">
                    <form method="GET" action="examlist.jsp" class="w-100">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0" style="border-radius: 25px 0 0 25px; padding-left: 20px;">
                                <i class="bi bi-search text-muted"></i>
                            </span>
                            <input type="text" name="search" class="form-control form-control-custom border-start-0 ps-0" 
                                   placeholder="Tìm kiếm bài kiểm tra..." 
                                   value="<%= !searchParam.equals("null") ? searchParam : "" %>">
                            <input type="hidden" name="filter" value="<%= filter %>">
                            <button type="submit" style="display: none;"></button>
                        </div>
                    </form>
                </div>

                <div class="col-md-3">
                    <form method="GET" action="examlist.jsp" class="d-flex align-items-center">
                        <%
                            String pageSizeParam = request.getParameter("pageSize");
                            int pageSize = 12;
                            if (pageSizeParam != null && !pageSizeParam.isEmpty() && !pageSizeParam.equals("all")) {
                                try { pageSize = Integer.parseInt(pageSizeParam); } catch (Exception e) {}
                            }
                        %>
                        <label class="me-2 text-muted small" style="white-space: nowrap;">Hiển thị:</label>
                        <select name="pageSize" class="form-select form-select-custom" onchange="this.form.submit()">
                            <option value="12" <%= pageSize == 12 ? "selected" : "" %>>12</option>
                            <option value="24" <%= pageSize == 24 ? "selected" : "" %>>24</option>
                            <option value="36" <%= pageSize == 36 ? "selected" : "" %>>36</option>
                            <option value="all" <%= "all".equals(pageSizeParam) ? "selected" : "" %>>Tất cả</option>
                        </select>
                        <input type="hidden" name="filter" value="<%= filter %>">
                        <input type="hidden" name="search" value="<%= searchParam %>">
                    </form>
                </div>
            </div>
        </div>

        <div class="row g-4 justify-content-center">
            <%
                List<Exam> exams = new StudentExamDAO().getAllExamIsAprrovedBySubjectID(subjectID);
                
                // --- Logic Lọc (Filter) ---
                if (filter != null) {
                    if (filter.equals("free")) exams.removeIf(exam -> exam.getPrice() > 0);
                    else if (filter.equals("paid")) exams.removeIf(exam -> exam.getPrice() == 0);
                    else if (filter.equals("purchased")) exams.removeIf(exam -> !new StudentExamDAO().checkExamPay(user.getUserID(), exam.getExamID()));
                }
                
                // --- Logic Tìm kiếm (Search) ---
                if (searchParam != null && !searchParam.trim().isEmpty() && !searchParam.equals("null")) {
                    String searchLower = searchParam.trim().toLowerCase();
                    exams.removeIf(exam -> !exam.getExamName().toLowerCase().contains(searchLower));
                }

                // --- Logic Phân trang (Pagination) ---
                if ("all".equals(pageSizeParam)) {
                    pageSize = exams.size() > 0 ? exams.size() : 1;
                }
                int totalPages = (int) Math.ceil((double) exams.size() / pageSize);
                String pageNumberParam = request.getParameter("pageNumber");
                int pageNumber = (pageNumberParam != null && !pageNumberParam.isEmpty()) ? Integer.parseInt(pageNumberParam) : 1;
                
                int startIndex = (pageNumber - 1) * pageSize;
                int endIndex = Math.min(startIndex + pageSize, exams.size());
                
                // Kiểm tra danh sách rỗng
                if (exams.isEmpty()) {
            %>
                <div class="col-12 text-center py-5">
                    <i class="bi bi-clipboard-x display-1 text-muted mb-3"></i>
                    <h4 class="text-muted">Không tìm thấy bài kiểm tra nào phù hợp.</h4>
                </div>
            <%
                } else {
                    List<Exam> examOnPage = exams.subList(startIndex, endIndex);
                    // Lặp danh sách bài thi
                    for(int i = 0; i < examOnPage.size(); i++){
                        Exam exam = examOnPage.get(i);
                        int price = exam.getPrice();
                        int attempt = new ExamDAO().countAttemptExam(exam.getExamID());
                        String modalID = "modalDetail" + exam.getExamID(); // ID duy nhất theo ExamID
                        
                        UserDAO userDAO = new UserDAO();
                        Users creator = userDAO.findByUserID(exam.getUserID());
                        
                        // Xử lý thời gian
                        int durationInSeconds = exam.getTimer(); 
                        long hours = TimeUnit.SECONDS.toHours(durationInSeconds);
                        long minutes = TimeUnit.SECONDS.toMinutes(durationInSeconds) - TimeUnit.HOURS.toMinutes(hours);
                        long seconds = durationInSeconds - TimeUnit.MINUTES.toSeconds(minutes) - TimeUnit.HOURS.toSeconds(hours);
            %>

            <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                <div class="course-item bg-white shadow-sm">
                    <div class="course-img-wrapper">
                        <img class="img-fluid" src="img/course-1.jpg" alt="Exam Image"> <div class="w-100 d-flex justify-content-center position-absolute bottom-0 start-0 mb-3">
                             <% if (price == 0 || new StudentExamDAO().checkExamPay(user.getUserID(), exam.getExamID())) { %>
                                <button type="button" class="btn btn-primary btn-custom rounded-pill px-4 shadow" data-bs-toggle="modal" data-bs-target="#<%= modalID %>">
                                    <% new ExamDAO().incrementViewCount(exam.getExamID()); %>
                                    Xem chi tiết
                                </button>
                             <% } else if (price > 0 && user.getBalance() >= price) { %>
                                <button type="button" class="btn btn-primary btn-custom rounded-pill px-4 shadow" data-bs-toggle="modal" data-bs-target="#<%= modalID %>">
                                    Mua ngay
                                </button>
                             <% } else { %>
                                <button type="button" class="btn btn-warning text-white btn-custom rounded-pill px-4 shadow" data-bs-toggle="modal" data-bs-target="#<%= modalID %>">
                                    Nạp thêm tiền
                                </button>
                             <% } %>
                        </div>
                    </div>

                    <div class="course-content">
                        <h5 class="mb-2 fw-bold text-dark"><%= exam.getExamName() %></h5>
                        
                        <div class="mb-3 badges-container justify-content-center">
                            <% if(price == 0){ %>
                                <span class="price-badge text-primary-custom">Miễn phí</span>
                            <% } else if(new StudentExamDAO().checkExamPay(user.getUserID(), exam.getExamID())){ %>
                                <span class="price-badge text-green"><i class="bi bi-check-circle-fill"></i> Đã sở hữu</span>
                            <% } else { %>
                                <span class="price-badge text-warning"><%= price %> Coin</span>
                            <% } %>
                            
                            <%
                                // Hiển thị độ khó với style cải tiến
                                int diffLevel = exam.getDifficultyLevel();
                                String diffBadgeClass = "";
                                String diffText = "";
                                String diffTooltip = "";
                                
                                if (diffLevel == 1) {
                                    diffBadgeClass = "difficulty-badge difficulty-easy";
                                    diffText = "Dễ";
                                    diffTooltip = "Phù hợp cho người mới bắt đầu";
                                } else if (diffLevel == 2) {
                                    diffBadgeClass = "difficulty-badge difficulty-medium";
                                    diffText = "Vừa";
                                    diffTooltip = "Yêu cầu kiến thức cơ bản đến trung bình";
                                } else if (diffLevel == 3) {
                                    diffBadgeClass = "difficulty-badge difficulty-hard";
                                    diffText = "Khó";
                                    diffTooltip = "Dành cho người có kinh nghiệm";
                                } else {
                                    diffBadgeClass = "difficulty-badge difficulty-unknown";
                                    diffText = "N/A";
                                    diffTooltip = "Độ khó chưa được xác định";
                                }
                            %>
                            <span class="<%= diffBadgeClass %>" 
                                  data-bs-toggle="tooltip" 
                                  data-bs-placement="top" 
                                  title="<%= diffTooltip %>">
                                <%= diffText %>
                            </span>
                        </div>
                        
                        <div class="d-flex justify-content-between text-muted small px-3">
                            <span><i class="bi bi-person me-1"></i> <%= creator != null ? creator.getUsername() : "Admin" %></span>
                            <span><i class="bi bi-pencil-square me-1"></i> <%= attempt %> lượt thi</span>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="<%= modalID %>" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 rounded-3">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title fw-bold">
                                    <% if (price == 0 || new StudentExamDAO().checkExamPay(user.getUserID(), exam.getExamID())) { %>
                                        Chi tiết bài thi
                                    <% } else if (user.getBalance() < price) { %>
                                        Số dư không đủ
                                    <% } else { %>
                                        Xác nhận mua bài thi
                                    <% } %>
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            
                            <div class="modal-body p-4">
                                <% if (price > 0 && user.getBalance() < price && !new StudentExamDAO().checkExamPay(user.getUserID(), exam.getExamID())) { %>
                                    <div class="text-center">
                                        <i class="bi bi-wallet2 text-warning display-4 mb-3"></i>
                                        <p class="fs-5">Bạn cần <strong><%= price %> coin</strong> nhưng số dư không đủ.</p>
                                        <p>Vui lòng nạp thêm tiền để tiếp tục.</p>
                                    </div>
                                    <div class="d-grid gap-2 mt-4">
                                        <a href="recharge.jsp" class="btn btn-warning text-white btn-lg rounded-pill">Nạp tiền ngay</a>
                                        <button type="button" class="btn btn-light rounded-pill" data-bs-dismiss="modal">Để sau</button>
                                    </div>
                                <% } else { %>
                                    <ul class="list-unstyled">
                                        <li class="mb-2"><strong><i class="bi bi-book me-2 text-primary"></i>Tên bài:</strong> <%= exam.getExamName() %></li>
                                        <li class="mb-2"><strong><i class="bi bi-tag me-2 text-primary"></i>Giá:</strong> <%= price == 0 ? "Miễn phí" : price + " Coin" %></li>
                                        <li class="mb-2">
                                            <strong><i class="bi bi-bar-chart-steps me-2 text-primary"></i>Độ khó:</strong> 
                                            <span class="<%= diffBadgeClass %>">
                                                <%= diffText %>
                                            </span>
                                        </li>
                                        <li class="mb-2"><strong><i class="bi bi-clock me-2 text-primary"></i>Thời gian:</strong> <%= String.format("%02d:%02d:%02d", hours, minutes, seconds) %></li>
                                        <li class="mb-2"><strong><i class="bi bi-person-badge me-2 text-primary"></i>Tác giả:</strong> <%= creator != null ? creator.getUsername() : "Unknown" %></li>
                                        <li><strong><i class="bi bi-calendar-event me-2 text-primary"></i>Ngày tạo:</strong> <%= exam.getCreateDate() %></li>
                                    </ul>

                                    <div class="d-grid gap-2 mt-4">
                                        <% if (price == 0 || new StudentExamDAO().checkExamPay(user.getUserID(), exam.getExamID())) { %>
                                            <a href="ExamDetail?examID=<%= exam.getExamID() %>" class="btn btn-primary btn-lg rounded-pill">Bắt đầu thi</a>
                                        <% } else { %>
                                            <form action="PurchaseExam" method="POST" class="d-grid">
                                                <input type="hidden" name="price" value="<%= price %>"/>
                                                <input type="hidden" name="examID" value="<%= exam.getExamID() %>">
                                                <button type="submit" class="btn btn-primary btn-lg rounded-pill">Thanh toán <%= price %> Coin</button>
                                            </form>
                                        <% } %>
                                        <button type="button" class="btn btn-light rounded-pill" data-bs-dismiss="modal">Đóng</button>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                </div>

            <%      } // End for loop
                } // End else check empty
            %>
        </div>

        <% if (totalPages > 1) { %>
        <div class="d-flex justify-content-center mt-5">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item <%= (pageNumber == 1) ? "disabled" : "" %>">
                        <a class="page-link" href="?pageSize=<%=pageSize%>&pageNumber=1&filter=<%=filter%>&search=<%=searchParam%>">
                            <i class="bi bi-chevron-double-left"></i>
                        </a>
                    </li>
                    
                    <li class="page-item <%= (pageNumber == 1) ? "disabled" : "" %>">
                        <a class="page-link" href="?pageSize=<%=pageSize%>&pageNumber=<%=pageNumber-1%>&filter=<%=filter%>&search=<%=searchParam%>">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>

                    <li class="page-item active">
                        <span class="page-link"><%= pageNumber %></span>
                    </li>

                    <li class="page-item <%= (pageNumber == totalPages) ? "disabled" : "" %>">
                        <a class="page-link" href="?pageSize=<%=pageSize%>&pageNumber=<%=pageNumber+1%>&filter=<%=filter%>&search=<%=searchParam%>">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>

                    <li class="page-item <%= (pageNumber == totalPages) ? "disabled" : "" %>">
                        <a class="page-link" href="?pageSize=<%=pageSize%>&pageNumber=<%=totalPages%>&filter=<%=filter%>&search=<%=searchParam%>">
                            <i class="bi bi-chevron-double-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <% } %>
    </div>
</div>

<%
    }
%>

<script>
    // Initialize Bootstrap tooltips for difficulty badges
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, {
                trigger: 'hover',
                delay: { show: 300, hide: 100 }
            });
        });
    });
</script>

<jsp:include page="footer.jsp"></jsp:include>
<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>