package com.newp.xiaopan.bean.system;

/**
 * @author 张霄鹏
 */
public class Key extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String name;
	private Integer sort;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
}
