package dao;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

import java.lang.reflect.Field;

import javax.persistence.EntityManager;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import model.Accommodation;
import model.Picture;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class PictureDAOImpTest {

    private PictureDAOImp pictureDAO;
    private EntityManager mockEm;

    @BeforeEach
    public void setUp() throws Exception {
        pictureDAO = new PictureDAOImp();
        mockEm = mock(EntityManager.class);

        Field emField = PictureDAOImp.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(pictureDAO, mockEm);
    }

    @Test
    public void testCreatePicture() {
        Accommodation accommodation = new Accommodation();
        String url = "image.jpg";

        pictureDAO.createPicture(accommodation, url);

        ArgumentCaptor<Picture> pictureCaptor = ArgumentCaptor.forClass(Picture.class);
        verify(mockEm).persist(pictureCaptor.capture());
        
        Picture persistedPicture = pictureCaptor.getValue();
        assertEquals(url, persistedPicture.getUrl());
    }
}
