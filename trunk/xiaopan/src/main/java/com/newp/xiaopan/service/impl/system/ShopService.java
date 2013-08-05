/**
 * 
 */
package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Shop;
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

	public Shop query(Shop shop) {
		List<Shop> list = this.queryList(shop);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Shop shop) {
		return this.shopDao.add(shop);
	}

	public Integer update(Shop shop) {
		return this.shopDao.update(shop);
	}

	public Integer delete(Shop shop) {
		return this.shopDao.delete(shop);
	}

}
