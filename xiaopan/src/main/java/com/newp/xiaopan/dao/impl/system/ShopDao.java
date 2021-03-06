/**
 * 
 */
package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.dao.system.IShopDao;

/**
 * @author 张霄鹏
 * 
 */
@Repository
public class ShopDao implements IShopDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Shop> query(Map<String, Object> params) {
		return this.sqlSession.selectList("shopNpc.query", params);
	}

	public String add(Shop shop) {
		this.sqlSession.insert("shopNpc.add", shop);
		return String.valueOf(shop.getId());
	}

	public Integer update(Shop shop) {
		return this.sqlSession.update("shopNpc.update", shop);
	}

	public Integer delete(Shop shop) {
		return this.sqlSession.delete("shopNpc.delete", shop);
	}

	public List<Shop> queryByPager(Map<String, Object> params) {
		return this.sqlSession.selectList("shopNpc.queryByPager", params);
	}

	public void addTypes(Shop shop) {
		this.sqlSession.insert("shopNpc.addTypes", shop);
	}

	public void deleteTypes(Shop shop) {
		this.sqlSession.delete("shopNpc.deleteTypes", shop);
	}

	public List<Shop> querySuport(Map<String, Object> params) {
		return this.sqlSession.selectList("shopNpc.querySuport", params);
	}

	public Integer updatePart(Shop shop) {
		return this.sqlSession.update("shopNpc.updatePart", shop);
	}

	public Integer count(Map<String, Object> params) {
		return this.sqlSession.selectOne("shopNpc.count", params);
	}
}
