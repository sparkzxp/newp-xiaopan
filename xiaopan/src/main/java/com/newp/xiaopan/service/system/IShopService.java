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

	String add(Shop shop);

	Integer update(Shop shop);

	Integer delete(Shop shop);
}
