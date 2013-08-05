package com.newp.xiaopan.action.system;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.common.Constants;
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

	private Type type;
	private List<Type> types;

	public String toList() {
		types = this.typeService.queryList(type);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != type && StringUtils.isNotEmpty(type.getId())) {
			type = this.typeService.query(type);
		}
		Type tmp = new Type();
		tmp.setTopid(0);
		types = this.typeService.queryList(tmp);
		return Constants.ACTION_TO_EDIT;
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
}
