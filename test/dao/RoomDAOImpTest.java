package dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.util.Arrays;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import model.Accommodation;
import model.Offer;
import model.Room;

public class RoomDAOImpTest {

    private RoomDAOImp roomDAO;
    private EntityManager mockEm;

    @BeforeEach
    public void setUp() throws Exception {
        roomDAO = new RoomDAOImp();
        mockEm = mock(EntityManager.class);

        Field emField = RoomDAOImp.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(roomDAO, mockEm);
    }

    @Test
    public void testGetRoom() {
        long roomId = 1L;
        Room room = new Room();
        when(mockEm.find(Room.class, roomId)).thenReturn(room);

        Room foundRoom = roomDAO.getRoom(roomId);

        assertNotNull(foundRoom);
        verify(mockEm).find(Room.class, roomId);
    }

    @Test
    public void testCreateRoom() {
        Accommodation accommodation = new Accommodation();
        String roomType = "Double";

        roomDAO.createRoom(accommodation, roomType);

        ArgumentCaptor<Room> roomCaptor = ArgumentCaptor.forClass(Room.class);
        verify(mockEm).persist(roomCaptor.capture());

        Room persistedRoom = roomCaptor.getValue();
        assertEquals("Double", persistedRoom.getType());
        assertEquals(accommodation, persistedRoom.getAccommodation());
    }

    @Test
    public void testDeleteRoom() {
        long roomId = 1L;
        Room room = new Room();
        when(mockEm.find(Room.class, roomId)).thenReturn(room);

        roomDAO.deleteRoom(roomId);

        verify(mockEm).find(Room.class, roomId);
        verify(mockEm).remove(room);
    }

    @Test
    public void testGetNumberOfRoomsInAccommodation() {
        int accommodationId = 1;
        TypedQuery<Room> mockQuery = mock(TypedQuery.class);
        when(mockEm.createQuery("SELECT COUNT(r) FROM Room r WHERE r.accommodation.id = ?1", Room.class))
            .thenReturn(mockQuery);
        when(mockQuery.setParameter(1, accommodationId)).thenReturn(mockQuery);
        when(mockQuery.getFirstResult()).thenReturn(3);

        int count = roomDAO.getNumberOfRoomsInAccommodation(accommodationId);

        assertEquals(3, count);
        verify(mockEm).createQuery("SELECT COUNT(r) FROM Room r WHERE r.accommodation.id = ?1", Room.class);
    }

    @Test
    public void testGetAccommodationRoom() {
        Accommodation accommodation = new Accommodation();
        TypedQuery<Room> mockQuery = mock(TypedQuery.class);
        when(mockEm.createQuery("SELECT r FROM Room r WHERE r.accommodation = ?1", Room.class))
            .thenReturn(mockQuery);
        when(mockQuery.setParameter(1, accommodation)).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(Arrays.asList(new Room(), new Room()));

        roomDAO.getAccommodationRoom(accommodation);

        verify(mockEm).createQuery("SELECT r FROM Room r WHERE r.accommodation = ?1", Room.class);
        verify(mockQuery).setParameter(1, accommodation);
    }
}
