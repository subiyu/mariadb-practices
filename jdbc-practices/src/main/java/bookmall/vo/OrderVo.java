package bookmall.vo;

public class OrderVo {
	private Long no;
	private String number; //order_no
	private Long userNo;
	private String status;
	private Integer payment;	
	private String shipping;

	public Long getNo() {
		return no;
	}
	
	public void setNo(Long no) {
		this.no = no;
	}
	
	public String getNumber() {
		return number;
	}
	
	public void setNumber(String number) {
		this.number = number;
	}
	
	public Long getUserNo() {
		return userNo;
	}

	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getPayment() {
		return payment;
	}

	public void setPayment(Integer payment) {
		this.payment = payment;
	}

	public String getShipping() {
		return shipping;
	}

	public void setShipping(String shipping) {
		this.shipping = shipping;
	}

	@Override
	public String toString() {
		return "OrderVo [no=" + no + ", number=" + number + ", userNo=" + userNo + ", status="
				+ status + ", payment=" + payment + ", shipping=" + shipping + "]";
	}

	
}
