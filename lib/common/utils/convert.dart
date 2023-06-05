// oss 图片加工 https://help.aliyun.com/document_detail/101260.html
// oss 图片参数 https://help.aliyun.com/document_detail/44688.html

/// 转换:
class Convert {
  // 阿里图片尺寸调整
  static String aliImageResize(
    String url, {
    double width = 300,
    double? maxHeight,
  }) {
    var crop = '';
    int widthInt = width.toInt();
    int? maxHeightInt = maxHeight?.toInt();

    if (maxHeight != null) {
      crop = '/crop,h_$maxHeightInt,g_center';
    }
    return '$url?x-oss-process=image/resize,w_$widthInt,m_lfit$crop';
  }
}
