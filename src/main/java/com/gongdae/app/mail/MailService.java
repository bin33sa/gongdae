package com.gongdae.app.mail;

import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MailService {
	private final JavaMailSender mailSender;
	
	public boolean sendHtmlMail(Mail dto) throws Exception {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		
		try {
			helper.setTo(dto.getReceiverEmail());
			if(dto.getSenderName() == null || dto.getSenderName().isEmpty()) {
				helper.setFrom(dto.getReceiverEmail());
			} else {
				helper.setFrom(dto.getReceiverEmail(), dto.getSenderName());
			}
			helper.setSubject(dto.getSubject());
			helper.setText(dto.getContent(), dto.isContentHtml());
			
			mailSender.send(message);
			return true;
		} catch (MailException e) {
			return false;
		}
		
	}
	
	
}
