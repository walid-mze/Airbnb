package dao;

import model.Accommodation;
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

class AccommodationDAOImpTest {
    
    @Mock
    private EntityManager mockEm;
    
    @Mock
    private TypedQuery<Accommodation> mockQuery;
    
    private AccommodationDAOImp accommodationDAO;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        accommodationDAO = new AccommodationDAOImp();
        try {
            java.lang.reflect.Field emField = AccommodationDAOImp.class.getDeclaredField("em");
            emField.setAccessible(true);
            emField.set(accommodationDAO, mockEm);
        } catch (Exception e) {
            fail("Failed to inject EntityManager: " + e.getMessage());
        }
    }
    
    @Test
    void testAddAccommodation() {
        Accommodation accommodation = new Accommodation();
        
        accommodationDAO.add(accommodation);
        
        verify(mockEm, times(1)).persist(accommodation);
    }
    
    @Test
    void testGetAllAccommodations() {
        Accommodation acc1 = new Accommodation();
        Accommodation acc2 = new Accommodation();
        List<Accommodation> expectedList = Arrays.asList(acc1, acc2);
        
        when(mockEm.createQuery(anyString(), eq(Accommodation.class))).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(expectedList);
        
        List<Accommodation> result = accommodationDAO.getAll();
        
        assertEquals(2, result.size());
        verify(mockEm, times(1)).createQuery(anyString(), eq(Accommodation.class));
    }
    
    @Test
    void testFindAccommodationById() {
        Accommodation expected = new Accommodation();
        
        when(mockEm.find(Accommodation.class, 1)).thenReturn(expected);
        
        Accommodation result = accommodationDAO.find(1);
        
        assertNotNull(result);
        verify(mockEm, times(1)).find(Accommodation.class, 1);
    }
    
    @Test
    void testDeleteAccommodation() {
        Accommodation accommodation = new Accommodation();
        
        when(mockEm.find(Accommodation.class, accommodation)).thenReturn(accommodation);
        
        accommodationDAO.delete(accommodation);
        
        verify(mockEm, times(1)).remove(accommodation);
    }
}