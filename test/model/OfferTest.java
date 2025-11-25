package model;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Calendar;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class OfferTest {

    private Offer offer;
    private User user;
    private Accommodation accommodation;
    private Calendar start;
    private Calendar end;

    @BeforeEach
    public void setUp() {
        user = new User();
        accommodation = new Accommodation();
        start = Calendar.getInstance();
        end = Calendar.getInstance();
        end.add(Calendar.DATE, 7);
        offer = new Offer(user, accommodation, start, end, 150.0, 50.0);
    }

    @Test
    public void testUpdate() {
        Calendar newStart = Calendar.getInstance();
        newStart.add(Calendar.DATE, 2);
        Calendar newEnd = Calendar.getInstance();
        newEnd.add(Calendar.DATE, 9);

        offer.update(newStart, newEnd, 160.0, 55.0);

        assertEquals(newStart, offer.getStartAvailability());
        assertEquals(newEnd, offer.getEndAvailability());
        assertEquals(160.0, offer.getPricePerNight());
        assertEquals(55.0, offer.getCleaningFee());
    }

    @Test
    public void testOfferCreation() {
        assertEquals(user, offer.getUser());
        assertEquals(accommodation, offer.getAccommodation());
        assertEquals(start, offer.getStartAvailability());
        assertEquals(end, offer.getEndAvailability());
        assertEquals(150.0, offer.getPricePerNight());
        assertEquals(50.0, offer.getCleaningFee());
    }

    @Test
    public void testSetters() {
        User newUser = new User();
        Accommodation newAccommodation = new Accommodation();
        Calendar newStart = Calendar.getInstance();
        newStart.add(Calendar.DATE, 10);
        Calendar newEnd = Calendar.getInstance();
        newEnd.add(Calendar.DATE, 20);

        offer.setUser(newUser);
        offer.setAccommodation(newAccommodation);
        offer.setStartAvailability(newStart);
        offer.setEndAvailability(newEnd);
        offer.setPricePerNight(200.0);
        offer.setCleaningFee(75.0);

        assertEquals(newUser, offer.getUser());
        assertEquals(newAccommodation, offer.getAccommodation());
        assertEquals(newStart, offer.getStartAvailability());
        assertEquals(newEnd, offer.getEndAvailability());
        assertEquals(200.0, offer.getPricePerNight());
        assertEquals(75.0, offer.getCleaningFee());
    }

    @Test
    public void testDefaultConstructor() {
        Offer emptyOffer = new Offer();
        assertEquals(emptyOffer.getPricePerNight(), 0.0);
        assertEquals(emptyOffer.getCleaningFee(), 0.0);
    }
}