/**
 * TODO 去掉字符串两端的空白字符
 */
String.prototype.trim = function() {
    return this.replace("/(^/s+)|(/s+$)/g", "");
};
/**
 * 忽略大小写比较字符串
 * 注：不忽略大小写比较用 == 号
 */
String.prototype.iEquals = function(str) {
    return this.toLowerCase() == str.toLowerCase();
};
/**
 * 比较字符串，根据结果返回 -1, 0, 1
 */
String.prototype.compareTo = function(str) {
    if (this == str) {
        return 0;
    } else if (this < str) {
        return -1;
    } else {
        return 1;
    }
};
/**
 * 忽略大小写比较字符串，根据结果返回 -1, 0, 1
 */
String.prototype.iCompareTo = function(str) {
    return this.toLowerCase().compareTo(str.toLowerCase());
};
/**
 * 判断字符串是否以指定的字符串开始
 */
String.prototype.startsWith = function(str) {
    return this.substr(0, str.length) == str;
};
/**
 * 判断字符串是否以指定的字符串开始，忽略大小写
 */
String.prototype.iStartsWith = function(str) {
    return this.substr(0, str.length).iEquals(str);
};
/**
 * 判断字符串是否以指定的字符串结束
 */
String.prototype.endsWith = function(str) {
    return this.substr(this.length - str.length) == str;
};
/**
 * 判断字符串是否以指定的字符串结束，忽略大小写
 */
String.prototype.iEndsWith = function(str) {
    return this.substr(this.length - str.length).iEquals(str);
};
/**
 * 构造特定样式的字符串，用 <span></span> 包含
 */
String.prototype.style = function(style) {
    return "<span style=\"".concat(style, "\">", this, "</span>");
};