/**
 * 
 */
package com.newp.xiaopan.bean.system;


/**
 * @author 张霄鹏
 * 
 */
public class Arctype extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String typename;
	private String seotitle;
	private String keyword;
	private String description;
	private String contents;
	private Integer topid;
	private Integer sort;

	/**
	 * @return the typename
	 */
	public String getTypename() {
		return typename;
	}

	/**
	 * @param typename
	 *            the typename to set
	 */
	public void setTypename(String typename) {
		this.typename = typename;
	}

	/**
	 * @return the seotitle
	 */
	public String getSeotitle() {
		return seotitle;
	}

	/**
	 * @param seotitle
	 *            the seotitle to set
	 */
	public void setSeotitle(String seotitle) {
		this.seotitle = seotitle;
	}

	/**
	 * @return the keyword
	 */
	public String getKeyword() {
		return keyword;
	}

	/**
	 * @param keyword
	 *            the keyword to set
	 */
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the contents
	 */
	public String getContents() {
		return contents;
	}

	/**
	 * @param contents
	 *            the contents to set
	 */
	public void setContents(String contents) {
		this.contents = contents;
	}

	/**
	 * @return the topid
	 */
	public Integer getTopid() {
		return topid;
	}

	/**
	 * @param topid
	 *            the topid to set
	 */
	public void setTopid(Integer topid) {
		this.topid = topid;
	}

	/**
	 * @return the sort
	 */
	public Integer getSort() {
		return sort;
	}

	/**
	 * @param sort
	 *            the sort to set
	 */
	public void setSort(Integer sort) {
		this.sort = sort;
	}
}
