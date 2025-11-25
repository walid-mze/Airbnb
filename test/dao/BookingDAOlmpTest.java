package dao;

import model.Booking;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

class BookingDAOImpTest {
    
    @Mock
    private EntityManager mockEm;
    
    @Mock
    private TypedQuery<Booking> mockQuery;
    
    private BookingDAOImp bookingDAO;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        bookingDAO = new BookingDAOImp();
        try {
            java.lang.reflect.Field emField = BookingDAOImp.class.getDeclaredField("em");
            emField.setAccessible(true);
            emField.set(bookingDAO, mockEm);
        } catch (Exception e) {
            fail("Failed to inject EntityManager: " + e.getMessage());
        }
    }
    
    @Test
    void testAddBooking() {
        Booking booking = new Booking();
        
        bookingDAO.add(booking);
        
        verify(mockEm, times(1)).persist(booking);
    }
    
    @Test
    void testGetAllBookings() {
        Booking b1 = new Booking();
        Booking b2 = new Booking();
        List<Booking> expectedList = Arrays.asList(b1, b2);
        
        when(mockEm.createQuery(anyString(), eq(Booking.class))).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(expectedList);
        
        List<Booking> result = bookingDAO.getAll();
        
        assertEquals(2, result.size());
        verify(mockEm, times(1)).createQuery(anyString(), eq(Booking.class));
    }
    
    @Test
    void testFindBookingById() {
        Booking expected = new Booking();
        
        when(mockEm.find(Booking.class, 1)).thenReturn(expected);
        
        Booking result = bookingDAO.find(1);
        
        assertNotNull(result);
    }
    
    @Test
    void testDeleteBooking() {
        Booking booking = new Booking();
        
        when(mockEm.find(Booking.class, booking)).thenReturn(booking);
        
        bookingDAO.delete(booking);
        
        verify(mockEm, times(1)).remove(booking);
    }
}