package com.newp.xiaopan.common;

/**
 * 常量
 * 
 * @author 张霄鹏
 * @version 创建时间：2012-12-11 下午1:32:52
 */
public interface Constants {

	/**
	 * 跳转密码管理页面
	 */
	String MANAGE_PWD = "managePwd";
	String DES_KEY = "iskyinfo";
	String SESSION_USER_KEY = "userInfo";
	String SESSION_USER_ORG_KEY = "userOrgInfo";
	String SESSION_USER_MARK = "userSessionMark";
	String SESSION_CONFIG_TOP_LOV_ID = "TOP_LOV_ID";
	String SESSION_QUERY_DATER = "queryDater";

	/**
	 * 页面跳转
	 */
	String ACTION_NOT_FOUND = "notFound";
	String ACTION_TO_LIST = "toList";
	String ACTION_TO_EDIT = "toEdit";
	String ACTION_TO_DETAIL = "toDetail";

	/**
	 * FTP
	 */
	String FTP_CONFIG_FILE = "ftpconfig.properties";
	String FTP_SERVER = "ftp.server";
	String FTP_TEMP_DIR = "static/ssi/temp/";
	String FTP_SSI_DIR = "static/ssi/";
	Integer FTP_IMAGE = 1;
	String FTP_IMAGE_DIR = "images";
	Integer FTP_PDM = 2;
	String FTP_PDM_DIR = "pdm";

	String SYSTEM_CONFIG_FILE = "systemConfig.properties";
	
	/**
	 * 行业类型
	 */
	String LIST_OF_INDUSTRY = "INDUSTRY_CAT";
	/**
	 * 行政区划类型
	 */
	String LIST_OF_ADMINISTRATION_REGION = "ADMINISTRATIVE_DIVISION";

	/**
	 * 监管等级配置
	 */
	String LIST_OF_SUPERVISE_GRADE = "SUPERVISE_GRADE";

	/**
	 * 排查项类别
	 */
	String LIST_OF_ITEM_CAT = "INSPECT_ITEM_CAT";
	/**
	 * 隐患状态
	 */
	String LIST_OF_HAZARD_STATUS = "HAZARD_STATUS";

	/**
	 * 隐患状态_待提交 1
	 */
	String LIST_OF_WAIT_TO_COMMIT = "1";
	/**
	 * 隐患状态_审核未通过待重新提交 1-A
	 */
	String LIST_OF_AUDIT_FAILURE_WAIT_TO_RECOMMIT = "1-A";
	/**
	 * 隐患状态_已提交-待审核 2
	 */
	String LIST_OF_COMMITTED_WAIT_TO_AUDIT = "2";
	/**
	 * 隐患状态_已审核-待整改 3
	 */
	String LIST_OF_AUDITED_WAIT_TO_RECTIFY = "3";
	/**
	 * 隐患状态_整改复查未通过待重新整改 3-A
	 */
	String LIST_OF_REEXAMINE_FAILURE_WAIT_TO_RERECTIFY = "3-A";
	/**
	 * 隐患状态_销案不通过待重新整改 3-B
	 */
	String LIST_OF_CLOSE_CASE_FAILURE_WAIT_TO_RERECTIFY = "3-B";
	/**
	 * 隐患状态_整改中 4
	 */
	String LIST_OF_RECTIFYING = "4";
	/**
	 * 隐患状态_已整改-待销案 5
	 */
	String LIST_OF_RECTIFIED_WAIT_TO_CLOSE_CASE = "5";
	/**
	 * 隐患状态_已整改-销案中 6
	 */
	String LIST_OF_RECTIFIED_CLOSING_CASE = "6";
	/**
	 * 隐患状态_已整改 7
	 */
	String LIST_OF_RECTIFIED = "7";
	/**
	 * 隐患状态_已整改-已销案 7-A
	 */
	String LIST_OF_RECTIFIED_CASE_CLOSED = "7-A";

	/**
	 * 隐患上报,销案状态
	 */
	String LIST_OF_HAZARD_RELEASE_REQ_STATUS = "HAZARD_RELEASE_REQ_STATUS";

	/**
	 * 隐患上报,销案状态_待提交 1
	 */
	String LIST_OF_HAZARD_RELEASE_REQ_STATUS_TO_COMMIT = "1";

	/**
	 * 隐患上报,销案状态_待审批 2
	 */
	String LIST_OF_HAZARD_RELEASE_REQ_STATUS_TO_VERIFY = "2";
	/**
	 * 隐患上报,销案状态_审批通过 3
	 */
	String LIST_OF_HAZARD_RELEASE_REQ_STATUS_TO_VERIFY_YES = "3";
	/**
	 * 隐患上报,销案状态_审批不通过 4
	 */
	String LIST_OF_HAZARD_RELEASE_REQ_STATUS_TO_VERIFY_NO = "4";

	/**
	 * 隐患申请类型_隐患审核申请 1
	 */
	String LIST_OF_HAZARD_RELEASE_REQ_TYPE_ADD = "1";

	/**
	 * 隐患申请类型_销案审批申请 2
	 */
	String LIST_OF_HAZARD_RELEASE_REQ_TYPE_REMOVE = "2";

	/**
	 * 隐患类别
	 */
	String LIST_OF_HAZARD_CAT = "HAZARD_GRADE";

	/**
	 * 隐患类别_一般隐患
	 */
	String LIST_OF_HAZARD_CAT_GENERAL = "GENERAL";
	/**
	 * 隐患类别_重大隐患
	 */
	String LIST_OF_HAZARD_CAT_FATAL = "FATAL";

	/**
	 * 隐患检查类型
	 */
	String LIST_OF_HAZARD_INSPECT_MAINSTAY = "INSPECT_MAINSTAY";

	/**
	 * 隐患检查类型_政府检查
	 */
	String LIST_OF_HAZARD_INSPECT_MAINSTAY_GOV = "GOV";
	/**
	 * T_SYS_LIST_OF_VAL表最顶层节点
	 */
	String LIST_OF_LOV_TOP_TYPE = "LOV_TOP_TYPE";
	String LIST_OF_LOV_TOP_VAL = "TOP_LOV_VAL";

	/**
	 * 系统中JSP页面的title
	 */
	// String SYSTEM_JSP_TITLE = "XX市安监局隐患排查系统";
	/**
	 * 机构类型_普通机构 1
	 */
	String ORG_TYPE_ORDINARY = "1";
	/**
	 * 机构类型_政府机构 2
	 */
	String ORG_TYPE_GOVERNMENT = "2";
	/**
	 * 机构隶属关系
	 */
	String ORG_LEVEL = "ORG_GRADE";
	/**
	 * 企业机构注册审核状态
	 */
	String ORG_AUDIT_STATUSES = "ORG_REG_AUDIT_STATUS";

	/**
	 * 企业机构注册审核状态_通过
	 */
	String ORG_AUDIT_STATUSES_PASSED = "PASSED";

	/**
	 * 企业机构注册审核状态_不通过
	 */
	String ORG_AUDIT_STATUSES_REJECTED = "REJECTED";

	/**
	 * 企业机构注册审核状态_待审核
	 */
	String ORG_AUDIT_STATUSES_WAITING = "WAITING";

	/**
	 * 机构监管行业
	 */
	String ORG_XM_INDUSTRY = "ORG_ADMIN_INDUSTRY";
	/**
	 * 机构监管区域
	 */
	String ORG_XM_DIVISION = "ORG_ADMIN_DIVISION";
	/**
	 * 企业机构经济性质
	 */
	String ORG_ECON_CAT = "ECON_CAT";

	/**
	 * 安全知识
	 */
	String KNOWLEDGE_TYPE = "KNOWLEDGE_TYPE";

	/**
	 * 安全知识-法律
	 */
	String KNOWLEDGE_TYPE_LAW = "LAW";

	/**
	 * 安全知识-标准规范
	 */
	String KNOWLEDGE_TYPE_CRITERIA = "CRITERIA";

	/**
	 * 安全知识-法律文件类别
	 */
	String KNOWLEDGE_LAW_TYPE = "LAW_TYPE";

	/**
	 * 系统默认组织
	 */
	String DEFAULT_ORG = "DEFAULT_ORG";
}
