/*
 * Enum để quản lý mức độ khó của câu hỏi và bài thi
 * Tạo bởi: AI Assistant
 * Ngày: 21/11/2025
 */
package model;

/**
 * Enum định nghĩa các mức độ khó của câu hỏi và bài thi
 * 
 * Ánh xạ với database:
 * - EASY = 1 (Dễ)
 * - MEDIUM = 2 (Vừa)
 * - HARD = 3 (Khó)
 */
public enum DifficultyLevel {
    
    EASY(1, "Dễ", "Easy", "success", "#28a745"),
    MEDIUM(2, "Vừa", "Medium", "warning", "#ffc107"),
    HARD(3, "Khó", "Hard", "danger", "#dc3545");
    
    private final int value;
    private final String displayNameVi;
    private final String displayNameEn;
    private final String badgeClass;
    private final String colorCode;
    
    /**
     * Constructor
     * 
     * @param value Giá trị lưu trong database (1, 2, 3)
     * @param displayNameVi Tên hiển thị tiếng Việt
     * @param displayNameEn Tên hiển thị tiếng Anh
     * @param badgeClass Bootstrap badge class
     * @param colorCode Mã màu hex
     */
    DifficultyLevel(int value, String displayNameVi, String displayNameEn, String badgeClass, String colorCode) {
        this.value = value;
        this.displayNameVi = displayNameVi;
        this.displayNameEn = displayNameEn;
        this.badgeClass = badgeClass;
        this.colorCode = colorCode;
    }
    
    /**
     * Lấy giá trị number để lưu vào database
     * @return 1 (Dễ), 2 (Vừa), 3 (Khó)
     */
    public int getValue() {
        return value;
    }
    
    /**
     * Lấy tên hiển thị tiếng Việt
     * @return "Dễ", "Vừa", "Khó"
     */
    public String getDisplayNameVi() {
        return displayNameVi;
    }
    
    /**
     * Lấy tên hiển thị tiếng Anh
     * @return "Easy", "Medium", "Hard"
     */
    public String getDisplayNameEn() {
        return displayNameEn;
    }
    
    /**
     * Lấy Bootstrap badge class
     * @return "success", "warning", "danger"
     */
    public String getBadgeClass() {
        return badgeClass;
    }
    
    /**
     * Lấy mã màu hex
     * @return "#28a745", "#ffc107", "#dc3545"
     */
    public String getColorCode() {
        return colorCode;
    }
    
    /**
     * Convert từ giá trị int sang enum
     * 
     * @param value Giá trị từ database (1, 2, 3)
     * @return DifficultyLevel enum tương ứng
     * @throws IllegalArgumentException nếu value không hợp lệ
     */
    public static DifficultyLevel fromValue(int value) {
        for (DifficultyLevel level : DifficultyLevel.values()) {
            if (level.value == value) {
                return level;
            }
        }
        throw new IllegalArgumentException("Invalid difficulty level value: " + value);
    }
    
    /**
     * Convert từ giá trị int sang enum với giá trị mặc định
     * 
     * @param value Giá trị từ database (1, 2, 3)
     * @param defaultLevel Giá trị mặc định nếu không hợp lệ
     * @return DifficultyLevel enum tương ứng hoặc defaultLevel
     */
    public static DifficultyLevel fromValue(int value, DifficultyLevel defaultLevel) {
        try {
            return fromValue(value);
        } catch (IllegalArgumentException e) {
            return defaultLevel;
        }
    }
    
    /**
     * Convert từ String sang enum (hỗ trợ cả tiếng Việt và tiếng Anh)
     * 
     * @param name Tên mức độ ("Dễ", "Easy", "Vừa", "Medium", "Khó", "Hard")
     * @return DifficultyLevel enum tương ứng
     * @throws IllegalArgumentException nếu name không hợp lệ
     */
    public static DifficultyLevel fromString(String name) {
        if (name == null || name.trim().isEmpty()) {
            return EASY; // Default
        }
        
        String normalized = name.trim().toLowerCase();
        
        for (DifficultyLevel level : DifficultyLevel.values()) {
            if (level.displayNameVi.toLowerCase().equals(normalized) ||
                level.displayNameEn.toLowerCase().equals(normalized) ||
                level.name().toLowerCase().equals(normalized)) {
                return level;
            }
        }
        
        throw new IllegalArgumentException("Invalid difficulty level name: " + name);
    }
    
    /**
     * Kiểm tra xem giá trị có hợp lệ không
     * 
     * @param value Giá trị cần kiểm tra
     * @return true nếu hợp lệ (1, 2, 3), false nếu không
     */
    public static boolean isValid(int value) {
        return value >= 1 && value <= 3;
    }
    
    /**
     * Lấy tất cả mức độ dưới dạng array
     * 
     * @return Array các DifficultyLevel
     */
    public static DifficultyLevel[] getAllLevels() {
        return DifficultyLevel.values();
    }
    
    /**
     * Format HTML badge cho hiển thị trên web
     * 
     * @return HTML badge string
     */
    public String toHtmlBadge() {
        return String.format("<span class='badge badge-%s'>%s</span>", badgeClass, displayNameVi);
    }
    
    /**
     * Format HTML badge với custom size
     * 
     * @param size "sm", "md", "lg"
     * @return HTML badge string
     */
    public String toHtmlBadge(String size) {
        return String.format("<span class='badge badge-%s badge-%s'>%s</span>", badgeClass, size, displayNameVi);
    }
    
    /**
     * So sánh mức độ khó
     * 
     * @param other Mức độ cần so sánh
     * @return true nếu mức độ hiện tại khó hơn
     */
    public boolean isHarderThan(DifficultyLevel other) {
        return this.value > other.value;
    }
    
    /**
     * So sánh mức độ khó
     * 
     * @param other Mức độ cần so sánh
     * @return true nếu mức độ hiện tại dễ hơn
     */
    public boolean isEasierThan(DifficultyLevel other) {
        return this.value < other.value;
    }
    
    @Override
    public String toString() {
        return displayNameVi;
    }
    
    /**
     * Format thành JSON string
     * 
     * @return JSON representation
     */
    public String toJson() {
        return String.format(
            "{\"value\":%d,\"nameVi\":\"%s\",\"nameEn\":\"%s\",\"color\":\"%s\"}",
            value, displayNameVi, displayNameEn, colorCode
        );
    }
}

