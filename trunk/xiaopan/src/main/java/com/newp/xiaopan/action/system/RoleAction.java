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
import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.PinyinUtil;
import com.newp.xiaopan.service.system.IResourceService;
import com.newp.xiaopan.service.system.IRoleService;
import com.newp.xiaopan.service.system.IShopService;
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
	@Autowired
	private IShopService shopService;

	private Role role;
	private List<Role> roles;
	private String resourceJson;
	private String resourceIds;
	private List<Site> sites;
	private String shopJson;

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
		// 1
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

		// 2
		setSites(this.siteService.queryList(null));

		// 3
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

		// 4
		jsonArray = new JSONArray();

		jsonObject = new JSONObject();
		jsonObject.put("id", "A_G");
		jsonObject.put("pId", 0);
		jsonObject.put("name", "A-G开头");
		jsonObject.put("nocheck", true);
		jsonArray.add(jsonObject);

		jsonObject = new JSONObject();
		jsonObject.put("id", "H_N");
		jsonObject.put("pId", 0);
		jsonObject.put("name", "H-N开头");
		jsonObject.put("nocheck", true);
		jsonArray.add(jsonObject);

		jsonObject = new JSONObject();
		jsonObject.put("id", "O_T");
		jsonObject.put("pId", 0);
		jsonObject.put("name", "O-T开头");
		jsonObject.put("nocheck", true);
		jsonArray.add(jsonObject);

		jsonObject = new JSONObject();
		jsonObject.put("id", "U_Z");
		jsonObject.put("pId", 0);
		jsonObject.put("name", "U-Z开头");
		jsonObject.put("nocheck", true);
		jsonArray.add(jsonObject);

		jsonObject = new JSONObject();
		jsonObject.put("id", "OTHER");
		jsonObject.put("pId", 0);
		jsonObject.put("name", "其它开头");
		jsonObject.put("nocheck", true);
		jsonArray.add(jsonObject);

		boolean checked = true;
		List<Shop> shops = this.shopService.queryList(new Shop());
		if (CollectionUtils.isNotEmpty(shops)) {
			String _head;
			for (Shop s : shops) {
				_head = PinyinUtil.getHeadPinYinHeadChar(s.getTitle());
				if (_head.toUpperCase().equals("A") || _head.toUpperCase().equals("B") || _head.toUpperCase().equals("C") || _head.toUpperCase().equals("D") || _head.toUpperCase().equals("E") || _head.toUpperCase().equals("F") || _head.toUpperCase().equals("G")) {
					jsonObject = new JSONObject();
					jsonObject.put("id", s.getId());
					jsonObject.put("pId", "A_G");
					jsonObject.put("name", s.getTitle());
					if (checked && role.getShop() != null && role.getShop().getId().equals(s.getId())) {
						jsonObject.put("checked", true);
						checked = false;
					}
					jsonArray.add(jsonObject);
				} else if (_head.toUpperCase().equals("H") || _head.toUpperCase().equals("I") || _head.toUpperCase().equals("J") || _head.toUpperCase().equals("K") || _head.toUpperCase().equals("L") || _head.toUpperCase().equals("M") || _head.toUpperCase().equals("N")) {
					jsonObject = new JSONObject();
					jsonObject.put("id", s.getId());
					jsonObject.put("pId", "H_N");
					jsonObject.put("name", s.getTitle());
					if (checked && role.getShop() != null && role.getShop().getId().equals(s.getId())) {
						jsonObject.put("checked", true);
						checked = false;
					}
					jsonArray.add(jsonObject);
				} else if (_head.toUpperCase().equals("O") || _head.toUpperCase().equals("P") || _head.toUpperCase().equals("Q") || _head.toUpperCase().equals("R") || _head.toUpperCase().equals("S") || _head.toUpperCase().equals("T")) {
					jsonObject = new JSONObject();
					jsonObject.put("id", s.getId());
					jsonObject.put("pId", "O_T");
					jsonObject.put("name", s.getTitle());
					if (checked && role.getShop() != null && role.getShop().getId().equals(s.getId())) {
						jsonObject.put("checked", true);
						checked = false;
					}
					jsonArray.add(jsonObject);
				} else if (_head.toUpperCase().equals("U") || _head.toUpperCase().equals("V") || _head.toUpperCase().equals("W") || _head.toUpperCase().equals("X") || _head.toUpperCase().equals("Y") || _head.toUpperCase().equals("Z")) {
					jsonObject = new JSONObject();
					jsonObject.put("id", s.getId());
					jsonObject.put("pId", "U_Z");
					jsonObject.put("name", s.getTitle());
					if (checked && role.getShop() != null && role.getShop().getId().equals(s.getId())) {
						jsonObject.put("checked", true);
						checked = false;
					}
					jsonArray.add(jsonObject);
				} else {
					jsonObject = new JSONObject();
					jsonObject.put("id", s.getId());
					jsonObject.put("pId", "OTHER");
					jsonObject.put("name", s.getTitle());
					if (checked && role.getShop() != null && role.getShop().getId().equals(s.getId())) {
						jsonObject.put("checked", true);
						checked = false;
					}
					jsonArray.add(jsonObject);
				}
			}
		}
		shopJson = jsonArray.toJSONString();
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		// 1
		if (StringUtils.isNotEmpty(role.getSite().getId()) && StringUtils.isNotEmpty(role.getShop().getId())) {
			Shop s = this.shopService.query(role.getShop());
			if (!s.getSiteId().equals(role.getSite().getId())) {
				jsonObject.put("result", "监管店铺不在所选站点内");
				this.ajax(jsonObject.toJSONString());
				return;
			}
		}

		// 2
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

		// 3
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

	/**
	 * @return the shopJson
	 */
	public String getShopJson() {
		return shopJson;
	}

	/**
	 * @param shopJson
	 *            the shopJson to set
	 */
	public void setShopJson(String shopJson) {
		this.shopJson = shopJson;
	}
}
