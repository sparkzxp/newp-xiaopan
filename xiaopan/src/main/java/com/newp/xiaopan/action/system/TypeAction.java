package com.newp.xiaopan.action.system;

import java.util.List;

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

	public String toList() {
		type.setTopid(0);
		types = this.typeService.queryList(type);
		return Constants.ACTION_TO_LIST;
	}

	public void getTypeMenu() {
		types = this.typeService.queryList(type);
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
		if (StringUtils.isEmpty(type.getId())) {
			String id = this.typeService.add(type);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.typeService.update(type);
			jsonObject.put("result", "success");
			jsonObject.put("id", type.getId());
		}
		this.ajax(jsonObject.toJSONString());
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
}
