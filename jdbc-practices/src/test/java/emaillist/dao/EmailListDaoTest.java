package emaillist.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import emaillist.vo.EmailListVo;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class EmailListDaoTest {
	private static int count = 0;
	
	@BeforeAll
	public static void setUp() {
		List<EmailListVo> list = new EmailListDao().findAll();
		count = list.size();
	}
	
	@Test
	@Order(1)
	public void testInsert() {
		EmailListVo vo = new EmailListVo();
		vo.setFirstName("둘");
		vo.setLastName("리");
		vo.setEmail("dooly@gmail.com");
		
		boolean result = new EmailListDao().insert(vo);
		assertTrue(result);
		
		//new EmailListDao().insert(vo);
		//assertNotNull(vo.getNo());
	}
	
	@Test
	@Order(3)
	public void testDeleteByEmail() {
		boolean result = new EmailListDao().deleteByEmail("dooly@gmail.com");
		assertTrue(result);
	}
	
	@Test
	@Order(2)
	public void testFindAll() {
		List<EmailListVo> list = new EmailListDao().findAll();
		assertEquals(count + 1, list.size());
	}
	
	@AfterAll
	public static void cleanup() {
		
	}
}