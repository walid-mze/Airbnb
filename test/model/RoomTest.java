package model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class RoomTest {
    
    private Room room;
    
    @BeforeEach
    void setUp() {
        room = new Room();
    }
    
    @Test
    void testSetAndGetId() {
        room.setId(1);
        assertEquals(1, room.getId());
    }
    
    @Test
    void testSetAndGetType() {
        room.setType("Bedroom");
        assertEquals("Bedroom", room.getType());
    }
    
    @Test
    void testRoomNotNull() {
        assertNotNull(room);
    }
}