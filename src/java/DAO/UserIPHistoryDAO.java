/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.*;

public class UserIPHistoryDAO extends DBConnection{

    // Lấy lịch sử các địa chỉ IP của người dùng
    public List<String> getUserIPHistory(int userID) throws SQLException {
        List<String> ipHistory = new ArrayList<>();
        String sql = "SELECT ipAddress FROM [dbo].[UserIPHistory] WHERE userID = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            
            if (conn == null) {
                System.err.println("❌ [UserIPHistoryDAO.getUserIPHistory] Connection is NULL!");
                throw new SQLException("Cannot get database connection");
            }
            
            System.out.println("✅ [UserIPHistoryDAO.getUserIPHistory] Querying IP for userID: " + userID);
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userID);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                String ip = rs.getString("ipAddress");
                ipHistory.add(ip);
                System.out.println("   Found IP: " + ip);
            }
            
            System.out.println("✅ [UserIPHistoryDAO.getUserIPHistory] Total IPs found: " + ipHistory.size());
            
        } catch (SQLException e) {
            System.err.println("❌ [UserIPHistoryDAO.getUserIPHistory] SQLException: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
            if (conn != null) try { conn.close(); } catch (SQLException e) { }
        }
        
        return ipHistory;
    }

    // Thêm một địa chỉ IP mới vào lịch sử
    public void addUserIP(int userID, String ipAddress) throws SQLException {
        String sql = "INSERT INTO [dbo].[UserIPHistory](userID, ipAddress, loginDate, isCurrentIP) VALUES (?, ?, GETDATE(), 1)";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = getConnection();
            
            if (conn == null) {
                System.err.println("❌ [UserIPHistoryDAO.addUserIP] Connection is NULL!");
                throw new SQLException("Cannot get database connection");
            }
            
            System.out.println("✅ [UserIPHistoryDAO.addUserIP] Connection established");
            System.out.println("   Auto-commit: " + conn.getAutoCommit());
            System.out.println("   Adding IP - userID: " + userID + ", IP: " + ipAddress);
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userID);
            stmt.setString(2, ipAddress);
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("✅ [UserIPHistoryDAO.addUserIP] Insert successful! Rows affected: " + rowsAffected);
            
        } catch (SQLException e) {
            System.err.println("❌ [UserIPHistoryDAO.addUserIP] SQLException: " + e.getMessage());
            System.err.println("   SQL State: " + e.getSQLState());
            System.err.println("   Error Code: " + e.getErrorCode());
            e.printStackTrace();
            throw e;
        } catch (Exception e) {
            System.err.println("❌ [UserIPHistoryDAO.addUserIP] Exception: " + e.getMessage());
            e.printStackTrace();
            throw new SQLException("Error adding IP: " + e.getMessage(), e);
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
            if (conn != null) try { conn.close(); } catch (SQLException e) { }
        }
    }

    // Cập nhật trạng thái "isCurrentIP" cho tất cả các IP cũ của người dùng
    public void updateUserIPStatus(int userID) throws SQLException {
        String sql = "UPDATE [dbo].[UserIPHistory] SET isCurrentIP = 0 WHERE userID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.executeUpdate();
        }
    }

    // Đặt trạng thái ban cho người dùng
    public void setBanStatus(int userID, boolean isBanned) throws SQLException {
        String sql = "UPDATE Users SET is_banned = ? WHERE userID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, isBanned);
            stmt.setInt(2, userID);
            stmt.executeUpdate();
        }
    }
}
