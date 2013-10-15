package com.newp.xiaopan.action.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.action.system.BaseAction;
import com.newp.xiaopan.bean.system.Ads;
import com.newp.xiaopan.bean.system.Archive;
import com.newp.xiaopan.bean.system.Arctype;
import com.newp.xiaopan.bean.system.City;
import com.newp.xiaopan.bean.system.Key;
import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.IAdsService;
import com.newp.xiaopan.service.system.IArchiveService;
import com.newp.xiaopan.service.system.IArctypeService;
import com.newp.xiaopan.service.system.ICityService;
import com.newp.xiaopan.service.system.IShopService;
import com.newp.xiaopan.service.system.ISiteService;
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
	private ITypeService typeService;
	@Autowired
	private IShopService shopService;
	@Autowired
	private IArctypeService arctypeService;
	@Autowired
	private ICityService cityService;
	@Autowired
	private ISiteService siteService;

	private String siteJson;
	private Site site;
	private List<Ads> adss;
	private List<Archive> archives;
	private List<Type> types;
	private List<Shop> suportShops;
	private City city;
	private List<City> citys;

	private Key key;
	private Shop shop;
	private List<Shop> shops;

	private Archive archive;
	private Arctype arctype;

	private List<Site> sites;
	private Ads ads;

	public String toMap() {
		return "toMap";
	}

	public String toAdvertise() {
		Ads t = new Ads();
		t.setIndexShow("0");
		adss = this.adsService.queryList(t);

		if (city == null) {
			if (this.getCurrentSession().getAttribute(Constants.SESSION_CITY) != null) {
				city = (City) this.getCurrentSession().getAttribute(Constants.SESSION_CITY);
			} else {
				this.getCity().setId("1");
			}
		}
		this.setCity(this.cityService.query(getCity()));
		Site _site = new Site();
		_site.setCity(getCity());
		this.getCurrentSession().setAttribute(Constants.SESSION_CITY, this.getCity());

		// sites = (List<Site>)
		// MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
		sites = this.siteService.queryList(_site);
		if (null != this.getCurrentSession().getAttribute(Constants.SESSION_USER_SITE)) {
			if (!getCity().getId().equals(((Site) getCurrentSession().getAttribute(Constants.SESSION_USER_SITE)).getCity().getId())) {
				getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, sites.get(0));
			}
		}
		citys = this.cityService.queryList(null);
		return "toAdvertise";
	}

	public String toShow() {
		initHeader();
		archives = archiveService.queryTopList(new Archive("网站公告"), 3);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", null);
		params.put("siteId", site.getId());
		types = typeService.queryDistinctList(params);
		citys = this.cityService.queryList(null);

		return "toShow";
	}

	public String toSearch() {
		initHeader();
		if (null == key || StringUtils.isBlank(key.getName())) {
			shops = shopService.queryListByPager(new Shop(site.getId()), null, getPager());
		} else {
			key.setName(key.getName().trim());
			shops = shopService.queryListByPager(new Shop(site.getId()), new Type(key.getName()), getPager());
		}

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", null);
		params.put("siteId", site.getId());
		types = typeService.queryDistinctList(params);
		return "toSearch";
	}

	public String toDetail() {
		if (null == shop || StringUtils.isEmpty(shop.getId())) {
			return toShow();
		}
		initHeader();
		shop = this.shopService.query(shop);
		Shop s = new Shop();
		s.setId(shop.getId());
		s.setClick(shop.getClick() + 1);
		this.shopService.updatePart(s);
		return Constants.ACTION_TO_DETAIL;
	}

	@SuppressWarnings("unchecked")
	private void initHeader() {
		if (city == null) {
			if (this.getCurrentSession().getAttribute(Constants.SESSION_CITY) != null) {
				city = (City) this.getCurrentSession().getAttribute(Constants.SESSION_CITY);
			} else {
				this.getCity().setId("1");
			}
		}
		this.setCity(this.cityService.query(getCity()));
		Site _site = new Site();
		_site.setCity(getCity());
		this.getCurrentSession().setAttribute(Constants.SESSION_CITY, this.getCity());
		citys = this.cityService.queryList(null);

		List<Site> tmpSites = this.siteService.queryList(_site);
		if (null != this.getCurrentSession().getAttribute(Constants.SESSION_USER_SITE)) {
			if (!getCity().getId().equals(((Site) getCurrentSession().getAttribute(Constants.SESSION_USER_SITE)).getCity().getId())) {
				getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, tmpSites.get(0));
			}
		}
		// List<Site> tmpSites = (List<Site>)
		// MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		for (Site t : tmpSites) {
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
				site = tmpSites.get(0);
				getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, site);
			} else {
				site = tmpSite;
			}
		} else {
			for (Site t : tmpSites) {
				if (t.getId().equals(site.getId())) {
					site = t;
					break;
				}
			}
			getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, site);
		}

		if (null == getCurrentSession().getAttribute(Constants.SESSION_SUPORT_SHOP)) {
			getCurrentSession().setAttribute(Constants.SESSION_SUPORT_SHOP, shopService.querySuportList(8));
		}
		suportShops = (List<Shop>) getCurrentSession().getAttribute(Constants.SESSION_SUPORT_SHOP);

		adss = adsService.queryList(new Ads(site.getId()));
	}

	public String toInfo() {
		if (null == arctype || StringUtils.isEmpty(arctype.getTypename())) {
			return toShow();
		}
		initHeader();
		arctype = this.arctypeService.query(new Arctype(arctype.getTypename()));
		archives = archiveService.queryTopList(new Archive("网站公告"), 5);
		return "toInfo";
	}

	public String toNoticeList() {
		initHeader();
		archives = archiveService.queryListByPager(new Archive("网站公告"), getPager());

		return "toNoticeList";
	}

	public String toNotice() {
		if (null == archive || StringUtils.isEmpty(archive.getId())) {
			return toShow();
		}
		initHeader();
		archives = archiveService.queryTopList(new Archive("网站公告"), 5);
		archive = archiveService.query(archive);

		return "toNotice";
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

	public List<Type> getTypes() {
		return types;
	}

	public void setTypes(List<Type> types) {
		this.types = types;
	}

	public Site getSite() {
		if (site == null) {
			site = new Site();
		}
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

	public Shop getShop() {
		return shop;
	}

	public void setShop(Shop shop) {
		this.shop = shop;
	}

	public List<Shop> getShops() {
		return shops;
	}

	public void setShops(List<Shop> shops) {
		this.shops = shops;
	}

	public List<Shop> getSuportShops() {
		return suportShops;
	}

	public void setSuportShops(List<Shop> suportShops) {
		this.suportShops = suportShops;
	}

	public Arctype getArctype() {
		return arctype;
	}

	public void setArctype(Arctype arctype) {
		this.arctype = arctype;
	}

	public Archive getArchive() {
		return archive;
	}

	public void setArchive(Archive archive) {
		this.archive = archive;
	}

	public List<Site> getSites() {
		return sites;
	}

	public void setSites(List<Site> sites) {
		this.sites = sites;
	}

	public Ads getAds() {
		return ads;
	}

	public void setAds(Ads ads) {
		this.ads = ads;
	}

	/**
	 * @return the citys
	 */
	public List<City> getCitys() {
		return citys;
	}

	/**
	 * @param citys
	 *            the citys to set
	 */
	public void setCitys(List<City> citys) {
		this.citys = citys;
	}

	/**
	 * @return the city
	 */
	public City getCity() {
		if (city == null) {
			city = new City();
		}
		return city;
	}

	/**
	 * @param city
	 *            the city to set
	 */
	public void setCity(City city) {
		this.city = city;
	}
}
