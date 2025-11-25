package model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class RoomTest {

    private Room room;
    private Accommodation accommodation;

    @BeforeEach
    public void setUp() {
        accommodation = new Accommodation();
        room = new Room(accommodation, "Master Bedroom");
    }

    @Test
    public void testRoomCreation() {
        assertNotNull(room);
        assertEquals("Master Bedroom", room.getType());
        assertEquals(accommodation, room.getAccommodation());
    }

    @Test
    public void testSetType() {
        room.setType("Guest Room");
        assertEquals("Guest Room", room.getType());
    }

    @Test
    public void testDefaultConstructor() {
        Room emptyRoom = new Room();
        assertNotNull(emptyRoom);
    }

    @Test
    public void testSetNumberOfBeds() {
        room.setNumberOfBeds(2);
        assertEquals(2, room.getNumberOfBeds());
        
        room.setNumberOfBeds(4);
        assertEquals(4, room.getNumberOfBeds());
    }

    @Test
    public void testSetAccommodation() {
        Accommodation newAccommodation = new Accommodation();
        room.setAccommodation(newAccommodation);
        assertEquals(newAccommodation, room.getAccommodation());
    }
}