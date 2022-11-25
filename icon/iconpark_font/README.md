# iconpark_font

iconpark图标以font图标呈现。

转出来的效果不太行，不能用，就先在这里放着吧。

# 使用

# 生成ttf

生成过程是svg装svgfont再转ttf。
不是专业前端，代码可能有点拉。

## svg转svgfont
1. 引入依赖 
   ```shell
   npm i svgicons2svgfont
   ```
2. 拷贝图标文件  
   将官方仓库中的source目录拷贝到工程下，将icons-config.json修改为icons-config.js并导出，拷贝到工程下。

3. 修改`svgicons2svgfont`包源码   
   由于IconPark图标下有部分图标`<circle>`标签中没有cx和cy导致无法转换为svgfont(比如说add-web这个图标)。需要修改转换代码，赋默认值。  
   直接修改node_modules/svgicons2svgfont/src/svgshapes2svgpath.js  
   修改后的代码如下所示：
   ```javascript
    function svgShapesToPathCircleToPath(attributes) {
        const cx = parseFloat(attributes.cx||'0');
        const cy = parseFloat(attributes.cy||'0');
        const rx =
            'undefined' !== typeof attributes.rx
            ? parseFloat(attributes.rx'0')
            : parseFloat(attributes.r||'0');
        const ry =
            'undefined' !== typeof attributes.ry
            ? parseFloat(attributes.ry||'0')
            : parseFloat(attributes.r||'0');

        // ... 忽略其他代码
    }
   ```
4. 编写转换代码
   ```javascript
    // 引入 svgicons2svgfont
    const SVGIcons2SVGFontStream = require('svgicons2svgfont');
    const fs = require('fs');

    // 将官网的icons-config.json修改为js文件并导出 用于解析svg图标
    const config = require('./icons-config.js');

    // 创建字体 设置字体名称
    const fontStream = new SVGIcons2SVGFontStream({
        fontName: 'IconPark',
        normalize: true,
    });

    // 导出设置
    fontStream
        .pipe(fs.createWriteStream('target/iconpark.svg')) // 导出文件
        .on('finish', () => console.log("字体成功创建")) // 成功提示
        .on('error', (err) => console.error(`字体创建失败${err}`)) //失败提示

    // unicode启始编号
    let unicodeStart = 10000;

    // 遍历设置 添加图标
    for (const item of config.config) {
        // 取值
        let { id, title, name, category, categoryCN, author, tag, rtl } = item;
        let iconPath = `source/${category}/${name}.svg`; // 图标路径
        let unicode = unicodeStart + id; // 图标unicode值
        let icon = fs.createReadStream(iconPath); // 读取图标
        // 设置图标unicode值和名称
        icon.metadata = {
            unicode:[String.fromCharCode(unicode)],
            name,
        };
        fontStream.write(icon); // 输出图标
    }

    fontStream.end();
   ```
## svgfont转ttf

1. 添加依赖
   ```shell
   npm i svg2ttf
   ```
2. 编写转换代码
   ```javascript
    const fs = require('fs');
    const svg2ttf = require('svg2ttf');

    let ttf = svg2ttf(fs.readFileSync('target/iconpark.svg','utf-8'),{});
    fs.writeFileSync('target/iconpark.ttf',Buffer.from(ttf.buffer));
   ```
# 生成Dart类
代码可能有点拉。
```javascript
const fs = require('fs');
const config = require('./icons-config.js');

let unicodeStart = 10000;

let constCode = "";

for (const item of config.config) {
    constCode+=`${getDartConst(item)}\n`;
}

let classCode = `
import "iconpark_font.dart";

class IconParks{
    IconParks._();

    static const String fontFamily = "IconPark";
    static const String fontPackage = "iconpark_font";

${constCode}
}
`;

fs.writeFileSync('target/iconparks.dart',classCode);

function getDartConst(item){
    let { id, title, name, category, categoryCN, author, tag, rtl } = item;
    let unicode = unicodeStart + id; // 图标unicode值
    let camel = camelName(name);
    let tagStr = tag.join('","')
    if(tagStr.length>0){
        tagStr = `"${tagStr}"`;
    }
    if(camel == 'return')camel = 'return_';
    if(camel == 'switch')camel = 'switch_';
    if(camel == 'tag')camel = 'tag_';
  
    return`
    /// ${title}
    static IconPark ${camel} = const IconPark(
        id: ${id},
        name: "${name}",
        title: "${title.replace('\n','')}",
        category: "${category}",
        categoryCN: "${categoryCN}",
        author: "${author}",
        tag: [${tagStr}],
        rtl: ${rtl},
        fontFamily: fontFamily,
        fontPackage: fontPackage,
        codePoint: ${unicode},
    );`
}

// 转换为驼峰命名
function camelName(name){
    var a = name.split("-");
    var o = a[0];
    for(var i=1;i<a.length;i++){
        o = o + a[i].slice(0,1).toUpperCase() + a[i].slice(1);
    }
    return o;
}
```