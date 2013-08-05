package com.newp.xiaopan.action.system;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.IShopService;
import com.newp.xiaopan.service.system.ISiteService;
import com.newp.xiaopan.service.system.ITypeService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class ShopAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private IShopService shopService;
	@Autowired
	private ISiteService siteService;
	@Autowired
	private ITypeService typeService;

	private Shop shop;
	private List<Shop> shops;
	private List<Site> sites;
	private String typeJson;

	public String toList() {
		shops = this.shopService.queryList(shop);
		return Constants.ACTION_TO_LIST;
	}

	@SuppressWarnings("unchecked")
	public String toEdit() {
		if (null != shop && StringUtils.isNotEmpty(shop.getId())) {
			shop = this.shopService.query(shop);
		}
		setSites(this.siteService.queryList(null));
		List<Type> types = this.typeService.queryList(null);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		for (Type t : types) {
			jsonObject = new JSONObject();
			jsonObject.put("id", t.getId());
			jsonObject.put("pId", t.getTopid());
			if (null != t.getTopid() && t.getTopid() != 0) {
				jsonObject.put("open", true);
				jsonObject.put("nocheck", true);
			}
			jsonArray.add(jsonObject);
		}
		this.typeJson = jsonArray.toJSONString();
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isEmpty(shop.getId())) {
			String id = this.shopService.add(shop);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.shopService.update(shop);
			jsonObject.put("result", "success");
			jsonObject.put("id", shop.getId());
		}
		this.ajax(jsonObject.toJSONString());
	}

	public void doDelete() {
		this.shopService.delete(shop);
		this.ajax(true);
	}

	/**
	 * @return the shops
	 */
	public List<Shop> getShops() {
		return shops;
	}

	/**
	 * @param shops
	 *            the shops to set
	 */
	public void setShops(List<Shop> shops) {
		this.shops = shops;
	}

	/**
	 * @return the shop
	 */
	public Shop getShop() {
		return shop;
	}

	/**
	 * @param shop
	 *            the shop to set
	 */
	public void setShop(Shop shop) {
		this.shop = shop;
	}

	public List<Site> getSites() {
		return sites;
	}

	public void setSites(List<Site> sites) {
		this.sites = sites;
	}

	public String getTypeJson() {
		if (StringUtils.isEmpty(typeJson)) {
			return "[]";
		}
		return typeJson;
	}

	public void setTypeJson(String typeJson) {
		this.typeJson = typeJson;
	}
}
