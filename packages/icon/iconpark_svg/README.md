# iconpark

来自于字节跳动的开源图标库。使用SVG图片形式呈现。

官方网站：https://iconpark.oceanengine.com

官方GitHub仓库：https://github.com/bytedance/iconpark

icons文件夹代码使用官方仓库中/packages/svg/src/icons/下的图标文件生成。

iconparks.dart使用source/icons-config.json生成

# 引用

# 使用

```Dart
/// 引用
import 'package:iconpark_svg/iconpark_svg.dart';

/// 获取图标数据
IconPark add = IconParks.add;

/// 构建图标
Widget widget = IconParks.add.build();

/// 使用指定属性构建图标
Widget widget =  IconParks.add.buildWithProps(props: const IIconProps());
```

# 转换代码java
## 依赖
```xml
<dependency>
    <groupId>com.alibaba.fastjson2</groupId>
    <artifactId>fastjson2</artifactId>
    <version>2.0.19</version>
</dependency>
<dependency>
    <groupId>commons-io</groupId>
    <artifactId>commons-io</artifactId>
    <version>2.11.0</version>
</dependency>
```
## 代码
转换代码比较拉，只追求能转成Dart代码。
```java
public class Main {
    public static void main(String[] args) {
        try {
            convertIcon();
            convertConfig();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 转换图标
     */
    public static void convertIcon() throws IOException {
        // 存放图标文件的文件夹
        String iconPath = "icons";
        URL url = ClassLoader.getSystemResource(iconPath);
        if (url == null) return;
        File file = new File(url.getFile()); // 读取文件夹
        File[] icons = file.listFiles(); // 所有图标
        if (icons == null) return;
        StringBuilder sb = new StringBuilder();
        String outputDir = "icons";
        File outputDirectory = new File(outputDir);
        // 创建文件
        if (!outputDirectory.exists()) {
            boolean result = outputDirectory.mkdir();
            if (!result) return;
        }
        for (File icon : icons) {
            String iconString = FileUtils.readFileToString(icon, "utf-8"); // 文件内容
            String fileName = icon.getName().toLowerCase().replace(".ts", ""); // 文件名
            if (fileName.equals("default_icon_configs")) continue;
            ;
            String varName = fileName;
            if (varName.equals("switch")) varName = "switch_";
            if (varName.equals("return")) varName = "return_";
            if (varName.equals("tag")) varName = "tag_";

            // 注释处理
            iconString = iconString.replace("/* tslint:disable: max-line-length */\n" +
                    "/* eslint-disable max-len */", "");
            iconString = iconString.replace("/**","");
            iconString = iconString.replace("*/","");
            iconString = iconString.replace(" *","///");

            // 引用处理
            iconString = iconString.replace("import {ISvgIconProps, IconWrapper} from '../runtime';", "import '../runtime.dart';");

            // 方法签名处理
            iconString = iconString.replace("export default IconWrapper", "IIconWrapper " + varName + " = iconWrapper");
            iconString = iconString.replace("props: ISvgIconProps", "ISvgIconProps props");
            // 模板字符串处理
            iconString = iconString.replace("' + '","");
            iconString = iconString.replace(" + '","}");
            iconString = iconString.replace("' + ","${");
            iconString = iconString.replace("}<","'<");
            iconString = iconString.replace("));","),);");
            // 参数处理
            iconString = iconString.replace("props.strokeWidth", "props.strokeWidth.toString()");
            iconString = iconString.replace("props.strokeLinecap", "props.strokeLinecap.value");
            iconString = iconString.replace("props.strokeLinejoin", "props.strokeLinejoin.value");
            File outputFile = new File(outputDir + "/" + fileName + ".dart");
            // 创建文件
            if (!outputFile.exists()) {
                boolean result = outputFile.createNewFile();
                if (!result) return;
            }
            FileUtils.write(outputFile, iconString, "utf-8");
            sb.append("export 'icons/").append(fileName).append(".dart';\n");
        }

        File output = new File("icons.dart");
        // 创建文件
        if (!output.exists()) {
            boolean result = output.createNewFile();
            if (!result) return;
        }
        FileUtils.write(output, sb, "utf-8");
    }


    /**
     * 通过config.json文件生成Dart对象
     */
    public static void convertConfig() throws IOException {
        // 配置文件地址 resources/icons-config.json
        String configPath = "icons-config.json";
        URL url = ClassLoader.getSystemResource(configPath); // 读取配置文件
        if (url == null) return;
        JSONArray iconList = JSON.parseArray(url);
        if (null == iconList) return;
        StringBuilder constBuilder = new StringBuilder();
        /// map构造
        StringBuilder mapBuilder = new StringBuilder(
                "static Map<String,IconPark> map = {"
        );
        iconList.forEach((icon) -> {
            JSONObject jsonObject = (JSONObject) icon;
            String name = jsonObject.getString("name");
            /// 中划线转驼峰
            String camelName = camelName(name);
            String fileName = name.replace("-", "");
            // 关键字替换，重名替换
            if (camelName.equals("switch")) camelName = "switch_";
            if (camelName.equals("return")) camelName = "return_";
            if (camelName.equals("tag")) camelName = "tag_";
            if (fileName.equals("switch")) fileName = "switch_";
            if (fileName.equals("return")) fileName = "return_";
            if (fileName.equals("tag")) fileName = "tag_";
            // 类别
            String category = jsonObject.getString("category");
            String object =
                    "/// " + jsonObject.get("title") + "\n" +
                            "static IconPark " + camelName +
                            " = IconPark._(id:" + jsonObject.get("id") +
                            ",name:\"" + jsonObject.get("name") + "\"" +
                            ",title:\"" + jsonObject.get("title").toString().replace("\n", "") + "\"" +
                            ",category:\"" + category + "\"" +
                            ",categoryCN:\"" + jsonObject.get("categoryCN") + "\"" +
                            ",author:\"" + jsonObject.get("author") + "\"" +
                            ",tag:" + jsonObject.get("tag") +
                            ",rtl:" + jsonObject.get("rtl") +
                            ",iconWrapper:icons." + name.replace("-", "") +
                            ",);";
            mapBuilder.append("\"").append(name).append("\" : ").append(camelName).append(",\n");
            constBuilder.append(object).append("\n");
        });
        mapBuilder.append("};");
        File output = new File("config.dart");
        // 创建文件
        if (!output.exists()) {
            boolean result = output.createNewFile();
            if (!result) return;
        }
        constBuilder.append(mapBuilder);
        FileUtils.write(output, constBuilder, "utf-8");
    }

    public static String camelName(String name) {
        StringBuilder result = new StringBuilder();
        // 快速检查
        if (name == null || name.isEmpty()) {
            // 没必要转换
            return "";
        } else if (!name.contains("-")) {
            // 不含下划线，仅将首字母小写
            return name.substring(0, 1).toLowerCase() + name.substring(1);
        }
        // 用下划线将原始字符串分割
        String[] camels = name.split("-");
        for (String camel : camels) {
            // 跳过原始字符串中开头、结尾的下换线或双重下划线
            if (camel.isEmpty()) {
                continue;
            }
            // 处理真正的驼峰片段
            if (result.length() == 0) {
                // 第一个驼峰片段，全部字母都小写
                result.append(camel.toLowerCase());
            } else {
                // 其他的驼峰片段，首字母大写
                result.append(camel.substring(0, 1).toUpperCase());
                result.append(camel.substring(1).toLowerCase());
            }
        }
        return result.toString();
    }
}
```