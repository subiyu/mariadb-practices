package bookmall.vo;

public class CartVo {
	private Long bookNo;
	private Long userNo;
	private Integer quantity;
	private String bookTitle;
	
	public Long getBookNo() {
		return bookNo;
	}
	
	public void setBookNo(Long bookNo) {
		this.bookNo = bookNo;
	}
	
	public Long getUserNo() {
		return userNo;
	}
	
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	
	public Integer getQuantity() {
		return quantity;
	}
	
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	
	public String getBookTitle() {
		return bookTitle;
	}

	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}

	@Override
	public String toString() {
		return "CartVo [bookNo=" + bookNo + ", userNo=" + userNo + ", quantity=" + quantity + ", bookTitle=" + bookTitle
				+ "]";
	}
}
