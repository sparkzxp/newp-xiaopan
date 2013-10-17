package com.newp.xiaopan.bean.system;

/**
 * @author 张霄鹏
 */
public class Setting extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String name;
	private String value;

	public Setting() {
		super();
	}

	public Setting(String name) {
		super();
		this.name = name;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * @param value
	 *            the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}
}
