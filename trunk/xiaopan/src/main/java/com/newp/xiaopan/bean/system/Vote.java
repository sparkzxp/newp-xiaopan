package com.newp.xiaopan.bean.system;

/**
 * @author 张霄鹏
 * 
 */
public class Vote extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String type;
	private String ipAddress;
	private String voteDt;
	private String shopId;

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the ipAddress
	 */
	public String getIpAddress() {
		return ipAddress;
	}

	/**
	 * @param ipAddress
	 *            the ipAddress to set
	 */
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	/**
	 * @return the voteDt
	 */
	public String getVoteDt() {
		return voteDt;
	}

	/**
	 * @param voteDt
	 *            the voteDt to set
	 */
	public void setVoteDt(String voteDt) {
		this.voteDt = voteDt;
	}

	/**
	 * @return the shopId
	 */
	public String getShopId() {
		return shopId;
	}

	/**
	 * @param shopId
	 *            the shopId to set
	 */
	public void setShopId(String shopId) {
		this.shopId = shopId;
	}
}
