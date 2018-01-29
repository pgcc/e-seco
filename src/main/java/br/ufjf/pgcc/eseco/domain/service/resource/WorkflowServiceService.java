package br.ufjf.pgcc.eseco.domain.service.resource;

import br.ufjf.pgcc.eseco.app.service.MailerService;
import br.ufjf.pgcc.eseco.domain.dao.resource.WorkflowServiceDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Developer;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRatingInvitation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class WorkflowServiceService {

    private WorkflowServiceDAO workflowServiceDAO;
    private WorkflowServiceRatingInvitationService workflowServiceRatingInvitationService;
    private MailerService mailerService;

    @Autowired
    public WorkflowServiceService(WorkflowServiceDAO workflowServiceDAO,
                                  WorkflowServiceRatingInvitationService workflowServiceRatingInvitationService,
                                  MailerService mailerService) {
        this.workflowServiceDAO = workflowServiceDAO;
        this.workflowServiceRatingInvitationService = workflowServiceRatingInvitationService;
        this.mailerService = mailerService;
    }

    @Transactional
    public WorkflowService add(WorkflowService workflowService) throws Exception {
        return workflowServiceDAO.add(workflowService);
    }

    public List<WorkflowService> findAll() {
        return workflowServiceDAO.findAll();
    }

    public WorkflowService findByInternalClass(String internalClass) {
        if (internalClass != null) {
            Map<String, String> map = new HashMap<>();
            map.put("internalClass", internalClass);

            return workflowServiceDAO.findOneBy(map);
        } else {
            return null;
        }
    }

    public WorkflowService findOneByUrl(String url) {
        if (url != null) {
            Map<String, String> map = new HashMap<>();
            map.put("url", url);

            return workflowServiceDAO.findOneBy(map);
        } else {
            return null;
        }
    }

    public void inviteResearcherForRating(WorkflowService workflowService, Researcher researcher, String datechat,
                                          Developer developer) throws Exception {
        WorkflowServiceRatingInvitation workflowServiceRatingInvitation = new WorkflowServiceRatingInvitation();
        workflowServiceRatingInvitation.setWorkflowService(workflowService);
        workflowServiceRatingInvitation.setAsker(developer);
        workflowServiceRatingInvitation.setRater(researcher);
        workflowServiceRatingInvitation.setDateInvited(new Date());
        if (datechat != null && !datechat.equals("____/__/__")) {
            workflowServiceRatingInvitation.setDateChat(new SimpleDateFormat("yyyy/MM/dd").parse(datechat));
        }

        workflowServiceRatingInvitationService.add(workflowServiceRatingInvitation);

        // Set register instructions e-mail content
        String to = researcher.getAgent().getUser().getEmail();
        String subject = "Invitation for Rate a Service";
        String linkToEseco = "http://nenc.ufjf.br:8080/eseco";
        // @TODO: Remove the hardcoded content by retrieving it from a .jsp file
        String content = ""
                + "<p>Hi <strong>" + researcher.getAgent().getName() + "</strong>!</p>"
                + "<p>You have been invitated to rate a service on E-SECO Platform</p>"
                + "<p>"
                + "    Service Name: " + workflowService.getComponent().getName()
                + "    <br>Invited by: " + developer.getAgent().getName()
                + "    <br>Chat date: " + datechat
                + "</p>"
                + "<p><a href='" + linkToEseco + "'>" + linkToEseco + "</a></p>"
                + "<br>"
                + "<br>"
                + "<p>E-Seco</p>";

        // Send register instructions e-mail
        mailerService.sendMail(to, subject, content);
    }
}