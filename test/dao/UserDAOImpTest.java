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

import model.User;

public class UserDAOImpTest {

    private UserDAOImp userDAO;
    private EntityManager mockEm;

    @BeforeEach
    public void setUp() throws Exception {
        userDAO = new UserDAOImp();
        mockEm = mock(EntityManager.class);
        
        Field emField = UserDAOImp.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(userDAO, mockEm);
    }

    @Test
    public void testCreateUser() {
        String mailAddress = "test@example.com";
        String hashedPassword = "password";
        String firstname = "John";
        String name = "Doe";
        String phoneNumber = "1234567890";
        String userType = "customer";
        double amount = 100.0;

        User createdUser = userDAO.createUser(mailAddress, hashedPassword, firstname, name, phoneNumber, userType, amount);

        assertNotNull(createdUser);
        assertEquals(mailAddress, createdUser.getMailAddress());
        
        ArgumentCaptor<User> userCaptor = ArgumentCaptor.forClass(User.class);
        verify(mockEm).persist(userCaptor.capture());
        User persistedUser = userCaptor.getValue();
        
        assertEquals(mailAddress, persistedUser.getMailAddress());
        assertEquals(hashedPassword, persistedUser.getHashedPassword());
    }

    @Test
    public void testGetUser() {
        String mailAddress = "test@example.com";
        User user = new User(mailAddress, "password", "John", "Doe", "1234567890", "customer", 100.0);
        when(mockEm.find(User.class, mailAddress)).thenReturn(user);

        User foundUser = userDAO.getUser(mailAddress);

        assertNotNull(foundUser);
        assertEquals(mailAddress, foundUser.getMailAddress());
        verify(mockEm).find(User.class, mailAddress);
    }

    @Test
    public void testUpdateUser() {
        User user = new User("test@example.com", "password", "John", "Doe", "1234567890", "customer", 100.0);
        user.setFirstname("Jane");

        userDAO.updateUser(user);

        verify(mockEm).merge(user);
    }

    @Test
    public void testDeleteUser() {
        String mailAddress = "test@example.com";
        User user = new User(mailAddress, "password", "John", "Doe", "1234567890", "customer", 100.0);
        when(mockEm.find(User.class, mailAddress)).thenReturn(user);

        userDAO.deleteUser(mailAddress);

        verify(mockEm).find(User.class, mailAddress);
        verify(mockEm).remove(user);
    }
    
    @Test
    public void testChangePassword() {
        String mailAddress = "test@example.com";
        String newHashedPassword = "newHashedPassword";
        User user = new User(mailAddress, "oldPassword", "John", "Doe", "1234567890", "customer", 100.0);
        when(mockEm.find(User.class, mailAddress)).thenReturn(user);

        userDAO.changePassword(mailAddress, newHashedPassword);

        verify(mockEm).find(User.class, mailAddress);
        assertEquals(newHashedPassword, user.getHashedPassword());
    }

    @Test
    public void testGetAllUser() {
        TypedQuery<User> mockQuery = mock(TypedQuery.class);
        when(mockEm.createQuery("SELECT u FROM User u", User.class)).thenReturn(mockQuery);
        when(mockQuery.getResultList()).thenReturn(Arrays.asList(new User(), new User()));

        userDAO.getAllUser();

        verify(mockEm).createQuery("SELECT u FROM User u", User.class);
        verify(mockQuery).getResultList();
    }

    @Test
    public void testChangeName() {
        String mailAddress = "test@example.com";
        String newName = "NewLastName";
        User user = new User(mailAddress, "password", "John", "Doe", "1234567890", "customer", 100.0);
        when(mockEm.find(User.class, mailAddress)).thenReturn(user);

        userDAO.changeName(mailAddress, newName);

        verify(mockEm).find(User.class, mailAddress);
        assertEquals(newName, user.getName());
    }

    @Test
    public void testChangeFirstname() {
        String mailAddress = "test@example.com";
        String newFirstname = "Jane";
        User user = new User(mailAddress, "password", "John", "Doe", "1234567890", "customer", 100.0);
        when(mockEm.find(User.class, mailAddress)).thenReturn(user);

        userDAO.changeFirstname(mailAddress, newFirstname);

        verify(mockEm).find(User.class, mailAddress);
        assertEquals(newFirstname, user.getFirstname());
    }

    @Test
    public void testChangePhoneNumber() {
        String mailAddress = "test@example.com";
        String newPhone = "9999999999";
        User user = new User(mailAddress, "password", "John", "Doe", "1234567890", "customer", 100.0);
        when(mockEm.find(User.class, mailAddress)).thenReturn(user);

        userDAO.changePhoneNumber(mailAddress, newPhone);

        verify(mockEm).find(User.class, mailAddress);
        assertEquals(newPhone, user.getPhoneNumber());
    }

    @Test
    public void testCredit() {
        String mailAddress = "test@example.com";
        User user = new User(mailAddress, "password", "John", "Doe", "1234567890", "customer", 100.0);
        when(mockEm.find(User.class, mailAddress)).thenReturn(user);

        userDAO.credit(mailAddress, 50.0);

        verify(mockEm).find(User.class, mailAddress);
        assertEquals(150.0, user.getBalance());
    }

    @Test
    public void testDebit() {
        String mailAddress = "test@example.com";
        User user = new User(mailAddress, "password", "John", "Doe", "1234567890", "customer", 100.0);
        when(mockEm.find(User.class, mailAddress)).thenReturn(user);

        userDAO.debit(mailAddress, 30.0);

        verify(mockEm).find(User.class, mailAddress);
        assertEquals(70.0, user.getBalance());
    }
}