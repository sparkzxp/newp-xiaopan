package com.newp.xiaopan.service.impl.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.common.PagerUtil;
import com.newp.xiaopan.common.bean.Pager;
import com.newp.xiaopan.dao.system.IShopDao;
import com.newp.xiaopan.service.system.IShopService;

/**
 * @author 张霄鹏
 * 
 */
@Service
public class ShopService extends BaseService implements IShopService {

	@Autowired
	private IShopDao shopDao;

	public List<Shop> queryList(Shop shop) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("shop", shop);
		return this.shopDao.query(params);
	}

	public List<Shop> queryList(Map<String, Object> params) {
		return this.shopDao.query(params);
	}

	public Shop query(Shop shop) {
		List<Shop> list = this.queryList(shop);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Shop shop) {
		String ret = this.shopDao.add(shop);
		if (CollectionUtils.isNotEmpty(shop.getTypes())) {
			this.shopDao.addTypes(shop);
		}
		return ret;
	}

	public Integer update(Shop shop) {
		Integer ret = this.shopDao.update(shop);
		this.shopDao.deleteTypes(shop);
		if (CollectionUtils.isNotEmpty(shop.getTypes())) {
			this.shopDao.addTypes(shop);
		}
		return ret;
	}

	public Integer delete(Shop shop) {
		Integer ret = this.shopDao.delete(shop);
		this.shopDao.deleteTypes(shop);
		return ret;
	}

	public List<Shop> queryListByPager(Shop shop, Type type, Pager pager) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("shop", shop);
		params.put("type", type);
		pager.setTotalSize(this.shopDao.count(params));
		PagerUtil.setPager(pager);
		if (pager.getTotalSize() == 0) {
			return new ArrayList<Shop>();
		}
		params.put("pager", pager);
		return this.shopDao.queryByPager(params);
	}

	public List<Shop> querySuportList(Shop shop, Integer top) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("top", top);
		params.put("shop", shop);
		return this.shopDao.querySuport(params);
	}

	public Integer updatePart(Shop shop) {
		return this.shopDao.updatePart(shop);
	}

	public Integer count(Shop shop, Type type) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("shop", shop);
		params.put("type", type);
		return this.shopDao.count(params);
	}

}
