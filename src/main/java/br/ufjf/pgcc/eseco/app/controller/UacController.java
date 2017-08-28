package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.common.controller.CommonController;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.domain.model.uac.Role;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.AgentService;
import br.ufjf.pgcc.eseco.domain.service.uac.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller
public class UacController extends CommonController {

    private UserService userService;
    private AgentService agentService;
    private static final int ID_ROLE_ADMIN = 1;
    private static final int ID_ROLE_RESEARCHER = 2;
    private static final int ID_ROLE_DEVELOPER = 3;

    @Autowired
    public UacController(UserService userService, AgentService agentService) {
        this.userService = userService;
        this.agentService = agentService;
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // LOGIN/LOGOUT                                                                                                  //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "uac/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(User user, HttpSession session, Model model) {

        // Try to find a user with the passed login credentials
        User authenticatedUser = userService.findByEmailAndPassword(user.getLogin(), user.getPassword());

        // If a active user can be found, register the session and redirect, otherwise, send an error to the view
        if (authenticatedUser != null) {
            if (authenticatedUser.getActive()) {
                session.setAttribute("logged_user", authenticatedUser);

                // Set roles
                session.setAttribute("role_admin", false);
                session.setAttribute("role_researcher", false);
                session.setAttribute("role_developer", false);
                for (Role role : authenticatedUser.getRoles()) {
                    if (role.getId() == ID_ROLE_ADMIN) {
                        session.setAttribute("role_admin", true);

                    } else if (role.getId() == ID_ROLE_RESEARCHER) {
                        session.setAttribute("role_researcher", true);

                    } else if (role.getId() == ID_ROLE_DEVELOPER) {
                        session.setAttribute("role_developer", true);
                    }
                }

                return "redirect:/";
            } else {
                model.addAttribute("error_active", true);
            }
        } else {
            model.addAttribute("error_credentials", true);
        }

        return "uac/login";
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:login";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // REGISTER                                                                                                      //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register() {
        return "uac/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(HttpServletRequest request, Model model) {

        //////////////////////////////////////////////////////////////////////
        // VALIDATE DATA                                                    //
        //////////////////////////////////////////////////////////////////////
        ArrayList<String> errorsList = new ArrayList<>();

        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // Name
        if (name.equals("")) {
            errorsList.add("Name cannot be empty.");
        }

        // E-mail
        if (email.equals("")) {
            errorsList.add("Email cannot be empty.");
        } else {
            List<User> usersWithSameEmail = userService.findByEmail(email);
            if (!usersWithSameEmail.isEmpty()) {
                errorsList.add("The provided Email is already registered to another user.");
            }
        }


        //////////////////////////////////////////////////////////////////////
        // PROCESS VALIDATED DATA                                           //
        //////////////////////////////////////////////////////////////////////
        if (errorsList.isEmpty()) {
            try {
                // Start the registration process
                User user = userService.registerNewUser(email, name);

                // Send new user to model
                model.addAttribute("new_user", user);

                return "uac/register-phase-one-result";

            } catch (Exception e) {
                errorsList.add(e.getMessage());
            }
        }


        //////////////////////////////////////////////////////////////////////
        // ERROR HANDLING                                                   //
        //////////////////////////////////////////////////////////////////////
        if (!errorsList.isEmpty()) {
            model.addAttribute("error", true);
            model.addAttribute("error_messages", errorsList);
        }

        return "uac/register";
    }

    @RequestMapping(value = "/register/{activationCode}", method = RequestMethod.GET)
    public String registerActivation(Model model, @PathVariable(value = "activationCode") String activationCode) {

        // Try to find a user with the passed activation code
        User user = userService.findByActivationCode(activationCode);

        // If a user can be found, send him to view, otherwise, send an error to the view
        if (user != null) {
            model.addAttribute("user", user);
        } else {
            model.addAttribute("error_activation", true);
        }

        return "uac/register-activation";
    }

    @RequestMapping(value = "/register/{activationCode}", method = RequestMethod.POST)
    public String registerActivation(Model model, HttpServletRequest request,
                                     @PathVariable(value = "activationCode") String activationCode) {

        // Redirect if the activation code don't return a valid user
        User user = userService.findByActivationCode(activationCode);
        if (userService.findByActivationCode(activationCode) == null) {
            return "redirect:login";
        } else {
            model.addAttribute("user", user);
        }


        //////////////////////////////////////////////////////////////////////
        // VALIDATE DATA                                                    //
        //////////////////////////////////////////////////////////////////////
        ArrayList<String> errorsList = new ArrayList<>();

        String gender = request.getParameter("gender");
        String birthday = request.getParameter("birthday");
        String role_researcher = request.getParameter("role_researcher");
        String role_developer = request.getParameter("role_developer");
        String password = request.getParameter("password");
        String password_re = request.getParameter("password_re");

        // Gender
        if (gender.equals("")) {
            errorsList.add("Gender cannot be empty.");
        }

        // At least one role
        if (role_researcher == null && role_developer == null) {
            errorsList.add("At least one Role must be chosen.");
        }

        // Password
        if (password.equals("")) {
            errorsList.add("Password cannot be empty.");
        } else {
            if (!password.equals(password_re)) {
                errorsList.add("Password confirmation differ from Password.");
            }
        }


        //////////////////////////////////////////////////////////////////////
        // PROCESS VALIDATED DATA                                           //
        //////////////////////////////////////////////////////////////////////
        if (errorsList.isEmpty()) {
            // Populate Roles list
            ArrayList<Integer> rolesIdList = new ArrayList<>();
            if (role_researcher != null) {
                rolesIdList.add(ID_ROLE_RESEARCHER);
            }
            if (role_developer != null) {
                rolesIdList.add(ID_ROLE_DEVELOPER);
            }

            try {
                // Activate user
                user = userService.activateUser(user, password, rolesIdList);

                // Update user agent basic data
                Agent agent = user.getAgent();
                agent.setGender(gender);
                if (birthday != null) {
                    agent.setBirthday(new SimpleDateFormat("dd/MM/yyyy").parse(birthday));
                }
                agentService.updateAgent(agent);

                // Send activated user to model
                model.addAttribute("user", user);

                return "uac/register-phase-two-result";

            } catch (Exception e) {
                errorsList.add(e.getMessage());
            }
        }


        //////////////////////////////////////////////////////////////////////
        // ERROR HANDLING                                                   //
        //////////////////////////////////////////////////////////////////////
        if (!errorsList.isEmpty()) {
            model.addAttribute("error", true);
            model.addAttribute("error_messages", errorsList);
        }

        return "uac/register-activation";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // RECOVERY                                                                                                      //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/recovery", method = RequestMethod.GET)
    public String recovery() {
        return "uac/recovery";
    }

    @RequestMapping(value = "/recovery", method = RequestMethod.POST)
    public String recovery(HttpServletRequest request, Model model) {

        //////////////////////////////////////////////////////////////////////
        // VALIDATE DATA                                                    //
        //////////////////////////////////////////////////////////////////////
        ArrayList<String> errorsList = new ArrayList<>();

        String email = request.getParameter("email");

        // E-mail
        if (email.equals("")) {
            errorsList.add("Email cannot be empty.");
        }

        // Find a user with the provided email
        List<User> usersWithSameEmail = userService.findByEmail(email);
        if (usersWithSameEmail.isEmpty()) {
            errorsList.add("We didn't found any user with the provided Email.");
        }


        //////////////////////////////////////////////////////////////////////
        // PROCESS VALIDATED DATA                                           //
        //////////////////////////////////////////////////////////////////////
        if (errorsList.isEmpty()) {
            try {
                // Get the first user found
                User user = usersWithSameEmail.get(0);

                // Start the user recovery process
                user = userService.startUserRecovery(user);

                // Send user to model
                model.addAttribute("user", user);

                return "uac/recovery-phase-one-result";

            } catch (Exception e) {
                errorsList.add(e.getMessage());
            }
        }


        //////////////////////////////////////////////////////////////////////
        // ERROR HANDLING                                                   //
        //////////////////////////////////////////////////////////////////////
        if (!errorsList.isEmpty()) {
            model.addAttribute("error", true);
            model.addAttribute("error_messages", errorsList);
        }

        return "uac/recovery";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // AUTHORIZATION ERRORS                                                                                          //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/not-authorized", method = RequestMethod.GET)
    public String notAuthorized() {
        return "uac/error-not-authorized";
    }
}
