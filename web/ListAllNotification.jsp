<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<jsp:include page="header.jsp"></jsp:include>

<style>
    /* Modern Notification Page */
    :root {
        --primary-color: #0d6efd;
        --danger-color: #dc3545;
        --card-shadow: 0 2px 8px rgba(0,0,0,0.08);
        --card-shadow-hover: 0 4px 16px rgba(0,0,0,0.12);
    }

    /* Header */
    .page-header {
        background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
    }

    .page-header h1 {
        text-shadow: 2px 4px 8px rgba(0,0,0,0.2);
    }

    /* Card */
    .card {
        border-radius: 20px;
        box-shadow: var(--card-shadow-hover);
        border: none;
        overflow: hidden;
    }

    .card-body {
        padding: 2.5rem;
    }

    /* Table */
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
        vertical-align: middle;
        text-align: center;
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
        text-align: center;
    }

    /* Notification Content */
    .notification-content {
        text-align: left;
        color: #495057;
        font-weight: 500;
        line-height: 1.6;
    }

    .notification-icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
        color: white;
        margin-right: 12px;
    }

    /* Date Badge */
    .date-badge {
        background: #e7f3ff;
        color: #0066cc;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.875rem;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    /* Button */
    .btn-delete {
        background: linear-gradient(135deg, var(--danger-color) 0%, #bb2d3b 100%);
        color: white;
        border: none;
        padding: 0.5rem 1.25rem;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .btn-delete:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(220,53,69,0.3);
    }

    /* Modal */
    .modal-content {
        border-radius: 20px;
        border: none;
        box-shadow: 0 15px 50px rgba(0,0,0,0.3);
    }

    .modal-header {
        border-radius: 20px 20px 0 0;
        padding: 1.75rem;
    }

    .modal-header.bg-danger {
        background: linear-gradient(135deg, var(--danger-color) 0%, #bb2d3b 100%) !important;
    }

    .modal-title {
        font-weight: 700;
        font-size: 1.5rem;
    }

    .modal-body {
        padding: 2rem;
    }

    .modal-footer {
        padding: 1.5rem 2rem;
        border-top: 1px solid #e9ecef;
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 4rem 2rem;
    }

    .empty-state i {
        font-size: 4rem;
        color: #cbd5e0;
        margin-bottom: 1rem;
    }

    .empty-state h3 {
        color: #6c757d;
        font-weight: 600;
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
    if (container) {
        var tag = container.getElementsByClassName("tag");
        var current = container.getElementsByClassName("active");
        if (current.length > 0) {
            current[0].className = current[0].className.replace(" active", "");
        }
    }
</script>

<%
if(session.getAttribute("currentUser") != null){
Users user = (Users)session.getAttribute("currentUser");
List<Notification> notis = new NotificationDAO().getAllNotification();
%>
<body>
<!-- ===== HEADER ===== -->
<div class="container-fluid page-header py-5 mb-5">
    <div class="container text-center py-4">
        <h1 class="display-4 text-white fw-bold animated slideInDown">
            <i class="fas fa-bell mr-3"></i>Thông Báo Hệ Thống
        </h1>

        <% if(user.getRole() == 1){ %>
            <h3 class="text-white animated slideInDown">Quản lý thông báo của bạn</h3>
        <% } else { %>
            <h3 class="text-white animated slideInDown">Xem các thông báo mới nhất</h3>
        <% } %>
    </div>
</div>

<!-- ===== MAIN ===== -->
<main id="main" class="main" style="margin-left: 0 !important;">

<section class="section">
    <div class="container">

        <div class="card animated-item">
            <div class="card-body">

                <% if(notis.size() > 0){ %>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="mb-0">
                        <i class="fas fa-inbox mr-2 text-primary"></i>
                        Tất cả thông báo (<span class="text-primary"><%=notis.size()%></span>)
                    </h4>
                </div>

                <div class="table-responsive">
                    <table class="table modern-table">
                        <thead>
                            <tr>
                                <th style="width: 5%;">
                                    <i class="fas fa-hashtag"></i>
                                </th>
                                <th style="width: <%=user.getRole() == 1 ? "55%" : "70%"%>;">
                                    <i class="fas fa-bell mr-2"></i>Nội dung thông báo
                                </th>
                                <th style="width: 25%;">
                                    <i class="fas fa-calendar-alt mr-2"></i>Ngày đăng
                                </th>
                                <% if(user.getRole() == 1){ %>
                                    <th style="width: 15%;">
                                        <i class="fas fa-cog mr-2"></i>Tác vụ
                                    </th>
                                <% } %>
                            </tr>
                        </thead>

                        <tbody>
                        <% 
                        int rowNum = 1;
                        for(int i = notis.size() - 1; i >= 0; i--){ 
                               Notification noti = notis.get(i);
                               String modalId = "threadModal" + i;
                        %>
                            <tr class="animated-item" style="animation-delay: <%=(rowNum * 0.05)%>s;">
                                <td>
                                    <span class="badge bg-light text-dark" style="font-size: 1rem; font-weight: 600;">
                                        <%=rowNum%>
                                    </span>
                                </td>
                                <td class="notification-content">
                                    <span class="notification-icon">
                                        <i class="fas fa-bullhorn"></i>
                                    </span>
                                    <%=noti.getNotiName()%>
                                </td>
                                <td>
                                    <span class="date-badge">
                                        <i class="fas fa-clock"></i>
                                        <%=noti.getNotiCreateDate()%>
                                    </span>
                                </td>

                                <% if(user.getRole() == 1){ %>
                                <td>
                                    <button class="btn-delete"
                                            data-toggle="modal"
                                            data-target="#<%= modalId %>">
                                        <i class="fas fa-trash-alt"></i>
                                        <span>Xoá</span>
                                    </button>
                                </td>
                                <% } %>
                            </tr>

                            <!-- ===== MODAL XÓA ===== -->
                            <div class="modal fade" id="<%= modalId %>" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">

                                        <form action="DeleteNotification" method="POST">
                                            <input type="hidden" name="notiID" value="<%=noti.getNotiID()%>">

                                            <div class="modal-header bg-danger text-white">
                                                <h5 class="modal-title">
                                                    <i class="fas fa-exclamation-triangle mr-2"></i>
                                                    Xác nhận xóa thông báo
                                                </h5>
                                                <button type="button" class="close text-white" data-dismiss="modal" style="opacity: 1;">
                                                    <span>&times;</span>
                                                </button>
                                            </div>

                                            <div class="modal-body text-center py-4">
                                                <i class="fas fa-trash-alt text-danger mb-3" style="font-size: 3rem;"></i>
                                                <p style="font-size: 1.1rem; color: #495057;">
                                                    Bạn có chắc chắn muốn xóa thông báo này không?
                                                </p>
                                                <p class="text-muted" style="font-size: 0.9rem;">
                                                    <i class="fas fa-info-circle mr-1"></i>Hành động này không thể hoàn tác!
                                                </p>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-light" data-dismiss="modal">
                                                    <i class="fas fa-times mr-2"></i>Hủy
                                                </button>
                                                <button type="submit" class="btn btn-danger">
                                                    <i class="fas fa-trash mr-2"></i>Xóa thông báo
                                                </button>
                                            </div>

                                        </form>

                                    </div>
                                </div>
                            </div>
                            <!-- ===== END MODAL ===== -->

                        <% 
                            rowNum++;
                        } %>
                        </tbody>
                    </table>
                </div>

                <% } else { %>
                    <div class="empty-state">
                        <i class="fas fa-bell-slash"></i>
                        <h3>Không có thông báo nào!</h3>
                        <p style="color: #adb5bd;">Chưa có thông báo mới từ hệ thống</p>
                    </div>
                <% } %>

            </div>
        </div>

    </div>
</section>

</main>

<!-- JS -->
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="assets/js/main.js"></script>

<% } %>
</body>

<jsp:include page="footer.jsp"></jsp:include>

<a href="#" class="back-to-top d-flex align-items-center justify-content-center">
    <i class="bi bi-arrow-up-short"></i>
</a>
