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
    void testOfferNotNull() {
        assertNotNull(offer);
    }
}