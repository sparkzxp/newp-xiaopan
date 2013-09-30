package com.newp.xiaopan.bean.system;

/**
 * @author 张霄鹏
 */
public class Resource extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String name;// 资源名称
	private String type;// 资源类型

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
