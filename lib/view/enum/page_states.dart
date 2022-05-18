enum PageState { browse, edit, add }

String getPageStatesName(PageState states) {
  switch (states) {
    case PageState.browse:
      return "查看";
    case PageState.edit:
      return "编辑";
    case PageState.add:
      return "新增";
  }
}
