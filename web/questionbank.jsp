<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<jsp:include page="header.jsp"></jsp:include>
<script>
        var container = document.getElementById("tagID");
        var tag = container.getElementsByClassName("tag");
        var current = container.getElementsByClassName("active");
        current[0].className = current[0].className.replace(" active", "");
        tag[2].className += " active";
    </script>
<%
Users user = (Users)session.getAttribute("currentUser");
TeacherRequest requests = new AdminDAO().getRequestByUserID(user.getUserID());
%>
    <style>
        /* Modern UI for Question Bank */
        body {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            min-height: 100vh;
        }

        .container-xxl {
            padding-top: 4rem !important;
            padding-bottom: 4rem !important;
        }

        .section-title {
            color: #fff !important;
            font-weight: 700;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 2px 4px 8px rgba(0,0,0,0.2);
            background: none !important;
        }

        .container h1 {
            color: #fff;
            font-weight: 700;
            text-shadow: 2px 4px 8px rgba(0,0,0,0.2);
        }

        .course-item {
            background: white !important;
            border-radius: 20px;
            padding: 3rem 2rem;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .course-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #2596be 0%, #1a7a9f 100%);
        }

        .course-item:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow: 0 20px 60px rgba(0,0,0,0.25);
            border-color: #2596be;
        }

        .course-item h3 {
            color: #2d3748;
            font-weight: 700;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            font-size: 1.5rem;
        }

        .course-item:hover h3 {
            color: #2596be;
            transform: scale(1.05);
        }

        .course-item a {
            text-decoration: none;
            display: block;
        }

        /* Icon decoration */
        .course-item::after {
            content: '\f101';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            position: absolute;
            bottom: 20px;
            right: 20px;
            font-size: 3rem;
            color: #e9ecef;
            transition: all 0.3s ease;
        }

        .course-item:hover::after {
            color: #2596be;
            transform: translateX(10px);
        }

        /* Add icons before titles */
        .course-item:nth-child(1) .text-center::before {
            content: '\f0c0';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            font-size: 3rem;
            color: #2596be;
            display: block;
            margin-bottom: 1rem;
        }

        .row:last-child .course-item .text-center::before {
            content: '\f007';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            font-size: 3rem;
            color: #1a7a9f;
            display: block;
            margin-bottom: 1rem;
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .wow {
            animation: fadeInUp 0.6s ease forwards;
        }

        .wow:nth-child(2) {
            animation-delay: 0.2s;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .course-item {
                margin-bottom: 2rem;
            }
        }
    </style>

<body>    
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                <h6 class="section-title bg-white text-center px-3">Ngân hàng câu hỏi</h6>
                <h1 class="mb-5">Vui lòng chọn một tác vụ</h1>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-lg-5 col-md-6 wow fadeInUp">
                    <div class="course-item bg-light">
                        <div class="text-center p-4 pb-0">
                            <a href="ChangeSubjectSystem" style="text-decoration: none">
                                <h3 class="mb-0">
                                    <i class="fas fa-database mr-3"></i>
                                    Câu hỏi của hệ thống
                                </h3>
                                <p class="text-muted mt-3">Xem và sử dụng câu hỏi có sẵn từ hệ thống</p>
                            </a>  
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 col-md-6 wow fadeInUp">
                    <div class="course-item bg-light">
                        <div class="text-center p-4 pb-0">
                            <a href="ChangeSubjectUser" style="text-decoration: none">
                                <h3 class="mb-0">
                                    <i class="fas fa-user-edit mr-3"></i>
                                    Câu hỏi của tôi
                                </h3>
                                <p class="text-muted mt-3">Quản lý câu hỏi bạn đã tạo</p>
                            </a>  
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

<jsp:include page="footer.jsp"></jsp:include>
<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>