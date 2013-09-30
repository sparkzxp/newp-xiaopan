package com.newp.xiaopan.action.system;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Resource;
import com.newp.xiaopan.bean.system.Role;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.IResourceService;
import com.newp.xiaopan.service.system.IRoleService;
import com.newp.xiaopan.service.system.ISiteService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class RoleAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private IRoleService roleService;
	@Autowired
	private IResourceService resourceService;
	@Autowired
	private ISiteService siteService;

	private Role role;
	private List<Role> roles;
	private String resourceJson;
	private String resourceIds;
	private List<Site> sites;

	public String toList() {
		roles = this.roleService.queryList(role);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		boolean isUpdate = null != role && StringUtils.isNotEmpty(role.getId());
		if (isUpdate) {
			role = this.roleService.query(role);
		}
		initEdit(isUpdate);
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	private void initEdit(boolean isUpdate) {
		String[] resourceIdArr = null;
		StringBuffer sb = new StringBuffer();
		if (isUpdate && CollectionUtils.isNotEmpty(role.getResources())) {
			resourceIdArr = new String[role.getResources().size()];
			for (int i = 0; i < role.getResources().size(); i++) {
				resourceIdArr[i] = role.getResources().get(i).getId();
				if (i == 0) {
					sb.append(resourceIdArr[i]);
				} else {
					sb.append(",").append(resourceIdArr[i]);
				}
			}
			resourceIds = sb.toString();
		}

		setSites(this.siteService.queryList(null));

		List<Resource> allResource = this.resourceService.queryList(null);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		boolean firstOpen = true;
		for (Resource t : allResource) {
			jsonObject = new JSONObject();
			jsonObject.put("id", t.getId());
			if (isUpdate && null != resourceIdArr) {
				for (String s : resourceIdArr) {
					if (t.getId().equals(s)) {
						jsonObject.put("checked", true);
						break;
					}
				}
			}
			jsonObject.put("pId", 0);
			jsonObject.put("name", t.getName());
			if (firstOpen) {
				jsonObject.put("open", true);
				firstOpen = false;
			}
			jsonArray.add(jsonObject);
		}
		this.resourceJson = jsonArray.toJSONString();
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		if (StringUtils.isNotEmpty(resourceIds)) {
			List<Resource> tmpResources = new ArrayList<Resource>();
			String[] arr = resourceIds.split(",");
			Resource t;
			for (String s : arr) {
				t = new Resource();
				t.setId(s);
				tmpResources.add(t);
			}
			role.setResources(tmpResources);
		}

		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isEmpty(role.getId())) {
			String id = this.roleService.add(role);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.roleService.update(role);
			jsonObject.put("result", "success");
			jsonObject.put("id", role.getId());
		}
		this.ajax(jsonObject.toJSONString());
	}

	public void doDelete() {
		this.roleService.delete(role);
		this.ajax(true);
	}

	/**
	 * @return the roles
	 */
	public List<Role> getRoles() {
		return roles;
	}

	/**
	 * @param roles
	 *            the roles to set
	 */
	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	/**
	 * @return the role
	 */
	public Role getRole() {
		return role;
	}

	/**
	 * @param role
	 *            the role to set
	 */
	public void setRole(Role role) {
		this.role = role;
	}

	public String getResourceJson() {
		return resourceJson;
	}

	public void setResourceJson(String resourceJson) {
		this.resourceJson = resourceJson;
	}

	public String getResourceIds() {
		return resourceIds;
	}

	public void setResourceIds(String resourceIds) {
		this.resourceIds = resourceIds;
	}

	public List<Site> getSites() {
		return sites;
	}

	public void setSites(List<Site> sites) {
		this.sites = sites;
	}
}
