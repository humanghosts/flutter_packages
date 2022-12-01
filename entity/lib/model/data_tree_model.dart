import 'package:hgs_entity/entity.dart';

/// T must is a DataTreeModel
abstract class DataTreeModel<T extends DataModel> extends DataModel {
  /// 路径
  late final Attribute<String> path;
  static const String pathKey = "path";

  /// 全路径
  late final Attribute<String> fullPath;
  static const fullPathKey = "full_path";

  /// 上级
  late final Attribute<T?> parent;
  static const parentKey = "parent";

  /// 下级
  late final ListAttribute<T> children;
  static const childrenKey = "children";

  DataTreeModel({
    String? id,
    DateTime? createTime,
    bool? isDelete,
    DateTime? deleteTime,
    DateTime? timestamp,
    String? version,
  }) : super(
          id: id,
          createTime: createTime,
          isDelete: isDelete,
          deleteTime: deleteTime,
          timestamp: timestamp,
          version: version,
        ) {
    path = attributes.string(name: pathKey, title: "路径", dvalue: PathUtil.genPath(length: pathLength));
    fullPath = attributes.string(name: fullPathKey, title: "绝对路径", dvalue: path.value);
    parent = attributes.dataModelNullable<T?>(name: parentKey, title: "上级");
    children = attributes.dataModelList<T>(name: childrenKey, title: "下级");
  }

  int get pathLength => 4;

  /// 克隆的缓存，防止parent和children克隆的时候循环
  static final Map<String, DataTreeModel> cloneCache = {};

  @override
  DataTreeModel clone({Map<String, AttributeCloneHandler>? attributeHandler, Model? newModel, bool isRoot = true}) {
    if (isRoot) cloneCache.clear();
    DataTreeModel cloneModel = (newModel as DataTreeModel?) ?? ConstructorCache.get(runtimeType);
    cloneModel.state = state;
    String id = this.id.value;
    cloneCache[id] = cloneModel;
    Map<String, AttributeCloneHandler> allHandler = {
      parent.name: parentCloneHandler,
      children.name: childrenCloneHandler,
    };
    if (null != attributeHandler) allHandler.addAll(attributeHandler);
    return super.clone(attributeHandler: allHandler, newModel: cloneModel) as DataTreeModel;
  }

  /// 父事件拷贝处理器
  void parentCloneHandler(Attribute attribute, Attribute newAttribute) {
    if (attribute.isNull) return;
    T parentModel = attribute.value as T;
    String parentId = parentModel.id.value;
    if (cloneCache.containsKey(parentId)) {
      newAttribute.value = cloneCache[parentId];
    } else {
      newAttribute.value = (parentModel as DataTreeModel).clone(isRoot: false);
    }
  }

  /// 子事件拷贝处理器
  void childrenCloneHandler(Attribute attribute, Attribute newAttribute) {
    if (attribute.isNull) return;
    List<T> children = this.children.value;
    List<T> cloneChildren = children.map((e) {
      String childId = e.id.value;
      if (cloneCache.containsKey(childId)) {
        return cloneCache[childId] as T;
      } else {
        return (e as DataTreeModel).clone(isRoot: false) as T;
      }
    }).toList();
    newAttribute.value = cloneChildren;
  }
}

/// 实现了部分功能的DataTreeModel
abstract class AdvancedDataTreeModel<T extends DataTreeModel> extends DataTreeModel<T> {
  final Map<String, T> childrenMap = {};

  /// 监听器key
  static const listenerKey = "data_tree_model";

  AdvancedDataTreeModel({
    String? id,
    DateTime? createTime,
    bool? isDelete,
    DateTime? deleteTime,
    DateTime? timestamp,
    String? version,
  }) : super(
          id: id,
          createTime: createTime,
          isDelete: isDelete,
          deleteTime: deleteTime,
          timestamp: timestamp,
          version: version,
        ) {
    parent.addAttributeListener(listenerKey, AttributeListener(beforeSetValue: beforeSetParent, afterSetValue: afterSetParent));
    children.addAttributeListener(
      listenerKey,
      ListAttributeListener(
        beforeAddValue: beforeAddChild,
        afterAddValue: afterAddChild,
        beforeSetValue: beforeSetChildren,
        beforeRemoveValue: beforeRemoveChild,
        afterRemoveValue: afterRemoveChild,
        beforeSetIndexValue: beforeAddChild,
        afterSetIndexValue: afterAddChild,
      ),
    );
  }

  T? getChild(String? id) {
    return childrenMap[id];
  }

  String get fullPathDivider => "|";

  /// 处理设置parent前 数据合法性校验，以及清空原本上级的中的自己
  bool beforeSetParent(T? parentValue) {
    // 处理重复设置Parent情况(两个都为null的情况也包含在内)
    if (parent.value == parentValue) {
      return false;
    }
    // 处理有一个为null的情况
    DataTreeModel? thisParentValue = parent.value;
    if (parentValue == null || thisParentValue == null) {
      // parentValue==null thisParenValue!=null
      // 清空parent
      if (thisParentValue != null) {
        // 清空上级的下级
        thisParentValue.children.remove(this);
      }
      // 另一种情况不用处理
      return true;
    }
    // 两个对象不等，但是id相等，可以设置，替换对象就可以了
    if (parentValue.id.value == thisParentValue.id.value) {
      return true;
    }
    String parentPath = (parentValue).path.value;
    // 判断是否是否循环树
    bool isLoop = fullPath.value.contains(parentPath);
    if (isLoop) {
      throw Exception("树发生了循环，请检查树结构");
    }
    return true;
  }

  /// 设置上级之后设置绝对路径
  void afterSetParent(T? parentValue) {
    if (parentValue == null) {
      fullPath.value = path.value;
    } else {
      fullPath.value = "${parentValue.fullPath.value}$fullPathDivider${path.value}";
      parentValue.children.add(this);
    }
    // 如果当前节点有子节点
    updateChildFullPath(this);
  }

  /// 更新子节点的fullPath
  void updateChildFullPath(DataTreeModel current) {
    List children = current.children.value;
    if (children.isEmpty) {
      return;
    }
    for (int i = 0; i < children.length; i++) {
      DataTreeModel child = children[i] as DataTreeModel;
      child.fullPath.value = "${current.fullPath.value}$fullPathDivider${child.path.value}";
      updateChildFullPath(child);
    }
  }

  bool beforeAddChild(int index, T child) {
    if (childrenMap.containsKey(child.id.value)) {
      return false;
    }
    // 这里会出发一次child的setParent，在beforeSetParent里面会进行校验
    // 在afterSetParent中会再次回到这里，然后再次进去beforeSetParent，然后判断上级一样，结束循环
    child.parent.value = this;
    // 再次判断，因为这个代码会走两次，防止重复添加
    if (childrenMap.containsKey(child.id.value)) {
      return false;
    }
    return true;
  }

  void afterAddChild(int index, T child) {
    childrenMap[child.id.value] = child;
  }

  bool beforeSetChildren(List<T> children) {
    this.children.addAll(children);
    return false;
  }

  bool beforeRemoveChild(int index, T child) {
    if (!childrenMap.containsKey(child.id.value)) {
      return false;
    }
    return true;
  }

  void afterRemoveChild(int index, T child) {
    childrenMap.remove(child.id.value);
    // 这里会出发一次child的setParent，在beforeSetParent里面会进行校验
    // 会再次回到beforeRemoveChild,判断map里面已经没有了，就会结束循环
    child.parent.value = null;
  }
}
