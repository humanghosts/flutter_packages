添加新主题类型的操作:  
1. 新建文件，新建类继承ThemeTemplateData实现方法，添加fromMap(Map<String,Object?>)构造方法
2. 在entities文件中注册构造方法，
3. ThemeType类中添加新的枚举类型
4. 在main.dart中buildWithTheme方法下添加主题类型分支判断及构建方法