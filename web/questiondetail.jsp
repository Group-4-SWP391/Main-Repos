<%@page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*"%>
<%@ page import="model.QuestionBank" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<jsp:include page="header.jsp"></jsp:include>
    <style>
        /* Modern UI for Question Detail */
        body {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Remove all underlines and unwanted borders */
        a, a:hover, a:focus, a:active {
            text-decoration: none !important;
            border-top: none !important;
            border-bottom: none !important;
        }

        * {
            text-decoration: none !important;
        }
        
        /* Aggressive removal of all horizontal lines */
        h1, h2, h3, h4, h5, h6, p, span, div, label {
            border-top: none !important;
            border-bottom: none !important;
            text-decoration: none !important;
        }
        
        /* Remove all pseudo-elements that might create lines */
        *::before, *::after {
            border-top: none !important;
            border-bottom: none !important;
            text-decoration: none !important;
        }
        
        /* Specifically target section-title pseudo-elements from global CSS */
        .section-title::before,
        .section-title::after,
        .section-title:hover::before,
        .section-title:hover::after,
        .section-title:focus::before,
        .section-title:focus::after,
        .section-title:active::before,
        .section-title:active::after {
            display: none !important;
            content: none !important;
            width: 0 !important;
            height: 0 !important;
            background: none !important;
            border: none !important;
            position: static !important;
            opacity: 0 !important;
            visibility: hidden !important;
        }
        
        h1::before, h1::after, h2::before, h2::after, 
        h3::before, h3::after, h4::before, h4::after,
        h5::before, h5::after, h6::before, h6::after {
            border: none !important;
            background: none !important;
            content: none !important;
        }

        .container {
            padding-top: 3rem;
            padding-bottom: 3rem;
        }

        /* Back Button */
        .btn-back {
            background: white;
            color: #2596be !important;
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none !important;
            margin-bottom: 2rem;
        }

        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.15);
            background: #f8f9fa;
            text-decoration: none !important;
        }

        /* Card Container */
        .question-detail-card {
            background: white;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: slideUp 0.6s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Card Header */
        .card-header-custom {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            padding: 2rem;
            color: white;
        }

        .card-header-custom h2 {
            margin: 0;
            font-weight: 700;
            font-size: 1.75rem;
            display: flex;
            align-items: center;
            gap: 12px;
            border: none !important;
            text-decoration: none !important;
        }
        
        .card-header-custom h2 * {
            border: none !important;
            text-decoration: none !important;
        }

        /* Card Body */
        .card-body-custom {
            padding: 2.5rem;
        }

        /* Section Styling */
        .section {
            margin-bottom: 2.5rem;
            padding: 1.5rem;
            border-radius: 16px;
            background: #f8f9fa;
            border-left: 5px solid #2596be;
            border-top: none !important;
            border-bottom: none !important;
            border-right: none !important;
            transition: all 0.3s ease;
            text-decoration: none !important;
        }

        .section:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            text-decoration: none !important;
            border-top: none !important;
            border-bottom: none !important;
        }

        .section-title {
            font-weight: 700;
            font-size: 1.25rem;
            color: #2596be;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none !important;
            border: none !important;
            border-top: none !important;
            border-bottom: none !important;
            position: relative !important;
        }
        
        .section-title * {
            border: none !important;
            border-top: none !important;
            border-bottom: none !important;
            text-decoration: none !important;
        }
        
        .section-title *::before,
        .section-title *::after {
            display: none !important;
            content: none !important;
        }
        
        /* Remove pseudo-elements that create horizontal lines */
        .section-title::before,
        .section-title::after,
        .section-title:hover::before,
        .section-title:hover::after,
        .section-title:focus::before,
        .section-title:focus::after,
        .section-title:active::before,
        .section-title:active::after {
            display: none !important;
            content: none !important;
            width: 0 !important;
            height: 0 !important;
            background: none !important;
            border: none !important;
            position: static !important;
            opacity: 0 !important;
            visibility: hidden !important;
            z-index: -999 !important;
        }

        .section-content {
            color: #495057;
            line-height: 1.8;
            font-size: 1rem;
            text-decoration: none !important;
            border: none !important;
        }
        
        .section-content p {
            text-decoration: none !important;
            border: none !important;
        }
        
        .section-content *,
        .section-title *,
        .choice-text *,
        .choice-label * {
            border-top: none !important;
            border-bottom: none !important;
            text-decoration: none !important;
        }

        /* Choice Items */
        .choice-item {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 0.75rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none !important;
        }

        .choice-item:hover {
            border-color: #2596be;
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(37,150,190,0.15);
            text-decoration: none !important;
        }

        .choice-label {
            background: linear-gradient(135deg, #2596be 0%, #1a7a9f 100%);
            color: white;
            font-weight: 700;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 1.1rem;
            text-decoration: none !important;
            border: none !important;
        }

        .choice-text {
            flex: 1;
            color: #495057;
            font-weight: 500;
            text-decoration: none !important;
            border: none !important;
        }
        
        /* Remove all borders from icons and SVGs */
        svg, i, .fa, .fas, .far, .fab {
            border: none !important;
            text-decoration: none !important;
        }
        
        /* Remove HR and other separator elements */
        hr {
            display: none !important;
        }
        
        /* Target any element that might have text-decoration or border */
        .container *, .card-body-custom *, .section * {
            text-decoration: none !important;
        }
        
        .container *:not(.section):not(.choice-item):not(.btn-back),
        .card-body-custom *:not(.section):not(.choice-item) {
            border-top: none !important;
            border-bottom: none !important;
        }

        /* Correct Answer Section */
        .correct-answer-section {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
            color: white;
            padding: 1.5rem;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(40,167,69,0.3);
        }

        .correct-answer-section .section-title {
            color: white;
            font-size: 1.5rem;
        }

        .correct-answer-section .choice-item {
            background: rgba(255,255,255,0.95);
            border: 2px solid white;
        }

        /* Explanation Section */
        .explanation-section {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            border-left: 5px solid #0ea5e9;
        }

        /* Images */
        .question-image {
            max-width: 100%;
            height: auto;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            margin: 1rem 0;
            transition: all 0.3s ease;
        }

        .question-image:hover {
            transform: scale(1.02);
            box-shadow: 0 12px 32px rgba(0,0,0,0.15);
        }

        .choice-image {
            max-height: 60px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        /* Difficulty Badge */
        .difficulty-badge {
            display: inline-flex;
            align-items: center;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            margin-left: auto;
        }

        .difficulty-easy {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
        }

        .difficulty-medium {
            background: linear-gradient(135deg, #f39c12 0%, #f1c40f 100%);
            color: white;
        }

        .difficulty-hard {
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
            color: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .card-body-custom {
                padding: 1.5rem;
            }

            .section {
                padding: 1rem;
            }
        }
    </style>
<%
if(session.getAttribute("questionID") != null){
int questionID = (Integer)session.getAttribute("questionID");
QuestionBank qb = new ExamDAO().getQuestionByID(questionID);
String link = (String)session.getAttribute("backlink");

// Determine difficulty badge
int diffLevel = qb.getDifficultyLevel();
String diffBadgeClass = "difficulty-medium";
String diffText = "Vừa";
if(diffLevel == 1) { 
    diffBadgeClass = "difficulty-easy"; 
    diffText = "Dễ"; 
} else if(diffLevel == 3) { 
    diffBadgeClass = "difficulty-hard"; 
    diffText = "Khó"; 
}
%>
<body>
    <div class="container">
        <a href="<%=link%>" class="btn-back">
            <i class="bi bi-arrow-left-circle"></i>
            <span>Trở về</span>
        </a>
        
        <div class="question-detail-card">
            <div class="card-header-custom">
                <h2>
                    <i class="bi bi-question-circle"></i>
                    Chi tiết câu hỏi
                    <span class="difficulty-badge <%=diffBadgeClass%>"><%=diffText%></span>
                </h2>
            </div>
            
            <div class="card-body-custom">
                <!-- Question Section -->
                <div class="section">
                    <div class="section-title">
                        <i class="bi bi-file-text"></i>
                        Nội dung câu hỏi
                    </div>
                    <div class="section-content">
                        <p style="overflow-wrap:break-word; margin: 0;"><%=qb.getQuestionContext()%></p>
                        <%
                        if(qb.getQuestionImg() != null){
                        %>
                        <img src="<%=qb.getQuestionImg()%>" class="question-image"/>
                        <%
                            }
                        %>
                    </div>
                </div>
                
                <!-- Choices Section -->
                <div class="section">
                    <div class="section-title">
                        <i class="bi bi-list-check"></i>
                        Các lựa chọn
                    </div>
                    <!-- Choice A -->
                    <div class="choice-item">
                        <div class="choice-label">A</div>
                        <%
                        if(qb.getChoice1().startsWith("uploads/docreader")){
                        %>
                        <img src="<%=qb.getChoice1()%>" class="choice-image" alt="Choice A"/>
                        <%
                            }
                        else{
                        %>
                        <div class="choice-text"><%=qb.getChoice1()%></div>
                        <%
                            }
                        %>
                    </div>
                    
                    <!-- Choice B -->
                    <div class="choice-item">
                        <div class="choice-label">B</div>
                        <%
                        if(qb.getChoice2().startsWith("uploads/docreader")){
                        %>
                        <img src="<%=qb.getChoice2()%>" class="choice-image" alt="Choice B"/>
                        <%
                            }
                        else{
                        %>
                        <div class="choice-text"><%=qb.getChoice2()%></div>
                        <%
                            }
                        %>
                    </div>
                    
                    <!-- Choice C -->
                    <div class="choice-item">
                        <div class="choice-label">C</div>
                        <%
                        if(qb.getChoice3().startsWith("uploads/docreader")){
                        %>
                        <img src="<%=qb.getChoice3()%>" class="choice-image" alt="Choice C"/>
                        <%
                            }
                        else{
                        %>
                        <div class="choice-text"><%=qb.getChoice3()%></div>
                        <%
                            }
                        %>
                    </div>
                    
                    <!-- Choice D -->
                    <div class="choice-item">
                        <div class="choice-label">D</div>
                        <%
                        if(qb.getChoiceCorrect().startsWith("uploads/docreader")){
                        %>
                        <img src="<%=qb.getChoiceCorrect()%>" class="choice-image" alt="Choice D"/>
                        <%
                            }
                        else{
                        %>
                        <div class="choice-text"><%=qb.getChoiceCorrect()%></div>
                        <%
                            }
                        %>
                    </div>
                </div>
                
                <!-- Correct Answer Section -->
                <div class="section correct-answer-section">
                    <div class="section-title">
                        <i class="bi bi-check-circle-fill"></i>
                        Đáp án đúng
                    </div>
                    <div class="choice-item">
                        <div class="choice-label">D</div>
                        <%
                        if(qb.getChoiceCorrect().startsWith("uploads/docreader")){
                        %>
                        <img src="<%=qb.getChoiceCorrect()%>" class="choice-image" alt="Correct Answer"/>
                        <%
                            }
                        else{
                        %>
                        <div class="choice-text"><%=qb.getChoiceCorrect()%></div>
                        <%
                            }
                        %>
                    </div>
                </div>
                
                <!-- Explanation Section -->
                <div class="section explanation-section">
                    <div class="section-title">
                        <i class="bi bi-lightbulb"></i>
                        Giải thích chi tiết
                    </div>
                    <div class="section-content">
                        <p style="overflow-wrap:break-word; margin: 0;"><%=qb.getExplain()%></p>
                        <%
                        if(qb.getExplainImg() != null){
                        %>
                        <img src="<%=qb.getExplainImg()%>" class="question-image"/>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        }
    %>
    <jsp:include page="footer.jsp"></jsp:include>
    
    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
