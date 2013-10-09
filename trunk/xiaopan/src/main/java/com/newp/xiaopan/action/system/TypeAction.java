package com.newp.xiaopan.action.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.ISiteService;
import com.newp.xiaopan.service.system.ITypeService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class TypeAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private ITypeService typeService;
	@Autowired
	private ISiteService siteService;

	private Type type;
	private List<Type> types;
	private String siteIds;
	private String siteJson;
	private String typeJson;
	private Boolean isAdmin;

	public String toList() {
		Map<String, Object> params = new HashMap<String, Object>();
		type.setTopid(0);
		params.put("type", type);
		if (this.getLoginUserSite() != null) {
			params.put("siteId", this.getLoginUserSite().getId());
		}
		types = this.typeService.queryList(params);
		return Constants.ACTION_TO_LIST;
	}

	public void getTypeMenu() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		if (this.getLoginUserSite() != null) {
			params.put("siteId", this.getLoginUserSite().getId());
		}
		types = this.typeService.queryList(params);
		net.sf.json.JSONObject jsonObject = new net.sf.json.JSONObject();
		if (CollectionUtils.isNotEmpty(types)) {
			jsonObject.put("list", net.sf.json.JSONArray.fromObject(types));
		} else {
			jsonObject.put("list", "[]");
		}
		jsonObject.put("success", true);
		this.ajax(jsonObject.toString());
	}

	public String toEdit() {
		boolean isUpdate = (null != type && StringUtils.isNotEmpty(type.getId()));
		if (isUpdate) {
			type = this.typeService.query(type);
		}
		setIsAdmin(this.getLoginUser().getId().equals(Constants.SYS_ADMIN_ID));
		initEdit(isUpdate);
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	private void initEdit(boolean isUpdate) {
		String[] siteIdArr = null;
		StringBuffer sb = new StringBuffer();
		if (isUpdate && CollectionUtils.isNotEmpty(type.getSites())) {
			siteIdArr = new String[type.getSites().size()];
			for (int i = 0; i < type.getSites().size(); i++) {
				siteIdArr[i] = type.getSites().get(i).getId();
				if (i == 0) {
					sb.append(siteIdArr[i]);
				} else {
					sb.append(",").append(siteIdArr[i]);
				}
			}
			setSiteIds(sb.toString());
		}

		List<Site> allSites = this.siteService.queryList(null);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		for (Site t : allSites) {
			jsonObject = new JSONObject();
			jsonObject.put("id", t.getId());
			if (isUpdate && null != siteIdArr) {
				for (String s : siteIdArr) {
					if (t.getId().equals(s)) {
						jsonObject.put("checked", true);
						break;
					}
				}
			}
			jsonObject.put("pId", 0);
			jsonObject.put("name", t.getName());
			jsonArray.add(jsonObject);
		}
		this.setSiteJson(jsonArray.toJSONString());

		boolean checked = true;
		jsonArray = new JSONArray();
		jsonObject = new JSONObject();
		jsonObject.put("id", 0);
		jsonObject.put("pId", 0);
		jsonObject.put("name", "顶级菜单");
		jsonObject.put("open", true);
		if (checked && isUpdate && this.getType().getTopid() == 0) {
			jsonObject.put("checked", true);
			checked = false;
		}
		jsonArray.add(jsonObject);

		Type tmp = new Type();
		tmp.setTopid(0);
		List<Type> type1 = this.typeService.queryList(tmp);
		if (CollectionUtils.isNotEmpty(type1)) {
			List<Type> type2 = this.typeService.queryquerySecondNodes();
			for (Type t1 : type1) {
				jsonObject = new JSONObject();
				jsonObject.put("id", t1.getId());
				jsonObject.put("pId", t1.getTopid());
				jsonObject.put("name", t1.getName());
				if (checked && isUpdate && this.getType().getTopid().toString().equals(t1.getId())) {
					jsonObject.put("checked", true);
					checked = false;
				}
				jsonArray.add(jsonObject);
			}
			for (Type t2 : type2) {
				jsonObject = new JSONObject();
				jsonObject.put("id", t2.getId());
				jsonObject.put("pId", t2.getTopid());
				jsonObject.put("name", t2.getName());
				if (checked && isUpdate && this.getType().getTopid().toString().equals(t2.getId())) {
					jsonObject.put("checked", true);
					checked = false;
				}
				jsonArray.add(jsonObject);
			}
		}
		this.setTypeJson(jsonArray.toJSONString());
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();

		String isExist = isExist();
		if (StringUtils.isNotEmpty(isExist) && !"{}".equals(isExist)) {
			this.ajax(isExist);
			return;
		}

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		if (this.getLoginUserSite() != null) {
			params.put("siteId", this.getLoginUserSite().getId());
		}
		params.put("siteIds", siteIds);
		// 新增
		if (StringUtils.isEmpty(type.getId())) {
			// 管理员，全删全加
			// 站点人员，判断本站点是否重名，重名则失败
			// 判断数据库是否已存在重名，存在则直接添加站点关联，不存在则新增后再添加站点关联
			String id = this.typeService.add(params);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			// 管理员，全删全加
			// 站点人员，判断本站点是否重名，重名则失败，不重名直接修改
			this.typeService.update(params);
			jsonObject.put("result", "success");
			jsonObject.put("id", type.getId());
		}
		this.ajax(jsonObject.toJSONString());
	}

	@SuppressWarnings("unchecked")
	private String isExist() {
		JSONObject jsonObject = new JSONObject();

		Type _t = new Type();
		_t.setName(type.getName());
		_t.setPrice(type.getPrice());
		Map<String, Object> _p = new HashMap<String, Object>();
		_p.put("type", _t);
		if (this.getLoginUserSite() != null) {
			_p.put("siteId", this.getLoginUserSite().getId());
		}
		List<Type> _ts = this.typeService.queryList(_p);
		if (StringUtils.isEmpty(type.getId())) {
			if (CollectionUtils.isNotEmpty(_ts)) {
				jsonObject.put("result", "菜单 " + type.getName() + "(" + type.getPrice() + ") 已存在");
			}
		} else {
			if (CollectionUtils.isNotEmpty(_ts)) {
				if (_ts.size() > 1) {
					jsonObject.put("result", "菜单 " + type.getName() + "(" + type.getPrice() + ") 已存在");
				} else if (_ts.size() == 1 && !_ts.get(0).getId().equals(type.getId())) {
					jsonObject.put("result", "菜单 " + type.getName() + "(" + type.getPrice() + ") 已存在");
				}
			}
		}
		return jsonObject.toJSONString();
	}

	public void doDelete() {
		this.typeService.delete(type);
		this.ajax(true);
	}

	/**
	 * @return the types
	 */
	public List<Type> getTypes() {
		return types;
	}

	/**
	 * @param types
	 *            the types to set
	 */
	public void setTypes(List<Type> types) {
		this.types = types;
	}

	/**
	 * @return the type
	 */
	public Type getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(Type type) {
		this.type = type;
	}

	/**
	 * @return the siteIds
	 */
	public String getSiteIds() {
		return siteIds;
	}

	/**
	 * @param siteIds
	 *            the siteIds to set
	 */
	public void setSiteIds(String siteIds) {
		this.siteIds = siteIds;
	}

	/**
	 * @return the siteJson
	 */
	public String getSiteJson() {
		return siteJson;
	}

	/**
	 * @param siteJson
	 *            the siteJson to set
	 */
	public void setSiteJson(String siteJson) {
		this.siteJson = siteJson;
	}

	/**
	 * @return the typeJson
	 */
	public String getTypeJson() {
		return typeJson;
	}

	/**
	 * @param typeJson
	 *            the typeJson to set
	 */
	public void setTypeJson(String typeJson) {
		this.typeJson = typeJson;
	}

	/**
	 * @return the isAdmin
	 */
	public Boolean getIsAdmin() {
		return isAdmin;
	}

	/**
	 * @param isAdmin
	 *            the isAdmin to set
	 */
	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
}
