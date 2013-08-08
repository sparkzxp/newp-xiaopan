package com.newp.xiaopan.action.system;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.action.listener.MySessionListener;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.ISiteService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class SiteAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private ISiteService siteService;

	private Site site;
	private List<Site> sites;

	public String toList() {
		sites = this.siteService.queryList(site);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != site && StringUtils.isNotEmpty(site.getId())) {
			site = this.siteService.query(site);
		}
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isEmpty(site.getId())) {
			String id = this.siteService.add(site);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.siteService.update(site);
			jsonObject.put("result", "success");
			jsonObject.put("id", site.getId());
		}
		MySessionListener.configMap_s.put(Constants.CONFIG_SITE_LIST, this.siteService.queryList(null));
		this.ajax(jsonObject.toJSONString());
	}

	public void doDelete() {
		this.siteService.delete(site);
		this.ajax(true);
	}

	/**
	 * @return the sites
	 */
	public List<Site> getSites() {
		return sites;
	}

	/**
	 * @param sites
	 *            the sites to set
	 */
	public void setSites(List<Site> sites) {
		this.sites = sites;
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
