# 添加实体方法

1. 在entity文件夹下选择合适的文件夹添加

> /entity/config 文件下存放页面配置实体  
> /entity/data 文件下存放普通数据实体  
> /entity/enum 文件下存放枚举类  
> /entity/value 文件下存放继承自custom_value的自定义值类型

2. 按照不同需要决定要继承的类

> 需要id的数据类型，每个id存储一个数据继承DataModel。如果是需要上下级的树形数据继承DataTreeModel，如果需要自动对上下级处理，继承AdvancedDataTreeModel  
> 如果是普通的类型数据，不需要id，只需要将一个实体存到数据库中，继承SimpleModel，这种类型的数据不具有id，存储的时候会覆盖原有数据  
> 如果要自定义值类型，继承CustomValue类
> 如果是枚举类型，因为都是静态属性，需要全手动编写

3. 使用`late final Attribute<需要的类型>`列出实体字段，如果是列表类型属性使用`ListAttribute`更好

4. 再构造方法中使用父类提供的`attributes`属性为实体字段初始化，代码示例如下:

```dart
class A extends DataModel {
  late final Attribute<String> a;

  A() {
    a = attributes.string();
  }
}
```

5. 在/entity/entities.dart下注册新增实体的构造方法，示例如下:

```dart
Map<Type, Object Function([Map<String, dynamic>? args])> getEntitiesMap() {
  return {
    A: ([Map<String, dynamic>? args]) => A(),
  };
}
```

其中key为实体类类型，value为提供map参数返回实体的构造方法

6. 在/entity/daos.dart下注册新增实体的dao类，示例如下：

```dart
Map<Type, Dao> getDaoMap() {
  return {
    A: SembastSimpleDao<OriginEvent>(),
  };
}
```

其中key是实体类类型，value是Dao，目前数据库使用的是Sembast,所有使用SembastDao即可

7. 需要添加Service类的要到/service下添加服务类，具体操作查看/service/info.md