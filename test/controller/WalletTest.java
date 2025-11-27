package controller;

import static org.mockito.ArgumentMatchers.anyDouble;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
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

public class WalletTest {

    private Wallet walletServlet;
    private HttpServletRequest mockRequest;
    private HttpServletResponse mockResponse;
    private HttpSession mockSession;
    private RequestDispatcher mockDispatcher;
    private ServletContext mockServletContext;
    private ServletConfig mockServletConfig;
    private UserDAO mockUserDAO;

    @BeforeEach
    public void setUp() throws Exception {
        walletServlet = new Wallet();
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
        when(mockServletContext.getRequestDispatcher("/WEB-INF/account/wallet.jsp")).thenReturn(mockDispatcher);
        
        walletServlet.init(mockServletConfig);
        
        Field userDAOField = Wallet.class.getDeclaredField("userDAO");
        userDAOField.setAccessible(true);
        userDAOField.set(walletServlet, mockUserDAO);
    }

    @Test
    public void testDoGet_UserNotLoggedIn_RedirectsToLogin() throws Exception {
        when(mockSession.getAttribute("user")).thenReturn(null);

        walletServlet.doGet(mockRequest, mockResponse);

        verify(mockResponse).sendRedirect("/Airbnb/login?redirect=wallet");
    }

    @Test
    public void testDoGet_UserLoggedIn_ShowsWalletPage() throws Exception {
        User mockUser = new User();
        mockUser.setMailAddress("user@test.com");
        mockUser.setAmount(100.0);
        
        when(mockSession.getAttribute("user")).thenReturn(mockUser);

        walletServlet.doGet(mockRequest, mockResponse);

        verify(mockServletContext).getRequestDispatcher("/WEB-INF/account/wallet.jsp");
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }

    @Test
    public void testDoPost_ValidAmount_CreditsUser() throws Exception {
        User mockUser = new User();
        mockUser.setMailAddress("user@test.com");
        mockUser.setAmount(100.0);
        
        User updatedUser = new User();
        updatedUser.setMailAddress("user@test.com");
        updatedUser.setAmount(150.0);
        
        when(mockSession.getAttribute("user")).thenReturn(mockUser);
        when(mockRequest.getParameter("amount")).thenReturn("50.0");
        when(mockUserDAO.getUser("user@test.com")).thenReturn(updatedUser);

        walletServlet.doPost(mockRequest, mockResponse);

        verify(mockUserDAO).credit("user@test.com", 50.0);
        verify(mockSession).setAttribute("user", updatedUser);
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }

    @Test
    public void testDoPost_InvalidAmount_HandlesError() throws Exception {
        User mockUser = new User();
        mockUser.setMailAddress("user@test.com");
        mockUser.setAmount(100.0);
        
        when(mockSession.getAttribute("user")).thenReturn(mockUser);
        when(mockRequest.getParameter("amount")).thenReturn("invalid");

        walletServlet.doPost(mockRequest, mockResponse);

        verify(mockUserDAO, org.mockito.Mockito.never()).credit(anyString(), anyDouble());
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }

    @Test
    public void testDoPost_NegativeAmount_ProcessesTransaction() throws Exception {
        User mockUser = new User();
        mockUser.setMailAddress("user@test.com");
        mockUser.setAmount(100.0);
        
        User updatedUser = new User();
        updatedUser.setMailAddress("user@test.com");
        updatedUser.setAmount(50.0);
        
        when(mockSession.getAttribute("user")).thenReturn(mockUser);
        when(mockRequest.getParameter("amount")).thenReturn("-50.0");
        when(mockUserDAO.getUser("user@test.com")).thenReturn(updatedUser);

        walletServlet.doPost(mockRequest, mockResponse);

        verify(mockUserDAO).credit("user@test.com", -50.0);
        verify(mockSession).setAttribute("user", updatedUser);
    }

    @Test
    public void testDoPost_ZeroAmount_ProcessesTransaction() throws Exception {
        User mockUser = new User();
        mockUser.setMailAddress("user@test.com");
        mockUser.setAmount(100.0);
        
        when(mockSession.getAttribute("user")).thenReturn(mockUser);
        when(mockRequest.getParameter("amount")).thenReturn("0");
        when(mockUserDAO.getUser("user@test.com")).thenReturn(mockUser);

        walletServlet.doPost(mockRequest, mockResponse);

        verify(mockUserDAO).credit("user@test.com", 0.0);
        verify(mockSession).setAttribute("user", mockUser);
    }
}
