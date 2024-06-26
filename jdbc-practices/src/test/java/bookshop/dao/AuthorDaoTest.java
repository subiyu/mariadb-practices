package bookshop.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import bookshop.vo.AuthorVo;
import bookshop.vo.BookVo;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class AuthorDaoTest {
	private static int count = 0;
	private static AuthorVo mockAuthorVo = new AuthorVo();
	private static AuthorDao authorDao = new AuthorDao();
	private static BookVo mockBookVo = new BookVo();
	private static BookDao bookDao = new BookDao();
	
	@BeforeAll
	public static void SetUp() {
		count = authorDao.findAll().size();
	}
	
	@Test
	@Order(1)
	public void testInsert() {
		mockAuthorVo.setName("칼세이건");
		authorDao.insert(mockAuthorVo);

		assertNotNull(mockAuthorVo.getNo());
	}
	
	@Test
	@Order(2)
	public void testFindAll() {
		assertEquals(count + 1, authorDao.findAll().size());
	}
	
	@AfterAll
	public static void cleanUp() {
		authorDao.deleteByNo(mockAuthorVo.getNo());
	}
}
