自己开发的一些Flutter相关的包。
License如果不特别标注，都是MIT。

接下来要做的事情是把framework里面的包都拆出去。

/framework 是用于快速开发的框架，支持全平台
/icon 各种开源图标包，支持全平台，目前包括iconpark_svg，iconpark_ttf(失败了，转出来的ttf没有细节)
/theme 基于flex_color_scheme的可定制主题，支持全平台
/entity 是实体支持包，非代码生成，支持全平台，可集成GetX使用简化代码
/database 数据库支持和ORM，支持全平台，目前只有sembast支持
/notification 本地提醒，支持全平台。
