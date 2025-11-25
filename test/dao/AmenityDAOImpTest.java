package dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import model.Amenity;
import model.Room;

public class AmenityDAOImpTest {

    private AmenityDAOImp amenityDAO;
    private EntityManager mockEm;

    @BeforeEach
    public void setUp() throws Exception {
        amenityDAO = new AmenityDAOImp();
        mockEm = mock(EntityManager.class);

        Field emField = AmenityDAOImp.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(amenityDAO, mockEm);
    }

    @Test
    public void testCreateAmenity() {
        Room room = new Room();
        String amenityName = "wifi";

        amenityDAO.createAmenity(room, amenityName);

        ArgumentCaptor<Amenity> amenityCaptor = ArgumentCaptor.forClass(Amenity.class);
        verify(mockEm).persist(amenityCaptor.capture());
        
        Amenity persistedAmenity = amenityCaptor.getValue();
        assertEquals(amenityName, persistedAmenity.getName());
    }

    @Test
    public void testGetAmenity() {
        long amenityId = 1L;
        Amenity amenity = new Amenity();
        when(mockEm.find(Amenity.class, amenityId)).thenReturn(amenity);

        Amenity foundAmenity = amenityDAO.getAmenity(amenityId);

        assertNotNull(foundAmenity);
        verify(mockEm).find(Amenity.class, amenityId);
    }

    @Test
    public void testDeleteAmenity() {
        long amenityId = 1L;
        Amenity amenity = new Amenity();
        when(mockEm.find(Amenity.class, amenityId)).thenReturn(amenity);

        amenityDAO.deleteAmenity(amenityId);

        verify(mockEm).find(Amenity.class, amenityId);
        verify(mockEm).remove(amenity);
    }

    @Test
    public void testGetRoomAmenity() {
        Room room = new Room();
        List<Amenity> amenities = Arrays.asList(new Amenity(), new Amenity());
        
        TypedQuery<Amenity> mockQuery = mock(TypedQuery.class);
        when(mockEm.createQuery("SELECT a FROM Amenity a WHERE a.room = ?1", Amenity.class)).thenReturn(mockQuery);
        when(mockQuery.setParameter(1, room)).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(amenities);

        List<Amenity> result = amenityDAO.getRoomAmenity(room);

        assertEquals(2, result.size());
        verify(mockEm).createQuery("SELECT a FROM Amenity a WHERE a.room = ?1", Amenity.class);
    }
}
