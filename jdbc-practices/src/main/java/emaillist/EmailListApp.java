package emaillist;

import java.util.List;
import java.util.Scanner;

import emaillist.dao.EmailListDao;
import emaillist.vo.EmailListVo;

public class EmailListApp {
	/* 
	 * 과제
	 * 1. Data Modeling
	 * 2. SQL Dev
	 * 3. Dao
	 * 4. 
	 */
	private static Scanner scanner;
	private static EmailListDao emailListDao = new EmailListDao();
	public static void main(String[] args) {
		scanner = new Scanner(System.in);
		
		while(true) {
			System.out.print("(l)ist (d)delete (i)insert (q)uit > ");
			String command = scanner.nextLine();
			
			if("l".equals(command)) {
				doList(); //email list 반환(f, l, e 를 vo에 담아서 C
			} else if("d".equals(command)) {
				doDelete();
			} else if("i".equals(command)) {
				doInsert();
			} else if("q".equals(command)) {
				break;
			}
		}
		
		if(scanner != null) {
			scanner.close();			
		}
		//DB만들고sql 개발하고 DAO에 넣어 CRUD 테스트 어플리케이션사용
	}

	private static void doInsert() {
		System.out.print("성:");
		String firstName = scanner.nextLine();
		
		System.out.print("이름:");
		String lastName = scanner.nextLine();
		
		System.out.print("이메일:");
		String email = scanner.nextLine();
		
		EmailListVo vo = new EmailListVo();
		vo.setFirstName(firstName);
		vo.setLastName(lastName);
		vo.setEmail(email);
		
		emailListDao.insert(vo);
		
		doList();
	}

	private static void doDelete() {
		System.out.print("이메일:");
		String email = scanner.nextLine();
		
		emailListDao.deleteByEmail(email);
		
		doList();
	}

	private static void doList() {
		List<EmailListVo> list = emailListDao.findAll();
		for(EmailListVo vo : list) {
			System.out.println(vo.getFirstName() + " " + vo.getLastName() + " " + vo.getEmail());
		}
	}
}
