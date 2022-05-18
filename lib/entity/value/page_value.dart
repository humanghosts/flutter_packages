import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/view/page/home_pages.dart';

class PageValue extends CustomValue {
  HomePages? page;

  PageValue({this.page});

  @override
  CustomValue clone() {
    return PageValue(page: page);
  }

  @override
  Future<CustomValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (null == value) {
      page == null;
    } else {
      page = HomePages.map[value.toString()];
    }
    return this;
  }

  @override
  bool get isNull => page == null;

  @override
  CustomValue merge(CustomValue value) {
    if (value is! PageValue) return this;
    page = value.page;
    return this;
  }

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    if (isNull) return null;
    return page!.toMap();
  }
}
