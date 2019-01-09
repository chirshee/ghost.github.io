package com.hyt.entity;

public class Goods {
	private int id;
	private String name;
	private int sum;
	public Goods() {
		
	}
	@Override
	public String toString() {
		return "Goods [id=" + id + ", name=" + name + ", sum=" + sum + "]";
	}
	public Goods(int id, String name, int sum) {
		this.id = id;
		this.name = name;
		this.sum = sum;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	
}
