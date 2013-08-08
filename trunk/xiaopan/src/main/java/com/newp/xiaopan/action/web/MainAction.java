package com.newp.xiaopan.action.web;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.action.listener.MySessionListener;
import com.newp.xiaopan.action.system.BaseAction;
import com.newp.xiaopan.bean.system.Ads;
import com.newp.xiaopan.bean.system.Archive;
import com.newp.xiaopan.bean.system.Key;
import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.IAdsService;
import com.newp.xiaopan.service.system.IArchiveService;
import com.newp.xiaopan.service.system.IKeyService;
import com.newp.xiaopan.service.system.IShopService;
import com.newp.xiaopan.service.system.ITypeService;

/**
 * @author 张霄鹏
 */
@Controller
@Scope(value = "prototype")
public class MainAction extends BaseAction {
	private static final long serialVersionUID = 1L;

	@Autowired
	private IAdsService adsService;
	@Autowired
	private IArchiveService archiveService;
	@Autowired
	private IKeyService keyService;
	@Autowired
	private ITypeService typeService;
	@Autowired
	private IShopService shopService;

	private String siteJson;
	private Site site;
	private List<Ads> adss;
	private List<Archive> archives;
	private List<Key> keys;
	private List<Type> types;

	private Key key;
	private List<Shop> shops;

	public String toShow() {
		initHeader();
		archives = archiveService.queryTopList(null, 3);
		types = typeService.queryList(null);
		adss = adsService.queryList(new Ads(site.getId()));

		return "toShow";
	}

	public String toSearch() {
		initHeader();
		shops = shopService.queryListBySiteAndType(site.getId(), key.getName());
		types = typeService.queryList(null);
		return "toSearch";
	}

	@SuppressWarnings("unchecked")
	private void initHeader() {
		List<Site> sites = (List<Site>) MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		for (Site t : sites) {
			jsonObject = new JSONObject();
			jsonObject.put("id", t.getId());
			jsonObject.put("pId", 0);
			jsonObject.put("name", t.getName());
			jsonArray.add(jsonObject);
		}
		siteJson = jsonArray.toJSONString();

		if (null == site || StringUtils.isEmpty(site.getId())) {
			Site tmpSite = (Site) getCurrentSession().getAttribute(Constants.SESSION_USER_SITE);
			if (null == tmpSite) {
				site = sites.get(0);
				getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, site);
			} else {
				site = tmpSite;
			}
		} else {
			for (Site t : sites) {
				if (t.getId().equals(site.getId())) {
					site = t;
					break;
				}
			}
			getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, site);
		}
		keys = keyService.queryList(null);
	}

	public String getSiteJson() {
		return siteJson;
	}

	public void setSiteJson(String siteJson) {
		this.siteJson = siteJson;
	}

	public List<Ads> getAdss() {
		return adss;
	}

	public void setAdss(List<Ads> adss) {
		this.adss = adss;
	}

	public List<Archive> getArchives() {
		return archives;
	}

	public void setArchives(List<Archive> archives) {
		this.archives = archives;
	}

	public List<Key> getKeys() {
		return keys;
	}

	public void setKeys(List<Key> keys) {
		this.keys = keys;
	}

	public List<Type> getTypes() {
		return types;
	}

	public void setTypes(List<Type> types) {
		this.types = types;
	}

	public Site getSite() {
		return site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	public Key getKey() {
		return key;
	}

	public void setKey(Key key) {
		this.key = key;
	}

	public List<Shop> getShops() {
		return shops;
	}

	public void setShops(List<Shop> shops) {
		this.shops = shops;
	}
}
