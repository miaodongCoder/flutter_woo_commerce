import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigService extends GetxService {
  // 外部通过单例对象获取当前类对象:
  static ConfigService get to => Get.find<ConfigService>();
  static ConfigService getInstance() => Get.find<ConfigService>();

  // 这是一个内部私有的成员 , 外部能拿到的只有version属性:
  PackageInfo? _platform;
  String get version => _platform?.version ?? "-";
  @override
  void onReady() {
    super.onReady();
    getPlatform();
  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }
}
