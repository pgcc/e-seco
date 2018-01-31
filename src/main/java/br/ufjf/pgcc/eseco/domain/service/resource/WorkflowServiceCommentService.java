package br.ufjf.pgcc.eseco.domain.service.resource;

import br.ufjf.pgcc.eseco.app.controller.MainController;
import br.ufjf.pgcc.eseco.app.service.MailerService;
import br.ufjf.pgcc.eseco.domain.dao.resource.WorkflowServiceCommentDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class WorkflowServiceCommentService {

    private WorkflowServiceCommentDAO workflowServiceCommentDAO;
    private MailerService mailerService;

    @Autowired
    public WorkflowServiceCommentService(WorkflowServiceCommentDAO workflowServiceCommentDAO,
                                         MailerService mailerService) {
        this.workflowServiceCommentDAO = workflowServiceCommentDAO;
        this.mailerService = mailerService;
    }

    @Transactional
    public WorkflowServiceComment add(WorkflowServiceComment workflowServiceComment) throws Exception {
        return workflowServiceCommentDAO.add(workflowServiceComment);
    }

    @Transactional
    public WorkflowServiceComment update(WorkflowServiceComment workflowServiceComment) throws Exception {
        return workflowServiceCommentDAO.update(workflowServiceComment);
    }

    public WorkflowServiceComment find(int workflowServiceCommentId) {
        return workflowServiceCommentDAO.find(workflowServiceCommentId);
    }

    public List<WorkflowServiceComment> findAll() {
        return workflowServiceCommentDAO.findAll();
    }

    @Transactional
    public WorkflowServiceComment registerComment(Agent agent, WorkflowService workflowService,
                                                  String content, WorkflowServiceComment replyTo) throws Exception {

        // Create comment
        WorkflowServiceComment workflowServiceComment = new WorkflowServiceComment();
        workflowServiceComment.setCommenter(agent);

        workflowServiceComment.setWorkflowService(workflowService);
        workflowServiceComment.setDate(new Date());
        workflowServiceComment.setRateStar1(0);
        workflowServiceComment.setRateStar2(0);
        workflowServiceComment.setRateStar3(0);
        workflowServiceComment.setRateStar4(0);
        workflowServiceComment.setRateStar5(0);
        workflowServiceComment.setContent(content);
        workflowServiceComment.setParent(replyTo);

        workflowServiceComment = add(workflowServiceComment);

        if (replyTo != null) {
            // Set notification email to user replyed
            String to = replyTo.getCommenter().getUser().getEmail();
            String subject = "New reply on your comment";
            String esecoUrl = "http://nenc.ufjf.br:8080/eseco";
            // @TODO: Remove the hardcoded content by retrieving it from a .jsp file
            String emailContent = ""
                    + "<p>Hi <strong>" + replyTo.getCommenter().getName() + "</strong>!</p>"
                    + "<br>"
                    + "<p>The comment you made in the Workflow Service <strong>" + workflowService.getComponent().getName() + "</strong>"
                    + " received a reply from <strong>" + agent.getName() + "</strong>"
                    + "</p>"
                    + "<p>"
                    + "<strong>Reply content: </strong>" + content
                    + "</p>"
                    + "<p><a href='" + esecoUrl + "'>" + esecoUrl + "</a></p>"
                    + "<br>"
                    + "<p>E-Seco</p>";

            // Send register instructions e-mail
            mailerService.sendMail(to, subject, emailContent);
        }

        return workflowServiceComment;
    }
}