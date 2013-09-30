package com.newp.xiaopan.bean.system;

import java.util.List;

/**
 * @author 张霄鹏
 */
public class Role extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String name;
	private List<Resource> resources;
	private String siteId;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Resource> getResources() {
		return resources;
	}

	public void setResources(List<Resource> resources) {
		this.resources = resources;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
}
