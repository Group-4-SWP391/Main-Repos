<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<jsp:include page="header.jsp"></jsp:include>
    
    <style>
        /* Modern UI for Choose Subject System */
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

        .course-item .position-relative {
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .course-item img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            transition: all 0.4s ease;
        }

        .course-item:hover img {
            transform: scale(1.1);
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

        .btn-primary, .btn-back-style {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%) !important;
            border: none !important;
            border-radius: 25px !important;
            padding: 0.75rem 1.5rem !important;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(37,150,190,0.3);
            transition: all 0.3s ease;
            color: white !important;
            display: inline-flex;
            align-items: center;
            text-decoration: none;
        }

        .btn-primary:hover, .btn-back-style:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(37,150,190,0.4);
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
    
    <script>
        var container = document.getElementById("tagID");
        var tag = container.getElementsByClassName("tag");
        var current = container.getElementsByClassName("active");
        current[0].className = current[0].className.replace(" active", "");
        tag[2].className += " active";
    </script>
<%
List<Subjects> subjects = new ExamDAO().getAllSubject();
%>

    <div class="container-xxl py-5">
        <div class="container">
            
            <a class="btn btn-primary btn-back-style mt-3" href="Home">
                <i class="fas fa-arrow-left me-2"></i> Trở về
            </a>

            <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                <h6 class="section-title bg-white text-center px-3">Môn học</h6>
                <h1 class="mb-5">Danh sách các môn học</h1>
            </div>
            
            <div class="row g-4 justify-content-center">
                <%
                for(Subjects subject: subjects){
                %>
                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="course-item bg-light">
                        <div class="position-relative overflow-hidden">
                            <img class="img-fluid" src="<%=subject.getSubjectImg()%>" alt="<%=subject.getSubjectName()%> Image">
                            
                            <div class="w-100 d-flex justify-content-center position-absolute bottom-0 start-0 mb-4">
                                <a href="ChangeSubjectUser?subjectID=<%=subject.getSubjectID()%>" class="flex-shrink-0 btn btn-sm btn-primary px-3" style="border-radius: 30px;">
                                    <i class="fas fa-search me-1"></i> Xem câu hỏi
                                </a>
                            </div>
                        </div>
                        <div class="text-center p-4 pb-0">
                            <h3 class="mb-0"><%=subject.getSubjectName()%></h3>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"></jsp-include>
    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>