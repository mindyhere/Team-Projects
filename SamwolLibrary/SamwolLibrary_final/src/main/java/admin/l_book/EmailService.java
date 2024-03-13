package admin.l_book;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailService {
	public void mailSender(EmailDTO dto) throws Exception {
		String host = "smtp.gmail.com";
		String username = "hjahee";// gmailid,@gmail.com은입력하지않음
		String password = "rfxr uhvg ibaa lvti";// 앱비밀번호
		int port = 587;

		String senderMail = dto.getSenderMail();
		String senderName = dto.getSenderName();
		String recipient = dto.getReceiveMail();
		String subject = dto.getSubject();
		String body = dto.getMessage();

		Properties props = System.getProperties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			String un = username;
			String pw = password;

			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true); // 디버그 활성화
		Message mimeMessage = new MimeMessage(session);
				// 이메일 객체
		mimeMessage.addFrom(new InternetAddress[] { new InternetAddress(senderMail, senderName) });
					// 발신자 주소추가										이메일 주소 	이름
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
					// 수신자 주소
		mimeMessage.setSubject(subject);
		mimeMessage.setText(body);
		Transport.send(mimeMessage);
	}
}
