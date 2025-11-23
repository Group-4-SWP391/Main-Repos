<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<jsp:include page="header.jsp"></jsp:include>
    <script>
        var container = document.getElementById("tagID");
        var tag = container.getElementsByClassName("tag");
        var current = container.getElementsByClassName("active");
        current[0].className = current[0].className.replace(" active", "");
        tag[1].className += " active";
    </script>

    <style type="text/css">
        /* ==================== MODERN UI STYLING ==================== */
        :root {
            --primary-color: #0d6efd;
            --danger-color: #dc3545;
            --success-color: #198754;
            --bg-light: #e0f2f7;
            --card-shadow: 0 2px 8px rgba(0,0,0,0.08);
            --card-shadow-hover: 0 4px 16px rgba(0,0,0,0.12);
        }

        body {
            color: #1a202c;
            text-align: left;
            background-color: var(--bg-light);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .inner-wrapper {
            position: relative;
            height: calc(100vh - 3.5rem);
            transition: transform 0.3s ease;
        }

        .inner-sidebar {
            left: 0;
            width: 235px;
            border-right: 1px solid #e0e7ff;
            background: linear-gradient(180deg, #f8f9fa 0%, #e9ecef 100%);
            z-index: 1;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
        }
        
        .inner-main-footer,
        .inner-main-header {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.04);
        }
        /* ====================================================================== */
        
        @media (min-width: 992px) {
            .sticky-navbar .inner-wrapper {
                height: calc(100vh - 3.5rem - 48px);
            }
        }

        a{
            overflow-wrap: break-word;
            word-break: break-word;
        }

        p{
            overflow-wrap: break-word;
            word-break: break-word;
        }

        .inner-main,
        .inner-sidebar {
            position: absolute;
            top: 0;
            bottom: 0;
            display: flex;
            flex-direction: column;
        }

        .inner-main {
            right: 0;
            left: 235px;
        }
        .inner-main-footer,
        .inner-main-header,
        .inner-sidebar-footer,
        .inner-sidebar-header {
            height: 3.5rem;
            border-bottom: 1px solid #cbd5e0;
            display: flex;
            align-items: center;
            padding: 0 1rem;
            flex-shrink: 0;
        }
        .inner-main-body,
        .inner-sidebar-body {
            padding: 1rem;
            overflow-y: auto;
            position: relative;
            flex: 1 1 auto;
        }
        .inner-main-body .sticky-top,
        .inner-sidebar-body .sticky-top {
            z-index: 999;
        }
        
        .inner-main-footer,
        .inner-sidebar-footer {
            border-top: 1px solid #cbd5e0;
            border-bottom: 0;
            height: auto;
            min-height: 3.5rem;
        }
        @media (max-width: 767.98px) {
            .inner-sidebar {
                left: -235px;
            }
            .inner-main {
                left: 0;
            }
            .inner-expand .main-body {
                overflow: hidden;
            }
            .inner-expand .inner-wrapper {
                transform: translate3d(235px, 0, 0);
            }
        }

        .nav .show > .nav-link.nav-link-faded,
        .nav-link.nav-link-faded.active,
        .nav-link.nav-link-faded:active,
        .nav-pills .nav-link.nav-link-faded.active,
        .navbar-nav .show > .nav-link.nav-link-faded {
            color: #3367b5;
            background-color: #c9d8f0;
        }

        .nav-pills .nav-link.active,
        .nav-pills .show > .nav-link {
            color: #fff;
            background-color: #467bcb;
        }
        .nav-link.has-icon {
            display: flex;
            align-items: center;
        }
        .nav-link.active {
            color: #467bcb;
        }
        .nav-pills .nav-link {
            border-radius: 0.25rem;
        }
        .nav-link {
            color: #4a5568;
        }
        /* Modern Card Styling */
        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            margin-bottom: 1rem;
        }

        .card:hover {
            box-shadow: var(--card-shadow-hover);
            transform: translateY(-2px);
            border-color: #d0d7de;
        }

        .card-body {
            flex: 1 1 auto;
            min-height: 1px;
            padding: 1.5rem;
        }
        
        .container {
            margin-top: 15px;
        }

        /* Forum Post Styling */
        .forum-item {
            transition: all 0.3s ease;
        }

        .forum-item img {
            border: 3px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .forum-item:hover img {
            border-color: var(--primary-color);
            transform: scale(1.05);
        }

        .forum-item h4 a {
            color: #1a202c;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .forum-item h4 a:hover {
            color: var(--primary-color);
            text-decoration: none;
        }

        .forum-item h6 a {
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .forum-item h6 a:hover {
            color: var(--primary-color);
        }

        .forum-item .text-secondary {
            color: #6c757d !important;
            transition: color 0.3s ease;
        }

        .forum-item:hover .text-secondary {
            color: #495057 !important;
        }
        #image-preview {
            max-width: 400px; /* Adjust max width as needed */
            max-height: 400px; /* Adjust max height as needed */
        }
        
        #image-preview2 {
            max-width: 400px; /* Adjust max width as needed */
            max-height: 400px; /* Adjust max height as needed */
        }

        #image-preview-wrapper {
            position: relative;
            display: inline-block; /* Ensure it wraps around the image */
        }

        #delete-image {
            position: absolute;
            top: 5px; /* Adjust as needed */
            right: 5px; /* Adjust as needed */
            background: transparent;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
            display: none; /* Initially hidden */
        }
        
        #delete-image2 {
            position: absolute;
            top: 5px; /* Adjust as needed */
            right: 5px; /* Adjust as needed */
            background: transparent;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
            display: none; /* Initially hidden */
        }
        /* Create Post Button */
        .btn-primary.has-icon.btn-block {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0b5ed7 100%);
            border: none;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(13,110,253,0.3);
            transition: all 0.3s ease;
        }

        .btn-primary.has-icon.btn-block:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(13,110,253,0.4);
        }

        /* Dropdown Styling */
        .dropbtn {
            color: #6c757d;
            padding: 8px 12px;
            font-size: 1.25rem;
            font-weight: bold;
            background-color: transparent;
            border: none;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .dropbtn:hover {
            background-color: #f8f9fa;
            color: var(--primary-color);
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #fff;
            min-width: 160px;
            overflow: auto;
            z-index: 1000;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            border: 1px solid #e9ecef;
        }

        .dropdown-content a,
        .dropdown-content button.btn-xoa {
            color: #495057;
            padding: 10px 16px;
            text-decoration: none;
            display: block;
            transition: all 0.3s ease;
            border: none;
            width: 100%;
            text-align: left;
            background: transparent;
        }

        .dropdown-content a:hover,
        .dropdown-content button.btn-xoa:hover {
            background-color: #f8f9fa;
            color: var(--danger-color);
        }

        .btn-xoa {
            cursor: pointer;
        }

        .show {
            display: block;
            animation: fadeIn 0.2s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Modal Improvements */
        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        .modal-header.bg-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0b5ed7 100%) !important;
            border-radius: 16px 16px 0 0;
            padding: 1.5rem;
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

        /* Form Controls */
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,0.1);
        }

        /* Checkbox Styling */
        .checkbox-container {
            display: flex;
            align-items: center;
            padding: 10px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .checkbox-container:hover {
            border-color: var(--primary-color);
            background-color: #f8f9fa;
        }

        .checkbox-container input[type="checkbox"] {
            margin-right: 8px;
            cursor: pointer;
        }

        /* Button Improvements */
        .btn {
            border-radius: 8px;
            padding: 0.5rem 1.25rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-primary {
            background: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-light {
            background: #f8f9fa;
            border-color: #e9ecef;
        }

        .btn-light:hover {
            background: #e9ecef;
        }
    </style>

<body>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-2/css/all.min.css"
    integrity="sha256-46r060N2LrChLLb5zowXQ72/iKKNiw/lAmygmHExk/o="
    crossorigin="anonymous"
    />
<div class="container">
    <div class="main-body p-0">
        <div class="inner-wrapper">
            <div class="inner-sidebar">
                <div class="inner-sidebar-header justify-content-center">
                    <button
                        class="btn btn-primary has-icon btn-block"
                        type="button"
                        data-toggle="modal"
                        data-target="#threadModal"
                        >
                        <i class="fas fa-plus-circle mr-2"></i>
                        Tạo bài đăng
                    </button>
                </div>

                <div class="inner-sidebar-body p-0">
                    <div class="p-3 h-100" data-simplebar="init">
                        <div class="simplebar-wrapper" style="margin: -16px">
                            <div class="simplebar-height-auto-observer-wrapper">
                                <div class="simplebar-height-auto-observer"></div>
                            </div>
                            <div class="simplebar-mask">
                                <div
                                    class="simplebar-offset"
                                    style="right: 0px; bottom: 0px"
                                    >
                                    <div
                                        class="simplebar-content-wrapper"
                                        style="height: 100%; overflow-y: hidden;"
                                        >
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div
                            class="simplebar-track simplebar-horizontal"
                            style="visibility: hidden"
                            >
                            <div
                                class="simplebar-scrollbar"
                                style="width: 0px; display: none"
                                ></div>
                        </div>
                        <div
                            class="simplebar-track simplebar-vertical"
                            style="visibility: visible"
                            >
                            <div
                                class="simplebar-scrollbar"
                                style="
                                height: 151px;
                                display: block;
                                transform: translate3d(0px, 0px, 0px);
                                "
                                ></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="inner-main">
                <div class="inner-main-header">
                    <a
                        class="nav-link nav-icon rounded-circle nav-link-faded mr-3 d-md-none"
                        href="#"
                        data-toggle="inner-sidebar"
                        ><i class="material-icons">arrow_forward_ios</i></a
                    >
                </div>

                <div class="inner-main-body p-2 p-sm-3 collapse forum-content show">
                    <%
                    List<Forum> forums = new ForumDAO().getAllPost();
                    boolean check;
                    for (int i = forums.size() - 1; i >= 0; i--) {
                     check = true;
                     Forum forum = forums.get(i);
                     Users user = new UserDAO().findByUserID(forum.getUserID());
                     if(session.getAttribute("currentUser") != null){
                        Users realUser = (Users)session.getAttribute("currentUser");
                        if(realUser.getUserID() == user.getUserID()){
                             check = true;
                        }
                        else check = false;
                     }
                     String str;
                     String title;
                     if(forum.getPostContext().length() > 150){ 
                         str = forum.getPostContext().substring(0, 150) + "...";
                     }
                     else {
                         str = forum.getPostContext();
                     }
                     if(forum.getPostTitle().length() > 100){ 
                         title = forum.getPostTitle().substring(0, 100) + "...";
                     }
                     else {
                         title = forum.getPostTitle();
                     }
                %>
                <div class="card mb-2 all">
                    <div class="card-body p-2 p-sm-3 ">
                        <%
                                 if(check == false){
                        %>
                        <div class="media forum-item" style="float: right;" class="dropbtn"> 
                            <div class="dropdown">
                                <button
                                    onclick="toggleReport(this)"
                                    class="dropbtn"
                                    >
                                    ...
                                </button>
                                <div class="dropdown-content report-dropdown">
                                    <button
                                        class="btn btn-xoa"
                                        href="#home"
                                        type="button"
                                        data-toggle="modal"
                                        data-target="#report"
                                        >
                                        Báo cáo
                                    </button>
                                </div>
                            </div> 
                            <div
                                class="modal fade"
                                id="report"
                                tabindex="-1"
                                role="dialog"
                                aria-labelledby="threadModalLabel"
                                aria-hidden="true"
                                >
                                <div class="modal-dialog modal-lg" role="document">
                                    <div class="modal-content">
                                        <form action="NewReport" id="reportForm" method="POST" enctype="multipart/form-data">
                                            <input type="hidden" name="link" value="forum.jsp"/>
                                            <input type="hidden" name="otherUserID" value="<%=user.getUserID()%>"/>
                                            <div class="modal-header bg-primary text-white">
                                                <h5 class="modal-title" id="threadModalLabel">
                                                    <i class="fas fa-flag mr-2"></i>Báo cáo vi phạm
                                                </h5>
                                                <button
                                                    type="button"
                                                    class="close text-white"
                                                    data-dismiss="modal"
                                                    aria-label="Close"
                                                    style="opacity: 1;"
                                                    >
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label for="threadTitle">Lý do báo cáo</label>
                                                    <div class="checkbox-group" style="
                                                        display: flex;
                                                        flex-wrap: wrap;
                                                        gap: 10px; /* Khoảng cách giữa các checkbox */
                                                        margin-top: 20px;">
                                                         <label class="checkbox-container" style="width: 30%;">
                                                             <input type="checkbox" name="reasons" value="1"/>
                                                             <span class="checkmark"></span>
                                                             Lạm dụng ngôn từ
                                                         </label>
                                                         <label class="checkbox-container" style="width: 30%;">
                                                             <input type="checkbox" name="reasons" value="2"/>
                                                             <span class="checkmark"></span>
                                                             Hành vi gây rối diễn đàn
                                                         </label>
                                                         <label class="checkbox-container" style="width: 30%;">
                                                             <input type="checkbox" name="reasons" value="3"/>
                                                             <span class="checkmark"></span>
                                                             Tạo bài đăng sai mục đích 
                                                         </label>
                                                         <label class="checkbox-container" style="width: 30%;">
                                                             <input type="checkbox" name="reasons" value="4"/>
                                                             <span class="checkmark"></span>
                                                             Bài đăng Không liên quan 
                                                         </label>
                                                         <label class="checkbox-container" style="width: 30%;">
                                                             <input type="checkbox" name="reasons" value="5"/>
                                                             <span class="checkmark"></span>
                                                             Spam Bình luận quảng cáo trong diễn đàn 
                                                         </label>
                                                         <label class="checkbox-container" style="width: 30%;">
                                                             <input type="checkbox" name="reasons" value="6"/>
                                                             <span class="checkmark"></span>
                                                             Bình luận mang tính phản cảm
                                                         </label>
                                                         <label class="checkbox-container" style="width: 30%;">
                                                             <input type="checkbox" name="reasons" value="7" class="reason-checkbox"/>
                                                             <span class="checkmark"></span>
                                                             lý do báo cáo khác
                                                         </label>
                                                    </div>
                                                    <br>
                                                    <div class="form-group" id="details-container" style="display: none;">
                                                        <label for="thread-detail">Chi tiết</label>
                                                        <textarea
                                                            type="text"
                                                            class="form-control"
                                                            name="context"
                                                            id="thread-detail"
                                                            placeholder="Chi tiết"
                                                            rows="5"
                                                            style="resize: none; overflow: hidden;"></textarea>
                                                    </div>
                                                    <div id="image-preview-container">
                                                        <label for="myfile">Chọn ảnh:</label>
                                                        <input id="image-upload" type="file" name="image" accept="image/*">
                                                        <br>
                                                        <div id="image-preview-wrapper" style="position: relative;">
                                                            <img id="image-preview" src="#" width="400" height="400" alt="Preview Image" style="display:none;">
                                                            <button id="delete-image"><i class="fa fa-times"></i></button>
                                                        </div>
                                                    </div>
                                                    <br>
                                                    <br><br>
                                                    <textarea class="form-control summernote" style="display: none"></textarea>
                                                    <div class="custom-file form-control-sm mt-3" style="max-width: 300px"></div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button onclick="removeURL(this)"
                                                            type="button"
                                                            class="btn btn-light"
                                                            data-dismiss="modal"
                                                            >
                                                        <i class="fas fa-times mr-2"></i>Hủy
                                                    </button>
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="fas fa-paper-plane mr-2"></i>Gửi báo cáo
                                                    </button>
                                                </div>
                                            </div> 
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="media forum-item">
                            <%
                                        }
                                        else{
                            %>
                            <div class="media forum-item" class="dropbtn">
                                <%
                                        }
                                %>
                                <%
                                   if(check == true){
                                %>
                                <a
                                    href="profile.jsp"
                                    data-target=".forum-content"
                                    ><img
                                        src="<%=user.getAvatarURL()%>"
                                        class="mr-3 rounded-circle"
                                        width="50"
                                        height="50"
                                        alt="User"
                                        /></a>
                                <div class="media-body">
                                    <h6>
                                        <a
                                            href="profile.jsp"
                                            data-target=".forum-content"
                                            class="text-body"
                                            style="text-decoration: none"
                                            ><%=user.getUsername()%></a>
                                        <p style="font-style: italic; color: gray; font-size: 12px"><%=forum.getPostDate()%></p>
                                    </h6> 
                                    <%
                                        }
                                        else{ 
                                    %> 

                                    <a
                                        href="UserProfile?userID=<%=forum.getUserID()%>"
                                        data-target=".forum-content"
                                        ><img
                                            src="<%=user.getAvatarURL()%>"
                                            class="mr-3 rounded-circle"
                                            width="50"
                                            height="50"
                                            alt="User"
                                            /></a>
                                    <div class="media-body">
                                        <h6>
                                            <a
                                                href="UserProfile?userID=<%=forum.getUserID()%>"
                                                data-target=".forum-content"
                                                class="text-body"
                                                style="text-decoration: none"
                                                ><%=user.getUsername()%></a>
                                            <p style="font-style: italic; color: gray; font-size: 12px"><%=forum.getPostDate()%></p>
                                        </h6>
                                        <%
                                            }
                                        %>
                                        <h4>
                                            <a
                                                href="ForumDetail?postID=<%=forum.getPostID()%>"
                                                data-target=".forum-content"
                                                class="text-body title"
                                                style="overflow-wrap:break-word;"
                                                ><%=title%></a
                                            >
                                        </h4>
                                        <a href="ForumDetail?postID=<%=forum.getPostID()%>" style="text-decoration: none">
                                            <p class="text-secondary context" style="overflow-wrap:break-word;" >
                                                <%=str%>
                                            </p>
                                        </a>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <div
                class="modal fade"
                id="threadModal"
                tabindex="-1"
                role="dialog"
                aria-labelledby="threadModalLabel"
                aria-hidden="true"
                >
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <form action="NewPost" method="POST" enctype="multipart/form-data">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="threadModalLabel">
                                    <i class="fas fa-edit mr-2"></i>Tạo bài đăng mới
                                </h5>
                                <button
                                    type="button"
                                    class="close text-white"
                                    data-dismiss="modal"
                                    aria-label="Close"
                                    style="opacity: 1;"
                                    >
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="threadTitle">Tiêu đề</label>
                                    <input
                                        type="text"
                                        class="form-control"
                                        id="threadTitle"
                                        name="title"
                                        placeholder="Tiêu đề"
                                        required
                                        autofocus
                                        />
                                    <br>
                                    <div class="form-group">
                                        <label for="thread-detail">Chi tiết</label>
                                        <textarea
                                            type="text"
                                            class="form-control"
                                            name="context"
                                            id="threadTitle"
                                            placeholder="Chi tiết"
                                            required
                                            autofocus
                                            rows="5" 
                                            style="resize: none; overflow: hidden;"
                                            ></textarea>
                                    </div>
                                    <div id="image-preview-container">
                                        <label for="myfile">Chọn ảnh:</label>
                                        <input id="image-upload2" type="file" name="image" accept="image/*">
                                        <br>
                                        <div id="image-preview-wrapper" style="position: relative;">
                                            <img id="image-preview2" src="#" alt="Preview Image" style="display:none;">
                                            <button id="delete-image2"><i class="fa fa-times"></i></button>
                                        </div>
                                    </div>
                                    <br>
                                    <br><br>
                                    <textarea
                                        class="form-control summernote"
                                        style="display: none"
                                        ></textarea>
                                    <div
                                        class="custom-file form-control-sm mt-3"
                                        style="max-width: 300px"
                                        >
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button onclick="removeURL(this)"
                                            type="button"
                                            class="btn btn-light"
                                            data-dismiss="modal"
                                            >
                                        <i class="fas fa-times mr-2"></i>Hủy
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane mr-2"></i>Đăng bài
                                    </button>
                                </div>

                            </div> 
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>        
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript"></script>
    <script>

                                            // Function to toggle report dropdown visibility
                                            function toggleReport(button) {
                                                var dropdownContent = button.nextElementSibling;
                                                dropdownContent.classList.toggle("show");
                                            }

                                            // Close dropdown when clicking outside of it
                                            window.onclick = function (event) {
                                                if (!event.target.matches('.dropbtn')) {
                                                    var dropdowns = document.getElementsByClassName("report-dropdown");
                                                    for (var i = 0; i < dropdowns.length; i++) {
                                                        var openDropdown = dropdowns[i];
                                                        if (openDropdown.classList.contains('show')) {
                                                            openDropdown.classList.remove('show');
                                                        }
                                                    }
                                                }
                                            }
                                            // Function to show/hide the "Chi tiết" textarea
                                            document.querySelectorAll('.reason-checkbox').forEach(checkbox => {
                                                checkbox.addEventListener('change', () => {
                                                    const detailsContainer = document.getElementById('details-container');
                                                    const anyChecked = Array.from(document.querySelectorAll('.reason-checkbox')).some(cb => cb.checked);
                                                    detailsContainer.style.display = anyChecked ? 'block' : 'none';

                                                    // Toggle required attribute
                                                    document.getElementById('thread-detail').required = anyChecked;
                                                });
                                            });
                                            document.getElementById('reportForm').addEventListener('submit', function (event) {
                                                var checkboxes = document.querySelectorAll('input[name="reasons"]');
                                                var isChecked = false;

                                                for (var i = 0; i < checkboxes.length; i++) {
                                                    if (checkboxes[i].checked) {
                                                        isChecked = true;
                                                        break;
                                                    }
                                                }

                                                if (!isChecked) {
                                                    alert('Vui lòng chọn ít nhất một lý do báo cáo.');
                                                    event.preventDefault(); // Ngăn chặn việc nộp biểu mẫu
                                                }
                                            });
    </script>
    <script>
        // Function to handle file input change event
        document.getElementById('image-upload').addEventListener('change', function (event) {
            var file = event.target.files[0];
            var reader = new FileReader();

            reader.onload = function (e) {
                var imgElement = document.getElementById('image-preview');
                imgElement.src = e.target.result;
                imgElement.style.display = 'block';

                // Show delete button
                document.getElementById('delete-image').style.display = 'inline-block';
            }

            reader.readAsDataURL(file);
        });

        // Function to handle delete image button click
        document.getElementById('delete-image2').addEventListener('click', function (event) {
            event.preventDefault(); // Prevent default behavior (page reload)

            var imgElement = document.getElementById('image-preview2');
            imgElement.src = '#'; // Clear the preview
            imgElement.style.display = 'none';

            // Hide delete button
            document.getElementById('delete-image2').style.display = 'none';

            // Reset file input
            document.getElementById('image-upload2').value = '';
        });

        function removeURL() {
            var imgElement = document.getElementById('image-preview2');
            imgElement.src = '#'; // Clear the preview
            imgElement.style.display = 'none';
            document.getElementById('image-upload2').value = '';
        }

        document.getElementById('image-upload2').addEventListener('change', function (event) {
            var file = event.target.files[0];
            var reader = new FileReader();

            reader.onload = function (e) {
                var imgElement = document.getElementById('image-preview2');
                imgElement.src = e.target.result;
                imgElement.style.display = 'block';

                // Show delete button
                document.getElementById('delete-image2').style.display = 'inline-block';
            }

            reader.readAsDataURL(file);
        });

        // Function to handle delete image button click
        document.getElementById('delete-image2').addEventListener('click', function (event) {
            event.preventDefault(); // Prevent default behavior (page reload)

            var imgElement = document.getElementById('image-preview2');
            imgElement.src = '#'; // Clear the preview
            imgElement.style.display = 'none';

            // Hide delete button
            document.getElementById('delete-image2').style.display = 'none';

            // Reset file input
            document.getElementById('image-upload2').value = '';
        });

        function removeURL() {
            var imgElement = document.getElementById('image-preview2');
            imgElement.src = '#'; // Clear the preview
            imgElement.style.display = 'none';
            document.getElementById('image-upload2').value = '';
        }

    </script>

    <script>
        var all = document.getElementsByClassName('all');
        function searchFuntion() {
            var input = document.getElementById('userInput');
            var filter = input.value.toUpperCase();
            var a, b, txtValue, txtValue2;
            for (var i = 0; i < all.length; i++) {
                a = all[i].getElementsByClassName("title")[0];
                b = all[i].getElementsByClassName("context")[0];
                txtValue = a.textContent || a.innerText;
                txtValue2 = b.textContent || b.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1 || txtValue2.toUpperCase().indexOf(filter) > -1)
                    all[i].style.display = 'block';
                else
                    all[i].style.display = 'none';
            }
        }
    </script>

    <script>
        var textarea = document.getElementById("submit-comment");
        if (textarea) {
            textarea.addEventListener("input", function () {
                this.style.height = "auto";
                this.style.height = (this.scrollHeight) + "px";
            });
        }
    </script>
</body>
<jsp:include page="footer.jsp"></jsp:include>

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>