/**
 * 
 */
package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Shop;

/**
 * @author 张霄鹏
 * 
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = false, rollbackFor = Exception.class)
public interface IShopService {

	Shop query(Shop shop);

	List<Shop> queryList(Shop shop);

	List<Shop> querySuportList(Integer top);

	List<Shop> queryListBySiteAndType(String siteId, String typeName);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	String add(Shop shop);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	Integer update(Shop shop);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer updatePart(Shop shop);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	Integer delete(Shop shop);
}
