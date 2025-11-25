package model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class OfferTest {
    
    private Offer offer;
    
    @BeforeEach
    void setUp() {
        offer = new Offer();
    }
    
    @Test
    void testSetAndGetId() {
        offer.setId(1);
        assertEquals(1, offer.getId());
    }
    
    @Test
    void testSetAndGetPrice() {
        offer.setPrice(150.0);
        assertEquals(150.0, offer.getPrice(), 0.01);
    }
    
    @Test
    void testSetAndGetAccommodation() {
        Accommodation accommodation = new Accommodation();
        accommodation.setId(1);
        
        offer.setAccommodation(accommodation);
        
        assertNotNull(offer.getAccommodation());
        assertEquals(1, offer.getAccommodation().getId());
    }
}