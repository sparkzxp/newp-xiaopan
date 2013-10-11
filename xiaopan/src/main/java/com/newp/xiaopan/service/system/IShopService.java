package com.newp.xiaopan.service.system;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.common.bean.Pager;

/**
 * @author 张霄鹏
 * 
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface IShopService {

	Shop query(Shop shop);

	List<Shop> queryList(Shop shop);

	List<Shop> queryList(Map<String, Object> params);

	List<Shop> querySuportList(Integer top);

	List<Shop> queryListByPager(Shop shop, Type type, Pager pager);

	Integer count(Shop shop, Type type);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Shop shop);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Shop shop);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer updatePart(Shop shop);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Shop shop);
}
