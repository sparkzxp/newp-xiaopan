package com.newp.xiaopan.bean.system;

import java.io.Serializable;

/**
 * @author 张霄鹏
 */
public class Site extends BaseBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private String name;
	private String description;
	private Integer sort;
	private City city;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	/**
	 * @return the city
	 */
	public City getCity() {
		return city;
	}

	/**
	 * @param city
	 *            the city to set
	 */
	public void setCity(City city) {
		this.city = city;
	}
}
