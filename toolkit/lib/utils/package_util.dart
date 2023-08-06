part of 'utils.dart';

/// 包工具
class PackageUtil {
  PackageUtil._();

  factory PackageUtil() => instanceUtil.singleton(PackageUtil._);

  late final PackageInfo _packageInfo;

  FutureOr<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  String get appName => _packageInfo.appName;

  String get packageName => _packageInfo.packageName;

  String get version => _packageInfo.version;

  String get buildNumber => _packageInfo.buildNumber;

  String get buildSignature => _packageInfo.buildSignature;

  String? get installerStore => _packageInfo.installerStore;
}
