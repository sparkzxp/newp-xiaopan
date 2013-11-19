package com.newp.xiaopan.action.web;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.action.system.BaseAction;
import com.newp.xiaopan.bean.system.Ads;
import com.newp.xiaopan.bean.system.Archive;
import com.newp.xiaopan.bean.system.Arctype;
import com.newp.xiaopan.bean.system.City;
import com.newp.xiaopan.bean.system.Comment;
import com.newp.xiaopan.bean.system.Feedback;
import com.newp.xiaopan.bean.system.Key;
import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.bean.system.Vote;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.IPUtil;
import com.newp.xiaopan.service.system.IAdsService;
import com.newp.xiaopan.service.system.IArchiveService;
import com.newp.xiaopan.service.system.IArctypeService;
import com.newp.xiaopan.service.system.ICityService;
import com.newp.xiaopan.service.system.ICommentService;
import com.newp.xiaopan.service.system.IFeedbackService;
import com.newp.xiaopan.service.system.IShopService;
import com.newp.xiaopan.service.system.ISiteService;
import com.newp.xiaopan.service.system.ITypeService;
import com.newp.xiaopan.service.system.IVoteService;

/**
 * @author 张霄鹏
 */
@Controller
@Scope(value = "prototype")
public class MainAction extends BaseAction {
	private static final long serialVersionUID = 1L;

	@Autowired
	private IAdsService adsService;
	@Autowired
	private IArchiveService archiveService;
	@Autowired
	private ITypeService typeService;
	@Autowired
	private IShopService shopService;
	@Autowired
	private IArctypeService arctypeService;
	@Autowired
	private ICityService cityService;
	@Autowired
	private ISiteService siteService;
	@Autowired
	private IFeedbackService feedbackService;
	@Autowired
	private ICommentService commentService;
	@Autowired
	private IVoteService voteService;

	private String siteJson;
	private Site site;
	private List<Ads> adss;
	private List<Archive> archives;
	private List<Type> types;
	private List<Shop> suportShops;
	private City city;
	private List<City> citys;

	private Key key;
	private Shop shop;
	private List<Shop> shops;

	private Archive archive;
	private Arctype arctype;

	private List<Site> sites;
	private Ads ads;

	private List<Feedback> feedbacks;
	private Feedback feedback;

	private List<Comment> comments;
	private Comment comment;

	private Vote vote;

	public String toMap() {
		return "toMap";
	}

	public String toAdvertise() {
		if (city == null) {
			if (this.getCurrentSession().getAttribute(Constants.SESSION_CITY) != null) {
				city = (City) this.getCurrentSession().getAttribute(Constants.SESSION_CITY);
			} else {
				this.getCity().setId("1");
			}
		}
		this.setCity(this.cityService.query(getCity()));

		Ads t = new Ads();
		t.setIndexShow("0");
		adss = this.adsService.queryList(t, getCity().getId());

		Site _site = new Site();
		_site.setCity(getCity());
		this.getCurrentSession().setAttribute(Constants.SESSION_CITY, this.getCity());

		// sites = (List<Site>)
		// MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
		sites = this.siteService.queryList(_site);
		if (null != this.getCurrentSession().getAttribute(Constants.SESSION_USER_SITE)) {
			if (!getCity().getId().equals(((Site) getCurrentSession().getAttribute(Constants.SESSION_USER_SITE)).getCity().getId())) {
				getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, sites.get(0));
			}
		}
		citys = this.cityService.queryList(null);
		return "toAdvertise";
	}

	public String toShow() {
		initHeader();
		archives = archiveService.queryTopList(new Archive("网站公告"), 3);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", null);
		params.put("siteId", site.getId());
		types = typeService.queryDistinctList(params);
		citys = this.cityService.queryList(null);

		return "toShow";
	}

	public String toSearch() {
		initHeader();
		if (null == key || StringUtils.isBlank(key.getName())) {
			shops = shopService.queryListByPager(new Shop(site.getId()), null, getPager());
		} else {
			key.setName(key.getName().trim());
			shops = shopService.queryListByPager(new Shop(site.getId()), new Type(key.getName()), getPager());
		}

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", null);
		params.put("siteId", site.getId());
		types = typeService.queryDistinctList(params);
		return "toSearch";
	}

	public String toDetail() {
		if (null == shop || StringUtils.isEmpty(shop.getId())) {
			return toShow();
		}
		initHeader();
		shop = this.shopService.query(shop);
		// Collections.sort(shop.getTypes(), new SortByTopid());
		Shop s = new Shop();
		s.setId(shop.getId());
		s.setClick(shop.getClick() + 1);
		this.shopService.updatePart(s);

		Map<String, Object> params = new HashMap<String, Object>();
		this.getComment().setIsDelete("0");
		this.getComment().setShop(s);
		params.put("comment", this.getComment());
		params.put("pager", this.getPager());
		this.setComments(this.commentService.queryList(params));
		return Constants.ACTION_TO_DETAIL;
	}

	public void addComment() {
		this.getComment().setIpAddress(IPUtil.getIpAddr(this.getCurrentRequest()));
		this.getComment().setIsDelete("0");
		this.commentService.add(this.getComment());

		this.ajax(true);
	}

	@SuppressWarnings("unchecked")
	private void initHeader() {
		if (city == null) {
			if (this.getCurrentSession().getAttribute(Constants.SESSION_CITY) != null) {
				city = (City) this.getCurrentSession().getAttribute(Constants.SESSION_CITY);
			} else {
				this.getCity().setId("1");
			}
		}
		this.setCity(this.cityService.query(getCity()));
		Site _site = new Site();
		_site.setCity(getCity());
		this.getCurrentSession().setAttribute(Constants.SESSION_CITY, this.getCity());
		citys = this.cityService.queryList(null);

		List<Site> tmpSites = this.siteService.queryList(_site);
		if (null != this.getCurrentSession().getAttribute(Constants.SESSION_USER_SITE)) {
			if (!getCity().getId().equals(((Site) getCurrentSession().getAttribute(Constants.SESSION_USER_SITE)).getCity().getId())) {
				getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, tmpSites.get(0));
			}
		}
		// List<Site> tmpSites = (List<Site>)
		// MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		for (Site t : tmpSites) {
			jsonObject = new JSONObject();
			jsonObject.put("id", t.getId());
			jsonObject.put("pId", 0);
			jsonObject.put("name", t.getName());
			jsonArray.add(jsonObject);
		}
		siteJson = jsonArray.toJSONString();

		if (null == site || StringUtils.isEmpty(site.getId())) {
			Site tmpSite = (Site) getCurrentSession().getAttribute(Constants.SESSION_USER_SITE);
			if (null == tmpSite) {
				site = tmpSites.get(0);
				getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, site);
			} else {
				site = tmpSite;
			}
		} else {
			for (Site t : tmpSites) {
				if (t.getId().equals(site.getId())) {
					site = t;
					break;
				}
			}
			getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, site);
		}

		Shop _shop = new Shop();
		_shop.setSiteId(site.getId());
		suportShops = this.shopService.querySuportList(_shop, 8);

		adss = adsService.queryList(new Ads(site.getId()));
	}

	public String toInfo() {
		if (null == arctype || StringUtils.isEmpty(arctype.getTypename())) {
			return toShow();
		}
		initHeader();
		arctype = this.arctypeService.query(new Arctype(arctype.getTypename()));
		archives = archiveService.queryTopList(new Archive("网站公告"), 5);
		return "toInfo";
	}

	public String toNoticeList() {
		initHeader();
		archives = archiveService.queryListByPager(new Archive("网站公告"), getPager());

		return "toNoticeList";
	}

	public String toNotice() {
		if (null == archive || StringUtils.isEmpty(archive.getId())) {
			return toShow();
		}
		initHeader();
		archives = archiveService.queryTopList(new Archive("网站公告"), 5);
		archive = archiveService.query(archive);

		return "toNotice";
	}

	public String toFeedback() {
		initHeader();
		archives = archiveService.queryTopList(new Archive("网站公告"), 3);
		Map<String, Object> params = new HashMap<String, Object>();
		this.getFeedback().setIsDelete("0");
		params.put("feedback", this.getFeedback());
		params.put("pager", this.getPager());
		feedbacks = this.feedbackService.queryList(params);
		return "toFeedback";
	}

	public void addFeedback() {
		feedback.setIpAddress(IPUtil.getIpAddr(this.getCurrentRequest()));
		feedback.setIsDelete("0");
		this.feedbackService.add(feedback);

		this.ajax(true);
	}

	public void addVote() {
		vote.setIpAddress(IPUtil.getIpAddr(this.getCurrentRequest()));
		this.ajax(this.voteService.add(vote));
	}

	@SuppressWarnings("unchecked")
	public void queryVoteByShop() {
		JSONObject result = new JSONObject();
		List<Map<String, Object>> list = this.voteService.queryStat(vote);
		JSONArray jsonArray = new JSONArray();
		JSONObject speed0 = new JSONObject();
		speed0.put("id", "speed0");
		speed0.put("name", "蜗牛店");
		speed0.put("value", "0");
		if (CollectionUtils.isNotEmpty(list)) {
			for (Map<String, Object> map : list) {
				if ("speed0".equals(map.get("type").toString())) {
					speed0.put("value", map.get("count").toString());
				}
			}
		}
		jsonArray.add(speed0);

		JSONObject speed1 = new JSONObject();
		speed1.put("id", "speed1");
		speed1.put("name", "乌龟店");
		speed1.put("value", "0");
		if (CollectionUtils.isNotEmpty(list)) {
			for (Map<String, Object> map : list) {
				if ("speed1".equals(map.get("type").toString())) {
					speed1.put("value", map.get("count").toString());
				}
			}
		}
		jsonArray.add(speed1);

		JSONObject speed2 = new JSONObject();
		speed2.put("id", "speed2");
		speed2.put("name", "兔子店");
		speed2.put("value", "0");
		if (CollectionUtils.isNotEmpty(list)) {
			for (Map<String, Object> map : list) {
				if ("speed2".equals(map.get("type").toString())) {
					speed2.put("value", map.get("count").toString());
				}
			}
		}
		jsonArray.add(speed2);

		JSONObject speed3 = new JSONObject();
		speed3.put("id", "speed3");
		speed3.put("name", "曹操店");
		speed3.put("value", "0");
		if (CollectionUtils.isNotEmpty(list)) {
			for (Map<String, Object> map : list) {
				if ("speed3".equals(map.get("type").toString())) {
					speed3.put("value", map.get("count").toString());
				}
			}
		}
		jsonArray.add(speed3);

		result.put("root", jsonArray);
		this.ajax(result.toJSONString());
	}

	public String getSiteJson() {
		return siteJson;
	}

	public void setSiteJson(String siteJson) {
		this.siteJson = siteJson;
	}

	public List<Ads> getAdss() {
		return adss;
	}

	public void setAdss(List<Ads> adss) {
		this.adss = adss;
	}

	public List<Archive> getArchives() {
		return archives;
	}

	public void setArchives(List<Archive> archives) {
		this.archives = archives;
	}

	public List<Type> getTypes() {
		return types;
	}

	public void setTypes(List<Type> types) {
		this.types = types;
	}

	public Site getSite() {
		if (site == null) {
			site = new Site();
		}
		return site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	public Key getKey() {
		return key;
	}

	public void setKey(Key key) {
		this.key = key;
	}

	public Shop getShop() {
		return shop;
	}

	public void setShop(Shop shop) {
		this.shop = shop;
	}

	public List<Shop> getShops() {
		return shops;
	}

	public void setShops(List<Shop> shops) {
		this.shops = shops;
	}

	public List<Shop> getSuportShops() {
		return suportShops;
	}

	public void setSuportShops(List<Shop> suportShops) {
		this.suportShops = suportShops;
	}

	public Arctype getArctype() {
		return arctype;
	}

	public void setArctype(Arctype arctype) {
		this.arctype = arctype;
	}

	public Archive getArchive() {
		return archive;
	}

	public void setArchive(Archive archive) {
		this.archive = archive;
	}

	public List<Site> getSites() {
		return sites;
	}

	public void setSites(List<Site> sites) {
		this.sites = sites;
	}

	public Ads getAds() {
		return ads;
	}

	public void setAds(Ads ads) {
		this.ads = ads;
	}

	/**
	 * @return the citys
	 */
	public List<City> getCitys() {
		return citys;
	}

	/**
	 * @param citys
	 *            the citys to set
	 */
	public void setCitys(List<City> citys) {
		this.citys = citys;
	}

	/**
	 * @return the city
	 */
	public City getCity() {
		if (city == null) {
			city = new City();
		}
		return city;
	}

	/**
	 * @param city
	 *            the city to set
	 */
	public void setCity(City city) {
		this.city = city;
	}

	/**
	 * @return the feedbacks
	 */
	public List<Feedback> getFeedbacks() {
		return feedbacks;
	}

	/**
	 * @param feedbacks
	 *            the feedbacks to set
	 */
	public void setFeedbacks(List<Feedback> feedbacks) {
		this.feedbacks = feedbacks;
	}

	/**
	 * @return the feedback
	 */
	public Feedback getFeedback() {
		if (feedback == null) {
			feedback = new Feedback();
		}
		return feedback;
	}

	/**
	 * @param feedback
	 *            the feedback to set
	 */
	public void setFeedback(Feedback feedback) {
		this.feedback = feedback;
	}

	/**
	 * @return the comments
	 */
	public List<Comment> getComments() {
		return comments;
	}

	/**
	 * @param comments
	 *            the comments to set
	 */
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	/**
	 * @return the comment
	 */
	public Comment getComment() {
		if (comment == null) {
			comment = new Comment();
		}
		return comment;
	}

	/**
	 * @param comment
	 *            the comment to set
	 */
	public void setComment(Comment comment) {
		this.comment = comment;
	}

	/**
	 * @return the vote
	 */
	public Vote getVote() {
		return vote;
	}

	/**
	 * @param vote
	 *            the vote to set
	 */
	public void setVote(Vote vote) {
		this.vote = vote;
	}
}

class SortByTopid implements Comparator<Type> {

	public int compare(Type o1, Type o2) {
		if (o1.getTopid() > o2.getTopid()) {
			return 1;
		} else {
			return 0;
		}
	}

}