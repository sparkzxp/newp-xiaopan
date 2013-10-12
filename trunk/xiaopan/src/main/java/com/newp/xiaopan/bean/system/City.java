package com.newp.xiaopan.bean.system;


/**
 * @author 张霄鹏
 */
public class City extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String name;

	public City() {
		super();
	}

	public City(String name) {
		super();
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
