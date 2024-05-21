package bookshop.example;

public class BookShopApp {
	private static AuthorDao authorDao = new AuthorDao();
	private static BookDao bookDao = new BookDao();
	
	public static void installDB() {
		bookDao.deleteAll();
		
	}
	public static void main(String[] args) {
		installDB()
	}
	
	private static void display
}
