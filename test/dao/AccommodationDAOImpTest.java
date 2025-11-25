package dao;

import model.Accommodation;
import model.Address;
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

class AccommodationDAOImpTest {
    
    @Mock
    private EntityManager mockEm;
    
    @Mock
    private Query mockQuery;
    
    private AccommodationDAOImp accommodationDAO;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        accommodationDAO = new AccommodationDAOImp(mockEm);
    }
    
    @Test
    void testAddAccommodation() {
        Accommodation accommodation = new Accommodation();
        accommodation.setTitle("Test Accommodation");
        
        accommodationDAO.addAccommodation(accommodation);
        
        verify(mockEm, times(1)).persist(accommodation);
    }
    
    @Test
    void testGetAllAccommodations() {
        Accommodation acc1 = new Accommodation();
        Accommodation acc2 = new Accommodation();
        List<Accommodation> expectedList = Arrays.asList(acc1, acc2);
        
        when(mockEm.createQuery(anyString(), eq(Accommodation.class))).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(expectedList);
        
        List<Accommodation> result = accommodationDAO.getAllAccommodations();
        
        assertEquals(2, result.size());
        verify(mockEm, times(1)).createQuery(anyString(), eq(Accommodation.class));
    }
    
    @Test
    void testFindAccommodationById() {
        Accommodation expected = new Accommodation();
        expected.setId(1);
        
        when(mockEm.find(Accommodation.class, 1)).thenReturn(expected);
        
        Accommodation result = accommodationDAO.findAccommodationById(1);
        
        assertNotNull(result);
        assertEquals(1, result.getId());
        verify(mockEm, times(1)).find(Accommodation.class, 1);
    }
    
    @Test
    void testDeleteAccommodation() {
        Accommodation accommodation = new Accommodation();
        accommodation.setId(1);
        
        when(mockEm.find(Accommodation.class, 1)).thenReturn(accommodation);
        
        accommodationDAO.deleteAccommodation(1);
        
        verify(mockEm, times(1)).remove(accommodation);
    }
}