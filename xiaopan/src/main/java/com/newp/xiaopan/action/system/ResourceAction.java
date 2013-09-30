package com.newp.xiaopan.action.system;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Resource;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.IResourceService;

/**
 * @author 张霄鹏
 */
@Controller
@Scope(value = "prototype")
public class ResourceAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private IResourceService resourceService;

	private Resource resource;
	private List<Resource> resources;

	public String toList() {
		resources = this.resourceService.queryList(resource);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != resource && StringUtils.isNotEmpty(resource.getId())) {
			resource = this.resourceService.query(resource);
		}
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isEmpty(resource.getId())) {
			String id = this.resourceService.add(resource);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.resourceService.update(resource);
			jsonObject.put("result", "success");
			jsonObject.put("id", resource.getId());
		}
		this.ajax(jsonObject.toJSONString());
	}

	public void doDelete() {
		this.resourceService.delete(resource);
		this.ajax(true);
	}

	/**
	 * @return the resources
	 */
	public List<Resource> getResources() {
		return resources;
	}

	/**
	 * @param resources
	 *            the resources to set
	 */
	public void setResources(List<Resource> resources) {
		this.resources = resources;
	}

	/**
	 * @return the resource
	 */
	public Resource getResource() {
		return resource;
	}

	/**
	 * @param resource
	 *            the resource to set
	 */
	public void setResource(Resource resource) {
		this.resource = resource;
	}
}
