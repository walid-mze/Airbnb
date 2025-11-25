package dao;

import model.Booking;
import model.Offer;
import model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

class BookingDAOImpTest {
    
    @Mock
    private EntityManager mockEm;
    
    @Mock
    private Query mockQuery;
    
    private BookingDAOImp bookingDAO;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        bookingDAO = new BookingDAOImp(mockEm);
    }
    
    @Test
    void testAddBooking() {
        Booking booking = new Booking();
        booking.setId(1);
        
        bookingDAO.addBooking(booking);
        
        verify(mockEm, times(1)).persist(booking);
    }
    
    @Test
    void testGetAllBookings() {
        Booking b1 = new Booking();
        Booking b2 = new Booking();
        List<Booking> expectedList = Arrays.asList(b1, b2);
        
        when(mockEm.createQuery(anyString(), eq(Booking.class))).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(expectedList);
        
        List<Booking> result = bookingDAO.getAllBookings();
        
        assertEquals(2, result.size());
        verify(mockEm, times(1)).createQuery(anyString(), eq(Booking.class));
    }
    
    @Test
    void testFindBookingById() {
        Booking expected = new Booking();
        expected.setId(1);
        
        when(mockEm.find(Booking.class, 1)).thenReturn(expected);
        
        Booking result = bookingDAO.findBookingById(1);
        
        assertNotNull(result);
        assertEquals(1, result.getId());
    }
    
    @Test
    void testDeleteBooking() {
        Booking booking = new Booking();
        booking.setId(1);
        
        when(mockEm.find(Booking.class, 1)).thenReturn(booking);
        
        bookingDAO.deleteBooking(1);
        
        verify(mockEm, times(1)).remove(booking);
    }
}