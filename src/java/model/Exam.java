/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;


public class Exam {
    private int examID;
    private String examName;
    private String createDate;
    private int userID;
    private int subjectID;
    private int timer;
    private int price;
    private int likes;
    private int views;
    private int status;
    private boolean isAprroved;
    private int difficultyLevel; // 1=Dễ, 2=Vừa, 3=Khó

    public Exam() {
        this.difficultyLevel = 1; // Default: Dễ
    }

    public Exam(int examID, String examName, String createDate, int userID, int subjectID, int timer, int price) {
        this.examID = examID;
        this.examName = examName;
        this.createDate = createDate;
        this.userID = userID;
        this.subjectID = subjectID;
        this.timer = timer;
        this.price = price;
        this.difficultyLevel = 1; // Default: Dễ
    }
    
    // Constructor with difficulty level
    public Exam(int examID, String examName, String createDate, int userID, int subjectID, int timer, int price, int difficultyLevel) {
        this.examID = examID;
        this.examName = examName;
        this.createDate = createDate;
        this.userID = userID;
        this.subjectID = subjectID;
        this.timer = timer;
        this.price = price;
        this.difficultyLevel = difficultyLevel;
    }

    public int getExamID() {
        return examID;
    }

    public void setExamID(int examID) {
        this.examID = examID;
    }

    public String getExamName() {
        return examName;
    }

    public void setExamName(String examName) {
        this.examName = examName;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public int getTimer() {
        return timer;
    }

    public void setTimer(int timer) {
        this.timer = timer;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public boolean isIsAprroved() {
        return isAprroved;
    }

    public void setIsAprroved(boolean isAprroved) {
        this.isAprroved = isAprroved;
    }

    public int getDifficultyLevel() {
        return difficultyLevel;
    }

    public void setDifficultyLevel(int difficultyLevel) {
        if (difficultyLevel < 1 || difficultyLevel > 3) {
            throw new IllegalArgumentException("Difficulty level must be 1 (Dễ), 2 (Vừa), or 3 (Khó)");
        }
        this.difficultyLevel = difficultyLevel;
    }
    
    /**
     * Lấy tên mức độ khó bằng tiếng Việt
     * @return "Dễ", "Vừa", hoặc "Khó"
     */
    public String getDifficultyLevelName() {
        return DifficultyLevel.fromValue(difficultyLevel).getDisplayNameVi();
    }
    
    /**
     * Lấy DifficultyLevel enum
     * @return DifficultyLevel enum
     */
    public DifficultyLevel getDifficulty() {
        return DifficultyLevel.fromValue(difficultyLevel, DifficultyLevel.EASY);
    }
    
    /**
     * Set difficulty bằng enum
     * @param difficulty DifficultyLevel enum
     */
    public void setDifficulty(DifficultyLevel difficulty) {
        this.difficultyLevel = difficulty.getValue();
    }
    
    /**
     * Lấy HTML badge cho hiển thị mức độ
     * @return HTML badge string
     */
    public String getDifficultyBadge() {
        return getDifficulty().toHtmlBadge();
    }
    
    @Override
    public String toString() {
        return "Exam{" + "examID=" + examID + ", examName=" + examName + ", createDate=" + createDate + ", userID=" + userID + ", subjectID=" + subjectID + ", timer=" + timer + ", price=" + price + ", difficultyLevel=" + difficultyLevel + '}';
    }
}
