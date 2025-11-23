<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*, Schedule.*"%>
<jsp:include page="header.jsp"></jsp:include>
    <style>
        /* Modern Schedule/Task Page */
        :root {
            --primary-color: #2596be;
            --danger-color: #dc3545;
            --success-color: #198754;
            --card-shadow: 0 2px 8px rgba(0,0,0,0.08);
            --card-shadow-hover: 0 4px 16px rgba(0,0,0,0.12);
        }

        body {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            min-height: 100vh;
        }

        .container {
            padding: 2rem 0;
        }

        /* Page Title */
        .pagetitle {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
            text-align: center;
        }

        .pagetitle h1 {
            color: #2596be;
            font-weight: 800;
            font-size: 2.5rem;
            margin: 0;
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Card Styling */
        .card {
            border-radius: 20px;
            box-shadow: var(--card-shadow-hover);
            border: none;
            background: white;
            overflow: hidden;
        }

        .card-body {
            padding: 2.5rem;
        }

        .card-title {
            color: #6c757d;
            font-size: 1.25rem;
            margin-bottom: 2rem;
        }

        /* Table Styling */
        .modern-table {
            width: 100%;
            margin-bottom: 0;
        }

        .modern-table thead {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
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
            color: #495057;
        }

        /* Button Styling */
        .btn {
            border-radius: 10px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.2);
        }

        .btn-primary {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger-color) 0%, #bb2d3b 100%);
            color: white;
            padding: 0.5rem 1.25rem;
        }

        .btn-light {
            background: #f8f9fa;
            color: #495057;
        }

        .btn-block {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            font-size: 1.1rem;
        }

        /* Modal Styling */
        .modal-content {
            border-radius: 20px;
            border: none;
            box-shadow: 0 15px 50px rgba(0,0,0,0.3);
        }

        .modal-header {
            border-radius: 20px 20px 0 0;
            padding: 1.75rem;
            border-bottom: none;
        }

        .modal-header.bg-primary {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%) !important;
        }

        .modal-title {
            font-weight: 700;
            font-size: 1.5rem;
        }

        .modal-body {
            padding: 2rem;
        }

        .modal-body .form-group {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }

        .modal-body label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
            font-size: 1rem;
        }

        .modal-body input[type="text"],
        .modal-body input[type="date"],
        .modal-body input[type="time"] {
            padding: 0.875rem 1rem;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            width: 100%;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .modal-body input:focus {
            border-color: #2596be;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(37,150,190,0.15);
        }

        .modal-footer {
            padding: 1.5rem 2rem;
            border-top: 1px solid #e9ecef;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
        }

        .empty-state i {
            font-size: 4rem;
            color: #cbd5e0;
            margin-bottom: 1rem;
        }

        /* Task ID Badge */
        .task-id-badge {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 10px;
            font-weight: 700;
            font-size: 1.1rem;
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
            .pagetitle h1 {
                font-size: 1.75rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .modern-table {
                font-size: 0.875rem;
            }
        }
    </style>
    <script>
        var container = document.getElementById("tagID");
        var tag = container.getElementsByClassName("tag");
        var current = container.getElementsByClassName("active");
        current[0].className = current[0].className.replace(" active", "");
        tag[3].className += " active";
    </script>
<%
if(session.getAttribute("currentUser") != null){
    Users user = (Users)session.getAttribute("currentUser");
    List<Task> listTask = new TaskDAO().getTasksByUser(user.getUserID());
%>
<div class="container">        
        <main id="main" class="main">
            <div class="pagetitle animated-item">
                <h1>
                    <i class="fas fa-tasks mr-3"></i>
                    Lịch Trình Học Tập
                </h1>   
            </div>
            
            <section class="section">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card animated-item" style="animation-delay: 0.2s;">
                            <div class="card-body">
                                <h4 class="card-title text-center">
                                    <i class="fas fa-calendar-check mr-2" style="color: #2596be;"></i>
                                    Lên lịch trình học tập khoa học để đạt kết quả tốt nhất!
                                </h4>
                                
                                <div class="table-responsive">
                                    <table class="table modern-table">
                                        <thead>
                                            <tr>
                                                <th style="width: 5%">
                                                    <i class="fas fa-hashtag"></i>
                                                </th>
                                                <th style="width: 50%">
                                                    <i class="fas fa-clipboard-list mr-2"></i>Nhiệm vụ
                                                </th>
                                                <th style="width: 25%">
                                                    <i class="fas fa-clock mr-2"></i>Thời gian
                                                </th>
                                                <th style="width: 20%">
                                                    <i class="fas fa-cog mr-2"></i>Tác vụ
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                            if(listTask.size() > 0){
                                            for(int i = listTask.size() - 1; i >= 0; i--){
                                                Task task = listTask.get(i);
                                                String modalId = "threadModal" + task.getTaskId();
                                                int rowNum = listTask.size() - i;
                                            %>
                                            <tr class="animated-item" style="animation-delay: <%=(rowNum * 0.05)%>s;">
                                                <td>
                                                    <span class="task-id-badge"><%=rowNum%></span>
                                                </td>
                                                <td style="text-align: left; font-weight: 500;">
                                                    <i class="fas fa-check-circle mr-2" style="color: #28a745;"></i>
                                                    <%=task.getTaskContext()%>
                                                </td>
                                                <td>
                                                    <i class="fas fa-calendar-alt mr-2" style="color: #2596be;"></i>
                                                    <%=task.getTaskDeadline()%>
                                                </td>
                                                <td>
                                                    <button
                                                        class="btn btn-danger btn-sm"
                                                        type="button"
                                                        data-toggle="modal"
                                                        data-target="#<%= modalId %>"  
                                                        >
                                                        <i class="fas fa-trash-alt mr-2"></i>Xoá
                                                    </button>
                                                    
                                                    <div class="modal fade" id="<%= modalId %>" tabindex="-1" role="dialog" aria-labelledby="threadModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                                            <div class="modal-content">
                                                                <form action="deleteTask" method="POST">
                                                                    <input type="hidden" name="taskId" value="<%=task.getTaskId()%>">
                                                                    <div class="modal-header bg-danger text-white" style="background: linear-gradient(135deg, #dc3545 0%, #bb2d3b 100%) !important;">
                                                                        <h5 class="modal-title" id="threadModalLabel">
                                                                            <i class="fas fa-exclamation-triangle mr-2"></i>Xác nhận xóa task
                                                                        </h5>
                                                                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close" style="opacity: 1;"><span aria-hidden="true">&times;</span></button>
                                                                    </div>
                                                                    <div class="modal-body text-center py-4">
                                                                        <i class="fas fa-trash-alt text-danger mb-3" style="font-size: 3rem;"></i>
                                                                        <p style="font-size: 1.1rem; color: #495057; margin-bottom: 0.5rem;">
                                                                            Bạn có chắc chắn muốn xóa nhiệm vụ:
                                                                        </p>
                                                                        <p style="font-weight: 700; font-size: 1.2rem; color: #2d3748;">
                                                                            "<%=task.getTaskContext()%>"
                                                                        </p>
                                                                        <p class="text-muted mt-2" style="font-size: 0.9rem;">
                                                                            <i class="fas fa-info-circle mr-1"></i>Hành động này không thể hoàn tác!
                                                                        </p>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-light" data-dismiss="modal">
                                                                            <i class="fas fa-times mr-2"></i>Hủy
                                                                        </button>
                                                                        <button type="submit" class="btn btn-danger">
                                                                            <i class="fas fa-trash mr-2"></i>Xóa Task
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
                                            }else{
                                            %>
                                            <tr>
                                                <td colspan="4">
                                                    <div class="empty-state">
                                                        <i class="fas fa-calendar-times"></i>
                                                        <h4 style="color: #6c757d; margin-top: 1rem;">Bạn chưa có lịch trình nào!</h4>
                                                        <p style="color: #adb5bd;">Hãy tạo task đầu tiên để bắt đầu</p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                                

                                <div style="margin-top: 2rem;">
                                    <div class="text-center">
                                        <button class="btn btn-primary btn-block" type="button" data-toggle="modal" data-target="#threadModal">
                                            <i class="fas fa-plus-circle"></i>
                                            <span>Thêm Task Mới</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
    
    <!-- Modal Thêm Task -->
    <div class="modal fade" id="threadModal" tabindex="-1" role="dialog" aria-labelledby="threadModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <form action="createTask" method="post">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="threadModalLabel">
                            <i class="fas fa-calendar-plus mr-2"></i>
                            Tạo Task Mới
                        </h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close" style="opacity: 1;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div>
                                <label for="taskContext">
                                    <i class="fas fa-tasks mr-2"></i>Nội dung nhiệm vụ:
                                </label>
                                <input type="text" id="taskContext" name="taskContext" class="form-control" placeholder="Ví dụ: Học bài Địa lý chương 3" required />
                            </div>

                            <div>
                                <label for="taskDate">
                                    <i class="fas fa-calendar-day mr-2"></i>Ngày hết hạn:
                                </label>
                                <input type="date" id="taskDate" name="taskDate" class="form-control" required min="<%= java.time.LocalDate.now() %>" />
                            </div>

                            <div>
                                <label for="taskTime">
                                    <i class="fas fa-clock mr-2"></i>Giờ hết hạn:
                                </label>
                                <input type="time" id="taskTime" name="taskTime" class="form-control" required />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-dismiss="modal">
                            <i class="fas fa-times mr-2"></i>Hủy
                        </button>
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-check mr-2"></i>Thêm Task
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

    <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/chart.js/chart.umd.js"></script>
    <script src="assets/vendor/echarts/echarts.min.js"></script>
    <script src="assets/vendor/quill/quill.js"></script>
    <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="assets/vendor/tinymce/tinymce.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>

    <script src="assets/js/main.js"></script>
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
</div>
<%
    }
%>
<jsp:include page="footer.jsp"></jsp:include>