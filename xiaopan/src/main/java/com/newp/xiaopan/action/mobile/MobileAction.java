package com.newp.xiaopan.action.mobile;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.action.listener.MySessionListener;
import com.newp.xiaopan.action.system.BaseAction;
import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.IShopService;
import com.newp.xiaopan.service.system.ITypeService;
import com.opensymphony.xwork2.Action;

/**
 * @author 张霄鹏
 */
@Controller
public class MobileAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private ITypeService typeService;
	@Autowired
	private IShopService shopService;

	private List<Site> sites;
	private List<Type> types;
	private List<Shop> shops;
	private Site site;
	private Type type;
	private Shop shop;

	@SuppressWarnings("unchecked")
	public String toSite() {
		sites = (List<Site>) MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
		return "toSite";
	}

	public String toTypeList() {
		types = typeService.queryDistinctList(null);
		initSite();
		return "toTypeList";
	}

	public String toSearch() {
		initSite();
		if (null == type || StringUtils.isBlank(type.getName())) {
			setShops(shopService.queryListByPager(new Shop(site.getId()), null, getPager()));
		} else {
			type.setName(type.getName().trim());
			setShops(shopService.queryListByPager(new Shop(site.getId()), new Type(type.getName()), getPager()));
		}
		return "toSearch";
	}

	public String toShop() {
		if (null == shop && StringUtils.isEmpty(shop.getId())) {
			return Action.NONE;
		}
		shop = this.shopService.query(shop);
		if (null == shop) {
			return Action.NONE;
		}
		return "toShop";
	}

	public String toPhone() {
		return "toPhone";
	}

	@SuppressWarnings("unchecked")
	private void initSite() {
		List<Site> tmpSites = (List<Site>) MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
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
	}

	public List<Site> getSites() {
		return sites;
	}

	public void setSites(List<Site> sites) {
		this.sites = sites;
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

	public List<Shop> getShops() {
		return shops;
	}

	public void setShops(List<Shop> shops) {
		this.shops = shops;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public Shop getShop() {
		return shop;
	}

	public void setShop(Shop shop) {
		this.shop = shop;
	}
}
