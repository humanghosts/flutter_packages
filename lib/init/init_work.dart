import '../ability/work/foreground.dart';

Future<void> initWork() async {
  // 暂时不需要
  // await BackgroundWorkHelper.init();
  await ForegroundWorkHelper.init();
}
