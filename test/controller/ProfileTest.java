package controller;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import dao.AccommodationDAO;
import dao.BookingDAO;
import dao.OfferDAO;
import model.Accommodation;
import model.Booking;
import model.Offer;
import model.User;

public class ProfileTest {

    private Profile profileServlet;
    private HttpServletRequest mockRequest;
    private HttpServletResponse mockResponse;
    private HttpSession mockSession;
    private RequestDispatcher mockDispatcher;
    private ServletContext mockServletContext;
    private ServletConfig mockServletConfig;
    private AccommodationDAO mockAccommodationDAO;
    private BookingDAO mockBookingDAO;
    private OfferDAO mockOfferDAO;

    @BeforeEach
    public void setUp() throws Exception {
        profileServlet = new Profile();
        mockRequest = mock(HttpServletRequest.class);
        mockResponse = mock(HttpServletResponse.class);
        mockSession = mock(HttpSession.class);
        mockDispatcher = mock(RequestDispatcher.class);
        mockServletContext = mock(ServletContext.class);
        mockServletConfig = mock(ServletConfig.class);
        mockAccommodationDAO = mock(AccommodationDAO.class);
        mockBookingDAO = mock(BookingDAO.class);
        mockOfferDAO = mock(OfferDAO.class);
        
        when(mockServletConfig.getServletContext()).thenReturn(mockServletContext);
        when(mockRequest.getSession()).thenReturn(mockSession);
        when(mockRequest.getContextPath()).thenReturn("/Airbnb");
        when(mockServletContext.getRequestDispatcher("/WEB-INF/account/profile.jsp")).thenReturn(mockDispatcher);
        
        profileServlet.init(mockServletConfig);
        
        Field accommodationDAOField = Profile.class.getDeclaredField("accommodationDAO");
        accommodationDAOField.setAccessible(true);
        accommodationDAOField.set(profileServlet, mockAccommodationDAO);
        
        Field bookingDAOField = Profile.class.getDeclaredField("bookingDAO");
        bookingDAOField.setAccessible(true);
        bookingDAOField.set(profileServlet, mockBookingDAO);
        
        Field offerDAOField = Profile.class.getDeclaredField("offerDAO");
        offerDAOField.setAccessible(true);
        offerDAOField.set(profileServlet, mockOfferDAO);
    }

    @Test
    public void testDoGet_UserNotLoggedIn_RedirectsToLogin() throws Exception {
        when(mockSession.getAttribute("user")).thenReturn(null);

        profileServlet.doGet(mockRequest, mockResponse);

        verify(mockResponse).sendRedirect("/Airbnb/login?redirect=profile");
    }

    @Test
    public void testDoGet_HostUser_ShowsAccommodations() throws Exception {
        User mockUser = new User();
        mockUser.setMailAddress("host@test.com");
        mockUser.setUserType("Hôte");
        
        List<Accommodation> accommodations = new ArrayList<>();
        Accommodation acc = new Accommodation();
        accommodations.add(acc);
        
        when(mockSession.getAttribute("user")).thenReturn(mockUser);
        when(mockAccommodationDAO.getAccommodationsByHost(mockUser)).thenReturn(accommodations);

        profileServlet.doGet(mockRequest, mockResponse);

        verify(mockAccommodationDAO).getAccommodationsByHost(mockUser);
        verify(mockRequest).setAttribute("accommodations", accommodations);
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }

    @Test
    public void testDoGet_ClientUser_ShowsBookings() throws Exception {
        User mockUser = new User();
        mockUser.setMailAddress("client@test.com");
        mockUser.setUserType("Client");
        
        List<Booking> bookings = new ArrayList<>();
        Booking booking = new Booking();
        bookings.add(booking);
        
        when(mockSession.getAttribute("user")).thenReturn(mockUser);
        when(mockBookingDAO.getBookingsByClient(mockUser)).thenReturn(bookings);

        profileServlet.doGet(mockRequest, mockResponse);

        verify(mockBookingDAO).getBookingsByClient(mockUser);
        verify(mockRequest).setAttribute("bookings", bookings);
        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }

    @Test
    public void testDoGet_AdminUser_ShowsFullProfile() throws Exception {
        User mockUser = new User();
        mockUser.setMailAddress("admin@test.com");
        mockUser.setUserType("Admin");
        
        List<Accommodation> accommodations = new ArrayList<>();
        List<Booking> bookings = new ArrayList<>();
        List<Offer> offers = new ArrayList<>();
        
        when(mockSession.getAttribute("user")).thenReturn(mockUser);
        when(mockAccommodationDAO.getAccommodationsByHost(mockUser)).thenReturn(accommodations);
        when(mockBookingDAO.getBookingsByClient(mockUser)).thenReturn(bookings);
        when(mockOfferDAO.getAllOffers()).thenReturn(offers);

        profileServlet.doGet(mockRequest, mockResponse);

        verify(mockDispatcher).forward(mockRequest, mockResponse);
    }
}
