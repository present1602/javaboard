package com.myspring.cpst.member;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("memberVO")
public class MemberVO {
	
	private int sid;
	private String email;
	private String password;
	private String nick;
	private String username;
	private String phone;
	private String univ;
	private String major;
	private String profile_image;
	private Date join_date;
	
	public MemberVO() {
		
	}

	public MemberVO(int sid, String email, String password, String nick, String username, String phone, String univ,
			String major, String profile_image, Date join_date) {
		super();
		this.sid = sid;
		this.email = email;
		this.password = password;
		this.nick = nick;
		this.username = username;
		this.phone = phone;
		this.univ = univ;
		this.major = major;
		this.profile_image = profile_image;
		this.join_date = join_date;
	}

	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUniv() {
		return univ;
	}
	public void setUniv(String univ) {
		this.univ = univ;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	
	@Override
	public String toString() {
		return "MemberVO [sid=" + sid + ", email=" + email + ", password=" + password + ", nick=" + nick + ", username="
				+ username + ", phone=" + phone + ", univ=" + univ + ", major=" + major + ", profile_image="
				+ profile_image + ", join_date=" + join_date + ", getPassword()=" + getPassword() + ", getSid()="
				+ getSid() + ", getEmail()=" + getEmail() + ", getNick()=" + getNick() + ", getUsername()="
				+ getUsername() + ", getPhone()=" + getPhone() + ", getUniv()=" + getUniv() + ", getMajor()="
				+ getMajor() + ", getProfile_image()=" + getProfile_image() + ", getJoin_date()=" + getJoin_date()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}
	
	
}
