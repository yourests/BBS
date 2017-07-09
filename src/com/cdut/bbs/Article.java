package com.cdut.bbs;

import java.util.Date;
import java.sql.*;

public class Article {

	private int id;
	private int pid;
	private int rootId;
	private String title;
	private String cont;
	private Date pdate;
	private boolean isLeaf;		// mysql��,0 ����Ҷ�ӽڵ� ,1������Ҷ�ӽڵ�
	private int grade;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getRootId() {
		return rootId;
	}
	public void setRootId(int rootId) {
		this.rootId = rootId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCont() {
		return cont;
	}
	public void setCont(String cont) {
		this.cont = cont;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	public boolean isLeaf() {
		return isLeaf;
	}
	public void setLeaf(boolean isLeaf) {
		this.isLeaf = isLeaf;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public void initFromRs(ResultSet rs)
	{
		try {
			setGrade(0);
			setId(rs.getInt("id"));
			setPid(rs.getInt("pid"));
			setRootId(rs.getInt("rootId"));
			setTitle(rs.getString("title"));
			setCont(rs.getString("cont"));
			setPdate(rs.getTimestamp("pdate"));	// ���ڴ���
			setLeaf(rs.getInt("isLeaf")==0?true:false);		// mysql��,0 ����Ҷ�ӽڵ� ,1������Ҷ�ӽڵ�
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
