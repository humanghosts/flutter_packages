# iconpark

来自于字节跳动的开源图标库。使用SVG图片形式呈现。

官方网站：https://iconpark.oceanengine.com

官方GitHub仓库：https://github.com/bytedance/iconpark

资源文件夹source直接拷贝自官方仓库的同名文件夹。

iconpark.dart使用source/icons-config.json生成

# 使用

```Dart
/// 获取图标数据
IconPark.add;

/// 构建图标
IconPark.add.build();
```


# 转换代码

## icons-config.json转IconPark对象
```java
public class Converter{
    /**
     * 通过config.json文件生成Dart对象
     */
    public static void convert() throws IOException {
        // 配置文件地址 resources/icons-config.json
        String configPath = "icons-config.json";
        URL url = ClassLoader.getSystemResource(configPath); // 读取配置文件
        if (url == null) return;
        JSONArray iconList = JSON.parseArray(url);
        if (null == iconList) return;
        /// map构造
        StringBuilder mapBuilder = new StringBuilder(
                "static const Map<String,IconPark> map = {"
        );
        /// category
        Set<String> categorySet = new TreeSet<>();
        iconList.forEach((icon) -> {
            JSONObject jsonObject = (JSONObject) icon;
            String name = jsonObject.getString("name");
            /// 中划线转驼峰
            String camelName = camelName(name);
            // 关键字替换，重名替换
            if (camelName.equals("switch")) camelName = "switch_";
            if (camelName.equals("return")) camelName = "return_";
            if (camelName.equals("tag")) camelName = "tag_";
            // 类别
            String category = jsonObject.getString("category");
            String object =
                    "/// " + jsonObject.get("title") + "\n" +
                            "static const IconPark " + camelName +
                            " = IconPark._(id:" + jsonObject.get("id") +
                            ",name:\"" + jsonObject.get("name") + "\"" +
                            ",title:\"" + jsonObject.get("title").toString().replace("\n", "") + "\"" +
                            ",category:\"" + category + "\"" +
                            ",categoryCN:\"" + jsonObject.get("categoryCN") + "\"" +
                            ",author:\"" + jsonObject.get("author") + "\"" +
                            ",tag:" + jsonObject.get("tag") +
                            ",rtl:" + jsonObject.get("rtl") +
                            ",);";
            mapBuilder.append("\"").append(name).append("\" : ").append(camelName).append(",\n");
            System.out.println(object);
            categorySet.add(category);
        });
        mapBuilder.append("};");
        // 输出map对象
        System.out.println(mapBuilder);
        // 输出assets路径
        categorySet.forEach(category->System.out.println("- lib/source/"+category+"/"));
    }
}
```