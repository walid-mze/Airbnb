package dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import model.Accommodation;
import model.Offer;
import model.Room;

public class OfferDAOImpTest {

    private OfferDAOImp offerDAO;
    private EntityManager mockEm;

    @BeforeEach
    public void setUp() throws Exception {
        offerDAO = new OfferDAOImp();
        mockEm = mock(EntityManager.class);
        
        Field emField = OfferDAOImp.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(offerDAO, mockEm);
    }

    @Test
    public void testCreateOffer() {
        Accommodation accommodation = new Accommodation();
        Room room = new Room();
        double price = 150.0;
        boolean available = true;

        Offer createdOffer = offerDAO.createOffer(accommodation, room, price, available);

        assertNotNull(createdOffer);
        assertEquals(accommodation, createdOffer.getAccommodation());
        assertEquals(room, createdOffer.getRoom());
        assertEquals(price, createdOffer.getPrice());
        assertEquals(available, createdOffer.isAvailable());
        
        ArgumentCaptor<Offer> offerCaptor = ArgumentCaptor.forClass(Offer.class);
        verify(mockEm).persist(offerCaptor.capture());
    }

    @Test
    public void testGetOffer() {
        long offerId = 1L;
        Offer mockOffer = new Offer();
        mockOffer.setId(offerId);
        mockOffer.setPrice(200.0);
        
        when(mockEm.find(Offer.class, offerId)).thenReturn(mockOffer);

        Offer foundOffer = offerDAO.getOffer(offerId);

        assertNotNull(foundOffer);
        assertEquals(offerId, foundOffer.getId());
        assertEquals(200.0, foundOffer.getPrice());
        verify(mockEm).find(Offer.class, offerId);
    }

    @Test
    public void testUpdateOffer() {
        Offer offer = new Offer();
        offer.setId(1L);
        offer.setPrice(100.0);
        
        when(mockEm.merge(offer)).thenReturn(offer);

        Offer updatedOffer = offerDAO.updateOffer(offer);

        assertNotNull(updatedOffer);
        verify(mockEm).merge(offer);
    }

    @Test
    public void testDeleteOffer() {
        long offerId = 1L;
        Offer mockOffer = new Offer();
        mockOffer.setId(offerId);
        
        when(mockEm.find(Offer.class, offerId)).thenReturn(mockOffer);

        offerDAO.deleteOffer(offerId);

        verify(mockEm).find(Offer.class, offerId);
        verify(mockEm).remove(mockOffer);
    }

    @Test
    public void testGetAllOffers() {
        TypedQuery<Offer> mockQuery = mock(TypedQuery.class);
        when(mockEm.createQuery("SELECT o FROM Offer o", Offer.class)).thenReturn(mockQuery);

        offerDAO.getAllOffers();

        verify(mockEm).createQuery("SELECT o FROM Offer o", Offer.class);
        verify(mockQuery).getResultList();
    }
}
