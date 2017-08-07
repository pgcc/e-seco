package br.ufjf.pgcc.eseco.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public class MailerService {

    private JavaMailSender mailSender;

    @Autowired
    public MailerService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }


    /**
     * Send an e-mail.
     *
     * @throws MessagingException Throws MessagingException exception
     */
    public void sendMail(String to, String subject, String content) throws MessagingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");

        mimeMessage.setContent(content, "text/html");
        helper.setTo(to);
        helper.setSubject(subject);
        helper.setFrom("E-Seco<eseco@datawebhost.com.br>");

        mailSender.send(mimeMessage);
    }
}
