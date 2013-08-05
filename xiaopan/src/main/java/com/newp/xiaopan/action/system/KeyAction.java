package com.newp.xiaopan.action.system;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Key;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.IKeyService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class KeyAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private IKeyService keyService;

	private Key key;
	private List<Key> keys;

	public String toList() {
		keys = this.keyService.queryList(key);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != key && StringUtils.isNotEmpty(key.getId())) {
			key = this.keyService.query(key);
		}
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isEmpty(key.getId())) {
			String id = this.keyService.add(key);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.keyService.update(key);
			jsonObject.put("result", "success");
			jsonObject.put("id", key.getId());
		}
		this.ajax(jsonObject.toJSONString());
	}

	public void doDelete() {
		this.keyService.delete(key);
		this.ajax(true);
	}

	/**
	 * @return the keys
	 */
	public List<Key> getKeys() {
		return keys;
	}

	/**
	 * @param keys
	 *            the keys to set
	 */
	public void setKeys(List<Key> keys) {
		this.keys = keys;
	}

	/**
	 * @return the key
	 */
	public Key getKey() {
		return key;
	}

	/**
	 * @param key
	 *            the key to set
	 */
	public void setKey(Key key) {
		this.key = key;
	}
}
