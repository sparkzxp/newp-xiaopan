package com.newp.xiaopan.bean.system;

import java.io.Serializable;

/**
 * @author 张霄鹏
 */
public class BaseBean implements Serializable {

	private static final long serialVersionUID = 1L;

	protected String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
