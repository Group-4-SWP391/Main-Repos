/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.*;


public class QuestionBankDAO extends DBConnection {

    // Helper method to map ResultSet to QuestionBank
    private QuestionBank mapResultSetToQuestionBank(ResultSet rs) throws SQLException {
        QuestionBank qb = new QuestionBank();
        qb.setQuestionId(rs.getInt("question_id"));
        qb.setSubjectId(rs.getInt("subject_id"));
        qb.setQuestionContext(rs.getString("question_context"));
        qb.setChoice1(rs.getString("question_choice_1"));
        qb.setChoice2(rs.getString("question_choice_2"));
        qb.setChoice3(rs.getString("question_choice_3"));
        qb.setChoiceCorrect(rs.getString("question_choice_correct"));
        qb.setExplain(rs.getString("question_explain"));
        qb.setQuestionImg(rs.getString("question_img"));
        qb.setExplainImg(rs.getString("question_explain_img"));
        qb.setUserID(rs.getInt("userID"));
        qb.setDifficultyLevel(rs.getInt("difficulty_level")); // Read difficulty level!
        return qb;
    }

    public List<QuestionBank> getQuestionsPageSize(int start, int pageSize) {
        List<QuestionBank> questionBanks = new ArrayList<>();
        String query = "SELECT * FROM QuestionBank ORDER BY question_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, start);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                questionBanks.add(mapResultSetToQuestionBank(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questionBanks;
    }

    public int getTotalQuestions() {
        String query = "SELECT COUNT(*) FROM QuestionBank";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;

    }

    // Update difficulty level for a question
    public boolean updateQuestionDifficulty(int questionId, int difficultyLevel) {
        String query = "UPDATE QuestionBank SET difficulty_level = ? WHERE question_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, difficultyLevel);
            ps.setInt(2, questionId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    

}
