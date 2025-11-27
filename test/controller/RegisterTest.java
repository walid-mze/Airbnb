package controller;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import dao.UserDAO;
import model.User;

public class RegisterTest {

    private Register registerServlet;
    private HttpServletRequest mockRequest;
    private HttpServletResponse mockResponse;
    private HttpSession mockSession;
    private RequestDispatcher mockDispatcher;
    private ServletContext mockServletContext;
    private ServletConfig mockServletConfig;
    private UserDAO mockUserDAO;

    @BeforeEach
    public void setUp() throws Exception {
        registerServlet = new Register();
        mockRequest = mock(HttpServletRequest.class);
        mockResponse = mock(HttpServletResponse.class);
        mockSession = mock(HttpSession.class);
        mockDispatcher = mock(RequestDispatcher.class);
        mockServletContext = mock(ServletContext.class);
        mockServletConfig = mock(ServletConfig.class);
        mockUserDAO = mock(UserDAO.class);
        
        when(mockServletConfig.getServletContext()).thenReturn(mockServletContext);
        when(mockRequest.getSession()).thenReturn(mockSession);
        when(mockRequest.getContextPath()).thenReturn("/Airbnb");
        
        registerServlet.init(mockServletConfig);
        
        Field userDAOField = Register.class.getDeclaredField("userDAO");
        userDAOField.setAccessible(true);
        userDAOField.set(registerServlet, mockUserDAO);
    }

    @Test
    public void testDoGet_UserAlreadyLoggedIn_RedirectsToHome() throws Exception {
        User mockUser = new User();
        mockUser.setMailAddress("user@test.com");
        when(mockSession.getAttribute("user")).thenReturn(mockUser);

        registerServlet.doGet(mockRequest, mockResponse);

        verify(mockResponse).sendRedirect("/Airbnb/home");
        verify(mockRequest, never()).getRequestDispatcher(anyString());
    }

    @Test
    public void testDoGet_NoUser_ShowsRegisterPage() throws Exception {
        when(mockSession.getAttribute("user")).thenReturn(null);
        when(mockRequest.getParameter("edit")).thenReturn(null);
        when(mockRequest.getRequestDispatcher("/WEB-INF/account/register.jsp")).thenReturn(mockDispatcher);

        registerServlet.doGet(mockRequest, mockResponse);

        verify(mockRequest).getRequestDispatcher("/WEB-INF/account/register.jsp");
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }

    @Test
    public void testDoPost_NewUser_Success() throws Exception {
        when(mockRequest.getParameter("mail")).thenReturn("newuser@test.com");
        when(mockRequest.getParameter("pass")).thenReturn("password123");
        when(mockRequest.getParameter("firstname")).thenReturn("John");
        when(mockRequest.getParameter("name")).thenReturn("Doe");
        when(mockRequest.getParameter("phone")).thenReturn("1234567890");
        when(mockUserDAO.getUser("newuser@test.com")).thenReturn(null);
        when(mockRequest.getRequestDispatcher("/WEB-INF/account/login.jsp")).thenReturn(mockDispatcher);

        registerServlet.doPost(mockRequest, mockResponse);

        verify(mockUserDAO).createUser(
            anyString(),  // mailAddress
            anyString(),  // hashedPassword
            anyString(),  // firstname
            anyString(),  // name
            anyString(),  // phoneNumber
            anyString(),  // userType
            any(Double.class)  // amount
        );
        verify(mockRequest).setAttribute("alertType", "alert-success");
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }

    @Test
    public void testDoPost_DuplicateEmail_ShowsWarning() throws Exception {
        User existingUser = new User();
        existingUser.setMailAddress("existing@test.com");
        
        when(mockRequest.getParameter("mail")).thenReturn("existing@test.com");
        when(mockRequest.getParameter("pass")).thenReturn("password123");
        when(mockRequest.getParameter("firstname")).thenReturn("John");
        when(mockRequest.getParameter("name")).thenReturn("Doe");
        when(mockRequest.getParameter("phone")).thenReturn("1234567890");
        when(mockUserDAO.getUser("existing@test.com")).thenReturn(existingUser);
        when(mockRequest.getRequestDispatcher("/WEB-INF/account/register.jsp")).thenReturn(mockDispatcher);

        registerServlet.doPost(mockRequest, mockResponse);

        verify(mockUserDAO, never()).createUser(anyString(), anyString(), anyString(), anyString(), anyString(), anyString(), any(Double.class));
        verify(mockRequest).setAttribute("alertType", "alert-warning");
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }

    @Test
    public void testDoGet_EditUserAsAdmin_Success() throws Exception {
        User adminUser = new User();
        adminUser.setMailAddress("admin@test.com");
        adminUser.setUserType("Admin");
        
        User targetUser = new User();
        targetUser.setMailAddress("target@test.com");
        
        when(mockSession.getAttribute("user")).thenReturn(adminUser);
        when(mockRequest.getParameter("edit")).thenReturn("target@test.com");
        when(mockUserDAO.getUser("target@test.com")).thenReturn(targetUser);
        when(mockRequest.getRequestDispatcher("/WEB-INF/account/register.jsp")).thenReturn(mockDispatcher);

        registerServlet.doGet(mockRequest, mockResponse);

        verify(mockRequest).setAttribute("user", targetUser);
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }

    @Test
    public void testDoGet_EditNonExistentUser_ShowsWarning() throws Exception {
        User adminUser = new User();
        adminUser.setMailAddress("admin@test.com");
        adminUser.setUserType("Admin");
        
        when(mockSession.getAttribute("user")).thenReturn(adminUser);
        when(mockRequest.getParameter("edit")).thenReturn("nonexistent@test.com");
        when(mockUserDAO.getUser("nonexistent@test.com")).thenReturn(null);
        when(mockRequest.getRequestDispatcher("/WEB-INF/account/register.jsp")).thenReturn(mockDispatcher);

        registerServlet.doGet(mockRequest, mockResponse);

        verify(mockRequest).setAttribute("alertType", "alert-warning");
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }
}
