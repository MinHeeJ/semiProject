package com.semi.mvc.member.model.vo;

public class Member {
	private String memberId;
	private String password;
	private String name;
	private String phone;
	private String address;
	private Gender gender;
	private MemberRole memberRole;
	


	public Member(String memberId, String password, String name, String phone, String address, Gender gender,
			MemberRole memberRole) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.name = name;
		this.phone = phone;
		this.address = address;
		this.gender = gender;
		this.memberRole = memberRole;
	}

	public Member() {
		// TODO Auto-generated constructor stub
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public MemberRole getMemberRole() {
		return memberRole;
	}

	public void setMemberRole(MemberRole memberRole) {
		this.memberRole = memberRole;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", password=" + password + ", name=" + name + ", phone=" + phone
				+ ", address=" + address + ", gender=" + gender + ", memberRole=" + memberRole + "]";
	}
	
}