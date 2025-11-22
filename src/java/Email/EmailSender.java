/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Email;

//import Schedule.TimetableDAO;
//import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;
//import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;



public class EmailSender {
      // Phương thức gửi email chứa mã OTP
    public static void sendOtpToEmail(String recipientEmail, String otp_code) {
        final String username = "hoanghkds2@gmail.com"; // Thay bằng email của bạn
        final String password = "yiff jduy hekn sthg"; // Thay bằng mật khẩu của bạn

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(recipientEmail));
            message.setSubject("OTP Verification");
            message.setText("Your OTP for verification is: " + otp_code);

            Transport.send(message);

            System.out.println("Email sent to " + recipientEmail);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public static void sendResetEmail(String recipientEmail, String resetLink) {
        final String username = "hoanghkds2@gmail.com"; // Thay bằng email của bạn
        final String password = "yiff jduy hekn sthg"; // Thay bằng mật khẩu của bạn

        // Cấu hình thuộc tính của mail server
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Tạo một phiên làm việc
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            // Tạo đối tượng MimeMessage
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(recipientEmail));
            message.setSubject("Password Reset Request");
            message.setText("Please click the link below to reset your password:\n\n" + resetLink);

            // Gửi email
            Transport.send(message);

            System.out.println("Email sent to " + recipientEmail);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

   public static String generateOTP() {
        // Tạo mã OTP ngẫu nhiên
        Random random = new Random();
        int otpLength = 6; // Độ dài của mã OTP
        StringBuilder otp = new StringBuilder();

        for (int i = 0; i < otpLength; i++) {
            otp.append(random.nextInt(10)); // Tạo số ngẫu nhiên từ 0 đến 9
        }

        return otp.toString();
    }
    public static String generateToken() {
        return UUID.randomUUID().toString();
    }
  public static boolean sendPlannerEmail(String toEmail, String emailContent) {
    final String username = "hoanghkds2@gmail.com"; // Replace with your email
    final String password = "yiff jduy hekn sthg"; // Replace with your password or app-specific password

    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");

    Session session = Session.getInstance(props, new javax.mail.Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password);
        }
    });

    try {
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Planner Email");

        // Set email content
        message.setText(emailContent);

        Transport.send(message);

        System.out.println("Email sent successfully");
        return true;
    } catch (MessagingException e) {
        e.printStackTrace();
        return false;
    }
}

/**
 * Gửi email thông báo nạp tiền thành công
 * @param recipientEmail Email người nhận
 * @param fullName Tên đầy đủ của người dùng
 * @param amount Số tiền đã nạp (VNĐ)
 * @param transactionId Mã giao dịch
 * @param newBalance Số dư mới sau khi nạp
 * @param transactionDate Ngày giao dịch
 * @return true nếu gửi thành công, false nếu thất bại
 */
public static boolean sendPaymentSuccessEmail(String recipientEmail, String fullName, 
                                               long amount, String transactionId, 
                                               int newBalance, String transactionDate) {
    final String username = "hoanghkds2@gmail.com"; // Thay bằng email của bạn
    final String password = "yiff jduy hekn sthg"; // Thay bằng mật khẩu của bạn

    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");

    Session session = Session.getInstance(props, new javax.mail.Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password);
        }
    });

    try {
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Payment Success - THI247");
        
        // Tạo nội dung email HTML đẹp
        String emailContent = createPaymentSuccessEmailContent(fullName, amount, transactionId, newBalance, transactionDate);
        message.setContent(emailContent, "text/html; charset=UTF-8");

        Transport.send(message);

        System.out.println("Payment success email sent to " + recipientEmail);
        return true;
    } catch (MessagingException e) {
        System.err.println("Failed to send payment success email: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}

/**
 * Tạo nội dung email HTML cho thông báo nạp tiền thành công
 */
private static String createPaymentSuccessEmailContent(String fullName, long amount, 
                                                       String transactionId, int newBalance, 
                                                       String transactionDate) {
    // Format số tiền
    java.text.NumberFormat formatter = java.text.NumberFormat.getInstance(java.util.Locale.US);
    String formattedAmount = formatter.format(amount);
    String formattedBalance = formatter.format(newBalance);
    
    StringBuilder html = new StringBuilder();
    html.append("<!DOCTYPE html>");
    html.append("<html lang='vi'>");
    html.append("<head>");
    html.append("<meta charset='UTF-8'>");
    html.append("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
    html.append("</head>");
    html.append("<body style='margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f4f4f4;'>");
    html.append("<div style='max-width: 600px; margin: 20px auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 4px rgba(0,0,0,0.1);'>");
    
    // Header
    html.append("<div style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px 20px; text-align: center;'>");
    html.append("<h1 style='margin: 0; font-size: 28px;'>✅ Nạp tiền thành công!</h1>");
    html.append("<p style='margin: 10px 0 0 0; font-size: 16px; opacity: 0.9;'>THI247 - Hệ thống thi trực tuyến</p>");
    html.append("</div>");
    
    // Content
    html.append("<div style='padding: 30px 20px;'>");
    html.append("<p style='font-size: 16px; color: #333; margin: 0 0 20px 0;'>Xin chào <strong>").append(fullName).append("</strong>,</p>");
    html.append("<p style='font-size: 14px; color: #666; line-height: 1.6; margin: 0 0 20px 0;'>");
    html.append("Giao dịch nạp tiền của bạn đã được xử lý thành công. Dưới đây là thông tin chi tiết:");
    html.append("</p>");
    
    // Transaction Details Box
    html.append("<div style='background-color: #f8f9fa; border-left: 4px solid #667eea; padding: 20px; margin: 20px 0; border-radius: 4px;'>");
    html.append("<h3 style='margin: 0 0 15px 0; color: #333; font-size: 18px;'>Thông tin giao dịch</h3>");
    
    html.append("<table style='width: 100%; border-collapse: collapse;'>");
    html.append("<tr><td style='padding: 8px 0; color: #666; font-size: 14px;'>Mã giao dịch:</td><td style='padding: 8px 0; color: #333; font-weight: bold; font-size: 14px; text-align: right;'>").append(transactionId).append("</td></tr>");
    html.append("<tr><td style='padding: 8px 0; color: #666; font-size: 14px;'>Số tiền nạp:</td><td style='padding: 8px 0; color: #28a745; font-weight: bold; font-size: 16px; text-align: right;'>").append(formattedAmount).append(" VNĐ</td></tr>");
    html.append("<tr><td style='padding: 8px 0; color: #666; font-size: 14px;'>Số Coin nhận được:</td><td style='padding: 8px 0; color: #ff6b6b; font-weight: bold; font-size: 16px; text-align: right;'>").append(formattedBalance).append(" Coins</td></tr>");
    html.append("<tr><td style='padding: 8px 0; color: #666; font-size: 14px;'>Thời gian:</td><td style='padding: 8px 0; color: #333; font-size: 14px; text-align: right;'>").append(transactionDate).append("</td></tr>");
    html.append("</table>");
    html.append("</div>");
    
    // Balance Info
    html.append("<div style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; margin: 20px 0; border-radius: 8px; text-align: center;'>");
    html.append("<p style='margin: 0 0 10px 0; font-size: 14px; opacity: 0.9;'>Số dư hiện tại của bạn</p>");
    html.append("<p style='margin: 0; font-size: 32px; font-weight: bold;'>").append(formattedBalance).append(" <span style='font-size: 20px;'>Coins</span></p>");
    html.append("</div>");
    
    // Call to Action
    html.append("<div style='text-align: center; margin: 30px 0 20px 0;'>");
    html.append("<a href='http://localhost:8080/THI247' style='display: inline-block; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; text-decoration: none; padding: 12px 30px; border-radius: 25px; font-weight: bold; font-size: 16px;'>Bắt đầu làm bài thi</a>");
    html.append("</div>");
    
    html.append("<p style='font-size: 14px; color: #666; line-height: 1.6; margin: 20px 0 0 0;'>");
    html.append("Cảm ơn bạn đã sử dụng dịch vụ của THI247! Nếu có bất kỳ thắc mắc nào, vui lòng liên hệ với chúng tôi.");
    html.append("</p>");
    html.append("</div>");
    
    // Footer
    html.append("<div style='background-color: #f8f9fa; padding: 20px; text-align: center; border-top: 1px solid #e9ecef;'>");
    html.append("<p style='margin: 0 0 10px 0; font-size: 12px; color: #999;'>© 2025 THI247. All rights reserved.</p>");
    html.append("<p style='margin: 0; font-size: 12px; color: #999;'>Email này được gửi tự động, vui lòng không trả lời.</p>");
    html.append("</div>");
    
    html.append("</div>");
    html.append("</body>");
    html.append("</html>");
    
    return html.toString();
}

}