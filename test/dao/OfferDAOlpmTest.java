package dao;

import model.Offer;
import model.Accommodation;
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

class OfferDAOImpTest {
    
    @Mock
    private EntityManager mockEm;
    
    @Mock
    private Query mockQuery;
    
    private OfferDAOImp offerDAO;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        offerDAO = new OfferDAOImp(mockEm);
    }
    
    @Test
    void testAddOffer() {
        Offer offer = new Offer();
        offer.setId(1);
        
        offerDAO.addOffer(offer);
        
        verify(mockEm, times(1)).persist(offer);
    }
    
    @Test
    void testGetAllOffers() {
        Offer o1 = new Offer();
        Offer o2 = new Offer();
        List<Offer> expectedList = Arrays.asList(o1, o2);
        
        when(mockEm.createQuery(anyString(), eq(Offer.class))).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(expectedList);
        
        List<Offer> result = offerDAO.getAllOffers();
        
        assertEquals(2, result.size());
        verify(mockEm, times(1)).createQuery(anyString(), eq(Offer.class));
    }
    
    @Test
    void testFindOfferById() {
        Offer expected = new Offer();
        expected.setId(1);
        
        when(mockEm.find(Offer.class, 1)).thenReturn(expected);
        
        Offer result = offerDAO.findOfferById(1);
        
        assertNotNull(result);
        assertEquals(1, result.getId());
    }
    
    @Test
    void testDeleteOffer() {
        Offer offer = new Offer();
        offer.setId(1);
        
        when(mockEm.find(Offer.class, 1)).thenReturn(offer);
        
        offerDAO.deleteOffer(1);
        
        verify(mockEm, times(1)).remove(offer);
    }
}