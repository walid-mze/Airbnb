package dao;

import model.User;
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

class UserDAOImpTest {
    
    @Mock
    private EntityManager mockEm;
    
    @Mock
    private Query mockQuery;
    
    private UserDAOImp userDAO;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        userDAO = new UserDAOImp(mockEm);
    }
    
    @Test
    void testAddUser() {
        User user = new User();
        user.setEmail("test@test.com");
        
        when(mockEm.find(User.class, "test@test.com")).thenReturn(null);
        
        userDAO.addUser(user);
        
        verify(mockEm, times(1)).persist(any(User.class));
    }
    
    @Test
    void testFindUserByEmail() {
        User expectedUser = new User();
        expectedUser.setEmail("test@test.com");
        
        when(mockEm.find(User.class, "test@test.com")).thenReturn(expectedUser);
        
        User result = userDAO.findUserByEmail("test@test.com");
        
        assertNotNull(result);
        verify(mockEm, times(1)).find(User.class, "test@test.com");
    }
    
    @Test
    void testDeleteUser() {
        User user = new User();
        user.setEmail("test@test.com");
        
        when(mockEm.find(User.class, "test@test.com")).thenReturn(user);
        
        userDAO.deleteUser("test@test.com");
        
        verify(mockEm, times(1)).find(User.class, "test@test.com");
        verify(mockEm, times(1)).remove(user);
    }
    
    @Test
    void testGetAllUsers() {
        User user1 = new User();
        User user2 = new User();
        List<User> userList = Arrays.asList(user1, user2);
        
        when(mockEm.createQuery(anyString(), eq(User.class))).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(userList);
        
        List<User> result = userDAO.getAllUsers();
        
        assertEquals(2, result.size());
        verify(mockEm, times(1)).createQuery(anyString(), eq(User.class));
    }
    
    @Test
    void testUpdateUserPassword() {
        User user = new User();
        user.setEmail("test@test.com");
        
        when(mockEm.find(User.class, "test@test.com")).thenReturn(user);
        
        userDAO.updateUserPassword("test@test.com", "newHashedPassword");
        
        assertEquals("newHashedPassword", user.getPassword());
    }
    
    @Test
    void testUpdateUserWallet() {
        User user = new User();
        user.setEmail("test@test.com");
        user.setWallet(100.0);
        
        when(mockEm.find(User.class, "test@test.com")).thenReturn(user);
        
        userDAO.updateUserWallet("test@test.com", 50.0);
        
        assertEquals(150.0, user.getWallet(), 0.01);
    }
}