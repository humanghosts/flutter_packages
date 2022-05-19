/// 页面状态
enum PageState { browse, edit, add, delete }

/// 页面状态扩展
extension PageStateTitleAble on PageState {
  /// 获取页面名称
  String get title {
    switch (this) {
      case PageState.browse:
        return "查看";
      case PageState.edit:
        return "编辑";
      case PageState.add:
        return "新增";
      case PageState.delete:
        return "删除";
    }
  }
}
