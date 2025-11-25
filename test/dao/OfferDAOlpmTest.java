package dao;

import model.Offer;
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

class OfferDAOImpTest {
    
    @Mock
    private EntityManager mockEm;
    
    @Mock
    private TypedQuery<Offer> mockQuery;
    
    private OfferDAOImp offerDAO;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        offerDAO = new OfferDAOImp();
        try {
            java.lang.reflect.Field emField = OfferDAOImp.class.getDeclaredField("em");
            emField.setAccessible(true);
            emField.set(offerDAO, mockEm);
        } catch (Exception e) {
            fail("Failed to inject EntityManager: " + e.getMessage());
        }
    }
    
    @Test
    void testAddOffer() {
        Offer offer = new Offer();
        
        offerDAO.add(offer);
        
        verify(mockEm, times(1)).persist(offer);
    }
    
    @Test
    void testGetAllOffers() {
        Offer o1 = new Offer();
        Offer o2 = new Offer();
        List<Offer> expectedList = Arrays.asList(o1, o2);
        
        when(mockEm.createQuery(anyString(), eq(Offer.class))).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(expectedList);
        
        List<Offer> result = offerDAO.getAll();
        
        assertEquals(2, result.size());
        verify(mockEm, times(1)).createQuery(anyString(), eq(Offer.class));
    }
    
    @Test
    void testFindOfferById() {
        Offer expected = new Offer();
        
        when(mockEm.find(Offer.class, 1)).thenReturn(expected);
        
        Offer result = offerDAO.find(1);
        
        assertNotNull(result);
    }
    
    @Test
    void testDeleteOffer() {
        Offer offer = new Offer();
        
        when(mockEm.find(Offer.class, offer)).thenReturn(offer);
        
        offerDAO.delete(offer);
        
        verify(mockEm, times(1)).remove(offer);
    }
}