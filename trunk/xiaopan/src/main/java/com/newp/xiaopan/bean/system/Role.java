package com.newp.xiaopan.bean.system;

import java.util.List;

/**
 * @author 张霄鹏
 */
public class Role extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String name;
	private List<Resource> resources;
	private Site site;

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

	/**
	 * @return the site
	 */
	public Site getSite() {
		return site;
	}

	/**
	 * @param site
	 *            the site to set
	 */
	public void setSite(Site site) {
		this.site = site;
	}
}
