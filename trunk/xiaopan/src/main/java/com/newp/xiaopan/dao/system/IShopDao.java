/**
 * 
 */
package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Shop;

/**
 * @author 张霄鹏
 * 
 */
public interface IShopDao {

	List<Shop> query(Map<String, Object> params);

	String add(Shop shop);

	Integer update(Shop shop);

	Integer delete(Shop shop);
}
