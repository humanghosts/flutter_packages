import 'package:icon/icon.dart';

/// 字节跳动IconPark图标 svg类型，官网：https://iconpark.oceanengine.com/official
class IconPark extends SvgIconEnum<SvgIcon> {
  /// id
  final int id;

  /// 中文名称
  final String title;

  /// 类别，对应Source下的文件夹
  final String category;

  /// 类别中文名称
  final String categoryCN;

  /// 图标作者
  final String author;

  /// 图标标签
  final List<String> tag;

  final bool rtl;

  const IconPark._({
    required this.id,
    required super.name,
    required this.title,
    required this.category,
    required this.categoryCN,
    required this.author,
    required this.tag,
    required this.rtl,
  });

  /// 资源文件路径
  @override
  String get path => "packages/iconpark/source/$category/$name.svg";

  /// 拐杖
  static const IconPark aCane = IconPark._(
    id: 0,
    name: "a-cane",
    title: "拐杖",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["工具", "登山杖", "拐杖", "木棍"],
    rtl: true,
  );

  /// 腹部
  static const IconPark abdominal = IconPark._(
    id: 1,
    name: "abdominal",
    title: "腹部",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["肚子", "腹", "腰"],
    rtl: false,
  );

  /// 异常
  static const IconPark abnormal = IconPark._(
    id: 2,
    name: "abnormal",
    title: "异常",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["报错", "提示", "提醒"],
    rtl: true,
  );

  /// 飞机加速
  static const IconPark acceleration = IconPark._(
    id: 3,
    name: "acceleration",
    title: "飞机加速",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["加速", "加速度", "超音速", "快速", "飞行气流"],
    rtl: true,
  );

  /// 接受邮件
  static const IconPark acceptEmail = IconPark._(
    id: 4,
    name: "accept-email",
    title: "接受邮件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "收件箱", "转发邮件", "回复邮件"],
    rtl: true,
  );

  /// 声波
  static const IconPark acoustic = IconPark._(
    id: 5,
    name: "acoustic",
    title: "声波",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["音频", "音量", "语音", "录音", "波纹", "声音"],
    rtl: false,
  );

  /// 活动源
  static const IconPark activitySource = IconPark._(
    id: 6,
    name: "activity-source",
    title: "活动源",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据库", "数据源", "活动源"],
    rtl: true,
  );

  /// 广告
  static const IconPark ad = IconPark._(
    id: 7,
    name: "ad",
    title: "广告",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["广告符号", "标志"],
    rtl: true,
  );

  /// 广告产品
  static const IconPark adProduct = IconPark._(
    id: 8,
    name: "ad-product",
    title: "广告产品",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "常留留",
    tag: ["广告产品", "抽象", "盒子", "箱子", "立体"],
    rtl: true,
  );

  /// 添加
  static const IconPark add = IconPark._(
    id: 9,
    name: "add",
    title: "添加",
    category: "Character",
    categoryCN: "符号标识",
    author: "常留留",
    tag: ["新建", "增加", "创建"],
    rtl: false,
  );

  /// 计算机添加
  static const IconPark addComputer = IconPark._(
    id: 10,
    name: "add-computer",
    title: "计算机添加",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 添加
  static const IconPark addFour = IconPark._(
    id: 11,
    name: "add-four",
    title: "添加",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["聚焦", "精准", "扫描", "识别", "添加"],
    rtl: false,
  );

  /// 添加同级条目
  static const IconPark addItem = IconPark._(
    id: 12,
    name: "add-item",
    title: "添加同级条目",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["添加同级条目", "拖拽", "复制"],
    rtl: true,
  );

  /// 增加模式
  static const IconPark addMode = IconPark._(
    id: 13,
    name: "add-mode",
    title: "增加模式",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["模式", "亮度", "对比度", "增加"],
    rtl: true,
  );

  /// 添加音乐
  static const IconPark addMusic = IconPark._(
    id: 14,
    name: "add-music",
    title: "添加音乐",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["播放", "音乐", "添加"],
    rtl: true,
  );

  /// 添加
  static const IconPark addOne = IconPark._(
    id: 15,
    name: "add-one",
    title: "添加",
    category: "Character",
    categoryCN: "符号标识",
    author: "常留留",
    tag: ["新建", "增加", "创建"],
    rtl: false,
  );

  /// 增加图片
  static const IconPark addPic = IconPark._(
    id: 16,
    name: "add-pic",
    title: "增加图片",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["添加", "图片", "相册"],
    rtl: true,
  );

  /// 图片添加
  static const IconPark addPicture = IconPark._(
    id: 17,
    name: "add-picture",
    title: "图片添加",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 加印
  static const IconPark addPrint = IconPark._(
    id: 18,
    name: "add-print",
    title: "加印",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["印记", "印章", "打印", "印刷"],
    rtl: false,
  );

  /// 添加子条目
  static const IconPark addSubset = IconPark._(
    id: 19,
    name: "add-subset",
    title: "添加子条目",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["添加子条目", "创建"],
    rtl: true,
  );

  /// 加减
  static const IconPark addSubtract = IconPark._(
    id: 20,
    name: "add-subtract",
    title: "加减",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["算数", "计算"],
    rtl: true,
  );

  /// 文字大小
  static const IconPark addText = IconPark._(
    id: 21,
    name: "add-text",
    title: "文字大小",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["编辑", "书写", "文案", "文字大小"],
    rtl: true,
  );

  /// 文字
  static const IconPark addTextTwo = IconPark._(
    id: 22,
    name: "add-text-two",
    title: "文字",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["文字", "编辑", "书写", "文案"],
    rtl: true,
  );

  /// 添加
  static const IconPark addThree = IconPark._(
    id: 23,
    name: "add-three",
    title: "添加",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["聚焦", "精准", "扫描", "识别", "添加"],
    rtl: false,
  );

  /// 添加2
  static const IconPark addTwo = IconPark._(
    id: 24,
    name: "add-two",
    title: "添加2",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 添加用户
  static const IconPark addUser = IconPark._(
    id: 25,
    name: "add-user",
    title: "添加用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["添加", "增加", "人群扩充", "用户", "个人中心", "我的", "人"],
    rtl: false,
  );

  /// 添加网页
  static const IconPark addWeb = IconPark._(
    id: 26,
    name: "add-web",
    title: "添加网页",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 通讯录
  static const IconPark addressBook = IconPark._(
    id: 27,
    name: "address-book",
    title: "通讯录",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["通讯录", "联系人"],
    rtl: true,
  );

  /// 相邻条目
  static const IconPark adjacentItem = IconPark._(
    id: 28,
    name: "adjacent-item",
    title: "相邻条目",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["相邻条目", "链接", "排序"],
    rtl: true,
  );

  /// 加减调整
  static const IconPark adjustment = IconPark._(
    id: 29,
    name: "adjustment",
    title: "加减调整",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["加减调整", "计算"],
    rtl: true,
  );

  /// adobe-illustrate
  static const IconPark adobeIllustrate = IconPark._(
    id: 30,
    name: "adobe-illustrate",
    title: "adobe-illustrate",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["软件", "应用", "工具", "设计", "logo", "ai"],
    rtl: true,
  );

  /// adobe-indesign
  static const IconPark adobeIndesign = IconPark._(
    id: 31,
    name: "adobe-indesign",
    title: "adobe-indesign",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["软件", "应用", "工具", "设计", "logo", "id"],
    rtl: true,
  );

  /// adobe-lightroom
  static const IconPark adobeLightroom = IconPark._(
    id: 32,
    name: "adobe-lightroom",
    title: "adobe-lightroom",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["软件", "应用", "工具", "设计", "logo", "lr"],
    rtl: true,
  );

  /// adobe-photoshop
  static const IconPark adobePhotoshop = IconPark._(
    id: 33,
    name: "adobe-photoshop",
    title: "adobe-photoshop",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["软件", "应用", "工具", "设计", "logo", "ps"],
    rtl: true,
  );

  /// 传入
  static const IconPark afferent = IconPark._(
    id: 34,
    name: "afferent",
    title: "传入",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["传送", "传输", "向左", "箭头"],
    rtl: true,
  );

  /// 传入4
  static const IconPark afferentFour = IconPark._(
    id: 35,
    name: "afferent-four",
    title: "传入4",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 传入3
  static const IconPark afferentThree = IconPark._(
    id: 36,
    name: "afferent-three",
    title: "传入3",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 传入
  static const IconPark afferentTwo = IconPark._(
    id: 37,
    name: "afferent-two",
    title: "传入",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["传送", "传输", "向左", "箭头"],
    rtl: true,
  );

  /// 发簪
  static const IconPark afroPick = IconPark._(
    id: 38,
    name: "afro-pick",
    title: "发簪",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "",
    tag: ["发箍", "发夹", "发簪"],
    rtl: true,
  );

  /// 协议
  static const IconPark agreement = IconPark._(
    id: 39,
    name: "agreement",
    title: "协议",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["文档", "规则", "详情", "文章", "短文", "合同"],
    rtl: true,
  );

  /// 瞄准
  static const IconPark aiming = IconPark._(
    id: 40,
    name: "aiming",
    title: "瞄准",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["瞄准", "聚焦", "关注", "锁定", "定位"],
    rtl: false,
  );

  /// 空气自行车
  static const IconPark airBike = IconPark._(
    id: 41,
    name: "air-bike",
    title: "空气自行车",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 空调
  static const IconPark airConditioning = IconPark._(
    id: 42,
    name: "air-conditioning",
    title: "空调",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["电空调", "家电", "温度", "过滤器", "制暖", "制冷", "换气"],
    rtl: true,
  );

  /// 飞机
  static const IconPark airplane = IconPark._(
    id: 43,
    name: "airplane",
    title: "飞机",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 飞机窗口
  static const IconPark airplaneWindow = IconPark._(
    id: 44,
    name: "airplane-window",
    title: "飞机窗口",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["靠窗", "靠边", "座椅", "窗口", "窗户", "窗外"],
    rtl: true,
  );

  /// 飞机窗口
  static const IconPark airplaneWindowOne = IconPark._(
    id: 45,
    name: "airplane-window-one",
    title: "飞机窗口",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["靠窗", "靠边", "座椅", "窗口"],
    rtl: true,
  );

  /// AirPlay
  static const IconPark airplay = IconPark._(
    id: 46,
    name: "airplay",
    title: "AirPlay",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["屏幕映像", "无线投屏", "电脑", "显示器"],
    rtl: true,
  );

  /// AirPods
  static const IconPark airpods = IconPark._(
    id: 47,
    name: "airpods",
    title: "AirPods",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["蓝牙耳机", "苹果耳机", "耳机", "无线耳机"],
    rtl: false,
  );

  /// 警报
  static const IconPark alarm = IconPark._(
    id: 48,
    name: "alarm",
    title: "警报",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "刘心乐",
    tag: ["警灯", "警报", "灯", "警示", "灵感", "提示"],
    rtl: true,
  );

  /// 闹钟
  static const IconPark alarmClock = IconPark._(
    id: 49,
    name: "alarm-clock",
    title: "闹钟",
    category: "Time",
    categoryCN: "时间日期",
    author: "常留留",
    tag: ["倒计时", "闹钟", "时间"],
    rtl: true,
  );

  /// 底对齐
  static const IconPark alignBottom = IconPark._(
    id: 50,
    name: "align-bottom",
    title: "底对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["底对齐", "下对齐"],
    rtl: true,
  );

  /// 下对齐2
  static const IconPark alignBottomTwo = IconPark._(
    id: 51,
    name: "align-bottom-two",
    title: "下对齐2",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["底对齐", "排版方式"],
    rtl: true,
  );

  /// 水平居中对齐2
  static const IconPark alignHorizontalCenterTwo = IconPark._(
    id: 52,
    name: "align-horizontal-center-two",
    title: "水平居中对齐2",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["居中对齐", "排版方式", "横向居中"],
    rtl: true,
  );

  /// 水平对齐
  static const IconPark alignHorizontally = IconPark._(
    id: 53,
    name: "align-horizontally",
    title: "水平对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["左右居中对齐", "中间对齐"],
    rtl: false,
  );

  /// 左对齐
  static const IconPark alignLeft = IconPark._(
    id: 54,
    name: "align-left",
    title: "左对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["左对齐"],
    rtl: true,
  );

  /// 文字左对齐
  static const IconPark alignLeftOne = IconPark._(
    id: 55,
    name: "align-left-one",
    title: "文字左对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["文字", "左对其", "编辑", "排版"],
    rtl: true,
  );

  /// 左对齐2
  static const IconPark alignLeftTwo = IconPark._(
    id: 56,
    name: "align-left-two",
    title: "左对齐2",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["左对齐", "排版方式"],
    rtl: true,
  );

  /// 右对齐
  static const IconPark alignRight = IconPark._(
    id: 57,
    name: "align-right",
    title: "右对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["右对齐"],
    rtl: true,
  );

  /// 文字右对齐
  static const IconPark alignRightOne = IconPark._(
    id: 58,
    name: "align-right-one",
    title: "文字右对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["文字", "右对其", "编辑", "排版"],
    rtl: true,
  );

  /// 右对齐2
  static const IconPark alignRightTwo = IconPark._(
    id: 59,
    name: "align-right-two",
    title: "右对齐2",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["右对齐", "排版方式"],
    rtl: true,
  );

  /// 文字两边对齐
  static const IconPark alignTextBoth = IconPark._(
    id: 60,
    name: "align-text-both",
    title: "文字两边对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["两端对齐", "文字对齐"],
    rtl: false,
  );

  /// 文字两边对齐1
  static const IconPark alignTextBothOne = IconPark._(
    id: 61,
    name: "align-text-both-one",
    title: "文字两边对齐1",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["文字对齐", "左右对齐", "两边对齐"],
    rtl: false,
  );

  /// 文字底对齐
  static const IconPark alignTextBottom = IconPark._(
    id: 62,
    name: "align-text-bottom",
    title: "文字底对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["文字底对齐"],
    rtl: false,
  );

  /// 文字底对齐1
  static const IconPark alignTextBottomOne = IconPark._(
    id: 63,
    name: "align-text-bottom-one",
    title: "文字底对齐1",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["文字对齐", "左底对齐"],
    rtl: true,
  );

  /// 文字居中
  static const IconPark alignTextCenter = IconPark._(
    id: 64,
    name: "align-text-center",
    title: "文字居中",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["居中对齐", "文字对齐"],
    rtl: true,
  );

  /// 文字居中1
  static const IconPark alignTextCenterOne = IconPark._(
    id: 65,
    name: "align-text-center-one",
    title: "文字居中1",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["文字对齐", "中对齐"],
    rtl: false,
  );

  /// 文字居左
  static const IconPark alignTextLeft = IconPark._(
    id: 66,
    name: "align-text-left",
    title: "文字居左",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["左对齐", "文字对齐"],
    rtl: true,
  );

  /// 文字居左1
  static const IconPark alignTextLeftOne = IconPark._(
    id: 67,
    name: "align-text-left-one",
    title: "文字居左1",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["文字对齐", "左对齐"],
    rtl: true,
  );

  /// 文字中间对齐
  static const IconPark alignTextMiddle = IconPark._(
    id: 68,
    name: "align-text-middle",
    title: "文字中间对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["居中对齐", "居中", "聚集"],
    rtl: false,
  );

  /// 文字中间对齐1
  static const IconPark alignTextMiddleOne = IconPark._(
    id: 69,
    name: "align-text-middle-one",
    title: "文字中间对齐1",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["文字对齐", "左居中对齐"],
    rtl: true,
  );

  /// 文字居右
  static const IconPark alignTextRight = IconPark._(
    id: 70,
    name: "align-text-right",
    title: "文字居右",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["右对齐", "文字对齐"],
    rtl: true,
  );

  /// 文字居右1
  static const IconPark alignTextRightOne = IconPark._(
    id: 71,
    name: "align-text-right-one",
    title: "文字居右1",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["文字对齐", "右对齐"],
    rtl: true,
  );

  /// 文字顶对齐
  static const IconPark alignTextTop = IconPark._(
    id: 72,
    name: "align-text-top",
    title: "文字顶对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["文字顶对齐"],
    rtl: false,
  );

  /// 文字顶对齐1
  static const IconPark alignTextTopOne = IconPark._(
    id: 73,
    name: "align-text-top-one",
    title: "文字顶对齐1",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["文字对齐", "左顶对齐"],
    rtl: true,
  );

  /// 顶对齐
  static const IconPark alignTop = IconPark._(
    id: 74,
    name: "align-top",
    title: "顶对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["顶部对齐", "上对齐"],
    rtl: true,
  );

  /// 上对齐2
  static const IconPark alignTopTwo = IconPark._(
    id: 75,
    name: "align-top-two",
    title: "上对齐2",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["顶对齐", "上对齐", "排版方式", "纵向居中"],
    rtl: true,
  );

  /// 垂直居中对齐2
  static const IconPark alignVerticalCenterTwo = IconPark._(
    id: 76,
    name: "align-vertical-center-two",
    title: "垂直居中对齐2",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["居中对齐", "排版方式", "纵向居中"],
    rtl: true,
  );

  /// 垂直对齐
  static const IconPark alignVertically = IconPark._(
    id: 77,
    name: "align-vertically",
    title: "垂直对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["中间随其", "上下居中对齐"],
    rtl: true,
  );

  /// 底部中心对齐
  static const IconPark alignmentBottomCenter = IconPark._(
    id: 78,
    name: "alignment-bottom-center",
    title: "底部中心对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["底部中心对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 底部左对齐
  static const IconPark alignmentBottomLeft = IconPark._(
    id: 79,
    name: "alignment-bottom-left",
    title: "底部左对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["底部左对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 底部右对齐
  static const IconPark alignmentBottomRight = IconPark._(
    id: 80,
    name: "alignment-bottom-right",
    title: "底部右对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["底部右对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 水平下对齐
  static const IconPark alignmentHorizontalBottom = IconPark._(
    id: 81,
    name: "alignment-horizontal-bottom",
    title: "水平下对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["水平下对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 水平居中对齐
  static const IconPark alignmentHorizontalCenter = IconPark._(
    id: 82,
    name: "alignment-horizontal-center",
    title: "水平居中对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["水平居中对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 水平上对齐
  static const IconPark alignmentHorizontalTop = IconPark._(
    id: 83,
    name: "alignment-horizontal-top",
    title: "水平上对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["水平上对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 左侧下对齐
  static const IconPark alignmentLeftBottom = IconPark._(
    id: 84,
    name: "alignment-left-bottom",
    title: "左侧下对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["左侧下对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 左侧居中对齐
  static const IconPark alignmentLeftCenter = IconPark._(
    id: 85,
    name: "alignment-left-center",
    title: "左侧居中对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["左侧居中对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 左侧上对齐
  static const IconPark alignmentLeftTop = IconPark._(
    id: 86,
    name: "alignment-left-top",
    title: "左侧上对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["左侧上对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 右侧下对齐
  static const IconPark alignmentRightBottom = IconPark._(
    id: 87,
    name: "alignment-right-bottom",
    title: "右侧下对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["右侧下对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 右侧居中对齐
  static const IconPark alignmentRightCenter = IconPark._(
    id: 88,
    name: "alignment-right-center",
    title: "右侧居中对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["右侧居中对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 右侧上对齐
  static const IconPark alignmentRightTop = IconPark._(
    id: 89,
    name: "alignment-right-top",
    title: "右侧上对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["右侧上对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 顶部居中对齐
  static const IconPark alignmentTopCenter = IconPark._(
    id: 90,
    name: "alignment-top-center",
    title: "顶部居中对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["顶部居中对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 顶部左对齐
  static const IconPark alignmentTopLeft = IconPark._(
    id: 91,
    name: "alignment-top-left",
    title: "顶部左对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["顶部左对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 顶部右对齐
  static const IconPark alignmentTopRight = IconPark._(
    id: 92,
    name: "alignment-top-right",
    title: "顶部右对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["顶部右对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 垂直居中对齐
  static const IconPark alignmentVerticalCenter = IconPark._(
    id: 93,
    name: "alignment-vertical-center",
    title: "垂直居中对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["垂直居中对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 垂直左对齐
  static const IconPark alignmentVerticalLeft = IconPark._(
    id: 94,
    name: "alignment-vertical-left",
    title: "垂直左对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["垂直左对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 垂直右对齐
  static const IconPark alignmentVerticalRight = IconPark._(
    id: 95,
    name: "alignment-vertical-right",
    title: "垂直右对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["垂直右对齐", "排版方式", "布局"],
    rtl: true,
  );

  /// 支付宝
  static const IconPark alipay = IconPark._(
    id: 96,
    name: "alipay",
    title: "支付宝",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["手机付款", "移动支付", "无现金支付", "阿里支付", "logo"],
    rtl: true,
  );

  /// 全部
  static const IconPark allApplication = IconPark._(
    id: 97,
    name: "all-application",
    title: "全部",
    category: "Base",
    categoryCN: "基础",
    author: "白明泽",
    tag: ["管理", "四块", "更多", "应用", "导航", "四宫格", "矩阵", "米亚格", "全部应用", "分类"],
    rtl: false,
  );

  /// 字母顺序
  static const IconPark alphabeticalSorting = IconPark._(
    id: 98,
    name: "alphabetical-sorting",
    title: "字母顺序",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["字母顺序", "排序", "顺序"],
    rtl: true,
  );

  /// 字母倒序
  static const IconPark alphabeticalSortingTwo = IconPark._(
    id: 99,
    name: "alphabetical-sorting-two",
    title: "字母倒序",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["字母倒序", "排序", "顺序"],
    rtl: true,
  );

  /// 救护车
  static const IconPark ambulance = IconPark._(
    id: 100,
    name: "ambulance",
    title: "救护车",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 分析
  static const IconPark analysis = IconPark._(
    id: 101,
    name: "analysis",
    title: "分析",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["网络分析", "数据", "趋势", "统计"],
    rtl: true,
  );

  /// 锚点
  static const IconPark anchor = IconPark._(
    id: 102,
    name: "anchor",
    title: "锚点",
    category: "Connect",
    categoryCN: "链接",
    author: "齐奉飞",
    tag: ["选中", "锚点", "可编辑", "操作"],
    rtl: false,
  );

  /// 锚点
  static const IconPark anchorOne = IconPark._(
    id: 103,
    name: "anchor-one",
    title: "锚点",
    category: "Connect",
    categoryCN: "链接",
    author: "齐奉飞",
    tag: ["曲线", "贝塞尔", "可编辑", "锚点"],
    rtl: false,
  );

  /// 锚轮
  static const IconPark anchorRound = IconPark._(
    id: 104,
    name: "anchor-round",
    title: "锚轮",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["锚点", "定位", "钢笔工具", "曲线", "路径"],
    rtl: false,
  );

  /// 锚方
  static const IconPark anchorSqure = IconPark._(
    id: 105,
    name: "anchor-squre",
    title: "锚方",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["锚点", "定位", "钢笔工具", "曲线", "路径"],
    rtl: false,
  );

  /// 抛锚
  static const IconPark anchorTwo = IconPark._(
    id: 106,
    name: "anchor-two",
    title: "抛锚",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["抛锚", "航行", "出海", "锚点"],
    rtl: false,
  );

  /// 安卓
  static const IconPark android = IconPark._(
    id: 107,
    name: "android",
    title: "安卓",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["安卓", "谷歌", "操作系统", "logo"],
    rtl: false,
  );

  /// 生气
  static const IconPark angryFace = IconPark._(
    id: 108,
    name: "angry-face",
    title: "生气",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["生气", "表情", "愤怒"],
    rtl: false,
  );

  /// 圆嘴
  static const IconPark anguishedFace = IconPark._(
    id: 109,
    name: "anguished-face",
    title: "圆嘴",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["圆嘴", "表情", "目瞪口呆"],
    rtl: false,
  );

  /// 公告
  static const IconPark announcement = IconPark._(
    id: 110,
    name: "announcement",
    title: "公告",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 防腐
  static const IconPark antiCorrosion = IconPark._(
    id: 111,
    name: "anti-corrosion",
    title: "防腐",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["防腐剂", "保存", "防腐科", "堆积物"],
    rtl: true,
  );

  /// 光圈优先
  static const IconPark aperturePriority = IconPark._(
    id: 112,
    name: "aperture-priority",
    title: "光圈优先",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["相机", "光圈", "照相"],
    rtl: false,
  );

  /// API 接口
  static const IconPark api = IconPark._(
    id: 113,
    name: "api",
    title: "API 接口",
    category: "Connect",
    categoryCN: "链接",
    author: "金磊",
    tag: ["接口", "开发", "程序", "研发", "API", "关联", "连接"],
    rtl: true,
  );

  /// API 应用
  static const IconPark apiApp = IconPark._(
    id: 114,
    name: "api-app",
    title: "API 应用",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "常留留",
    tag: ["API", "应用", "抽象", "AD", "平台"],
    rtl: true,
  );

  /// 应用商店
  static const IconPark appStore = IconPark._(
    id: 115,
    name: "app-store",
    title: "应用商店",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["商店", "应用", "商城", "logo", "工具"],
    rtl: true,
  );

  /// 切换
  static const IconPark appSwitch = IconPark._(
    id: 116,
    name: "app-switch",
    title: "切换",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["屏幕切换", "轮播", "幻屏"],
    rtl: false,
  );

  /// 苹果
  static const IconPark apple = IconPark._(
    id: 117,
    name: "apple",
    title: "苹果",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["苹果", "手机", "电脑", "设备", "logo"],
    rtl: true,
  );

  /// 苹果
  static const IconPark appleOne = IconPark._(
    id: 118,
    name: "apple-one",
    title: "苹果",
    category: "Foods",
    categoryCN: "食品",
    author: "常留留",
    tag: ["水果", "健康", "绿色", "无公害食品", "苹果"],
    rtl: true,
  );

  /// 小程序关闭
  static const IconPark appletClosed = IconPark._(
    id: 119,
    name: "applet-closed",
    title: "小程序关闭",
    category: "Connect",
    categoryCN: "链接",
    author: "金磊",
    tag: ["小程序关闭"],
    rtl: false,
  );

  /// 应用
  static const IconPark application = IconPark._(
    id: 120,
    name: "application",
    title: "应用",
    category: "Build",
    categoryCN: "建筑",
    author: "白明泽",
    tag: ["商店", "店铺", "门店", "商铺", "房子"],
    rtl: false,
  );

  /// 应用效果
  static const IconPark applicationEffect = IconPark._(
    id: 121,
    name: "application-effect",
    title: "应用效果",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["效果", "圆环", "圆形", "连接", "关联"],
    rtl: true,
  );

  /// 应用菜单
  static const IconPark applicationMenu = IconPark._(
    id: 122,
    name: "application-menu",
    title: "应用菜单",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["菜单", "应用", "更多"],
    rtl: false,
  );

  /// 应用
  static const IconPark applicationOne = IconPark._(
    id: 123,
    name: "application-one",
    title: "应用",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "白明泽",
    tag: ["受众分析", "抽象", "立方体"],
    rtl: false,
  );

  /// 应用
  static const IconPark applicationTwo = IconPark._(
    id: 124,
    name: "application-two",
    title: "应用",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["编辑", "其他", "应用", "分类"],
    rtl: false,
  );

  /// 定时见面
  static const IconPark appointment = IconPark._(
    id: 125,
    name: "appointment",
    title: "定时见面",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 水瓶座
  static const IconPark aquarius = IconPark._(
    id: 126,
    name: "aquarius",
    title: "水瓶座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 凯旋门
  static const IconPark arcDeTriomphe = IconPark._(
    id: 127,
    name: "arc-de-triomphe",
    title: "凯旋门",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["楼", "门", "古建筑", "景区"],
    rtl: false,
  );

  /// 射箭
  static const IconPark archersBow = IconPark._(
    id: 128,
    name: "archers-bow",
    title: "射箭",
    category: "Sports",
    categoryCN: "体育运动",
    author: "",
    tag: ["弓箭"],
    rtl: true,
  );

  /// 射箭
  static const IconPark archery = IconPark._(
    id: 129,
    name: "archery",
    title: "射箭",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 区域图
  static const IconPark areaMap = IconPark._(
    id: 130,
    name: "area-map",
    title: "区域图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["数据", "图表", "区域", "面积图", "趋势"],
    rtl: true,
  );

  /// 竞技场
  static const IconPark arena = IconPark._(
    id: 131,
    name: "arena",
    title: "竞技场",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["竞技场", "拳击", "拳击台", "比赛", "擂台", "摔跤", "体育", "运动", "体育"],
    rtl: true,
  );

  /// 白羊座
  static const IconPark aries = IconPark._(
    id: 132,
    name: "aries",
    title: "白羊座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 计算
  static const IconPark arithmetic = IconPark._(
    id: 133,
    name: "arithmetic",
    title: "计算",
    category: "Charts",
    categoryCN: "数据图表",
    author: "刘心乐",
    tag: ["计算", "算数", "计算器", "算法"],
    rtl: true,
  );

  /// 加减乘除
  static const IconPark arithmeticButtons = IconPark._(
    id: 134,
    name: "arithmetic-buttons",
    title: "加减乘除",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["加减乘除", "键盘"],
    rtl: true,
  );

  /// 计算
  static const IconPark arithmeticOne = IconPark._(
    id: 135,
    name: "arithmetic-one",
    title: "计算",
    category: "Charts",
    categoryCN: "数据图表",
    author: "刘心乐",
    tag: ["计算器", "算数", "计算", "算法"],
    rtl: true,
  );

  /// 下-箭头
  static const IconPark arrowCircleDown = IconPark._(
    id: 136,
    name: "arrow-circle-down",
    title: "下-箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向下", "箭头", "圆圈箭头"],
    rtl: false,
  );

  /// 左-箭头
  static const IconPark arrowCircleLeft = IconPark._(
    id: 137,
    name: "arrow-circle-left",
    title: "左-箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["上一个", "箭头", "圆圈箭头", "左"],
    rtl: true,
  );

  /// 右-箭头
  static const IconPark arrowCircleRight = IconPark._(
    id: 138,
    name: "arrow-circle-right",
    title: "右-箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["下一个", "箭头", "圆圈箭头", "右"],
    rtl: true,
  );

  /// 上-箭头
  static const IconPark arrowCircleUp = IconPark._(
    id: 139,
    name: "arrow-circle-up",
    title: "上-箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向上", "箭头", "圆圈箭头"],
    rtl: false,
  );

  /// 箭头下
  static const IconPark arrowDown = IconPark._(
    id: 140,
    name: "arrow-down",
    title: "箭头下",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向下", "箭头", "方向"],
    rtl: false,
  );

  /// 方向键
  static const IconPark arrowKeys = IconPark._(
    id: 141,
    name: "arrow-keys",
    title: "方向键",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["方向键", "键盘"],
    rtl: true,
  );

  /// 箭头左
  static const IconPark arrowLeft = IconPark._(
    id: 142,
    name: "arrow-left",
    title: "箭头左",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "向左", "上一个", "返回", "方向"],
    rtl: true,
  );

  /// 箭头左下
  static const IconPark arrowLeftDown = IconPark._(
    id: 143,
    name: "arrow-left-down",
    title: "箭头左下",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向左下", "箭头", "方向"],
    rtl: true,
  );

  /// 箭头左上
  static const IconPark arrowLeftUp = IconPark._(
    id: 144,
    name: "arrow-left-up",
    title: "箭头左上",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向左上", "箭头", "方向"],
    rtl: true,
  );

  /// 箭头右
  static const IconPark arrowRight = IconPark._(
    id: 145,
    name: "arrow-right",
    title: "箭头右",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向右", "箭头", "下一个", "跳转", "方向"],
    rtl: true,
  );

  /// 箭头右下
  static const IconPark arrowRightDown = IconPark._(
    id: 146,
    name: "arrow-right-down",
    title: "箭头右下",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向右下", "箭头", "方向"],
    rtl: true,
  );

  /// 箭头右上
  static const IconPark arrowRightUp = IconPark._(
    id: 147,
    name: "arrow-right-up",
    title: "箭头右上",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向右上", "箭头", "方向"],
    rtl: true,
  );

  /// 箭头上
  static const IconPark arrowUp = IconPark._(
    id: 148,
    name: "arrow-up",
    title: "箭头上",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "向上", "方向"],
    rtl: false,
  );

  /// 流水线
  static const IconPark assemblyLine = IconPark._(
    id: 149,
    name: "assembly-line",
    title: "流水线",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["流水线", "流转", "流向", "串联", "链接", "连接", "路径"],
    rtl: true,
  );

  /// 关联
  static const IconPark association = IconPark._(
    id: 150,
    name: "association",
    title: "关联",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["交集", "关联", "联系", "A", "交叉", "编辑"],
    rtl: false,
  );

  /// 星号
  static const IconPark asterisk = IconPark._(
    id: 151,
    name: "asterisk",
    title: "星号",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["星号", "符号", "圆形"],
    rtl: false,
  );

  /// 星号键
  static const IconPark asteriskKey = IconPark._(
    id: 152,
    name: "asterisk-key",
    title: "星号键",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["星号", "按钮"],
    rtl: false,
  );

  /// 张大嘴
  static const IconPark astonishedFace = IconPark._(
    id: 153,
    name: "astonished-face",
    title: "张大嘴",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["张大嘴", "表情", "惊呆"],
    rtl: false,
  );

  /// 邮件符号
  static const IconPark atSign = IconPark._(
    id: 154,
    name: "at-sign",
    title: "邮件符号",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["邮件", "圈人", "提醒用户", "相关人"],
    rtl: true,
  );

  /// 注意
  static const IconPark attention = IconPark._(
    id: 155,
    name: "attention",
    title: "注意",
    category: "Character",
    categoryCN: "符号标识",
    author: "刘心乐",
    tag: ["提示", "注意", "警示"],
    rtl: true,
  );

  /// 音频文件
  static const IconPark audioFile = IconPark._(
    id: 156,
    name: "audio-file",
    title: "音频文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["歌曲", "音乐", "音频", "声音"],
    rtl: true,
  );

  /// 审核
  static const IconPark audit = IconPark._(
    id: 157,
    name: "audit",
    title: "审核",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["印章", "评审", "审查"],
    rtl: true,
  );

  /// 自定对焦
  static const IconPark autoFocus = IconPark._(
    id: 158,
    name: "auto-focus",
    title: "自定对焦",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["对焦", "中心", "靶心", "旋转"],
    rtl: true,
  );

  /// 自动高度1
  static const IconPark autoHeightOne = IconPark._(
    id: 159,
    name: "auto-height-one",
    title: "自动高度1",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["高度自适应", "上下自动", "固定宽"],
    rtl: false,
  );

  /// 自动行高
  static const IconPark autoLineHeight = IconPark._(
    id: 160,
    name: "auto-line-height",
    title: "自动行高",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["文字", "高度自适应", "固定高"],
    rtl: false,
  );

  /// 自动列宽
  static const IconPark autoLineWidth = IconPark._(
    id: 161,
    name: "auto-line-width",
    title: "自动列宽",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["文字", "宽度自适应", "固定宽"],
    rtl: false,
  );

  /// 自动宽度
  static const IconPark autoWidth = IconPark._(
    id: 162,
    name: "auto-width",
    title: "自动宽度",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["宽度自适应", "左右自动", "双向箭头"],
    rtl: false,
  );

  /// 自动宽度1
  static const IconPark autoWidthOne = IconPark._(
    id: 163,
    name: "auto-width-one",
    title: "自动宽度1",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["宽度自适应", "左右自动", "固定高"],
    rtl: false,
  );

  /// 头像
  static const IconPark avatar = IconPark._(
    id: 164,
    name: "avatar",
    title: "头像",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: ["用户", "客户", "个人中心", "账户中心", "我的", "员工", "男"],
    rtl: true,
  );

  /// 平均值
  static const IconPark average = IconPark._(
    id: 165,
    name: "average",
    title: "平均值",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["平均", "中等", "数值", "数据", "图表", "曲线"],
    rtl: true,
  );

  /// 航空
  static const IconPark aviation = IconPark._(
    id: 166,
    name: "aviation",
    title: "航空",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["飞机", "飞行", "滑行", "飞行中"],
    rtl: true,
  );

  /// 牛油果
  static const IconPark avocado = IconPark._(
    id: 167,
    name: "avocado",
    title: "牛油果",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["牛油果", "水果", "果蔬"],
    rtl: true,
  );

  /// 牛油果
  static const IconPark avocadoOne = IconPark._(
    id: 168,
    name: "avocado-one",
    title: "牛油果",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["果子", "水果", "食物", "零食"],
    rtl: false,
  );

  /// 婴儿
  static const IconPark baby = IconPark._(
    id: 169,
    name: "baby",
    title: "婴儿",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "常留留",
    tag: ["育儿", "宝宝", "小朋友", "婴幼儿", "儿童票"],
    rtl: true,
  );

  /// 应用
  static const IconPark babyApp = IconPark._(
    id: 170,
    name: "baby-app",
    title: "应用",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["电脑", "应用", "小孩"],
    rtl: true,
  );

  /// 奶瓶
  static const IconPark babyBottle = IconPark._(
    id: 171,
    name: "baby-bottle",
    title: "奶瓶",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "白明泽",
    tag: ["奶瓶", "婴儿", "牛奶", "儿童"],
    rtl: true,
  );

  /// 车载座
  static const IconPark babyCarSeat = IconPark._(
    id: 172,
    name: "baby-car-seat",
    title: "车载座",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["座椅"],
    rtl: true,
  );

  /// 脚掌
  static const IconPark babyFeet = IconPark._(
    id: 173,
    name: "baby-feet",
    title: "脚掌",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["脚", "脚印"],
    rtl: true,
  );

  /// 餐具
  static const IconPark babyMeal = IconPark._(
    id: 174,
    name: "baby-meal",
    title: "餐具",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["餐具", "勺子", "盘子"],
    rtl: true,
  );

  /// 摇玩
  static const IconPark babyMobile = IconPark._(
    id: 175,
    name: "baby-mobile",
    title: "摇玩",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["挂钩"],
    rtl: true,
  );

  /// 儿童1
  static const IconPark babyOne = IconPark._(
    id: 176,
    name: "baby-one",
    title: "儿童1",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["儿童", "宝宝", "娃娃"],
    rtl: false,
  );

  /// 裤子
  static const IconPark babyPants = IconPark._(
    id: 177,
    name: "baby-pants",
    title: "裤子",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["裤子", "秋裤"],
    rtl: true,
  );

  /// 背带
  static const IconPark babySling = IconPark._(
    id: 178,
    name: "baby-sling",
    title: "背带",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["孩子", "儿童"],
    rtl: false,
  );

  /// 品尝
  static const IconPark babyTaste = IconPark._(
    id: 179,
    name: "baby-taste",
    title: "品尝",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["鬼脸", "味道", "口味"],
    rtl: true,
  );

  /// 学士帽
  static const IconPark bachelorCap = IconPark._(
    id: 180,
    name: "bachelor-cap",
    title: "学士帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["帽子", "学士", "博士帽"],
    rtl: true,
  );

  /// 博士帽1
  static const IconPark bachelorCapOne = IconPark._(
    id: 181,
    name: "bachelor-cap-one",
    title: "博士帽1",
    category: "Clothes",
    categoryCN: "服饰",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 博士帽2
  static const IconPark bachelorCapTwo = IconPark._(
    id: 182,
    name: "bachelor-cap-two",
    title: "博士帽2",
    category: "Clothes",
    categoryCN: "服饰",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 上一步
  static const IconPark back = IconPark._(
    id: 183,
    name: "back",
    title: "上一步",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["撤销", "返回", "上一步", "上一层", "快退", "后退", "跳转", "向左"],
    rtl: true,
  );

  /// 返回
  static const IconPark backOne = IconPark._(
    id: 184,
    name: "back-one",
    title: "返回",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 背景颜色
  static const IconPark backgroundColor = IconPark._(
    id: 185,
    name: "background-color",
    title: "背景颜色",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["背景颜色", "油漆桶", "粉刷", "上色", "染料"],
    rtl: true,
  );

  /// 背包
  static const IconPark backpack = IconPark._(
    id: 186,
    name: "backpack",
    title: "背包",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["书包", "双肩包", "运动包", "登山包"],
    rtl: true,
  );

  /// 坏的
  static const IconPark bad = IconPark._(
    id: 187,
    name: "bad",
    title: "坏的",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["不好", "不认可", "不肯定"],
    rtl: true,
  );

  /// 差劲
  static const IconPark badOne = IconPark._(
    id: 188,
    name: "bad-one",
    title: "差劲",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["踩", "坏的", "不认可"],
    rtl: true,
  );

  /// 踩
  static const IconPark badTwo = IconPark._(
    id: 189,
    name: "bad-two",
    title: "踩",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["不好", "不认可", "不肯定"],
    rtl: true,
  );

  /// 徽章提醒
  static const IconPark badge = IconPark._(
    id: 190,
    name: "badge",
    title: "徽章提醒",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["抽象", "框选", "提醒"],
    rtl: true,
  );

  /// 徽章
  static const IconPark badgeTwo = IconPark._(
    id: 191,
    name: "badge-two",
    title: "徽章",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["徽章"],
    rtl: true,
  );

  /// 羽毛球
  static const IconPark badminton = IconPark._(
    id: 192,
    name: "badminton",
    title: "羽毛球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["羽毛球", "球类", "球", "运动", "网球", "体育"],
    rtl: false,
  );

  /// 行李延误
  static const IconPark baggageDelay = IconPark._(
    id: 193,
    name: "baggage-delay",
    title: "行李延误",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["行李延误"],
    rtl: true,
  );

  /// 平衡
  static const IconPark balance = IconPark._(
    id: 194,
    name: "balance",
    title: "平衡",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["平衡点", "支撑点", "中心"],
    rtl: true,
  );

  /// 电子秤
  static const IconPark balanceOne = IconPark._(
    id: 195,
    name: "balance-one",
    title: "电子秤",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["称", "减肥", "减脂", "平衡", "体重", "重量", "质量", "沉重", "体育"],
    rtl: true,
  );

  /// 天平
  static const IconPark balanceTwo = IconPark._(
    id: 196,
    name: "balance-two",
    title: "天平",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "金磊",
    tag: ["天平", "公平", "法律", "平衡", "衡量", "比重"],
    rtl: false,
  );

  /// 香蕉
  static const IconPark banana = IconPark._(
    id: 197,
    name: "banana",
    title: "香蕉",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["果子", "水果", "食物"],
    rtl: true,
  );

  /// 银行
  static const IconPark bank = IconPark._(
    id: 198,
    name: "bank",
    title: "银行",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["钱", "银行", "财务", "财富"],
    rtl: false,
  );

  /// 银行卡
  static const IconPark bankCard = IconPark._(
    id: 199,
    name: "bank-card",
    title: "银行卡",
    category: "Money",
    categoryCN: "电商财产",
    author: "刘心乐",
    tag: ["银行卡", "卡片", "证件"],
    rtl: true,
  );

  /// 银行卡
  static const IconPark bankCardOne = IconPark._(
    id: 200,
    name: "bank-card-one",
    title: "银行卡",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["钱", "银行", "财务", "财富"],
    rtl: true,
  );

  /// 银行卡
  static const IconPark bankCardTwo = IconPark._(
    id: 201,
    name: "bank-card-two",
    title: "银行卡",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["银行卡", "财富", "前", "金钱", "银行", "卡片"],
    rtl: true,
  );

  /// 银行转账
  static const IconPark bankTransfer = IconPark._(
    id: 202,
    name: "bank-transfer",
    title: "银行转账",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["银行", "转账"],
    rtl: true,
  );

  /// 精灵球
  static const IconPark baokemeng = IconPark._(
    id: 203,
    name: "baokemeng",
    title: "精灵球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["球类", "球", "弹性球", "圆球", "彩色球", "水晶球", "精灵"],
    rtl: false,
  );

  /// 条形码
  static const IconPark barCode = IconPark._(
    id: 204,
    name: "bar-code",
    title: "条形码",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["条形码", "扫码", "支付", "结账"],
    rtl: true,
  );

  /// 烧烤
  static const IconPark barbecue = IconPark._(
    id: 205,
    name: "barbecue",
    title: "烧烤",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["食物", "肉", "饭菜", "夜宵", "烤串", "烧烤"],
    rtl: false,
  );

  /// 理发刷
  static const IconPark barberBrush = IconPark._(
    id: 206,
    name: "barber-brush",
    title: "理发刷",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["刷子"],
    rtl: false,
  );

  /// 理发剪
  static const IconPark barberClippers = IconPark._(
    id: 207,
    name: "barber-clippers",
    title: "理发剪",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["理发"],
    rtl: false,
  );

  /// 棒球
  static const IconPark baseball = IconPark._(
    id: 208,
    name: "baseball",
    title: "棒球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "常留留",
    tag: ["棒球", "运动", "体育", "板球"],
    rtl: false,
  );

  /// 棒球棍
  static const IconPark baseballBat = IconPark._(
    id: 209,
    name: "baseball-bat",
    title: "棒球棍",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 棒球帽
  static const IconPark baseballCap = IconPark._(
    id: 210,
    name: "baseball-cap",
    title: "棒球帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["运动帽", "帽子", "棒球帽", "潮牌"],
    rtl: true,
  );

  /// 篮球
  static const IconPark basketball = IconPark._(
    id: 211,
    name: "basketball",
    title: "篮球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "常留留",
    tag: ["追波", "dribbble", "篮球", "设计"],
    rtl: false,
  );

  /// 篮球服
  static const IconPark basketballClothes = IconPark._(
    id: 212,
    name: "basketball-clothes",
    title: "篮球服",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["篮球服", "运动", "球衣", "衣服", "号码", "背心"],
    rtl: true,
  );

  /// 篮球架1
  static const IconPark basketballOne = IconPark._(
    id: 213,
    name: "basketball-one",
    title: "篮球架1",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["篮球", "篮板", "三分球", "得分", "进球", "进攻", "命中", "投篮", "球类", "球", "体育"],
    rtl: true,
  );

  /// 篮球架
  static const IconPark basketballStand = IconPark._(
    id: 214,
    name: "basketball-stand",
    title: "篮球架",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["篮球架", "运动", "篮板"],
    rtl: false,
  );

  /// 蝙蝠
  static const IconPark bat = IconPark._(
    id: 215,
    name: "bat",
    title: "蝙蝠",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 电池充电
  static const IconPark batteryCharge = IconPark._(
    id: 216,
    name: "battery-charge",
    title: "电池充电",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "齐奉飞",
    tag: ["电池", "充电"],
    rtl: true,
  );

  /// 电池没电
  static const IconPark batteryEmpty = IconPark._(
    id: 217,
    name: "battery-empty",
    title: "电池没电",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "齐奉飞",
    tag: ["电池", "电量空"],
    rtl: true,
  );

  /// 电池故障
  static const IconPark batteryFailure = IconPark._(
    id: 218,
    name: "battery-failure",
    title: "电池故障",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 电池满电
  static const IconPark batteryFull = IconPark._(
    id: 219,
    name: "battery-full",
    title: "电池满电",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "齐奉飞",
    tag: ["电池", "满电"],
    rtl: true,
  );

  /// 电池充电
  static const IconPark batteryStorage = IconPark._(
    id: 220,
    name: "battery-storage",
    title: "电池充电",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 电池提示
  static const IconPark batteryTips = IconPark._(
    id: 221,
    name: "battery-tips",
    title: "电池提示",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 电池运行
  static const IconPark batteryWorking = IconPark._(
    id: 222,
    name: "battery-working",
    title: "电池运行",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "齐奉飞",
    tag: ["电池", "电池电量", "能量"],
    rtl: true,
  );

  /// 电池
  static const IconPark batteryWorkingOne = IconPark._(
    id: 223,
    name: "battery-working-one",
    title: "电池",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["电池", "电量", "充电", "能量", "能源"],
    rtl: true,
  );

  /// 海滩雨伞
  static const IconPark beachUmbrella = IconPark._(
    id: 224,
    name: "beach-umbrella",
    title: "海滩雨伞",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["海滩雨伞", "度假", "休息"],
    rtl: true,
  );

  /// 熊
  static const IconPark bear = IconPark._(
    id: 225,
    name: "bear",
    title: "熊",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 美颜
  static const IconPark beauty = IconPark._(
    id: 226,
    name: "beauty",
    title: "美颜",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["美妆", "变美", "化妆", "美女", "女性", "女性用户"],
    rtl: true,
  );

  /// 美容仪
  static const IconPark beautyInstrument = IconPark._(
    id: 227,
    name: "beauty-instrument",
    title: "美容仪",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["扫码仪", "扫描", "识别", "美容仪"],
    rtl: false,
  );

  /// 床头柜
  static const IconPark bedside = IconPark._(
    id: 228,
    name: "bedside",
    title: "床头柜",
    category: "Life",
    categoryCN: "生活",
    author: "齐奉飞",
    tag: ["床头柜", "家居", "家具", "装修"],
    rtl: false,
  );

  /// 床头柜
  static const IconPark bedsideTwo = IconPark._(
    id: 229,
    name: "bedside-two",
    title: "床头柜",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["床头柜", "家具", "家居", "台灯"],
    rtl: false,
  );

  /// 蜜蜂
  static const IconPark bee = IconPark._(
    id: 230,
    name: "bee",
    title: "蜜蜂",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 啤酒
  static const IconPark beer = IconPark._(
    id: 231,
    name: "beer",
    title: "啤酒",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["饮料", "酒水", "酒精", "啤酒"],
    rtl: true,
  );

  /// 啤酒杯
  static const IconPark beerMug = IconPark._(
    id: 232,
    name: "beer-mug",
    title: "啤酒杯",
    category: "Foods",
    categoryCN: "食品",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// behance
  static const IconPark behance = IconPark._(
    id: 233,
    name: "behance",
    title: "behance",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["设计", "案例", "作品", "logo", "behance"],
    rtl: true,
  );

  /// 上课铃
  static const IconPark bellRing = IconPark._(
    id: 234,
    name: "bell-ring",
    title: "上课铃",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["铃声", "闹钟", "信号", "上课"],
    rtl: true,
  );

  /// 腰带
  static const IconPark belt = IconPark._(
    id: 235,
    name: "belt",
    title: "腰带",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["皮带", "皮具", "腰带"],
    rtl: true,
  );

  /// 奔驰
  static const IconPark benz = IconPark._(
    id: 236,
    name: "benz",
    title: "奔驰",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["奔驰", "三叉戟", "轮毂", "三角", "饼状"],
    rtl: false,
  );

  /// 贝塞尔曲线
  static const IconPark bezierCurve = IconPark._(
    id: 237,
    name: "bezier-curve",
    title: "贝塞尔曲线",
    category: "Connect",
    categoryCN: "链接",
    author: "金磊",
    tag: ["贝塞尔曲线", "编辑", "节点"],
    rtl: false,
  );

  /// 吊带裙
  static const IconPark bib = IconPark._(
    id: 238,
    name: "bib",
    title: "吊带裙",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["围巾", "就餐裙"],
    rtl: false,
  );

  /// 大钟表
  static const IconPark bigClock = IconPark._(
    id: 239,
    name: "big-clock",
    title: "大钟表",
    category: "Time",
    categoryCN: "时间日期",
    author: "金磊",
    tag: ["钟表", "时间", "表", "复古"],
    rtl: true,
  );

  /// 错误
  static const IconPark bigX = IconPark._(
    id: 240,
    name: "big-x",
    title: "错误",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["错误", "埃克斯", "特步", "叉"],
    rtl: true,
  );

  /// 自行车
  static const IconPark bike = IconPark._(
    id: 241,
    name: "bike",
    title: "自行车",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["自行车", "单车", "交通", "出行", "健身", "锻炼"],
    rtl: true,
  );

  /// 法案
  static const IconPark bill = IconPark._(
    id: 242,
    name: "bill",
    title: "法案",
    category: "Base",
    categoryCN: "基础",
    author: "史晓彤",
    tag: ["标签", "书签", "文本", "法案", "订单", "合同", "文档", "规则"],
    rtl: false,
  );

  /// 鸟
  static const IconPark bird = IconPark._(
    id: 243,
    name: "bird",
    title: "鸟",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 生日蛋糕
  static const IconPark birthdayCake = IconPark._(
    id: 244,
    name: "birthday-cake",
    title: "生日蛋糕",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["生日蛋糕", "奶油蛋糕"],
    rtl: true,
  );

  /// 比特币
  static const IconPark bitcoin = IconPark._(
    id: 245,
    name: "bitcoin",
    title: "比特币",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["比特币符号", "标志"],
    rtl: true,
  );

  /// 台球黑八
  static const IconPark blackEight = IconPark._(
    id: 246,
    name: "black-eight",
    title: "台球黑八",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["台球黑八", "运动", "台球", "斯诺克", "桌球"],
    rtl: false,
  );

  /// 黑板
  static const IconPark blackboard = IconPark._(
    id: 247,
    name: "blackboard",
    title: "黑板",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 刀片
  static const IconPark blade = IconPark._(
    id: 248,
    name: "blade",
    title: "刀片",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["刀"],
    rtl: false,
  );

  /// 保佑
  static const IconPark bless = IconPark._(
    id: 249,
    name: "bless",
    title: "保佑",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["手势", "祈祷", "拜佛", "行李"],
    rtl: true,
  );

  /// 行内公式
  static const IconPark block = IconPark._(
    id: 250,
    name: "block",
    title: "行内公式",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["公式"],
    rtl: true,
  );

  /// 俄罗斯方块
  static const IconPark blockEight = IconPark._(
    id: 251,
    name: "block-eight",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: false,
  );

  /// 俄罗斯方块
  static const IconPark blockFive = IconPark._(
    id: 252,
    name: "block-five",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: true,
  );

  /// 俄罗斯方块
  static const IconPark blockFour = IconPark._(
    id: 253,
    name: "block-four",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: false,
  );

  /// 俄罗斯方块
  static const IconPark blockNine = IconPark._(
    id: 254,
    name: "block-nine",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: true,
  );

  /// 俄罗斯方块
  static const IconPark blockOne = IconPark._(
    id: 255,
    name: "block-one",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: true,
  );

  /// 俄罗斯方块
  static const IconPark blockSeven = IconPark._(
    id: 256,
    name: "block-seven",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: false,
  );

  /// 俄罗斯方块
  static const IconPark blockSix = IconPark._(
    id: 257,
    name: "block-six",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: false,
  );

  /// 俄罗斯方块
  static const IconPark blockTen = IconPark._(
    id: 258,
    name: "block-ten",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: true,
  );

  /// 俄罗斯方块
  static const IconPark blockThree = IconPark._(
    id: 259,
    name: "block-three",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: false,
  );

  /// 俄罗斯方块
  static const IconPark blockTwo = IconPark._(
    id: 260,
    name: "block-two",
    title: "俄罗斯方块",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["俄罗斯方块", "拼接", "模块", "组合", "组件", "游戏", "娱乐", "乐高", "魔方"],
    rtl: true,
  );

  /// 区块链
  static const IconPark blockchain = IconPark._(
    id: 261,
    name: "blockchain",
    title: "区块链",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["区块", "链条", "虚拟网"],
    rtl: false,
  );

  /// 模块箭头
  static const IconPark blocksAndArrows = IconPark._(
    id: 262,
    name: "blocks-and-arrows",
    title: "模块箭头",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["模块箭头", "分类"],
    rtl: true,
  );

  /// 开花
  static const IconPark bloom = IconPark._(
    id: 263,
    name: "bloom",
    title: "开花",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 花
  static const IconPark blossom = IconPark._(
    id: 264,
    name: "blossom",
    title: "花",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 蓝牙
  static const IconPark bluetooth = IconPark._(
    id: 265,
    name: "bluetooth",
    title: "蓝牙",
    category: "Others",
    categoryCN: "其它",
    author: "齐奉飞",
    tag: ["蓝牙", "设备", "无线连接", "打开蓝牙"],
    rtl: true,
  );

  /// 壁炉
  static const IconPark boiler = IconPark._(
    id: 266,
    name: "boiler",
    title: "壁炉",
    category: "Life",
    categoryCN: "生活",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 插头
  static const IconPark boltOne = IconPark._(
    id: 267,
    name: "bolt-one",
    title: "插头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["电器", "电源", "充电器", "插排", "插座"],
    rtl: true,
  );

  /// 骨头
  static const IconPark bone = IconPark._(
    id: 268,
    name: "bone",
    title: "骨头",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["骨骼", "健康", "身体", "骨头"],
    rtl: true,
  );

  /// 书籍
  static const IconPark book = IconPark._(
    id: 269,
    name: "book",
    title: "书籍",
    category: "Office",
    categoryCN: "办公文档",
    author: "常留留",
    tag: ["书本", "笔记", "文件", "知识", "图书", "书籍", "学习", "信息"],
    rtl: true,
  );

  /// 书籍1
  static const IconPark bookOne = IconPark._(
    id: 270,
    name: "book-one",
    title: "书籍1",
    category: "Office",
    categoryCN: "办公文档",
    author: "常留留",
    tag: ["书本", "笔记", "文件", "知识", "图书", "书籍", "学习", "信息"],
    rtl: true,
  );

  /// 书籍-打开
  static const IconPark bookOpen = IconPark._(
    id: 271,
    name: "book-open",
    title: "书籍-打开",
    category: "Office",
    categoryCN: "办公文档",
    author: "常留留",
    tag: ["书本", "笔记", "文件", "打开书本", "知识", "图书", "书籍", "学习", "信息"],
    rtl: false,
  );

  /// 书签
  static const IconPark bookmark = IconPark._(
    id: 272,
    name: "bookmark",
    title: "书签",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["书签", "标签", "记录", "图书", "书本"],
    rtl: true,
  );

  /// 书签
  static const IconPark bookmarkOne = IconPark._(
    id: 273,
    name: "bookmark-one",
    title: "书签",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["书签", "便签", "标记", "标签"],
    rtl: true,
  );

  /// 书签3
  static const IconPark bookmarkThree = IconPark._(
    id: 274,
    name: "bookmark-three",
    title: "书签3",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 书籍
  static const IconPark bookshelf = IconPark._(
    id: 275,
    name: "bookshelf",
    title: "书籍",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["知识", "书籍", "书架", "学习", "信息"],
    rtl: true,
  );

  /// 辅助座椅
  static const IconPark boosterCarSeat = IconPark._(
    id: 276,
    name: "booster-car-seat",
    title: "辅助座椅",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["座椅"],
    rtl: false,
  );

  /// 摊位
  static const IconPark booth = IconPark._(
    id: 277,
    name: "booth",
    title: "摊位",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["超市", "门店", "作坊", "摊位"],
    rtl: false,
  );

  /// 靴子
  static const IconPark boots = IconPark._(
    id: 278,
    name: "boots",
    title: "靴子",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["皮靴", "高筒靴", "女士靴子", "雨靴"],
    rtl: true,
  );

  /// 奶瓶
  static const IconPark bottle = IconPark._(
    id: 279,
    name: "bottle",
    title: "奶瓶",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["育儿", "哺育", "婴幼儿科"],
    rtl: true,
  );

  /// 酒瓶
  static const IconPark bottleOne = IconPark._(
    id: 280,
    name: "bottle-one",
    title: "酒瓶",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["酒水", "瓶子", "容器", "塑料瓶", "玻璃瓶"],
    rtl: false,
  );

  /// 瓶装
  static const IconPark bottleThree = IconPark._(
    id: 281,
    name: "bottle-three",
    title: "瓶装",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["酒水", "瓶子", "容器", "塑料瓶", "玻璃瓶"],
    rtl: false,
  );

  /// 瓶子
  static const IconPark bottleTwo = IconPark._(
    id: 282,
    name: "bottle-two",
    title: "瓶子",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["酒水", "瓶子", "容器", "塑料瓶", "玻璃瓶"],
    rtl: true,
  );

  /// 底栏
  static const IconPark bottomBar = IconPark._(
    id: 283,
    name: "bottom-bar",
    title: "底栏",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版", "下"],
    rtl: false,
  );

  /// 保留球
  static const IconPark bottomBarOne = IconPark._(
    id: 284,
    name: "bottom-bar-one",
    title: "保留球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "",
    tag: ["球"],
    rtl: false,
  );

  /// 领结
  static const IconPark bow = IconPark._(
    id: 285,
    name: "bow",
    title: "领结",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["饰品", "蝴蝶结", "领带", "发卡"],
    rtl: false,
  );

  /// 面条
  static const IconPark bowl = IconPark._(
    id: 286,
    name: "bowl",
    title: "面条",
    category: "Foods",
    categoryCN: "食品",
    author: "齐奉飞",
    tag: ["食物", "碗", "吃的", "美食", "碗", "热饭"],
    rtl: true,
  );

  /// 碗
  static const IconPark bowlOne = IconPark._(
    id: 287,
    name: "bowl-one",
    title: "碗",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["容器", "饭菜", "餐饮", "餐具", "热汤"],
    rtl: false,
  );

  /// 保龄球
  static const IconPark bowling = IconPark._(
    id: 288,
    name: "bowling",
    title: "保龄球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["保龄球", "球类", "球", "圆球", "硬球", "体育"],
    rtl: false,
  );

  /// 盒子
  static const IconPark box = IconPark._(
    id: 289,
    name: "box",
    title: "盒子",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["箱子", "盒子", "纸盒", "容器", "办公用品", "收纳"],
    rtl: false,
  );

  /// 拳击
  static const IconPark boxing = IconPark._(
    id: 290,
    name: "boxing",
    title: "拳击",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["拳击", "手套", "护具", "套", "训练", "打击", "拳头", "力量", "对打", "攻击", "跆拳道", "摔跤", "体育"],
    rtl: true,
  );

  /// 拳击1
  static const IconPark boxingOne = IconPark._(
    id: 291,
    name: "boxing-one",
    title: "拳击1",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["拳击", "手套", "护具", "套", "训练", "打击", "拳头", "力量", "对打", "攻击", "跆拳道", "摔跤", "体育"],
    rtl: true,
  );

  /// 男孩
  static const IconPark boy = IconPark._(
    id: 292,
    name: "boy",
    title: "男孩",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["人", "性别", "男"],
    rtl: false,
  );

  /// 男孩1
  static const IconPark boyOne = IconPark._(
    id: 293,
    name: "boy-one",
    title: "男孩1",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["人", "性别", "男"],
    rtl: false,
  );

  /// 男儿童车
  static const IconPark boyStroller = IconPark._(
    id: 294,
    name: "boy-stroller",
    title: "男儿童车",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["童车"],
    rtl: true,
  );

  /// 男孩2
  static const IconPark boyTwo = IconPark._(
    id: 295,
    name: "boy-two",
    title: "男孩2",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["人", "性别", "男"],
    rtl: false,
  );

  /// 大脑
  static const IconPark brain = IconPark._(
    id: 296,
    name: "brain",
    title: "大脑",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["脑部", "头部", "脑科", "思考", "智慧", "医疗"],
    rtl: true,
  );

  /// 刹车片
  static const IconPark brakePads = IconPark._(
    id: 297,
    name: "brake-pads",
    title: "刹车片",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["刹车片", "汽车"],
    rtl: true,
  );

  /// 分支
  static const IconPark branch = IconPark._(
    id: 298,
    name: "branch",
    title: "分支",
    category: "Connect",
    categoryCN: "链接",
    author: "齐奉飞",
    tag: ["分支", "程序", "管理", "Git"],
    rtl: true,
  );

  /// 分支
  static const IconPark branchOne = IconPark._(
    id: 299,
    name: "branch-one",
    title: "分支",
    category: "Connect",
    categoryCN: "链接",
    author: "张蔓",
    tag: ["分支", "排列", "结构", "整理", "树状图", "散发"],
    rtl: false,
  );

  /// 分支
  static const IconPark branchTwo = IconPark._(
    id: 300,
    name: "branch-two",
    title: "分支",
    category: "Connect",
    categoryCN: "链接",
    author: "金磊",
    tag: ["分支", "代码管理", "分布式"],
    rtl: true,
  );

  /// 桥
  static const IconPark brdigeThree = IconPark._(
    id: 301,
    name: "brdige-three",
    title: "桥",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["大桥", "桥梁", "连接"],
    rtl: false,
  );

  /// 面包
  static const IconPark bread = IconPark._(
    id: 302,
    name: "bread",
    title: "面包",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["面食", "食物", "零食", "早餐", "面包"],
    rtl: true,
  );

  /// 面包机
  static const IconPark breadMachine = IconPark._(
    id: 303,
    name: "bread-machine",
    title: "面包机",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["面包机", "面包", "电器", "早餐", "烤面包"],
    rtl: true,
  );

  /// 面包
  static const IconPark breadOne = IconPark._(
    id: 304,
    name: "bread-one",
    title: "面包",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["面包", "早餐", "甜品", "下午茶"],
    rtl: true,
  );

  /// 吸奶器
  static const IconPark breastPump = IconPark._(
    id: 305,
    name: "breast-pump",
    title: "吸奶器",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["杯子", "容器"],
    rtl: true,
  );

  /// 桥
  static const IconPark bridgeOne = IconPark._(
    id: 306,
    name: "bridge-one",
    title: "桥",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["大桥", "石拱桥", "连接"],
    rtl: false,
  );

  /// 桥
  static const IconPark bridgeTwo = IconPark._(
    id: 307,
    name: "bridge-two",
    title: "桥",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["大桥", "立交桥", "连接", "天桥", "玻璃桥"],
    rtl: false,
  );

  /// 公文包
  static const IconPark briefcase = IconPark._(
    id: 308,
    name: "briefcase",
    title: "公文包",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["办公包", "皮包", "手提包"],
    rtl: false,
  );

  /// 亮度
  static const IconPark brightness = IconPark._(
    id: 309,
    name: "brightness",
    title: "亮度",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["显示", "显示屏", "明暗", "太阳", "亮度"],
    rtl: true,
  );

  /// 上层
  static const IconPark bringForward = IconPark._(
    id: 310,
    name: "bring-forward",
    title: "上层",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["上层", "顶层", "向上"],
    rtl: false,
  );

  /// 最上层
  static const IconPark bringToFront = IconPark._(
    id: 311,
    name: "bring-to-front",
    title: "最上层",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["最上层", "图层", "层级", "顶层"],
    rtl: true,
  );

  /// 移到前面
  static const IconPark bringToFrontOne = IconPark._(
    id: 312,
    name: "bring-to-front-one",
    title: "移到前面",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["移到前面", "置于顶层", "路径查找器", "移动"],
    rtl: true,
  );

  /// 广播
  static const IconPark broadcast = IconPark._(
    id: 313,
    name: "broadcast",
    title: "广播",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["投射", "发射", "辐射", "分享", "信号", "传递"],
    rtl: true,
  );

  /// 广播
  static const IconPark broadcastOne = IconPark._(
    id: 314,
    name: "broadcast-one",
    title: "广播",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["多节点传输", "传输", "数据", "通信"],
    rtl: true,
  );

  /// 收音机
  static const IconPark broadcastRadio = IconPark._(
    id: 315,
    name: "broadcast-radio",
    title: "收音机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["收音机", "声音", "播放器", "复古电器"],
    rtl: true,
  );

  /// 浏览器
  static const IconPark browser = IconPark._(
    id: 316,
    name: "browser",
    title: "浏览器",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["窗口", "浏览器", "网页", "页面", "pc端"],
    rtl: true,
  );

  /// 浏览器
  static const IconPark browserChrome = IconPark._(
    id: 317,
    name: "browser-chrome",
    title: "浏览器",
    category: "Brand",
    categoryCN: "品牌",
    author: "杨威",
    tag: ["浏览器", "Chrome", "logo", "飞机"],
    rtl: true,
  );

  /// 浏览器-safari
  static const IconPark browserSafari = IconPark._(
    id: 318,
    name: "browser-safari",
    title: "浏览器-safari",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["苹果浏览器", "Safari", "指针", "方向", "罗盘"],
    rtl: true,
  );

  /// 气泡图
  static const IconPark bubbleChart = IconPark._(
    id: 319,
    name: "bubble-chart",
    title: "气泡图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["气泡", "数据", "图表", "蒸发"],
    rtl: true,
  );

  /// 程序问题
  static const IconPark bug = IconPark._(
    id: 320,
    name: "bug",
    title: "程序问题",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "齐奉飞",
    tag: ["甲壳虫", "问题", "损坏", "事故", "BUG", "问题", "程序问题", "报错"],
    rtl: false,
  );

  /// 建筑
  static const IconPark buildingFour = IconPark._(
    id: 321,
    name: "building-four",
    title: "建筑",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["建筑", "楼房", "建筑", "购物", "商城", "城市"],
    rtl: true,
  );

  /// 建筑
  static const IconPark buildingOne = IconPark._(
    id: 322,
    name: "building-one",
    title: "建筑",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["建筑", "楼房", "高楼", "办公楼", "商城", "城市"],
    rtl: true,
  );

  /// 建筑
  static const IconPark buildingThree = IconPark._(
    id: 323,
    name: "building-three",
    title: "建筑",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["建筑", "楼房", "家", "房子"],
    rtl: true,
  );

  /// 建筑
  static const IconPark buildingTwo = IconPark._(
    id: 324,
    name: "building-two",
    title: "建筑",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["建筑", "楼房", "高楼", "办公楼", "商城", "城市"],
    rtl: true,
  );

  /// 子弹图
  static const IconPark bulletMap = IconPark._(
    id: 325,
    name: "bullet-map",
    title: "子弹图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据", "图表"],
    rtl: true,
  );

  /// 大巴
  static const IconPark bus = IconPark._(
    id: 326,
    name: "bus",
    title: "大巴",
    category: "Hardware",
    categoryCN: "硬件",
    author: "白明泽",
    tag: ["大巴", "旅游", "汽车", "出行", "交通"],
    rtl: false,
  );

  /// 公交
  static const IconPark busOne = IconPark._(
    id: 327,
    name: "bus-one",
    title: "公交",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 公交车
  static const IconPark busTwo = IconPark._(
    id: 328,
    name: "bus-two",
    title: "公交车",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["公交车", "运输", "交通", "汽车", "大巴"],
    rtl: false,
  );

  /// 蝴蝶
  static const IconPark butterfly = IconPark._(
    id: 329,
    name: "butterfly",
    title: "蝴蝶",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 购买
  static const IconPark buy = IconPark._(
    id: 330,
    name: "buy",
    title: "购买",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["购物", "采购", "手提包", "购物袋", "袋子"],
    rtl: false,
  );

  /// 字节设计
  static const IconPark bydesign = IconPark._(
    id: 331,
    name: "bydesign",
    title: "字节设计",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["Bytedesign", "Bydesign", "字节跳动", "设计中台", "design", "logo"],
    rtl: true,
  );

  /// 拜拜
  static const IconPark bye = IconPark._(
    id: 332,
    name: "bye",
    title: "拜拜",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["再见", "再会", "离开", "分别", "bye"],
    rtl: true,
  );

  /// 字节跳动
  static const IconPark bytedance = IconPark._(
    id: 333,
    name: "bytedance",
    title: "字节跳动",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["头条", "音符", "字节跳动", "logo"],
    rtl: true,
  );

  /// 字节跳动小程序
  static const IconPark bytedanceApplets = IconPark._(
    id: 334,
    name: "bytedance-applets",
    title: "字节跳动小程序",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["小程序", "字节跳动"],
    rtl: false,
  );

  /// 应用程序
  static const IconPark bytedanceMiniApp = IconPark._(
    id: 335,
    name: "bytedance-mini-app",
    title: "应用程序",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 缆车
  static const IconPark cableCar = IconPark._(
    id: 336,
    name: "cable-car",
    title: "缆车",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["缆车", "电缆车", "观光车"],
    rtl: true,
  );

  /// 仙人掌
  static const IconPark cactus = IconPark._(
    id: 337,
    name: "cactus",
    title: "仙人掌",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 蛋糕
  static const IconPark cake = IconPark._(
    id: 338,
    name: "cake",
    title: "蛋糕",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["生日蛋糕", "生日", "蛋糕", "糕点", "甜品", "蜡烛"],
    rtl: false,
  );

  /// 蛋糕
  static const IconPark cakeFive = IconPark._(
    id: 339,
    name: "cake-five",
    title: "蛋糕",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["甜点", "糕点", "甜食", "甜品", "食物", "点心", "下午茶", "小蛋糕"],
    rtl: true,
  );

  /// 蛋糕
  static const IconPark cakeFour = IconPark._(
    id: 340,
    name: "cake-four",
    title: "蛋糕",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["甜点", "糕点", "甜食", "甜品", "食物", "点心", "下午茶", "小蛋糕"],
    rtl: false,
  );

  /// 蛋糕
  static const IconPark cakeOne = IconPark._(
    id: 341,
    name: "cake-one",
    title: "蛋糕",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["甜点", "糕点", "甜食", "甜品", "食物", "点心", "下午茶", "小蛋糕"],
    rtl: true,
  );

  /// 蛋糕
  static const IconPark cakeThree = IconPark._(
    id: 342,
    name: "cake-three",
    title: "蛋糕",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["甜点", "糕点", "甜食", "甜品", "食物", "点心", "下午茶", "小蛋糕", "生日蛋糕"],
    rtl: true,
  );

  /// 蛋糕
  static const IconPark cakeTwo = IconPark._(
    id: 343,
    name: "cake-two",
    title: "蛋糕",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["甜点", "糕点", "甜食", "甜品", "食物", "点心", "下午茶", "小蛋糕"],
    rtl: true,
  );

  /// 计算器
  static const IconPark calculator = IconPark._(
    id: 344,
    name: "calculator",
    title: "计算器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["计算器", "计算", "硬件", "算数", "数学", "算力"],
    rtl: true,
  );

  /// 计算器
  static const IconPark calculatorOne = IconPark._(
    id: 345,
    name: "calculator-one",
    title: "计算器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["计算", "智能", "算数", "统计", "结果", "答案", "数字", "加", "减", "乘", "除", "工具"],
    rtl: false,
  );

  /// 日历
  static const IconPark calendar = IconPark._(
    id: 346,
    name: "calendar",
    title: "日历",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["日期", "时间", "日历", "排期"],
    rtl: false,
  );

  /// 日历
  static const IconPark calendarDot = IconPark._(
    id: 347,
    name: "calendar-dot",
    title: "日历",
    category: "Time",
    categoryCN: "时间日期",
    author: "金磊",
    tag: ["日历", "日期", "时间", "期限", "长期"],
    rtl: false,
  );

  /// 日历
  static const IconPark calendarThirty = IconPark._(
    id: 348,
    name: "calendar-thirty",
    title: "日历",
    category: "Time",
    categoryCN: "时间日期",
    author: "金磊",
    tag: ["日历", "日期", "时间", "期限", "长期"],
    rtl: true,
  );

  /// 日历
  static const IconPark calendarThirtyTwo = IconPark._(
    id: 349,
    name: "calendar-thirty-two",
    title: "日历",
    category: "Time",
    categoryCN: "时间日期",
    author: "金磊",
    tag: ["日历", "日期", "时间", "期限", "长期"],
    rtl: true,
  );

  /// 日历
  static const IconPark calendarThree = IconPark._(
    id: 350,
    name: "calendar-three",
    title: "日历",
    category: "Time",
    categoryCN: "时间日期",
    author: "金磊",
    tag: ["日历", "日期", "时间", "期限", "长期"],
    rtl: false,
  );

  /// 相机
  static const IconPark camera = IconPark._(
    id: 351,
    name: "camera",
    title: "相机",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["拍照", "相机", "照片", "图像", "摄影"],
    rtl: false,
  );

  /// 摄像头
  static const IconPark cameraFive = IconPark._(
    id: 352,
    name: "camera-five",
    title: "摄像头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "探头", "抓拍", "偷拍", "电影", "放映"],
    rtl: false,
  );

  /// 监控录像
  static const IconPark cameraFour = IconPark._(
    id: 353,
    name: "camera-four",
    title: "监控录像",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "探头", "抓拍", "偷拍", "电影", "放映"],
    rtl: false,
  );

  /// 摄像头
  static const IconPark cameraOne = IconPark._(
    id: 354,
    name: "camera-one",
    title: "摄像头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "探头", "抓拍", "偷拍"],
    rtl: false,
  );

  /// 智能摄像头
  static const IconPark cameraThree = IconPark._(
    id: 355,
    name: "camera-three",
    title: "智能摄像头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "探头", "抓拍", "偷拍"],
    rtl: true,
  );

  /// 相机
  static const IconPark cameraTwo = IconPark._(
    id: 356,
    name: "camera-two",
    title: "相机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["照相机", "傻瓜机", "摄像机", "摄影", "记录", "记载", "画面", "抓拍", "偷拍"],
    rtl: true,
  );

  /// 野营
  static const IconPark camp = IconPark._(
    id: 357,
    name: "camp",
    title: "野营",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["宿营", "宿营地", "帐篷", "户外"],
    rtl: true,
  );

  /// 巨蟹座
  static const IconPark cancer = IconPark._(
    id: 358,
    name: "cancer",
    title: "巨蟹座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 糖果
  static const IconPark candy = IconPark._(
    id: 359,
    name: "candy",
    title: "糖果",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["糖", "甜点", "下午茶", "零食"],
    rtl: true,
  );

  /// 水果罐头
  static const IconPark cannedFruit = IconPark._(
    id: 360,
    name: "canned-fruit",
    title: "水果罐头",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["水果罐头", "罐头", "瓶子"],
    rtl: true,
  );

  /// 摩羯座
  static const IconPark capricornus = IconPark._(
    id: 361,
    name: "capricornus",
    title: "摩羯座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 汽车
  static const IconPark car = IconPark._(
    id: 362,
    name: "car",
    title: "汽车",
    category: "Hardware",
    categoryCN: "硬件",
    author: "白明泽",
    tag: ["交通", "汽车", "小轿车", "出行"],
    rtl: false,
  );

  /// 汽车电瓶
  static const IconPark carBattery = IconPark._(
    id: 363,
    name: "car-battery",
    title: "汽车电瓶",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["汽车电瓶", "发电"],
    rtl: true,
  );

  /// 双卡片
  static const IconPark cardTwo = IconPark._(
    id: 364,
    name: "card-two",
    title: "双卡片",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["双卡片", "立体", "层级", "前后", "关系"],
    rtl: true,
  );

  /// 心电
  static const IconPark cardioelectric = IconPark._(
    id: 365,
    name: "cardioelectric",
    title: "心电",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["电波", "心电图", "检测", "心跳", "波动"],
    rtl: true,
  );

  /// 轮播
  static const IconPark carousel = IconPark._(
    id: 366,
    name: "carousel",
    title: "轮播",
    category: "Components",
    categoryCN: "界面组件",
    author: "金磊",
    tag: ["轮播", "轮换", "轮转", "头图", "焦点图", "运营图"],
    rtl: true,
  );

  /// 轮播视频
  static const IconPark carouselVideo = IconPark._(
    id: 367,
    name: "carousel-video",
    title: "轮播视频",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["轮播视频", "多个视频", "播放", "叠加"],
    rtl: true,
  );

  /// 胡萝卜
  static const IconPark carrot = IconPark._(
    id: 368,
    name: "carrot",
    title: "胡萝卜",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["食物", "菜类", "水果", "青菜"],
    rtl: true,
  );

  /// 投射屏幕
  static const IconPark castScreen = IconPark._(
    id: 369,
    name: "cast-screen",
    title: "投射屏幕",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["投射", "投屏", "无线投屏"],
    rtl: true,
  );

  /// 城堡
  static const IconPark castle = IconPark._(
    id: 370,
    name: "castle",
    title: "城堡",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "城门", "堡垒", "游乐场", "城堡", "宫殿"],
    rtl: false,
  );

  /// 猫
  static const IconPark cat = IconPark._(
    id: 371,
    name: "cat",
    title: "猫",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 分类管理
  static const IconPark categoryManagement = IconPark._(
    id: 372,
    name: "category-management",
    title: "分类管理",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["分类", "管理", "整理", "抽象"],
    rtl: true,
  );

  /// 牛
  static const IconPark cattle = IconPark._(
    id: 373,
    name: "cattle",
    title: "牛",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 生肖牛
  static const IconPark cattleZodiac = IconPark._(
    id: 374,
    name: "cattle-zodiac",
    title: "生肖牛",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 报错
  static const IconPark caution = IconPark._(
    id: 375,
    name: "caution",
    title: "报错",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "常留留",
    tag: ["错误", "警示", "提示", "报警"],
    rtl: false,
  );

  /// 巨量创意
  static const IconPark cc = IconPark._(
    id: 376,
    name: "cc",
    title: "巨量创意",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["创意中心", "商业化品牌", "创意广告", "oceanengine"],
    rtl: true,
  );

  /// 光盘
  static const IconPark cd = IconPark._(
    id: 377,
    name: "cd",
    title: "光盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["刻盘", "CD", "影片", "光碟"],
    rtl: true,
  );

  /// 欧洲市场
  static const IconPark ceMarking = IconPark._(
    id: 378,
    name: "ce-marking",
    title: "欧洲市场",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["欧洲市场", "标志"],
    rtl: true,
  );

  /// 细胞
  static const IconPark cell = IconPark._(
    id: 379,
    name: "cell",
    title: "细胞",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["䏭", "生命体", "生命", "生物"],
    rtl: true,
  );

  /// 居中对齐
  static const IconPark centerAlignment = IconPark._(
    id: 380,
    name: "center-alignment",
    title: "居中对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["居中", "对齐方式", "排版方式"],
    rtl: true,
  );

  /// 证书
  static const IconPark certificate = IconPark._(
    id: 381,
    name: "certificate",
    title: "证书",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["证书", "安全", "级别"],
    rtl: true,
  );

  /// 鸳鸯锅
  static const IconPark chafingDish = IconPark._(
    id: 382,
    name: "chafing-dish",
    title: "鸳鸯锅",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["鸳鸯锅", "火锅", "烹饪", "涮菜"],
    rtl: true,
  );

  /// 火锅
  static const IconPark chafingDishOne = IconPark._(
    id: 383,
    name: "chafing-dish-one",
    title: "火锅",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["火锅", "铜锅", "涮锅", "烹饪", "锅"],
    rtl: false,
  );

  /// 座椅
  static const IconPark chair = IconPark._(
    id: 384,
    name: "chair",
    title: "座椅",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["椅子"],
    rtl: false,
  );

  /// 座椅1
  static const IconPark chairOne = IconPark._(
    id: 385,
    name: "chair-one",
    title: "座椅1",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["椅子"],
    rtl: false,
  );

  /// 更改
  static const IconPark change = IconPark._(
    id: 386,
    name: "change",
    title: "更改",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["修改", "改变", "调整", "数据", "线条"],
    rtl: true,
  );

  /// 按修改日期排序
  static const IconPark changeDateSort = IconPark._(
    id: 387,
    name: "change-date-sort",
    title: "按修改日期排序",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["修改", "排序"],
    rtl: true,
  );

  /// 充电宝
  static const IconPark chargingTreasure = IconPark._(
    id: 388,
    name: "charging-treasure",
    title: "充电宝",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["电池", "电量", "充电", "能量", "能源", "充电器", "移动电源"],
    rtl: true,
  );

  /// 关系图
  static const IconPark chartGraph = IconPark._(
    id: 389,
    name: "chart-graph",
    title: "关系图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["结构图", "关系图", "层级"],
    rtl: false,
  );

  /// 条形图
  static const IconPark chartHistogram = IconPark._(
    id: 390,
    name: "chart-histogram",
    title: "条形图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "齐奉飞",
    tag: ["图表", "数据", "柱形图", "趋势", "财经"],
    rtl: true,
  );

  /// 条形图
  static const IconPark chartHistogramOne = IconPark._(
    id: 391,
    name: "chart-histogram-one",
    title: "条形图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "齐奉飞",
    tag: ["图表", "数据", "柱形图", "趋势", "财经"],
    rtl: true,
  );

  /// 条形图
  static const IconPark chartHistogramTwo = IconPark._(
    id: 392,
    name: "chart-histogram-two",
    title: "条形图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "齐奉飞",
    tag: ["柱形图", "图表", "趋势", "数据"],
    rtl: true,
  );

  /// 折线图
  static const IconPark chartLine = IconPark._(
    id: 393,
    name: "chart-line",
    title: "折线图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "齐奉飞",
    tag: ["面积图", "曲线图", "折线图", "趋势"],
    rtl: true,
  );

  /// 折线面积图
  static const IconPark chartLineArea = IconPark._(
    id: 394,
    name: "chart-line-area",
    title: "折线面积图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["面积图", "曲线图", "折线图"],
    rtl: true,
  );

  /// 饼图
  static const IconPark chartPie = IconPark._(
    id: 395,
    name: "chart-pie",
    title: "饼图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["饼图", "占比", "比例", "划分"],
    rtl: true,
  );

  /// 数据图
  static const IconPark chartPieOne = IconPark._(
    id: 396,
    name: "chart-pie-one",
    title: "数据图",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["圆形图", "饼状图", "图表"],
    rtl: true,
  );

  /// 占比图
  static const IconPark chartProportion = IconPark._(
    id: 397,
    name: "chart-proportion",
    title: "占比图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "齐奉飞",
    tag: ["饼图", "占比", "比例", "划分"],
    rtl: true,
  );

  /// 环形图
  static const IconPark chartRing = IconPark._(
    id: 398,
    name: "chart-ring",
    title: "环形图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["环形图", "环状图", "靶子", "瞄准"],
    rtl: true,
  );

  /// 散点图
  static const IconPark chartScatter = IconPark._(
    id: 399,
    name: "chart-scatter",
    title: "散点图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "齐奉飞",
    tag: ["散点图", "图表"],
    rtl: true,
  );

  /// K线图
  static const IconPark chartStock = IconPark._(
    id: 400,
    name: "chart-stock",
    title: "K线图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["K线图", "股票图", "股票"],
    rtl: false,
  );

  /// 校验
  static const IconPark check = IconPark._(
    id: 401,
    name: "check",
    title: "校验",
    category: "Character",
    categoryCN: "符号标识",
    author: "刘心乐",
    tag: ["勾选", "对勾", "正确", "成功", "完成", "选中"],
    rtl: true,
  );

  /// 对勾
  static const IconPark checkCorrect = IconPark._(
    id: 402,
    name: "check-correct",
    title: "对勾",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["对勾", "正确", "复选", "多选", "选中"],
    rtl: true,
  );

  /// 插入
  static const IconPark checkIn = IconPark._(
    id: 403,
    name: "check-in",
    title: "插入",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["值机", "检票"],
    rtl: true,
  );

  /// 校验
  static const IconPark checkOne = IconPark._(
    id: 404,
    name: "check-one",
    title: "校验",
    category: "Character",
    categoryCN: "符号标识",
    author: "刘心乐",
    tag: ["勾选", "对勾", "正确", "成功", "完成", "选中"],
    rtl: true,
  );

  /// 校验-小
  static const IconPark checkSmall = IconPark._(
    id: 405,
    name: "check-small",
    title: "校验-小",
    category: "Character",
    categoryCN: "符号标识",
    author: "刘心乐",
    tag: ["勾选", "对勾", "正确", "成功", "选中", "完成"],
    rtl: true,
  );

  /// 多选框
  static const IconPark checkbox = IconPark._(
    id: 406,
    name: "checkbox",
    title: "多选框",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 棋盘
  static const IconPark checkerboard = IconPark._(
    id: 407,
    name: "checkerboard",
    title: "棋盘",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["棋盘", "下棋", "围棋"],
    rtl: true,
  );

  /// 检查列表
  static const IconPark checklist = IconPark._(
    id: 408,
    name: "checklist",
    title: "检查列表",
    category: "Components",
    categoryCN: "界面组件",
    author: "金磊",
    tag: ["核查", "列表", "校验", "纠正", "检查"],
    rtl: true,
  );

  /// 奶酪
  static const IconPark cheese = IconPark._(
    id: 409,
    name: "cheese",
    title: "奶酪",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["奶酪", "甜点", "蛋糕", "芝士奶酪"],
    rtl: true,
  );

  /// 厨师帽
  static const IconPark chefHat = IconPark._(
    id: 410,
    name: "chef-hat",
    title: "厨师帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["厨师", "帽子", "面包师"],
    rtl: true,
  );

  /// 厨师帽子
  static const IconPark chefHatOne = IconPark._(
    id: 411,
    name: "chef-hat-one",
    title: "厨师帽子",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["帽子", "厨师帽"],
    rtl: true,
  );

  /// 樱桃
  static const IconPark cherry = IconPark._(
    id: 412,
    name: "cherry",
    title: "樱桃",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水果", "桃子"],
    rtl: true,
  );

  /// 西洋棋
  static const IconPark chess = IconPark._(
    id: 413,
    name: "chess",
    title: "西洋棋",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["象棋", "国际象棋", "西洋象棋", "棋子", "人马", "兵", "卒", "战争", "战场", "对战", "比赛", "智力", "战术", "策略"],
    rtl: false,
  );

  /// 国际象棋
  static const IconPark chessOne = IconPark._(
    id: 414,
    name: "chess-one",
    title: "国际象棋",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["象棋", "国际象棋", "西洋象棋", "棋子", "人马", "兵", "卒", "战争", "战场", "对战", "比赛", "智力", "战术", "策略"],
    rtl: false,
  );

  /// 胸部
  static const IconPark chest = IconPark._(
    id: 415,
    name: "chest",
    title: "胸部",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["胸腔", "肺部", "器官", "医疗"],
    rtl: false,
  );

  /// 鸡肉
  static const IconPark chicken = IconPark._(
    id: 416,
    name: "chicken",
    title: "鸡肉",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["肉食", "鸡肉", "鸡", "烤鸡", "烧鸡"],
    rtl: true,
  );

  /// 鸡腿
  static const IconPark chickenLeg = IconPark._(
    id: 417,
    name: "chicken-leg",
    title: "鸡腿",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["鸡肉", "鸡腿", "美食", "餐饮"],
    rtl: true,
  );

  /// 生肖鸡
  static const IconPark chickenZodiac = IconPark._(
    id: 418,
    name: "chicken-zodiac",
    title: "生肖鸡",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 吃奶嘴
  static const IconPark childWithPacifier = IconPark._(
    id: 419,
    name: "child-with-pacifier",
    title: "吃奶嘴",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["吃奶"],
    rtl: true,
  );

  /// 儿童帽
  static const IconPark childrenCap = IconPark._(
    id: 420,
    name: "children-cap",
    title: "儿童帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["帽子", "可爱", "耳朵帽", "卡通"],
    rtl: false,
  );

  /// 儿童金字塔
  static const IconPark childrenPyramid = IconPark._(
    id: 421,
    name: "children-pyramid",
    title: "儿童金字塔",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["玩具", "模型"],
    rtl: false,
  );

  /// 辣椒
  static const IconPark chili = IconPark._(
    id: 422,
    name: "chili",
    title: "辣椒",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["蔬菜", "青椒"],
    rtl: true,
  );

  /// 烟筒
  static const IconPark chimney = IconPark._(
    id: 423,
    name: "chimney",
    title: "烟筒",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["烟火", "排烟", "工厂", "烟筒"],
    rtl: true,
  );

  /// 中文
  static const IconPark chinese = IconPark._(
    id: 424,
    name: "chinese",
    title: "中文",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["中", "汉语", "汉字", "语文"],
    rtl: false,
  );

  /// 中文1
  static const IconPark chineseOne = IconPark._(
    id: 425,
    name: "chinese-one",
    title: "中文1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 中国楼阁
  static const IconPark chinesePavilion = IconPark._(
    id: 426,
    name: "chinese-pavilion",
    title: "中国楼阁",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["亭子", "古建筑", "寺庙", "楼阁", "景区"],
    rtl: false,
  );

  /// 芯片
  static const IconPark chip = IconPark._(
    id: 427,
    name: "chip",
    title: "芯片",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["芯片", "科技", "晶片"],
    rtl: true,
  );

  /// 切菜板
  static const IconPark choppingBoard = IconPark._(
    id: 428,
    name: "chopping-board",
    title: "切菜板",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["切菜板", "案板", "菜板", "砧板", "切菜"],
    rtl: true,
  );

  /// 筷子叉子
  static const IconPark chopsticksFork = IconPark._(
    id: 429,
    name: "chopsticks-fork",
    title: "筷子叉子",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["筷子叉子", "餐饮", "吃饭", "工具"],
    rtl: true,
  );

  /// 圣诞树
  static const IconPark christmasTree = IconPark._(
    id: 430,
    name: "christmas-tree",
    title: "圣诞树",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["圣诞", "树", "节日", "假期", "温暖", "过节"],
    rtl: false,
  );

  /// 松树
  static const IconPark christmasTreeOne = IconPark._(
    id: 431,
    name: "christmas-tree-one",
    title: "松树",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 教堂
  static const IconPark churchOne = IconPark._(
    id: 432,
    name: "church-one",
    title: "教堂",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["基督教", "宗教", "宫殿", "楼房", "教堂", "建筑"],
    rtl: false,
  );

  /// 教堂
  static const IconPark churchTwo = IconPark._(
    id: 433,
    name: "church-two",
    title: "教堂",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["基督教", "宗教", "楼房", "教堂", "建筑"],
    rtl: false,
  );

  /// 圆形双下箭头
  static const IconPark circleDoubleDown = IconPark._(
    id: 434,
    name: "circle-double-down",
    title: "圆形双下箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["双箭头", "向下", "圆圈箭头"],
    rtl: false,
  );

  /// 圆形双左箭头
  static const IconPark circleDoubleLeft = IconPark._(
    id: 435,
    name: "circle-double-left",
    title: "圆形双左箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["双箭头", "向左", "圆圈箭头"],
    rtl: true,
  );

  /// 圆形双右箭头
  static const IconPark circleDoubleRight = IconPark._(
    id: 436,
    name: "circle-double-right",
    title: "圆形双右箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["双箭头", "向右", "圆圈箭头"],
    rtl: true,
  );

  /// 圆形双上箭头
  static const IconPark circleDoubleUp = IconPark._(
    id: 437,
    name: "circle-double-up",
    title: "圆形双上箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["双箭头", "向上", "圆圈箭头"],
    rtl: false,
  );

  /// 圆圈
  static const IconPark circleFiveLine = IconPark._(
    id: 438,
    name: "circle-five-line",
    title: "圆圈",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆圈", "连接", "抽象", "锚点"],
    rtl: false,
  );

  /// 圆圈
  static const IconPark circleFour = IconPark._(
    id: 439,
    name: "circle-four",
    title: "圆圈",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆圈", "抽象", "叠加"],
    rtl: false,
  );

  /// 圆圈
  static const IconPark circleFourLine = IconPark._(
    id: 440,
    name: "circle-four-line",
    title: "圆圈",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆圈", "连接", "抽象", "箭头"],
    rtl: true,
  );

  /// 圈舍
  static const IconPark circleHouse = IconPark._(
    id: 441,
    name: "circle-house",
    title: "圈舍",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["房子", "屋子", "阁楼", "圈舍"],
    rtl: false,
  );

  /// 圆形左下
  static const IconPark circleLeftDown = IconPark._(
    id: 442,
    name: "circle-left-down",
    title: "圆形左下",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "圆圈箭头", "左下方向"],
    rtl: true,
  );

  /// 圆形左上
  static const IconPark circleLeftUp = IconPark._(
    id: 443,
    name: "circle-left-up",
    title: "圆形左上",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "圆圈箭头", "左上方向"],
    rtl: true,
  );

  /// 圆形右下
  static const IconPark circleRightDown = IconPark._(
    id: 444,
    name: "circle-right-down",
    title: "圆形右下",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "圆圈箭头", "右下方向"],
    rtl: true,
  );

  /// 圆形右上
  static const IconPark circleRightUp = IconPark._(
    id: 445,
    name: "circle-right-up",
    title: "圆形右上",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "圆圈箭头", "右上方向"],
    rtl: true,
  );

  /// 圆圈
  static const IconPark circleThree = IconPark._(
    id: 446,
    name: "circle-three",
    title: "圆圈",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆圈", "抽象", "叠加", "关联"],
    rtl: false,
  );

  /// 圆圈
  static const IconPark circleTwoLine = IconPark._(
    id: 447,
    name: "circle-two-line",
    title: "圆圈",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆圈", "连接", "抽象", "锚点", "缩放"],
    rtl: true,
  );

  /// 圆形和三角
  static const IconPark circlesAndTriangles = IconPark._(
    id: 448,
    name: "circles-and-triangles",
    title: "圆形和三角",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆形和三角", "形状拼接", "组合"],
    rtl: false,
  );

  /// 圆圈
  static const IconPark circlesSeven = IconPark._(
    id: 449,
    name: "circles-seven",
    title: "圆圈",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆圈", "抽象", "六个圆"],
    rtl: false,
  );

  /// 圆形连接
  static const IconPark circularConnection = IconPark._(
    id: 450,
    name: "circular-connection",
    title: "圆形连接",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆形连接", "渠道", "关联"],
    rtl: false,
  );

  /// 马戏团
  static const IconPark circus = IconPark._(
    id: 451,
    name: "circus",
    title: "马戏团",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["蒙古包", "营地", "驻扎", "露营"],
    rtl: false,
  );

  /// 城市
  static const IconPark city = IconPark._(
    id: 452,
    name: "city",
    title: "城市",
    category: "Build",
    categoryCN: "建筑",
    author: "齐奉飞",
    tag: ["城市", "建筑", "楼房", "办公楼", "小区"],
    rtl: true,
  );

  /// 城门
  static const IconPark cityGate = IconPark._(
    id: 453,
    name: "city-gate",
    title: "城门",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "房子", "楼房", "景区", "古建筑"],
    rtl: false,
  );

  /// 城市
  static const IconPark cityOne = IconPark._(
    id: 454,
    name: "city-one",
    title: "城市",
    category: "Build",
    categoryCN: "建筑",
    author: "齐奉飞",
    tag: ["城市", "建筑", "楼房", "办公楼", "小区"],
    rtl: true,
  );

  /// 鼓掌
  static const IconPark clap = IconPark._(
    id: 455,
    name: "clap",
    title: "鼓掌",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["拍手", "打击", "掌声"],
    rtl: true,
  );

  /// 课堂
  static const IconPark classroom = IconPark._(
    id: 456,
    name: "classroom",
    title: "课堂",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "常留留",
    tag: ["听课", "教学", "学习", "用户", "个人中心"],
    rtl: false,
  );

  /// 清除
  static const IconPark clear = IconPark._(
    id: 457,
    name: "clear",
    title: "清除",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["删除", "清除", "擦除", "扫把", "清理", "环保", "卫生"],
    rtl: false,
  );

  /// 清除格式
  static const IconPark clearFormat = IconPark._(
    id: 458,
    name: "clear-format",
    title: "清除格式",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["清除", "恢复", "字体格式", "橡皮擦"],
    rtl: true,
  );

  /// 点击
  static const IconPark click = IconPark._(
    id: 459,
    name: "click",
    title: "点击",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["点击", "选中", "鼠标", "操作", "执行"],
    rtl: true,
  );

  /// 点击
  static const IconPark clickTap = IconPark._(
    id: 460,
    name: "click-tap",
    title: "点击",
    category: "Hands",
    categoryCN: "手势动作",
    author: "齐奉飞",
    tag: ["小手", "点击率", "点击效果", "按键", "触发"],
    rtl: true,
  );

  /// 点击
  static const IconPark clickTapTwo = IconPark._(
    id: 461,
    name: "click-tap-two",
    title: "点击",
    category: "Hands",
    categoryCN: "手势动作",
    author: "金磊",
    tag: ["点击", "按下", "点按", "触摸", "操作", "编辑"],
    rtl: true,
  );

  /// 点击缩起
  static const IconPark clickToFold = IconPark._(
    id: 462,
    name: "click-to-fold",
    title: "点击缩起",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "张蔓",
    tag: ["点击缩起", "缩小", "收起", "聚集"],
    rtl: true,
  );

  /// 剪切板
  static const IconPark clipboard = IconPark._(
    id: 463,
    name: "clipboard",
    title: "剪切板",
    category: "Office",
    categoryCN: "办公文档",
    author: "常留留",
    tag: ["画板", "黏贴板", "公告板", "电池", "没电了", "记录", "账单", "条例"],
    rtl: false,
  );

  /// 钟楼
  static const IconPark clockTower = IconPark._(
    id: 464,
    name: "clock-tower",
    title: "钟楼",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["大笨钟", "楼房", "大厦", "建筑"],
    rtl: true,
  );

  /// 关闭
  static const IconPark close = IconPark._(
    id: 465,
    name: "close",
    title: "关闭",
    category: "Character",
    categoryCN: "符号标识",
    author: "刘心乐",
    tag: ["删除", "清除", "错误", "关闭", "取消"],
    rtl: false,
  );

  /// 关闭
  static const IconPark closeOne = IconPark._(
    id: 466,
    name: "close-one",
    title: "关闭",
    category: "Character",
    categoryCN: "符号标识",
    author: "刘心乐",
    tag: ["删除", "清除", "错误", "关闭", "取消"],
    rtl: false,
  );

  /// 关闭提醒
  static const IconPark closeRemind = IconPark._(
    id: 467,
    name: "close-remind",
    title: "关闭提醒",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["提示", "消息", "警示", "警钟", "铃铛", "关闭", "禁止提醒"],
    rtl: true,
  );

  /// 关闭-小
  static const IconPark closeSmall = IconPark._(
    id: 468,
    name: "close-small",
    title: "关闭-小",
    category: "Character",
    categoryCN: "符号标识",
    author: "刘心乐",
    tag: ["删除", "清除", "错误", "关闭", "取消"],
    rtl: false,
  );

  /// 关闭无线网络
  static const IconPark closeWifi = IconPark._(
    id: 469,
    name: "close-wifi",
    title: "关闭无线网络",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["Wi-Fi", "无线网", "网络", "信号", "关闭"],
    rtl: true,
  );

  /// 内裤
  static const IconPark clothesBriefs = IconPark._(
    id: 470,
    name: "clothes-briefs",
    title: "内裤",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "裤子", "内裤", "女士内裤"],
    rtl: false,
  );

  /// 开衫
  static const IconPark clothesCardigan = IconPark._(
    id: 471,
    name: "clothes-cardigan",
    title: "开衫",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "开衫", "服装", "上衣"],
    rtl: false,
  );

  /// 圆领衫
  static const IconPark clothesCrewNeck = IconPark._(
    id: 472,
    name: "clothes-crew-neck",
    title: "圆领衫",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "开衫", "服装", "秋衣"],
    rtl: false,
  );

  /// 纸尿裤
  static const IconPark clothesDiapers = IconPark._(
    id: 473,
    name: "clothes-diapers",
    title: "纸尿裤",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "婴儿", "小孩", "内裤"],
    rtl: false,
  );

  /// 手套
  static const IconPark clothesGloves = IconPark._(
    id: 474,
    name: "clothes-gloves",
    title: "手套",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["手套", "五指手套"],
    rtl: true,
  );

  /// 手套
  static const IconPark clothesGlovesTwo = IconPark._(
    id: 475,
    name: "clothes-gloves-two",
    title: "手套",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["手套", "工具", "滑雪用品"],
    rtl: true,
  );

  /// 卫衣
  static const IconPark clothesHoodie = IconPark._(
    id: 476,
    name: "clothes-hoodie",
    title: "卫衣",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "服饰", "上衣"],
    rtl: true,
  );

  /// 裤子
  static const IconPark clothesPants = IconPark._(
    id: 477,
    name: "clothes-pants",
    title: "裤子",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "服饰", "裤子"],
    rtl: false,
  );

  /// 短裤
  static const IconPark clothesPantsShort = IconPark._(
    id: 478,
    name: "clothes-pants-short",
    title: "短裤",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "服饰", "裤子", "短裤"],
    rtl: false,
  );

  /// 运动裤
  static const IconPark clothesPantsSweat = IconPark._(
    id: 479,
    name: "clothes-pants-sweat",
    title: "运动裤",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "服饰", "裤子", "运动"],
    rtl: false,
  );

  /// 短裤
  static const IconPark clothesShortSleeve = IconPark._(
    id: 480,
    name: "clothes-short-sleeve",
    title: "短裤",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "服饰", "短袖"],
    rtl: false,
  );

  /// 滑冰鞋
  static const IconPark clothesSkates = IconPark._(
    id: 481,
    name: "clothes-skates",
    title: "滑冰鞋",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["服饰", "装备", "滑冰", "鞋子", "靴子"],
    rtl: true,
  );

  /// 西装
  static const IconPark clothesSuit = IconPark._(
    id: 482,
    name: "clothes-suit",
    title: "西装",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "服饰", "正式", "外套"],
    rtl: true,
  );

  /// 帽衫
  static const IconPark clothesSweater = IconPark._(
    id: 483,
    name: "clothes-sweater",
    title: "帽衫",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "服饰", "正式", "外套"],
    rtl: false,
  );

  /// 高领毛衣
  static const IconPark clothesTurtleneck = IconPark._(
    id: 484,
    name: "clothes-turtleneck",
    title: "高领毛衣",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "服饰", "正式"],
    rtl: false,
  );

  /// 风衣
  static const IconPark clothesWindbreaker = IconPark._(
    id: 485,
    name: "clothes-windbreaker",
    title: "风衣",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["衣服", "服装", "服饰", "正式", "上衣"],
    rtl: true,
  );

  /// 云存储
  static const IconPark cloudStorage = IconPark._(
    id: 486,
    name: "cloud-storage",
    title: "云存储",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["储存", "云盘", "cloud", "store"],
    rtl: true,
  );

  /// 多云
  static const IconPark cloudy = IconPark._(
    id: 487,
    name: "cloudy",
    title: "多云",
    category: "Weather",
    categoryCN: "天气",
    author: "齐奉飞",
    tag: ["阴天", "云彩", "云朵", "多云"],
    rtl: true,
  );

  /// 夜间多云
  static const IconPark cloudyNight = IconPark._(
    id: 488,
    name: "cloudy-night",
    title: "夜间多云",
    category: "Weather",
    categoryCN: "天气",
    author: "",
    tag: ["云"],
    rtl: true,
  );

  /// 线索
  static const IconPark clue = IconPark._(
    id: 489,
    name: "clue",
    title: "线索",
    category: "Connect",
    categoryCN: "链接",
    author: "齐奉飞",
    tag: ["线索池", "连接", "相连"],
    rtl: true,
  );

  /// 衣架
  static const IconPark coatHanger = IconPark._(
    id: 490,
    name: "coat-hanger",
    title: "衣架",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["衣服撑", "衣服架", "晾衣架"],
    rtl: true,
  );

  /// 鸡尾酒
  static const IconPark cocktail = IconPark._(
    id: 491,
    name: "cocktail",
    title: "鸡尾酒",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["鸡尾酒", "浪漫", "酒杯", "红酒", "调制酒", "气泡酒"],
    rtl: true,
  );

  /// 椰子树
  static const IconPark coconutTree = IconPark._(
    id: 492,
    name: "coconut-tree",
    title: "椰子树",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["椰子树", "海边", "沙滩", "棕榈树"],
    rtl: true,
  );

  /// 代码
  static const IconPark code = IconPark._(
    id: 493,
    name: "code",
    title: "代码",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["代码序列", "字段"],
    rtl: true,
  );

  /// 大括号
  static const IconPark codeBrackets = IconPark._(
    id: 494,
    name: "code-brackets",
    title: "大括号",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["代码括号", "代码块", "大括号", "开发"],
    rtl: true,
  );

  /// 计算机代码
  static const IconPark codeComputer = IconPark._(
    id: 495,
    name: "code-computer",
    title: "计算机代码",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 下载代码
  static const IconPark codeDownload = IconPark._(
    id: 496,
    name: "code-download",
    title: "下载代码",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["下载", "代码"],
    rtl: true,
  );

  /// 笔记本电脑代码
  static const IconPark codeLaptop = IconPark._(
    id: 497,
    name: "code-laptop",
    title: "笔记本电脑代码",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 代码1
  static const IconPark codeOne = IconPark._(
    id: 498,
    name: "code-one",
    title: "代码1",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 咖啡机
  static const IconPark coffeeMachine = IconPark._(
    id: 499,
    name: "coffee-machine",
    title: "咖啡机",
    category: "Life",
    categoryCN: "生活",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 可乐
  static const IconPark cola = IconPark._(
    id: 500,
    name: "cola",
    title: "可乐",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["可乐", "饮料", "水", "听装可乐", "可口可乐"],
    rtl: true,
  );

  /// 收起文本域
  static const IconPark collapseTextInput = IconPark._(
    id: 501,
    name: "collapse-text-input",
    title: "收起文本域",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["缩小", "收起", "箭头"],
    rtl: true,
  );

  /// 计算机收藏
  static const IconPark collectComputer = IconPark._(
    id: 502,
    name: "collect-computer",
    title: "计算机收藏",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 笔记本电脑收集
  static const IconPark collectLaptop = IconPark._(
    id: 503,
    name: "collect-laptop",
    title: "笔记本电脑收集",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 图片收集
  static const IconPark collectPicture = IconPark._(
    id: 504,
    name: "collect-picture",
    title: "图片收集",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 收藏文件
  static const IconPark collectionFiles = IconPark._(
    id: 505,
    name: "collection-files",
    title: "收藏文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["收藏", "星星", "评级", "级别"],
    rtl: true,
  );

  /// 收藏音乐
  static const IconPark collectionRecords = IconPark._(
    id: 506,
    name: "collection-records",
    title: "收藏音乐",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["收藏", "喜欢"],
    rtl: true,
  );

  /// 色卡
  static const IconPark colorCard = IconPark._(
    id: 507,
    name: "color-card",
    title: "色卡",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "金磊",
    tag: ["颜色", "绚丽", "选择", "旋转", "叠加"],
    rtl: true,
  );

  /// 颜色滤镜
  static const IconPark colorFilter = IconPark._(
    id: 508,
    name: "color-filter",
    title: "颜色滤镜",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["颜色滤镜", "滤镜", "过滤", "效果", "特效"],
    rtl: false,
  );

  /// 列
  static const IconPark column = IconPark._(
    id: 509,
    name: "column",
    title: "列",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["列表", "表格", "左右布局"],
    rtl: false,
  );

  /// 梳子
  static const IconPark comb = IconPark._(
    id: 510,
    name: "comb",
    title: "梳子",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 招引
  static const IconPark come = IconPark._(
    id: 511,
    name: "come",
    title: "招引",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["引诱", "勾引", "引诱"],
    rtl: true,
  );

  /// 命令键
  static const IconPark command = IconPark._(
    id: 512,
    name: "command",
    title: "命令键",
    category: "Connect",
    categoryCN: "链接",
    author: "常留留",
    tag: ["命令建", "符号", "键盘", "按键"],
    rtl: false,
  );

  /// 评论
  static const IconPark comment = IconPark._(
    id: 513,
    name: "comment",
    title: "评论",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "刘心乐",
    tag: ["对话", "评论", "聊天", "消息", "通知"],
    rtl: true,
  );

  /// 评论
  static const IconPark commentOne = IconPark._(
    id: 514,
    name: "comment-one",
    title: "评论",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "刘心乐",
    tag: ["对话", "评论", "聊天", "消息", "通知"],
    rtl: true,
  );

  /// 评论
  static const IconPark comments = IconPark._(
    id: 515,
    name: "comments",
    title: "评论",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "常留留",
    tag: ["信息", "聊天", "通知", "社交", "沟通", "新消息", "合作洽谈", "评论区"],
    rtl: true,
  );

  /// 商品
  static const IconPark commodity = IconPark._(
    id: 516,
    name: "commodity",
    title: "商品",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["货品", "购物"],
    rtl: false,
  );

  /// 沟通
  static const IconPark communication = IconPark._(
    id: 517,
    name: "communication",
    title: "沟通",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "常留留",
    tag: ["信息", "聊天", "通知", "社交", "沟通", "新消息", "合作洽谈", "评论"],
    rtl: true,
  );

  /// 通勤包
  static const IconPark commuterBag = IconPark._(
    id: 518,
    name: "commuter-bag",
    title: "通勤包",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["挎包", "手提包", "小包", "布袋", "女士包"],
    rtl: false,
  );

  /// 圆规
  static const IconPark compass = IconPark._(
    id: 519,
    name: "compass",
    title: "圆规",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "金磊",
    tag: ["圆规", "角落", "角度", "测量"],
    rtl: false,
  );

  /// 指南针
  static const IconPark compassOne = IconPark._(
    id: 520,
    name: "compass-one",
    title: "指南针",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["指南针", "方向", "位置"],
    rtl: true,
  );

  /// 组件
  static const IconPark components = IconPark._(
    id: 521,
    name: "components",
    title: "组件",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["组件", "组合", "图形"],
    rtl: false,
  );

  /// 成份
  static const IconPark composition = IconPark._(
    id: 522,
    name: "composition",
    title: "成份",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["实验", "元素", "组成部分", "组成元素", "试管"],
    rtl: true,
  );

  /// 压缩
  static const IconPark compression = IconPark._(
    id: 523,
    name: "compression",
    title: "压缩",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["挤压", "文章", "文档", "小说", "合同", "规则", "详情"],
    rtl: true,
  );

  /// 电脑
  static const IconPark computer = IconPark._(
    id: 524,
    name: "computer",
    title: "电脑",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["显示屏", "PC电脑", "电视"],
    rtl: false,
  );

  /// 计算机
  static const IconPark computerOne = IconPark._(
    id: 525,
    name: "computer-one",
    title: "计算机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["计算", "算数", "加", "减", "乘", "除"],
    rtl: true,
  );

  /// 理念共享
  static const IconPark conceptSharing = IconPark._(
    id: 526,
    name: "concept-sharing",
    title: "理念共享",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["共享", "创意共享", "想法"],
    rtl: true,
  );

  /// 关注
  static const IconPark concern = IconPark._(
    id: 527,
    name: "concern",
    title: "关注",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["关系", "重视", "喜欢", "爱", "心动"],
    rtl: false,
  );

  /// 护发素
  static const IconPark conditioner = IconPark._(
    id: 528,
    name: "conditioner",
    title: "护发素",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["洗护", "日化", "面霜", "护发素"],
    rtl: true,
  );

  /// 圆锥
  static const IconPark cone = IconPark._(
    id: 529,
    name: "cone",
    title: "圆锥",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆锥", "测量", "锐度"],
    rtl: false,
  );

  /// 坐标系
  static const IconPark cones = IconPark._(
    id: 530,
    name: "cones",
    title: "坐标系",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["坐标系", "三角", "立体"],
    rtl: false,
  );

  /// 配置
  static const IconPark config = IconPark._(
    id: 531,
    name: "config",
    title: "配置",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["配置", "设置", "工具", "螺丝", "螺母", "齿轮"],
    rtl: false,
  );

  /// 抿嘴闭眼
  static const IconPark confoundedFace = IconPark._(
    id: 532,
    name: "confounded-face",
    title: "抿嘴闭眼",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["抿嘴闭眼", "表情", "害怕"],
    rtl: false,
  );

  /// 别嘴
  static const IconPark confusedFace = IconPark._(
    id: 533,
    name: "confused-face",
    title: "别嘴",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["别嘴", "表情", "耍酷"],
    rtl: true,
  );

  /// 链接
  static const IconPark connect = IconPark._(
    id: 534,
    name: "connect",
    title: "链接",
    category: "Connect",
    categoryCN: "链接",
    author: "金磊",
    tag: ["链接", "分享", "连接", "拓扑图", "图表"],
    rtl: true,
  );

  /// 连接地址1
  static const IconPark connectAddressOne = IconPark._(
    id: 535,
    name: "connect-address-one",
    title: "连接地址1",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["锚点", "定位", "定点", "鱼钩"],
    rtl: false,
  );

  /// 连接地址2
  static const IconPark connectAddressTwo = IconPark._(
    id: 536,
    name: "connect-address-two",
    title: "连接地址2",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["锚点", "定位", "定点", "鱼钩"],
    rtl: false,
  );

  /// 连接
  static const IconPark connection = IconPark._(
    id: 537,
    name: "connection",
    title: "连接",
    category: "Connect",
    categoryCN: "链接",
    author: "金磊",
    tag: ["连接", "箭头", "线段", "链接", "结合"],
    rtl: true,
  );

  /// 连接箭头
  static const IconPark connectionArrow = IconPark._(
    id: 538,
    name: "connection-arrow",
    title: "连接箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["连接", "箭头", "相连", "流程"],
    rtl: true,
  );

  /// 分组
  static const IconPark connectionBox = IconPark._(
    id: 539,
    name: "connection-box",
    title: "分组",
    category: "Connect",
    categoryCN: "链接",
    author: "常留留",
    tag: ["分组", "关联", "联系", "服务器", "技术", "管理"],
    rtl: true,
  );

  /// 连接点
  static const IconPark connectionPoint = IconPark._(
    id: 540,
    name: "connection-point",
    title: "连接点",
    category: "Connect",
    categoryCN: "链接",
    author: "刘心乐",
    tag: ["网络", "连接点", "节点", "网络邻居", "渠道"],
    rtl: false,
  );

  /// 两点连接
  static const IconPark connectionPointTwo = IconPark._(
    id: 541,
    name: "connection-point-two",
    title: "两点连接",
    category: "Connect",
    categoryCN: "链接",
    author: "金磊",
    tag: ["两点连接", "链接", "相连"],
    rtl: true,
  );

  /// 托运
  static const IconPark consignment = IconPark._(
    id: 542,
    name: "consignment",
    title: "托运",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["托运", "运输", "运送", "行李托运", "传送"],
    rtl: false,
  );

  /// 消费
  static const IconPark consume = IconPark._(
    id: 543,
    name: "consume",
    title: "消费",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["总消耗", "花钱", "花费", "钱包"],
    rtl: false,
  );

  /// 对比度
  static const IconPark contrast = IconPark._(
    id: 544,
    name: "contrast",
    title: "对比度",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["对比度", "参数", "摄像", "牌照", "配置"],
    rtl: true,
  );

  /// 对比
  static const IconPark contrastView = IconPark._(
    id: 545,
    name: "contrast-view",
    title: "对比",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["对比", "对比查看", "查看", "编辑"],
    rtl: true,
  );

  /// 对比
  static const IconPark contrastViewCircle = IconPark._(
    id: 546,
    name: "contrast-view-circle",
    title: "对比",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["对比", "对比度", "调整", "编辑"],
    rtl: true,
  );

  /// 控制器
  static const IconPark control = IconPark._(
    id: 547,
    name: "control",
    title: "控制器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["控制设备", "调控器", "调节器", "控制台"],
    rtl: true,
  );

  /// 汇聚网关
  static const IconPark convergingGateway = IconPark._(
    id: 548,
    name: "converging-gateway",
    title: "汇聚网关",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "常留留",
    tag: ["汇聚", "菱形", "抽象", "几何"],
    rtl: false,
  );

  /// 煮饭
  static const IconPark cook = IconPark._(
    id: 549,
    name: "cook",
    title: "煮饭",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["煮饭", "锅", "奶锅", "锅具", "炒锅", "汤锅"],
    rtl: true,
  );

  /// 烹饪
  static const IconPark cooking = IconPark._(
    id: 550,
    name: "cooking",
    title: "烹饪",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["做饭", "厨师", "加工", "餐饮", "餐具"],
    rtl: true,
  );

  /// 煮锅
  static const IconPark cookingPot = IconPark._(
    id: 551,
    name: "cooking-pot",
    title: "煮锅",
    category: "Life",
    categoryCN: "生活",
    author: "白明泽",
    tag: ["煮熟", "烹饪", "厨房", "做饭", "美食", "餐饮"],
    rtl: false,
  );

  /// 酷的
  static const IconPark cool = IconPark._(
    id: 552,
    name: "cool",
    title: "酷的",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["喜欢", "指向", "手型", "手指"],
    rtl: true,
  );

  /// 合作握手
  static const IconPark cooperativeHandshake = IconPark._(
    id: 553,
    name: "cooperative-handshake",
    title: "合作握手",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["合作握手", "爱心"],
    rtl: true,
  );

  /// 坐标系统
  static const IconPark coordinateSystem = IconPark._(
    id: 554,
    name: "coordinate-system",
    title: "坐标系统",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["坐标系统", "3D", "立体", "坐标"],
    rtl: false,
  );

  /// 复制
  static const IconPark copy = IconPark._(
    id: 555,
    name: "copy",
    title: "复制",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["复制", "拷贝", "克隆", "叠加", "重叠"],
    rtl: true,
  );

  /// 复制链接
  static const IconPark copyLink = IconPark._(
    id: 556,
    name: "copy-link",
    title: "复制链接",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["复制链接", "地址", "绑定", "关联"],
    rtl: true,
  );

  /// 复制
  static const IconPark copyOne = IconPark._(
    id: 557,
    name: "copy-one",
    title: "复制",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["文章", "文档", "小说", "合同", "规则", "详情"],
    rtl: true,
  );

  /// 版权符号
  static const IconPark copyright = IconPark._(
    id: 558,
    name: "copyright",
    title: "版权符号",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["版权符号", "标志"],
    rtl: true,
  );

  /// 向下左角
  static const IconPark cornerDownLeft = IconPark._(
    id: 559,
    name: "corner-down-left",
    title: "向下左角",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向左", "左边", "方向", "箭头", "拐角", "撤回"],
    rtl: true,
  );

  /// 向下右角
  static const IconPark cornerDownRight = IconPark._(
    id: 560,
    name: "corner-down-right",
    title: "向下右角",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向右", "右边", "方向", "箭头", "拐角", "下"],
    rtl: true,
  );

  /// 左角向下
  static const IconPark cornerLeftDown = IconPark._(
    id: 561,
    name: "corner-left-down",
    title: "左角向下",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向下", "左边", "方向", "箭头", "拐角", "下"],
    rtl: true,
  );

  /// 左角向上
  static const IconPark cornerLeftUp = IconPark._(
    id: 562,
    name: "corner-left-up",
    title: "左角向上",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向上", "左边", "方向", "箭头", "拐角", "上"],
    rtl: true,
  );

  /// 右角向下
  static const IconPark cornerRightDown = IconPark._(
    id: 563,
    name: "corner-right-down",
    title: "右角向下",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向下", "右边", "下降", "方向", "箭头", "拐角", "下"],
    rtl: true,
  );

  /// 右角向上
  static const IconPark cornerRightUp = IconPark._(
    id: 564,
    name: "corner-right-up",
    title: "右角向上",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向上", "右边", "上升", "方向", "箭头", "拐角", "上"],
    rtl: true,
  );

  /// 向上左角
  static const IconPark cornerUpLeft = IconPark._(
    id: 565,
    name: "corner-up-left",
    title: "向上左角",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向左", "左角", "左上角", "左拐", "左侧", "方向"],
    rtl: true,
  );

  /// 向上右角
  static const IconPark cornerUpRight = IconPark._(
    id: 566,
    name: "corner-up-right",
    title: "向上右角",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向右", "右边", "方向", "箭头", "拐角", "上"],
    rtl: true,
  );

  /// 冠状病毒
  static const IconPark coronavirus = IconPark._(
    id: 567,
    name: "coronavirus",
    title: "冠状病毒",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["冠状病毒", "细菌", "生病"],
    rtl: false,
  );

  /// 正确的
  static const IconPark correct = IconPark._(
    id: 568,
    name: "correct",
    title: "正确的",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["正确的", "对勾", "成功"],
    rtl: true,
  );

  /// 化妆刷
  static const IconPark cosmeticBrush = IconPark._(
    id: 569,
    name: "cosmetic-brush",
    title: "化妆刷",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["笔"],
    rtl: true,
  );

  /// 优惠券
  static const IconPark coupon = IconPark._(
    id: 570,
    name: "coupon",
    title: "优惠券",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["优惠", "卡券", "促销", "电商", "钱", "折扣"],
    rtl: false,
  );

  /// 篮球场
  static const IconPark court = IconPark._(
    id: 571,
    name: "court",
    title: "篮球场",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["运动", "篮球", "场地"],
    rtl: false,
  );

  /// 芯片
  static const IconPark cpu = IconPark._(
    id: 572,
    name: "cpu",
    title: "芯片",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["芯片", "CPU", "GPU", "算法", "算力", "电路", "运算"],
    rtl: false,
  );

  /// 螃蟹
  static const IconPark crab = IconPark._(
    id: 573,
    name: "crab",
    title: "螃蟹",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["螃蟹", "海鲜", "生鲜", "梭子蟹"],
    rtl: false,
  );

  /// 按创建日期排序
  static const IconPark creationDateSort = IconPark._(
    id: 574,
    name: "creation-date-sort",
    title: "按创建日期排序",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["创建", "日期", "排序", "添加", "图表", "数据"],
    rtl: true,
  );

  /// 创意
  static const IconPark creative = IconPark._(
    id: 575,
    name: "creative",
    title: "创意",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["想法", "创新", "五星", "徽章"],
    rtl: false,
  );

  /// 信用卡
  static const IconPark credit = IconPark._(
    id: 576,
    name: "credit",
    title: "信用卡",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["卡片", "银行", "财务", "财富"],
    rtl: true,
  );

  /// 摇篮
  static const IconPark crib = IconPark._(
    id: 577,
    name: "crib",
    title: "摇篮",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["儿童床"],
    rtl: false,
  );

  /// 牛角面包
  static const IconPark croissant = IconPark._(
    id: 578,
    name: "croissant",
    title: "牛角面包",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["牛角包", "面包", "甜点", "零食", "下午茶"],
    rtl: true,
  );

  /// 交叉环
  static const IconPark crossRing = IconPark._(
    id: 579,
    name: "cross-ring",
    title: "交叉环",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "齐奉飞",
    tag: ["交叉", "环形", "关系"],
    rtl: false,
  );

  /// 魔比斯环
  static const IconPark crossRingTwo = IconPark._(
    id: 580,
    name: "cross-ring-two",
    title: "魔比斯环",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["魔比斯环", "循环", "双环", "关联"],
    rtl: true,
  );

  /// 红十字
  static const IconPark crossSociety = IconPark._(
    id: 581,
    name: "cross-society",
    title: "红十字",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 皇冠
  static const IconPark crown = IconPark._(
    id: 582,
    name: "crown",
    title: "皇冠",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["皇冠", "王冠", "皇上", "国王", "第一", "权利"],
    rtl: false,
  );

  /// 皇冠帽
  static const IconPark crownThree = IconPark._(
    id: 583,
    name: "crown-three",
    title: "皇冠帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["皇冠", "权利", "皇帝"],
    rtl: false,
  );

  /// 皇冠
  static const IconPark crownTwo = IconPark._(
    id: 584,
    name: "crown-two",
    title: "皇冠",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["皇冠", "王后", "国王", "徽章", "荣耀", "等级"],
    rtl: false,
  );

  /// 航海
  static const IconPark cruise = IconPark._(
    id: 585,
    name: "cruise",
    title: "航海",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["邮轮", "轮船", "航海", "轮渡"],
    rtl: false,
  );

  /// 孩子哭泣
  static const IconPark cryingBaby = IconPark._(
    id: 586,
    name: "crying-baby",
    title: "孩子哭泣",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["哭泣", "表情", "难过"],
    rtl: true,
  );

  /// 魔方
  static const IconPark cube = IconPark._(
    id: 587,
    name: "cube",
    title: "魔方",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["魔方", "六边形", "立方体", "立体"],
    rtl: false,
  );

  /// 魔方
  static const IconPark cubeFive = IconPark._(
    id: 588,
    name: "cube-five",
    title: "魔方",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["魔方", "六边形", "立方体"],
    rtl: false,
  );

  /// 魔方
  static const IconPark cubeFour = IconPark._(
    id: 589,
    name: "cube-four",
    title: "魔方",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["魔方", "六边形", "立方体", "零件"],
    rtl: false,
  );

  /// 魔方
  static const IconPark cubeThree = IconPark._(
    id: 590,
    name: "cube-three",
    title: "魔方",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["魔方", "六边形", "立方体", "零件"],
    rtl: false,
  );

  /// 魔方
  static const IconPark cubeTwo = IconPark._(
    id: 591,
    name: "cube-two",
    title: "魔方",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["魔方", "六边形", "三角拼接"],
    rtl: false,
  );

  /// 咖啡杯
  static const IconPark cup = IconPark._(
    id: 592,
    name: "cup",
    title: "咖啡杯",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["水", "水杯", "被子", "饮料", "咖啡", "热饮", "喝"],
    rtl: true,
  );

  /// 茶杯4
  static const IconPark cupFour = IconPark._(
    id: 593,
    name: "cup-four",
    title: "茶杯4",
    category: "Foods",
    categoryCN: "食品",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 杯子
  static const IconPark cupOne = IconPark._(
    id: 594,
    name: "cup-one",
    title: "杯子",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["杯子", "水杯", "喝水"],
    rtl: false,
  );

  /// 冰壶
  static const IconPark curling = IconPark._(
    id: 595,
    name: "curling",
    title: "冰壶",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["奥运会", "冰壶", "滑冰", "比赛", "运动", "团队项目", "体育"],
    rtl: true,
  );

  /// 货币流通
  static const IconPark currency = IconPark._(
    id: 596,
    name: "currency",
    title: "货币流通",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["钱", "银行", "财务", "财富"],
    rtl: true,
  );

  /// 曲线调整
  static const IconPark curveAdjustment = IconPark._(
    id: 597,
    name: "curve-adjustment",
    title: "曲线调整",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["曲线调整", "调整", "曲线", "动效"],
    rtl: true,
  );

  /// 小六客服
  static const IconPark customer = IconPark._(
    id: 598,
    name: "customer",
    title: "小六客服",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["客服", "聊天", "沟通", "oceanengine", "logo"],
    rtl: true,
  );

  /// 裁切
  static const IconPark cutting = IconPark._(
    id: 599,
    name: "cutting",
    title: "裁切",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["裁剪", "剪切", "编辑"],
    rtl: true,
  );

  /// 裁切
  static const IconPark cuttingOne = IconPark._(
    id: 600,
    name: "cutting-one",
    title: "裁切",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["裁剪", "剪切", "编辑", "剪刀"],
    rtl: false,
  );

  /// 试管
  static const IconPark cuvette = IconPark._(
    id: 601,
    name: "cuvette",
    title: "试管",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "金磊",
    tag: ["试管", "试验", "容器", "化学", "科学", "容器"],
    rtl: false,
  );

  /// 循环
  static const IconPark cycle = IconPark._(
    id: 602,
    name: "cycle",
    title: "循环",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["连续", "持续", "轮回", "圆圈", "循环", "抽象"],
    rtl: true,
  );

  /// 循环箭头
  static const IconPark cycleArrow = IconPark._(
    id: 603,
    name: "cycle-arrow",
    title: "循环箭头",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["循环箭头", "环绕", "连接"],
    rtl: false,
  );

  /// 循环移动
  static const IconPark cycleMovement = IconPark._(
    id: 604,
    name: "cycle-movement",
    title: "循环移动",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["循环", "移动", "收集", "集合", "汇集"],
    rtl: true,
  );

  /// 循环
  static const IconPark cycleOne = IconPark._(
    id: 605,
    name: "cycle-one",
    title: "循环",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["循环", "可利用", "周转", "抽象"],
    rtl: true,
  );

  /// 圆柱
  static const IconPark cylinder = IconPark._(
    id: 606,
    name: "cylinder",
    title: "圆柱",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆柱", "容器"],
    rtl: false,
  );

  /// 故障图
  static const IconPark damageMap = IconPark._(
    id: 607,
    name: "damage-map",
    title: "故障图",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["图片", "故障", "断裂", "破坏"],
    rtl: true,
  );

  /// 夜晚模式
  static const IconPark darkMode = IconPark._(
    id: 608,
    name: "dark-mode",
    title: "夜晚模式",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["模式", "亮度", "对比度", "黑暗"],
    rtl: true,
  );

  /// 仪表盘
  static const IconPark dashboard = IconPark._(
    id: 609,
    name: "dashboard",
    title: "仪表盘",
    category: "Time",
    categoryCN: "时间日期",
    author: "金磊",
    tag: ["仪表盘", "仪表", "指针", "数据", "转盘"],
    rtl: true,
  );

  /// 仪表盘
  static const IconPark dashboardCar = IconPark._(
    id: 610,
    name: "dashboard-car",
    title: "仪表盘",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["仪表盘", "汽车", "指针", "表盘"],
    rtl: false,
  );

  /// 仪表盘
  static const IconPark dashboardOne = IconPark._(
    id: 611,
    name: "dashboard-one",
    title: "仪表盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["仪表", "速度", "数值", "速度", "计数", "表盘", "统计", "温度", "转动"],
    rtl: true,
  );

  /// 仪表盘
  static const IconPark dashboardTwo = IconPark._(
    id: 612,
    name: "dashboard-two",
    title: "仪表盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["仪表盘", "仪表", "看板"],
    rtl: false,
  );

  /// 数据库
  static const IconPark data = IconPark._(
    id: 613,
    name: "data",
    title: "数据库",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据库", "叠加"],
    rtl: false,
  );

  /// 数据
  static const IconPark dataAll = IconPark._(
    id: 614,
    name: "data-all",
    title: "数据",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据库", "多数据", "满数据", "叠加"],
    rtl: false,
  );

  /// 数据到达
  static const IconPark dataArrival = IconPark._(
    id: 615,
    name: "data-arrival",
    title: "数据到达",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["任务完成", "结束", "成功"],
    rtl: true,
  );

  /// 数据显示
  static const IconPark dataDisplay = IconPark._(
    id: 616,
    name: "data-display",
    title: "数据显示",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据显示", "数据同步", "资源共享"],
    rtl: true,
  );

  /// 数据文件
  static const IconPark dataFile = IconPark._(
    id: 617,
    name: "data-file",
    title: "数据文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["数据", "指标", "增长", "趋势"],
    rtl: true,
  );

  /// 数据
  static const IconPark dataFour = IconPark._(
    id: 618,
    name: "data-four",
    title: "数据",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据库", "叠加"],
    rtl: false,
  );

  /// 数据锁定
  static const IconPark dataLock = IconPark._(
    id: 619,
    name: "data-lock",
    title: "数据锁定",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据锁定", "资源库"],
    rtl: true,
  );

  /// 数据空
  static const IconPark dataNull = IconPark._(
    id: 620,
    name: "data-null",
    title: "数据空",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据为空", "空数据", "无数据", "叠加"],
    rtl: false,
  );

  /// 数据
  static const IconPark dataOne = IconPark._(
    id: 621,
    name: "data-one",
    title: "数据",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据库", "叠加"],
    rtl: false,
  );

  /// 数据看板
  static const IconPark dataScreen = IconPark._(
    id: 622,
    name: "data-screen",
    title: "数据看板",
    category: "Charts",
    categoryCN: "数据图表",
    author: "史晓彤",
    tag: ["数据看板", "代码", "编程", "符号", "电脑"],
    rtl: true,
  );

  /// 数据服务器
  static const IconPark dataServer = IconPark._(
    id: 623,
    name: "data-server",
    title: "数据服务器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["数据服务器"],
    rtl: true,
  );

  /// 数据表
  static const IconPark dataSheet = IconPark._(
    id: 624,
    name: "data-sheet",
    title: "数据表",
    category: "Charts",
    categoryCN: "数据图表",
    author: "史晓彤",
    tag: ["数据", "图表", "屏幕", "数据表"],
    rtl: true,
  );

  /// 数据切换
  static const IconPark dataSwitching = IconPark._(
    id: 625,
    name: "data-switching",
    title: "数据切换",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据切换", "资源互换", "数据关联"],
    rtl: true,
  );

  /// 数据
  static const IconPark dataThree = IconPark._(
    id: 626,
    name: "data-three",
    title: "数据",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据库", "叠加"],
    rtl: false,
  );

  /// 数据
  static const IconPark dataTwo = IconPark._(
    id: 627,
    name: "data-two",
    title: "数据",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据库", "叠加"],
    rtl: false,
  );

  /// 数据用户
  static const IconPark dataUser = IconPark._(
    id: 628,
    name: "data-user",
    title: "数据用户",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据用户", "数据共享"],
    rtl: true,
  );

  /// 数据库警示
  static const IconPark databaseAlert = IconPark._(
    id: 629,
    name: "database-alert",
    title: "数据库警示",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库警示", "资源库"],
    rtl: true,
  );

  /// 数据库代码
  static const IconPark databaseCode = IconPark._(
    id: 630,
    name: "database-code",
    title: "数据库代码",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库代码"],
    rtl: true,
  );

  /// 数据库配置
  static const IconPark databaseConfig = IconPark._(
    id: 631,
    name: "database-config",
    title: "数据库配置",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库配置"],
    rtl: true,
  );

  /// 数据库下载
  static const IconPark databaseDownload = IconPark._(
    id: 632,
    name: "database-download",
    title: "数据库下载",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库下载", "资源下载"],
    rtl: true,
  );

  /// 数据库进入
  static const IconPark databaseEnter = IconPark._(
    id: 633,
    name: "database-enter",
    title: "数据库进入",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库进入", "数据移出"],
    rtl: true,
  );

  /// 数据库错误
  static const IconPark databaseFail = IconPark._(
    id: 634,
    name: "database-fail",
    title: "数据库错误",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库错误", "资源错误"],
    rtl: true,
  );

  /// 数据库第一
  static const IconPark databaseFirst = IconPark._(
    id: 635,
    name: "database-first",
    title: "数据库第一",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库第一"],
    rtl: true,
  );

  /// 数据库禁止
  static const IconPark databaseForbid = IconPark._(
    id: 636,
    name: "database-forbid",
    title: "数据库禁止",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库禁止", "保密", "资源封锁"],
    rtl: true,
  );

  /// 数据库锁定
  static const IconPark databaseLock = IconPark._(
    id: 637,
    name: "database-lock",
    title: "数据库锁定",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库锁定", "资源库"],
    rtl: true,
  );

  /// 数据库网络
  static const IconPark databaseNetwork = IconPark._(
    id: 638,
    name: "database-network",
    title: "数据库网络",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库网络", "资源库"],
    rtl: true,
  );

  /// 数据库网络节点
  static const IconPark databaseNetworkPoint = IconPark._(
    id: 639,
    name: "database-network-point",
    title: "数据库网络节点",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库网络节点"],
    rtl: false,
  );

  /// 数据库节点
  static const IconPark databasePoint = IconPark._(
    id: 640,
    name: "database-point",
    title: "数据库节点",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库节点"],
    rtl: true,
  );

  /// 数据库定位
  static const IconPark databasePosition = IconPark._(
    id: 641,
    name: "database-position",
    title: "数据库定位",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库定位"],
    rtl: true,
  );

  /// 数据库电源
  static const IconPark databasePower = IconPark._(
    id: 642,
    name: "database-power",
    title: "数据库电源",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库电源", "资源库"],
    rtl: true,
  );

  /// 数据库占比
  static const IconPark databaseProportion = IconPark._(
    id: 643,
    name: "database-proportion",
    title: "数据库占比",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库占比"],
    rtl: true,
  );

  /// 数据库搜索
  static const IconPark databaseSearch = IconPark._(
    id: 644,
    name: "database-search",
    title: "数据库搜索",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库搜索", "资源查找"],
    rtl: true,
  );

  /// 数据库设置
  static const IconPark databaseSetting = IconPark._(
    id: 645,
    name: "database-setting",
    title: "数据库设置",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库设置", "资源库"],
    rtl: true,
  );

  /// 数据库成功
  static const IconPark databaseSuccess = IconPark._(
    id: 646,
    name: "database-success",
    title: "数据库成功",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库成功", "保存成功"],
    rtl: true,
  );

  /// 数据库同步
  static const IconPark databaseSync = IconPark._(
    id: 647,
    name: "database-sync",
    title: "数据库同步",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库同步", "数据运转"],
    rtl: true,
  );

  /// 数据库时间
  static const IconPark databaseTime = IconPark._(
    id: 648,
    name: "database-time",
    title: "数据库时间",
    category: "Datas",
    categoryCN: "数据",
    author: "金磊",
    tag: ["数据库时间", "资源库"],
    rtl: true,
  );

  /// 回传数据
  static const IconPark dateComesBack = IconPark._(
    id: 649,
    name: "date-comes-back",
    title: "回传数据",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["数据", "指标", "增长", "趋势", "回传", "传送", "连接"],
    rtl: true,
  );

  /// 按截止日期排序
  static const IconPark deadlineSort = IconPark._(
    id: 650,
    name: "deadline-sort",
    title: "按截止日期排序",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["截止", "关闭", "排序", "截止日期"],
    rtl: true,
  );

  /// 死亡之星
  static const IconPark deathStar = IconPark._(
    id: 651,
    name: "death-star",
    title: "死亡之星",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["星星", "倒映", "球体", "风景"],
    rtl: true,
  );

  /// 链接
  static const IconPark deeplink = IconPark._(
    id: 652,
    name: "deeplink",
    title: "链接",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["深度链接", "连接", "联系"],
    rtl: true,
  );

  /// 鹿
  static const IconPark deer = IconPark._(
    id: 653,
    name: "deer",
    title: "鹿",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 学位帽
  static const IconPark degreeHat = IconPark._(
    id: 654,
    name: "degree-hat",
    title: "学位帽",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["今日学堂", "学位", "学习", "帽子"],
    rtl: true,
  );

  /// 删除
  static const IconPark delete = IconPark._(
    id: 655,
    name: "delete",
    title: "删除",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["删除", "垃圾桶", "勒色桶", "回收"],
    rtl: false,
  );

  /// 删除5
  static const IconPark deleteFive = IconPark._(
    id: 656,
    name: "delete-five",
    title: "删除5",
    category: "Edit",
    categoryCN: "编辑",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 删除4
  static const IconPark deleteFour = IconPark._(
    id: 657,
    name: "delete-four",
    title: "删除4",
    category: "Edit",
    categoryCN: "编辑",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 删除键
  static const IconPark deleteKey = IconPark._(
    id: 658,
    name: "delete-key",
    title: "删除键",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["删除", "去除"],
    rtl: true,
  );

  /// 删除模式
  static const IconPark deleteMode = IconPark._(
    id: 659,
    name: "delete-mode",
    title: "删除模式",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["模式", "亮度", "对比度", "减少"],
    rtl: true,
  );

  /// 删除
  static const IconPark deleteOne = IconPark._(
    id: 660,
    name: "delete-one",
    title: "删除",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["删除", "垃圾桶", "勒色桶", "回收"],
    rtl: false,
  );

  /// 删除主题
  static const IconPark deleteThemes = IconPark._(
    id: 661,
    name: "delete-themes",
    title: "删除主题",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["删除", "清理", "移至废纸篓", "垃圾桶"],
    rtl: true,
  );

  /// 删除
  static const IconPark deleteThree = IconPark._(
    id: 662,
    name: "delete-three",
    title: "删除",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["删除", "关闭", "错误", "乘号"],
    rtl: true,
  );

  /// 删除
  static const IconPark deleteTwo = IconPark._(
    id: 663,
    name: "delete-two",
    title: "删除",
    category: "Base",
    categoryCN: "基础",
    author: "金磊",
    tag: ["删除", "清除", "消除", "关闭"],
    rtl: true,
  );

  /// 交货
  static const IconPark delivery = IconPark._(
    id: 664,
    name: "delivery",
    title: "交货",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["服务", "传递", "交付", "拱手相让"],
    rtl: true,
  );

  /// 存款
  static const IconPark deposit = IconPark._(
    id: 665,
    name: "deposit",
    title: "存款",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["钱", "银行", "财务", "财富"],
    rtl: false,
  );

  /// 下降
  static const IconPark descend = IconPark._(
    id: 666,
    name: "descend",
    title: "下降",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["下降", "降落"],
    rtl: true,
  );

  /// 台灯
  static const IconPark deskLamp = IconPark._(
    id: 667,
    name: "desk-lamp",
    title: "台灯",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["灯具", "电灯"],
    rtl: true,
  );

  /// 台灯1
  static const IconPark deskLampOne = IconPark._(
    id: 668,
    name: "desk-lamp-one",
    title: "台灯1",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 检测
  static const IconPark detection = IconPark._(
    id: 669,
    name: "detection",
    title: "检测",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["检查", "测试", "实验", "测量"],
    rtl: true,
  );

  /// 设备
  static const IconPark devices = IconPark._(
    id: 670,
    name: "devices",
    title: "设备",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["设备", "手机", "平板电脑", "移动端", "网络", "屏幕"],
    rtl: true,
  );

  /// 钻石
  static const IconPark diamond = IconPark._(
    id: 671,
    name: "diamond",
    title: "钻石",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["钻石", "钻戒", "戒指", "结婚"],
    rtl: false,
  );

  /// 钻石项链
  static const IconPark diamondNecklace = IconPark._(
    id: 672,
    name: "diamond-necklace",
    title: "钻石项链",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["项链", "挂件", "宝石", "首饰"],
    rtl: false,
  );

  /// 菱形1
  static const IconPark diamondOne = IconPark._(
    id: 673,
    name: "diamond-one",
    title: "菱形1",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 钻戒
  static const IconPark diamondRing = IconPark._(
    id: 674,
    name: "diamond-ring",
    title: "钻戒",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["钻石", "戒指", "首饰"],
    rtl: false,
  );

  /// 菱形3
  static const IconPark diamondThree = IconPark._(
    id: 675,
    name: "diamond-three",
    title: "菱形3",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 菱形2
  static const IconPark diamondTwo = IconPark._(
    id: 676,
    name: "diamond-two",
    title: "菱形2",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 钻石
  static const IconPark diamonds = IconPark._(
    id: 677,
    name: "diamonds",
    title: "钻石",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["钻", "宝石", "sketch"],
    rtl: false,
  );

  /// 电子签
  static const IconPark dianziqian = IconPark._(
    id: 678,
    name: "dianziqian",
    title: "电子签",
    category: "Brand",
    categoryCN: "品牌",
    author: "",
    tag: ["logo", "电子签", "签合同", "合作"],
    rtl: true,
  );

  /// 尿不湿
  static const IconPark diapersOne = IconPark._(
    id: 679,
    name: "diapers-one",
    title: "尿不湿",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["内裤", "短裤", "尿不湿"],
    rtl: false,
  );

  /// 差异集
  static const IconPark differenceSet = IconPark._(
    id: 680,
    name: "difference-set",
    title: "差异集",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["交集", "路径查找器", "排除"],
    rtl: true,
  );

  /// 电子表
  static const IconPark digitalWatches = IconPark._(
    id: 681,
    name: "digital-watches",
    title: "电子表",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["计时器", "手表", "时间", "智能手表", "机械表"],
    rtl: true,
  );

  /// 方向
  static const IconPark direction = IconPark._(
    id: 682,
    name: "direction",
    title: "方向",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["游戏", "方向", "左右", "手柄"],
    rtl: false,
  );

  /// 方向校准
  static const IconPark directionAdjustment = IconPark._(
    id: 683,
    name: "direction-adjustment",
    title: "方向校准",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["方向校准", "方向箭头"],
    rtl: false,
  );

  /// 方向校准
  static const IconPark directionAdjustmentThree = IconPark._(
    id: 684,
    name: "direction-adjustment-three",
    title: "方向校准",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["方向校准", "方向箭头"],
    rtl: false,
  );

  /// 方向校准
  static const IconPark directionAdjustmentTwo = IconPark._(
    id: 685,
    name: "direction-adjustment-two",
    title: "方向校准",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["方向校准", "方向箭头"],
    rtl: false,
  );

  /// 网页禁用
  static const IconPark disabaledWeb = IconPark._(
    id: 686,
    name: "disabaled-web",
    title: "网页禁用",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 计算机禁用
  static const IconPark disabledComputer = IconPark._(
    id: 687,
    name: "disabled-computer",
    title: "计算机禁用",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 笔记本电脑禁用
  static const IconPark disabledLaptop = IconPark._(
    id: 688,
    name: "disabled-laptop",
    title: "笔记本电脑禁用",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 图片禁用
  static const IconPark disabledPicture = IconPark._(
    id: 689,
    name: "disabled-picture",
    title: "图片禁用",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 失落
  static const IconPark disappointedFace = IconPark._(
    id: 690,
    name: "disappointed-face",
    title: "失落",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["失落", "表情", "伤心", "沮丧"],
    rtl: false,
  );

  /// 发现指数
  static const IconPark discoveryIndex = IconPark._(
    id: 691,
    name: "discovery-index",
    title: "发现指数",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["阴线", "阳线", "股市图", "指数"],
    rtl: false,
  );

  /// 磁盘
  static const IconPark disk = IconPark._(
    id: 692,
    name: "disk",
    title: "磁盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["保存", "存储", "储存", "硬盘", "磁盘"],
    rtl: true,
  );

  /// U盘1
  static const IconPark diskOne = IconPark._(
    id: 693,
    name: "disk-one",
    title: "U盘1",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: false,
  );

  /// U盘2
  static const IconPark diskTwo = IconPark._(
    id: 694,
    name: "disk-two",
    title: "U盘2",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: true,
  );

  /// 不喜欢
  static const IconPark dislike = IconPark._(
    id: 695,
    name: "dislike",
    title: "不喜欢",
    category: "Base",
    categoryCN: "基础",
    author: "金磊",
    tag: ["喜欢", "讨厌", "不喜欢", "心碎", "裂痕"],
    rtl: true,
  );

  /// 不喜欢
  static const IconPark dislikeTwo = IconPark._(
    id: 696,
    name: "dislike-two",
    title: "不喜欢",
    category: "Base",
    categoryCN: "基础",
    author: "金磊",
    tag: ["讨厌", "不喜欢", "爱心"],
    rtl: false,
  );

  /// 显示屏
  static const IconPark display = IconPark._(
    id: 697,
    name: "display",
    title: "显示屏",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["显示屏", "白板", "展示", "投屏"],
    rtl: true,
  );

  /// 扭曲
  static const IconPark distortion = IconPark._(
    id: 698,
    name: "distortion",
    title: "扭曲",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["扭曲", "不规则", "网格"],
    rtl: true,
  );

  /// 闭眼生气
  static const IconPark distraughtFace = IconPark._(
    id: 699,
    name: "distraught-face",
    title: "闭眼生气",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["闭眼生气", "表情", "害怕"],
    rtl: false,
  );

  /// 水平间距分布
  static const IconPark distributeHorizontalSpacing = IconPark._(
    id: 700,
    name: "distribute-horizontal-spacing",
    title: "水平间距分布",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["水平间距分布", "横向居中对齐"],
    rtl: false,
  );

  /// 水平分布
  static const IconPark distributeHorizontally = IconPark._(
    id: 701,
    name: "distribute-horizontally",
    title: "水平分布",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["水平分布", "间距"],
    rtl: false,
  );

  /// 垂直间距分布
  static const IconPark distributeVerticalSpacing = IconPark._(
    id: 702,
    name: "distribute-vertical-spacing",
    title: "垂直间距分布",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["垂直间距分布", "纵向居中对齐"],
    rtl: false,
  );

  /// 垂直分布
  static const IconPark distributeVertically = IconPark._(
    id: 703,
    name: "distribute-vertically",
    title: "垂直分布",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["垂直分布", "间距"],
    rtl: true,
  );

  /// 分界线
  static const IconPark dividingLine = IconPark._(
    id: 704,
    name: "dividing-line",
    title: "分界线",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["分割线", "界线", "马路", "道路"],
    rtl: false,
  );

  /// 分割线
  static const IconPark dividingLineOne = IconPark._(
    id: 705,
    name: "dividing-line-one",
    title: "分割线",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["分割线", "区分", "线段"],
    rtl: false,
  );

  /// 潜水
  static const IconPark diving = IconPark._(
    id: 706,
    name: "diving",
    title: "潜水",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["潜水", "游泳镜", "游泳"],
    rtl: true,
  );

  /// 潜水瓶
  static const IconPark divingBottle = IconPark._(
    id: 707,
    name: "diving-bottle",
    title: "潜水瓶",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["潜水", "氧气瓶", "补给", "装备", "瓶子", "救生", "医疗", "换气", "体育"],
    rtl: true,
  );

  /// 潜水装
  static const IconPark divingSuit = IconPark._(
    id: 708,
    name: "diving-suit",
    title: "潜水装",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["潜水", "服装", "装备", "潜水服", "衣服", "呼吸", "换气", "眼罩", "体育"],
    rtl: true,
  );

  /// 除号
  static const IconPark division = IconPark._(
    id: 709,
    name: "division",
    title: "除号",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["符号", "乘除", "除法"],
    rtl: false,
  );

  /// 张嘴晕
  static const IconPark dizzyFace = IconPark._(
    id: 710,
    name: "dizzy-face",
    title: "张嘴晕",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["张嘴晕", "表情", "昏倒"],
    rtl: false,
  );

  /// 文档添加
  static const IconPark docAdd = IconPark._(
    id: 711,
    name: "doc-add",
    title: "文档添加",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["文档添加", "文本", "文件", "添加"],
    rtl: true,
  );

  /// 文档详情
  static const IconPark docDetail = IconPark._(
    id: 712,
    name: "doc-detail",
    title: "文档详情",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["文档详情", "文本", "文件", "排版"],
    rtl: true,
  );

  /// 文档失败
  static const IconPark docFail = IconPark._(
    id: 713,
    name: "doc-fail",
    title: "文档失败",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["文档失败", "文本", "文件", "失败"],
    rtl: true,
  );

  /// 文档搜索
  static const IconPark docSearch = IconPark._(
    id: 714,
    name: "doc-search",
    title: "文档搜索",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["文档搜索", "文件", "查找内容", "文本"],
    rtl: true,
  );

  /// 文档搜索
  static const IconPark docSearchTwo = IconPark._(
    id: 715,
    name: "doc-search-two",
    title: "文档搜索",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["文档搜索", "文本", "文件", "查找"],
    rtl: true,
  );

  /// 文档成功
  static const IconPark docSuccess = IconPark._(
    id: 716,
    name: "doc-success",
    title: "文档成功",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["文档成功", "文本", "文件", "成功"],
    rtl: true,
  );

  /// 文档架子
  static const IconPark documentFolder = IconPark._(
    id: 717,
    name: "document-folder",
    title: "文档架子",
    category: "Office",
    categoryCN: "办公文档",
    author: "白明泽",
    tag: ["文档", "书架", "办公", "图书", "文件", "资料"],
    rtl: true,
  );

  /// 狗
  static const IconPark dog = IconPark._(
    id: 718,
    name: "dog",
    title: "狗",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 生肖狗
  static const IconPark dogZodiac = IconPark._(
    id: 719,
    name: "dog-zodiac",
    title: "生肖狗",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 美元
  static const IconPark dollar = IconPark._(
    id: 720,
    name: "dollar",
    title: "美元",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["美元", "钱", "财富", "货币", "经济"],
    rtl: true,
  );

  /// 海豚
  static const IconPark dolphin = IconPark._(
    id: 721,
    name: "dolphin",
    title: "海豚",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 圆顶
  static const IconPark dome = IconPark._(
    id: 722,
    name: "dome",
    title: "圆顶",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["地球", "圆球", "纬度", "地理"],
    rtl: false,
  );

  /// 顶灯
  static const IconPark domeLight = IconPark._(
    id: 723,
    name: "dome-light",
    title: "顶灯",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["灯", "光", "亮", "家具", "装饰", "闪光", "打光", "照亮"],
    rtl: false,
  );

  /// 完成全部
  static const IconPark doneAll = IconPark._(
    id: 724,
    name: "done-all",
    title: "完成全部",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["全部完成", "打勾", "勾选", "全选"],
    rtl: true,
  );

  /// 懂车帝
  static const IconPark dongchedi = IconPark._(
    id: 725,
    name: "dongchedi",
    title: "懂车帝",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["汽车", "资讯", "媒体", "logo", "字节跳动", "懂车帝"],
    rtl: false,
  );

  /// 门把手
  static const IconPark doorHandle = IconPark._(
    id: 726,
    name: "door-handle",
    title: "门把手",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["门把手", "房间", "开门"],
    rtl: true,
  );

  /// 点
  static const IconPark dot = IconPark._(
    id: 727,
    name: "dot",
    title: "点",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["圆点", "黑点", "圈", "实心"],
    rtl: true,
  );

  /// 双人床
  static const IconPark doubleBed = IconPark._(
    id: 728,
    name: "double-bed",
    title: "双人床",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["双人床", "睡觉", "休息"],
    rtl: false,
  );

  /// 双下
  static const IconPark doubleDown = IconPark._(
    id: 729,
    name: "double-down",
    title: "双下",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["双下", "向下", "双箭头", "方向"],
    rtl: false,
  );

  /// 双左
  static const IconPark doubleLeft = IconPark._(
    id: 730,
    name: "double-left",
    title: "双左",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["倒回", "返回", "双箭头", "向左", "上一个", "方向"],
    rtl: true,
  );

  /// 双右
  static const IconPark doubleRight = IconPark._(
    id: 731,
    name: "double-right",
    title: "双右",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["快进", "向右", "双箭头", "下一个", "方向"],
    rtl: true,
  );

  /// 双上
  static const IconPark doubleUp = IconPark._(
    id: 732,
    name: "double-up",
    title: "双上",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["双上", "向上", "双箭头", "方向"],
    rtl: false,
  );

  /// 甜甜圈
  static const IconPark doughnut = IconPark._(
    id: 733,
    name: "doughnut",
    title: "甜甜圈",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["甜甜圈", "面包", "甜点", "糕点"],
    rtl: true,
  );

  /// 下
  static const IconPark down = IconPark._(
    id: 734,
    name: "down",
    title: "下",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向下", "箭头", "方向"],
    rtl: false,
  );

  /// 下-圆
  static const IconPark downC = IconPark._(
    id: 735,
    name: "down-c",
    title: "下-圆",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向下", "箭头", "圆圈箭头"],
    rtl: false,
  );

  /// 下1
  static const IconPark downOne = IconPark._(
    id: 736,
    name: "down-one",
    title: "下1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向下", "箭头", "方向"],
    rtl: false,
  );

  /// 图片下载
  static const IconPark downPicture = IconPark._(
    id: 737,
    name: "down-picture",
    title: "图片下载",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 下-小
  static const IconPark downSmall = IconPark._(
    id: 738,
    name: "down-small",
    title: "下-小",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向下", "箭头", "方向"],
    rtl: false,
  );

  /// 下箭头-方
  static const IconPark downSquare = IconPark._(
    id: 739,
    name: "down-square",
    title: "下箭头-方",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向下", "箭头", "方形箭头"],
    rtl: false,
  );

  /// 下1
  static const IconPark downTwo = IconPark._(
    id: 740,
    name: "down-two",
    title: "下1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "下", "指针", "方向"],
    rtl: false,
  );

  /// 下载
  static const IconPark download = IconPark._(
    id: 741,
    name: "download",
    title: "下载",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["下载", "向下", "箭头"],
    rtl: false,
  );

  /// 计算机下载
  static const IconPark downloadComputer = IconPark._(
    id: 742,
    name: "download-computer",
    title: "计算机下载",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 下载
  static const IconPark downloadFour = IconPark._(
    id: 743,
    name: "download-four",
    title: "下载",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["向下", "下载", "指向"],
    rtl: false,
  );

  /// 笔记本电脑下载
  static const IconPark downloadLaptop = IconPark._(
    id: 744,
    name: "download-laptop",
    title: "笔记本电脑下载",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 下载1
  static const IconPark downloadOne = IconPark._(
    id: 745,
    name: "download-one",
    title: "下载1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["下载", "云下载"],
    rtl: true,
  );

  /// 下载3
  static const IconPark downloadThree = IconPark._(
    id: 746,
    name: "download-three",
    title: "下载3",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向下", "下载"],
    rtl: false,
  );

  /// 下载2
  static const IconPark downloadTwo = IconPark._(
    id: 747,
    name: "download-two",
    title: "下载2",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["下载", "云下载"],
    rtl: true,
  );

  /// 网页下载
  static const IconPark downloadWeb = IconPark._(
    id: 748,
    name: "download-web",
    title: "网页下载",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 拖拽
  static const IconPark drag = IconPark._(
    id: 749,
    name: "drag",
    title: "拖拽",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["拉", "拖拽", "位移", "移动", "六点"],
    rtl: false,
  );

  /// 生肖龙
  static const IconPark dragonZodiac = IconPark._(
    id: 750,
    name: "dragon-zodiac",
    title: "生肖龙",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 追波
  static const IconPark dribble = IconPark._(
    id: 751,
    name: "dribble",
    title: "追波",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["logo", "设计", "社区", "分享", "国际设计师社区", "design", "designer", "share", "球"],
    rtl: true,
  );

  /// 饮料
  static const IconPark drink = IconPark._(
    id: 752,
    name: "drink",
    title: "饮料",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水杯", "果汁", "汽水", "咖啡", "奶茶"],
    rtl: true,
  );

  /// 无人机
  static const IconPark drone = IconPark._(
    id: 753,
    name: "drone",
    title: "无人机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["无人机", "飞机", "玩具", "数码", "飞行", "飞盘"],
    rtl: false,
  );

  /// 无人机
  static const IconPark droneOne = IconPark._(
    id: 754,
    name: "drone-one",
    title: "无人机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["飞机", "遥控", "飞行", "航空", "航行", "飞"],
    rtl: false,
  );

  /// 下拉列表
  static const IconPark dropDownList = IconPark._(
    id: 755,
    name: "drop-down-list",
    title: "下拉列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["下拉", "列表", "表单", "向下", "下展"],
    rtl: true,
  );

  /// 下投影
  static const IconPark dropShadowDown = IconPark._(
    id: 756,
    name: "drop-shadow-down",
    title: "下投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["下投影", "圆", "阴影"],
    rtl: false,
  );

  /// 左投影
  static const IconPark dropShadowLeft = IconPark._(
    id: 757,
    name: "drop-shadow-left",
    title: "左投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["左投影", "圆", "阴影"],
    rtl: true,
  );

  /// 右投影
  static const IconPark dropShadowRight = IconPark._(
    id: 758,
    name: "drop-shadow-right",
    title: "右投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["右投影", "圆", "阴影"],
    rtl: true,
  );

  /// 上投影
  static const IconPark dropShadowUp = IconPark._(
    id: 759,
    name: "drop-shadow-up",
    title: "上投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["上投影", "圆", "阴影"],
    rtl: false,
  );

  /// 管理箱
  static const IconPark dropbox = IconPark._(
    id: 760,
    name: "dropbox",
    title: "管理箱",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["盒子", "箱子", "管理", "存储", "logo"],
    rtl: true,
  );

  /// 鸡腿
  static const IconPark drumstick = IconPark._(
    id: 761,
    name: "drumstick",
    title: "鸡腿",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["鸡腿", "肉食", "鸡肉"],
    rtl: true,
  );

  /// 迪拜大厦
  static const IconPark dubai = IconPark._(
    id: 762,
    name: "dubai",
    title: "迪拜大厦",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["迪拜", "大厦", "高楼", "楼宇", "建筑"],
    rtl: true,
  );

  /// 鸭子
  static const IconPark duck = IconPark._(
    id: 763,
    name: "duck",
    title: "鸭子",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 杠铃
  static const IconPark dumbbelLine = IconPark._(
    id: 764,
    name: "dumbbel-line",
    title: "杠铃",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 健身
  static const IconPark dumbbell = IconPark._(
    id: 765,
    name: "dumbbell",
    title: "健身",
    category: "Sports",
    categoryCN: "体育运动",
    author: "常留留",
    tag: ["健身", "运动", "减肥", "体育", "哑铃", "举重"],
    rtl: false,
  );

  /// DVI
  static const IconPark dvi = IconPark._(
    id: 766,
    name: "dvi",
    title: "DVI",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "dvi"],
    rtl: true,
  );

  /// 鹰
  static const IconPark eagle = IconPark._(
    id: 767,
    name: "eagle",
    title: "鹰",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 地球仪
  static const IconPark earth = IconPark._(
    id: 768,
    name: "earth",
    title: "地球仪",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "白明泽",
    tag: ["网路", "语言", "全球", "互联网"],
    rtl: false,
  );

  /// 简单
  static const IconPark easy = IconPark._(
    id: 769,
    name: "easy",
    title: "简单",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["差劲", "小拇指", "手势", "手指"],
    rtl: true,
  );

  /// 心电图2
  static const IconPark ecg = IconPark._(
    id: 770,
    name: "ecg",
    title: "心电图2",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 编辑
  static const IconPark edit = IconPark._(
    id: 771,
    name: "edit",
    title: "编辑",
    category: "Edit",
    categoryCN: "编辑",
    author: "白明泽",
    tag: ["撰写", "修改", "编辑", "输入"],
    rtl: true,
  );

  /// 影片剪辑
  static const IconPark editMovie = IconPark._(
    id: 772,
    name: "edit-movie",
    title: "影片剪辑",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["影片剪辑", "编辑"],
    rtl: false,
  );

  /// 编辑姓名
  static const IconPark editName = IconPark._(
    id: 773,
    name: "edit-name",
    title: "编辑姓名",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 编辑1
  static const IconPark editOne = IconPark._(
    id: 774,
    name: "edit-one",
    title: "编辑1",
    category: "Edit",
    categoryCN: "编辑",
    author: "白明泽",
    tag: ["撰写", "修改", "文本", "编辑", "输入"],
    rtl: true,
  );

  /// 编辑2
  static const IconPark editTwo = IconPark._(
    id: 775,
    name: "edit-two",
    title: "编辑2",
    category: "Edit",
    categoryCN: "编辑",
    author: "白明泽",
    tag: ["撰写", "修改", "编辑", "输入"],
    rtl: true,
  );

  /// 剪辑
  static const IconPark editing = IconPark._(
    id: 776,
    name: "editing",
    title: "剪辑",
    category: "Edit",
    categoryCN: "编辑",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 编辑
  static const IconPark editor = IconPark._(
    id: 777,
    name: "editor",
    title: "编辑",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["修改", "撰写", "书写", "写作", "抄袭", "文章", "文档", "小说", "合同", "规则", "详情"],
    rtl: true,
  );

  /// 脑电图
  static const IconPark eeg = IconPark._(
    id: 778,
    name: "eeg",
    title: "脑电图",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 特效
  static const IconPark effects = IconPark._(
    id: 779,
    name: "effects",
    title: "特效",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["美化", "效果", "化妆", "变美", "改变"],
    rtl: true,
  );

  /// 传出4
  static const IconPark efferentFour = IconPark._(
    id: 780,
    name: "efferent-four",
    title: "传出4",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 传出3
  static const IconPark efferentThree = IconPark._(
    id: 781,
    name: "efferent-three",
    title: "传出3",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 煎鸡蛋
  static const IconPark egg = IconPark._(
    id: 782,
    name: "egg",
    title: "煎鸡蛋",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["摊鸡蛋", "早餐", "煎蛋"],
    rtl: true,
  );

  /// 鸡蛋
  static const IconPark eggOne = IconPark._(
    id: 783,
    name: "egg-one",
    title: "鸡蛋",
    category: "Foods",
    categoryCN: "食品",
    author: "史晓彤",
    tag: ["鸡蛋", "美妆蛋"],
    rtl: true,
  );

  /// 茄子
  static const IconPark eggplant = IconPark._(
    id: 784,
    name: "eggplant",
    title: "茄子",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["茄子", "蔬菜", "生鲜"],
    rtl: true,
  );

  /// 埃菲尔铁塔
  static const IconPark eiffelTower = IconPark._(
    id: 785,
    name: "eiffel-tower",
    title: "埃菲尔铁塔",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["铁塔", "法国建筑", "浪漫"],
    rtl: false,
  );

  /// 按键八
  static const IconPark eightKey = IconPark._(
    id: 786,
    name: "eight-key",
    title: "按键八",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["八", "8", "按键"],
    rtl: false,
  );

  /// 电钻
  static const IconPark electricDrill = IconPark._(
    id: 787,
    name: "electric-drill",
    title: "电钻",
    category: "Industry",
    categoryCN: "工业",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 电熨斗
  static const IconPark electricIron = IconPark._(
    id: 788,
    name: "electric-iron",
    title: "电熨斗",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["加热", "电", "烫衣服", "烫印", "烙印"],
    rtl: true,
  );

  /// 电波
  static const IconPark electricWave = IconPark._(
    id: 789,
    name: "electric-wave",
    title: "电波",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["电流", "电波", "心电图", "股票", "浮动"],
    rtl: true,
  );

  /// 心电图
  static const IconPark electrocardiogram = IconPark._(
    id: 790,
    name: "electrocardiogram",
    title: "心电图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["报警", "监控", "监视", "心电图"],
    rtl: true,
  );

  /// 智能门锁
  static const IconPark electronicDoorLock = IconPark._(
    id: 791,
    name: "electronic-door-lock",
    title: "智能门锁",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["门", "锁", "智能", "密码锁", "安全", "防盗门", "关门", "加密"],
    rtl: true,
  );

  /// 电子锁关
  static const IconPark electronicLocksClose = IconPark._(
    id: 792,
    name: "electronic-locks-close",
    title: "电子锁关",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["锁", "电子", "感应", "关"],
    rtl: true,
  );

  /// 电子锁开
  static const IconPark electronicLocksOpen = IconPark._(
    id: 793,
    name: "electronic-locks-open",
    title: "电子锁开",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["锁", "电子", "感应", "开"],
    rtl: false,
  );

  /// 触电笔
  static const IconPark electronicPen = IconPark._(
    id: 794,
    name: "electronic-pen",
    title: "触电笔",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["电笔", "体温计"],
    rtl: true,
  );

  /// 大象
  static const IconPark elephant = IconPark._(
    id: 795,
    name: "elephant",
    title: "大象",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 电梯
  static const IconPark elevator = IconPark._(
    id: 796,
    name: "elevator",
    title: "电梯",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["电梯", "上下楼", "门"],
    rtl: true,
  );

  /// 邮件屏蔽
  static const IconPark emailBlock = IconPark._(
    id: 797,
    name: "email-block",
    title: "邮件屏蔽",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "禁止查看", "错误提示"],
    rtl: true,
  );

  /// 邮件删除
  static const IconPark emailDelect = IconPark._(
    id: 798,
    name: "email-delect",
    title: "邮件删除",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "删除邮件"],
    rtl: true,
  );

  /// 邮件下载
  static const IconPark emailDown = IconPark._(
    id: 799,
    name: "email-down",
    title: "邮件下载",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "下载邮件"],
    rtl: false,
  );

  /// 邮件发送失败
  static const IconPark emailFail = IconPark._(
    id: 800,
    name: "email-fail",
    title: "邮件发送失败",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "删除邮件", "关闭邮件"],
    rtl: true,
  );

  /// 邮件锁定
  static const IconPark emailLock = IconPark._(
    id: 801,
    name: "email-lock",
    title: "邮件锁定",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "保密邮件"],
    rtl: true,
  );

  /// 邮件推送
  static const IconPark emailPush = IconPark._(
    id: 802,
    name: "email-push",
    title: "邮件推送",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "转发邮件"],
    rtl: true,
  );

  /// 邮件搜索
  static const IconPark emailSearch = IconPark._(
    id: 803,
    name: "email-search",
    title: "邮件搜索",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "搜索邮件", "查找邮件"],
    rtl: true,
  );

  /// 邮件安全
  static const IconPark emailSecurity = IconPark._(
    id: 804,
    name: "email-security",
    title: "邮件安全",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "保护邮件", "安全"],
    rtl: true,
  );

  /// 邮件发送成功
  static const IconPark emailSuccessfully = IconPark._(
    id: 805,
    name: "email-successfully",
    title: "邮件发送成功",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "发送成功"],
    rtl: true,
  );

  /// 开心
  static const IconPark emotionHappy = IconPark._(
    id: 806,
    name: "emotion-happy",
    title: "开心",
    category: "Emoji",
    categoryCN: "表情",
    author: "刘心乐",
    tag: ["表情", "成功", "笑脸", "喜悦"],
    rtl: false,
  );

  /// 不开心
  static const IconPark emotionUnhappy = IconPark._(
    id: 807,
    name: "emotion-unhappy",
    title: "不开心",
    category: "Emoji",
    categoryCN: "表情",
    author: "刘心乐",
    tag: ["表情", "失败", "哭脸", "不开心", "悲伤"],
    rtl: false,
  );

  /// 空手
  static const IconPark empty = IconPark._(
    id: 808,
    name: "empty",
    title: "空手",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["摊手", "空手", "伸手"],
    rtl: true,
  );

  /// 按结束时间排序
  static const IconPark endTimeSort = IconPark._(
    id: 809,
    name: "end-time-sort",
    title: "按结束时间排序",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["排序", "序列", "按时间排序"],
    rtl: true,
  );

  /// 无穷尽
  static const IconPark endless = IconPark._(
    id: 810,
    name: "endless",
    title: "无穷尽",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "史晓彤",
    tag: ["基因", "链接", "无穷大", "闭环", "相交", "循环"],
    rtl: true,
  );

  /// 内分泌
  static const IconPark endocrine = IconPark._(
    id: 811,
    name: "endocrine",
    title: "内分泌",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["分泌", "火", "新陈代谢"],
    rtl: true,
  );

  /// 端点位移
  static const IconPark endpointDisplacement = IconPark._(
    id: 812,
    name: "endpoint-displacement",
    title: "端点位移",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["端点位移"],
    rtl: true,
  );

  /// 方头端点
  static const IconPark endpointFlat = IconPark._(
    id: 813,
    name: "endpoint-flat",
    title: "方头端点",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["端点类型", "方头端点"],
    rtl: true,
  );

  /// 圆头端点
  static const IconPark endpointRound = IconPark._(
    id: 814,
    name: "endpoint-round",
    title: "圆头端点",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["端点类型", "圆头断点"],
    rtl: true,
  );

  /// 平头端点
  static const IconPark endpointSquare = IconPark._(
    id: 815,
    name: "endpoint-square",
    title: "平头端点",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["端点类型", "平头端点"],
    rtl: true,
  );

  /// 能源插座
  static const IconPark energySocket = IconPark._(
    id: 816,
    name: "energy-socket",
    title: "能源插座",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["能源插座"],
    rtl: false,
  );

  /// 工程牌
  static const IconPark engineeringBrand = IconPark._(
    id: 817,
    name: "engineering-brand",
    title: "工程牌",
    category: "Industry",
    categoryCN: "工业",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 工程车
  static const IconPark engineeringVehicle = IconPark._(
    id: 818,
    name: "engineering-vehicle",
    title: "工程车",
    category: "Industry",
    categoryCN: "工业",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 英文
  static const IconPark english = IconPark._(
    id: 819,
    name: "english",
    title: "英文",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["英", "英文", "英语", "西文"],
    rtl: true,
  );

  /// 胡子
  static const IconPark englishMustache = IconPark._(
    id: 820,
    name: "english-mustache",
    title: "胡子",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["胡须"],
    rtl: false,
  );

  /// 安检
  static const IconPark enquire = IconPark._(
    id: 821,
    name: "enquire",
    title: "安检",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["问询", "检票", "人工", "安检", "沟通"],
    rtl: true,
  );

  /// 回车键
  static const IconPark enterKey = IconPark._(
    id: 822,
    name: "enter-key",
    title: "回车键",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["回车键", "键盘"],
    rtl: true,
  );

  /// 回车键
  static const IconPark enterKeyOne = IconPark._(
    id: 823,
    name: "enter-key-one",
    title: "回车键",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["回车"],
    rtl: true,
  );

  /// 输入键盘
  static const IconPark enterTheKeyboard = IconPark._(
    id: 824,
    name: "enter-the-keyboard",
    title: "输入键盘",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["输入", "录入", "键盘", "打字"],
    rtl: true,
  );

  /// 娱乐
  static const IconPark entertainment = IconPark._(
    id: 825,
    name: "entertainment",
    title: "娱乐",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["娱乐", "唱歌", "麦克风", "说话", "KTV"],
    rtl: true,
  );

  /// 信封
  static const IconPark envelope = IconPark._(
    id: 826,
    name: "envelope",
    title: "信封",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["信封", "邮件", "袋子", "纸袋", "折叠"],
    rtl: false,
  );

  /// 信封1
  static const IconPark envelopeOne = IconPark._(
    id: 827,
    name: "envelope-one",
    title: "信封1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "多封邮件"],
    rtl: true,
  );

  /// 等比
  static const IconPark equalRatio = IconPark._(
    id: 828,
    name: "equal-ratio",
    title: "等比",
    category: "Edit",
    categoryCN: "编辑",
    author: "白明泽",
    tag: ["等比", "一比一", "还原"],
    rtl: false,
  );

  /// 均衡器
  static const IconPark equalizer = IconPark._(
    id: 829,
    name: "equalizer",
    title: "均衡器",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["音量调节", "设置调整", "音频"],
    rtl: true,
  );

  /// 擦除
  static const IconPark erase = IconPark._(
    id: 830,
    name: "erase",
    title: "擦除",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["橡皮", "擦除", "清除", "移除", "消灭"],
    rtl: true,
  );

  /// 错误
  static const IconPark error = IconPark._(
    id: 831,
    name: "error",
    title: "错误",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["错误", "不正确", "关闭", "叉"],
    rtl: false,
  );

  /// 计算机错误
  static const IconPark errorComputer = IconPark._(
    id: 832,
    name: "error-computer",
    title: "计算机错误",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 图片错误
  static const IconPark errorPicture = IconPark._(
    id: 833,
    name: "error-picture",
    title: "图片错误",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 错误提示
  static const IconPark errorPrompt = IconPark._(
    id: 834,
    name: "error-prompt",
    title: "错误提示",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["错误提示", "声音", "静音", "声音提示"],
    rtl: true,
  );

  /// 手扶电梯
  static const IconPark escalators = IconPark._(
    id: 835,
    name: "escalators",
    title: "手扶电梯",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["手扶电梯", "上下楼"],
    rtl: true,
  );

  /// 网口关
  static const IconPark ethernetOff = IconPark._(
    id: 836,
    name: "ethernet-off",
    title: "网口关",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "网口", "网线"],
    rtl: false,
  );

  /// 网口开
  static const IconPark ethernetOn = IconPark._(
    id: 837,
    name: "ethernet-on",
    title: "网口开",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "网口", "网线"],
    rtl: false,
  );

  /// 众多用户
  static const IconPark everyUser = IconPark._(
    id: 838,
    name: "every-user",
    title: "众多用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["用户", "很多", "群", "用户群", "用户组"],
    rtl: false,
  );

  /// 数据统计工具
  static const IconPark excel = IconPark._(
    id: 839,
    name: "excel",
    title: "数据统计工具",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["表格", "文档", "统计", "分析", "汇总"],
    rtl: true,
  );

  /// 表格
  static const IconPark excelOne = IconPark._(
    id: 840,
    name: "excel-one",
    title: "表格",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["表格", "电子文件"],
    rtl: true,
  );

  /// 货币兑换
  static const IconPark exchange = IconPark._(
    id: 841,
    name: "exchange",
    title: "货币兑换",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["钱", "银行", "财务", "财富"],
    rtl: true,
  );

  /// 兑换4
  static const IconPark exchangeFour = IconPark._(
    id: 842,
    name: "exchange-four",
    title: "兑换4",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["兑换", "交换", "转换"],
    rtl: true,
  );

  /// 兑换1
  static const IconPark exchangeOne = IconPark._(
    id: 843,
    name: "exchange-one",
    title: "兑换1",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["兑换", "交换", "转换"],
    rtl: true,
  );

  /// 兑换3
  static const IconPark exchangeThree = IconPark._(
    id: 844,
    name: "exchange-three",
    title: "兑换3",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["兑换", "交换", "转换"],
    rtl: true,
  );

  /// 兑换2
  static const IconPark exchangeTwo = IconPark._(
    id: 845,
    name: "exchange-two",
    title: "兑换2",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["兑换", "交换", "转换"],
    rtl: true,
  );

  /// 排除选择
  static const IconPark excludeSelection = IconPark._(
    id: 846,
    name: "exclude-selection",
    title: "排除选择",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["剪切", "相交", "排除选择"],
    rtl: true,
  );

  /// 排他网关
  static const IconPark exclusiveGateway = IconPark._(
    id: 847,
    name: "exclusive-gateway",
    title: "排他网关",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "常留留",
    tag: ["排他", "菱形", "抽象", "几何"],
    rtl: false,
  );

  /// 展开
  static const IconPark expandDown = IconPark._(
    id: 848,
    name: "expand-down",
    title: "展开",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["向下展开", "浮层", "抽屉", "示例"],
    rtl: false,
  );

  /// 向下收起
  static const IconPark expandDownOne = IconPark._(
    id: 849,
    name: "expand-down-one",
    title: "向下收起",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["展开", "收起"],
    rtl: false,
  );

  /// 展开
  static const IconPark expandLeft = IconPark._(
    id: 850,
    name: "expand-left",
    title: "展开",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["向右展开", "浮层", "抽屉", "示例"],
    rtl: true,
  );

  /// 左右扩大
  static const IconPark expandLeftAndRight = IconPark._(
    id: 851,
    name: "expand-left-and-right",
    title: "左右扩大",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["左右扩大", "间距"],
    rtl: false,
  );

  /// 展开
  static const IconPark expandRight = IconPark._(
    id: 852,
    name: "expand-right",
    title: "展开",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["向左展开", "浮层", "抽屉", "示例"],
    rtl: true,
  );

  /// 展开文本域
  static const IconPark expandTextInput = IconPark._(
    id: 853,
    name: "expand-text-input",
    title: "展开文本域",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["放大", "展开", "撑开", "箭头"],
    rtl: true,
  );

  /// 展开
  static const IconPark expandUp = IconPark._(
    id: 854,
    name: "expand-up",
    title: "展开",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["向上展开", "浮层", "抽屉", "示例"],
    rtl: false,
  );

  /// 转出
  static const IconPark expenses = IconPark._(
    id: 855,
    name: "expenses",
    title: "转出",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["消费", "支出", "钱", "转出"],
    rtl: true,
  );

  /// 支出
  static const IconPark expensesOne = IconPark._(
    id: 856,
    name: "expenses-one",
    title: "支出",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["消费", "支出", "钱", "转出"],
    rtl: true,
  );

  /// 实验
  static const IconPark experiment = IconPark._(
    id: 857,
    name: "experiment",
    title: "实验",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "常留留",
    tag: ["测试", "化验", "测验", "蒸馏瓶", "容器", "量杯"],
    rtl: true,
  );

  /// 实验
  static const IconPark experimentOne = IconPark._(
    id: 858,
    name: "experiment-one",
    title: "实验",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "常留留",
    tag: ["测试", "化验", "测验", "蒸馏瓶", "容器", "量杯"],
    rtl: true,
  );

  /// 导出
  static const IconPark export = IconPark._(
    id: 859,
    name: "export",
    title: "导出",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["导出", "输出", "传输", "上传", "下载"],
    rtl: true,
  );

  /// 快递
  static const IconPark expressDelivery = IconPark._(
    id: 860,
    name: "express-delivery",
    title: "快递",
    category: "Others",
    categoryCN: "其它",
    author: "齐奉飞",
    tag: ["快递盒", "快递箱"],
    rtl: false,
  );

  /// 无语脸
  static const IconPark expressionlessFace = IconPark._(
    id: 861,
    name: "expressionless-face",
    title: "无语脸",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["无语脸", "表情"],
    rtl: false,
  );

  /// 拓展
  static const IconPark extend = IconPark._(
    id: 862,
    name: "extend",
    title: "拓展",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["扩大", "拓展", "全屏"],
    rtl: false,
  );

  /// 外部传输
  static const IconPark externalTransmission = IconPark._(
    id: 863,
    name: "external-transmission",
    title: "外部传输",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["外部传输", "传输", "导出文件"],
    rtl: true,
  );

  /// 眼眉
  static const IconPark eyebrow = IconPark._(
    id: 864,
    name: "eyebrow",
    title: "眼眉",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["眉毛"],
    rtl: true,
  );

  /// 眼睛
  static const IconPark eyes = IconPark._(
    id: 865,
    name: "eyes",
    title: "眼睛",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["眼科", "睁眼", "开启", "眼科"],
    rtl: false,
  );

  /// F8
  static const IconPark fEightKey = IconPark._(
    id: 866,
    name: "f-eight-key",
    title: "F8",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["八", "8", "按键"],
    rtl: true,
  );

  /// F5
  static const IconPark fFiveKey = IconPark._(
    id: 867,
    name: "f-five-key",
    title: "F5",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["五", "5", "按键"],
    rtl: true,
  );

  /// F4
  static const IconPark fFourKey = IconPark._(
    id: 868,
    name: "f-four-key",
    title: "F4",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["四", "4", "按键"],
    rtl: true,
  );

  /// Fn
  static const IconPark fNKey = IconPark._(
    id: 869,
    name: "f-n-key",
    title: "Fn",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["n", "按键"],
    rtl: true,
  );

  /// F9
  static const IconPark fNineKey = IconPark._(
    id: 870,
    name: "f-nine-key",
    title: "F9",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["九", "9", "按键"],
    rtl: true,
  );

  /// F1
  static const IconPark fOneKey = IconPark._(
    id: 871,
    name: "f-one-key",
    title: "F1",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["一", "1", "按键"],
    rtl: true,
  );

  /// F7
  static const IconPark fSevenKey = IconPark._(
    id: 872,
    name: "f-seven-key",
    title: "F7",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["七", "7", "按键"],
    rtl: true,
  );

  /// F6
  static const IconPark fSixKey = IconPark._(
    id: 873,
    name: "f-six-key",
    title: "F6",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["六", "6", "按键"],
    rtl: true,
  );

  /// F3
  static const IconPark fThreeKey = IconPark._(
    id: 874,
    name: "f-three-key",
    title: "F3",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["三", "3", "按键"],
    rtl: true,
  );

  /// F2
  static const IconPark fTwoKey = IconPark._(
    id: 875,
    name: "f-two-key",
    title: "F2",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["二", "2", "按键"],
    rtl: true,
  );

  /// F0
  static const IconPark fZeroKey = IconPark._(
    id: 876,
    name: "f-zero-key",
    title: "F0",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["零", "0", "按键"],
    rtl: true,
  );

  /// 脸粉
  static const IconPark facePowder = IconPark._(
    id: 877,
    name: "face-powder",
    title: "脸粉",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["小镜子", "化妆镜"],
    rtl: true,
  );

  /// 人脸识别
  static const IconPark faceRecognition = IconPark._(
    id: 878,
    name: "face-recognition",
    title: "人脸识别",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "常留留",
    tag: ["人脸支付", "人脸", "刷脸", "人脸密码", "扫脸"],
    rtl: true,
  );

  /// 大眼笑
  static const IconPark faceWithSmilingOpenEyes = IconPark._(
    id: 879,
    name: "face-with-smiling-open-eyes",
    title: "大眼笑",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["大眼笑", "表情", "惊呆"],
    rtl: false,
  );

  /// 无嘴脸
  static const IconPark faceWithoutMouth = IconPark._(
    id: 880,
    name: "face-without-mouth",
    title: "无嘴脸",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["无嘴脸", "表情", "偷看"],
    rtl: false,
  );

  /// 脸书
  static const IconPark facebook = IconPark._(
    id: 881,
    name: "facebook",
    title: "脸书",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["小视频", "短视频", "logo", "社交", "社交平台"],
    rtl: true,
  );

  /// 脸书
  static const IconPark facebookOne = IconPark._(
    id: 882,
    name: "facebook-one",
    title: "脸书",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["小视频", "短视频", "logo", "社交", "社交平台", "logo"],
    rtl: true,
  );

  /// 视频电话
  static const IconPark facetime = IconPark._(
    id: 883,
    name: "facetime",
    title: "视频电话",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["视频", "音频", "电话", "连线", "直播", "logo"],
    rtl: true,
  );

  /// 激萌
  static const IconPark faceu = IconPark._(
    id: 884,
    name: "faceu",
    title: "激萌",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["拍照", "logo", "修图", "美颜", "相机", "激萌"],
    rtl: true,
  );

  /// 洗面奶
  static const IconPark facialCleanser = IconPark._(
    id: 885,
    name: "facial-cleanser",
    title: "洗面奶",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["洗面奶", "洁面", "护手霜", "洗化"],
    rtl: false,
  );

  /// 口罩2
  static const IconPark facialMask = IconPark._(
    id: 886,
    name: "facial-mask",
    title: "口罩2",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 工厂
  static const IconPark factoryBuilding = IconPark._(
    id: 887,
    name: "factory-building",
    title: "工厂",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["建筑", "工厂", "烟囱", "厂房", "工作"],
    rtl: true,
  );

  /// 图片错误
  static const IconPark failPicture = IconPark._(
    id: 888,
    name: "fail-picture",
    title: "图片错误",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 家庭
  static const IconPark family = IconPark._(
    id: 889,
    name: "family",
    title: "家庭",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["团聚", "人群"],
    rtl: false,
  );

  /// 扇子
  static const IconPark fan = IconPark._(
    id: 890,
    name: "fan",
    title: "扇子",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["扇子", "文化", "中国风", "凉快", "降温"],
    rtl: false,
  );

  /// 番茄小说
  static const IconPark fanqiexiaoshuo = IconPark._(
    id: 891,
    name: "fanqiexiaoshuo",
    title: "番茄小说",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["番茄小说", "logo", "阅读软件"],
    rtl: true,
  );

  /// feelgood
  static const IconPark feelgood = IconPark._(
    id: 892,
    name: "feelgood",
    title: "feelgood",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["评估", "体验", "logo", "feelgood"],
    rtl: false,
  );

  /// feegood1
  static const IconPark feelgoodOne = IconPark._(
    id: 893,
    name: "feelgood-one",
    title: "feegood1",
    category: "Brand",
    categoryCN: "品牌",
    author: "",
    tag: ["logo", "对话", "气泡", "feegood"],
    rtl: true,
  );

  /// 飞鱼CRM
  static const IconPark feiyu = IconPark._(
    id: 894,
    name: "feiyu",
    title: "飞鱼CRM",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["飞鱼", "CRM", "线索", "oceanengine", "logo"],
    rtl: true,
  );

  /// 女性
  static const IconPark female = IconPark._(
    id: 895,
    name: "female",
    title: "女性",
    category: "Base",
    categoryCN: "基础",
    author: "刘心乐",
    tag: ["女", "性别", "符号"],
    rtl: true,
  );

  /// 栏栅
  static const IconPark fenceOne = IconPark._(
    id: 896,
    name: "fence-one",
    title: "栏栅",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["护栏", "拦网", "栅栏"],
    rtl: false,
  );

  /// 栅栏
  static const IconPark fenceTwo = IconPark._(
    id: 897,
    name: "fence-two",
    title: "栅栏",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["护栏", "拦网", "栅栏"],
    rtl: false,
  );

  /// 摩天轮
  static const IconPark ferrisWheel = IconPark._(
    id: 898,
    name: "ferris-wheel",
    title: "摩天轮",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["摩天轮", "大转轮", "游乐场"],
    rtl: false,
  );

  /// figma
  static const IconPark figma = IconPark._(
    id: 899,
    name: "figma",
    title: "figma",
    category: "Brand",
    categoryCN: "品牌",
    author: "",
    tag: ["figma", "logo", "设计软件", "应用", "工具"],
    rtl: true,
  );

  /// 组件
  static const IconPark figmaComponent = IconPark._(
    id: 900,
    name: "figma-component",
    title: "组件",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["组件", "菱形组合", "四边形"],
    rtl: false,
  );

  /// Figma 选择箭头
  static const IconPark figmaFlattenSelection = IconPark._(
    id: 901,
    name: "figma-flatten-selection",
    title: "Figma 选择箭头",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["向下箭头", "箭头"],
    rtl: false,
  );

  /// 遮罩
  static const IconPark figmaMask = IconPark._(
    id: 902,
    name: "figma-mask",
    title: "遮罩",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["遮罩", "遮挡", "编辑", "功能", "绘图"],
    rtl: true,
  );

  /// 解除组件
  static const IconPark figmaResetInstance = IconPark._(
    id: 903,
    name: "figma-reset-instance",
    title: "解除组件",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["解除组件", "转移", "箭头"],
    rtl: true,
  );

  /// 文件添加
  static const IconPark fileAddition = IconPark._(
    id: 904,
    name: "file-addition",
    title: "文件添加",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "添加"],
    rtl: true,
  );

  /// 文件添加1
  static const IconPark fileAdditionOne = IconPark._(
    id: 905,
    name: "file-addition-one",
    title: "文件添加1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "添加"],
    rtl: true,
  );

  /// 文件柜
  static const IconPark fileCabinet = IconPark._(
    id: 906,
    name: "file-cabinet",
    title: "文件柜",
    category: "Office",
    categoryCN: "办公文档",
    author: "常留留",
    tag: ["文件", "柜子", "抽屉"],
    rtl: false,
  );

  /// 代码文件
  static const IconPark fileCode = IconPark._(
    id: 907,
    name: "file-code",
    title: "代码文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "代码"],
    rtl: true,
  );

  /// 代码文件1
  static const IconPark fileCodeOne = IconPark._(
    id: 908,
    name: "file-code-one",
    title: "代码文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "代码"],
    rtl: true,
  );

  /// 收藏文件
  static const IconPark fileCollection = IconPark._(
    id: 909,
    name: "file-collection",
    title: "收藏文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "爱心", "收藏"],
    rtl: true,
  );

  /// 收藏文件1
  static const IconPark fileCollectionOne = IconPark._(
    id: 910,
    name: "file-collection-one",
    title: "收藏文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "爱心", "收藏"],
    rtl: true,
  );

  /// 转换文件
  static const IconPark fileConversion = IconPark._(
    id: 911,
    name: "file-conversion",
    title: "转换文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "转换"],
    rtl: true,
  );

  /// 转换文件1
  static const IconPark fileConversionOne = IconPark._(
    id: 912,
    name: "file-conversion-one",
    title: "转换文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "转换"],
    rtl: true,
  );

  /// 到期文件
  static const IconPark fileDate = IconPark._(
    id: 913,
    name: "file-date",
    title: "到期文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "时间"],
    rtl: true,
  );

  /// 到期文件1
  static const IconPark fileDateOne = IconPark._(
    id: 914,
    name: "file-date-one",
    title: "到期文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "时间"],
    rtl: true,
  );

  /// 显示文件
  static const IconPark fileDisplay = IconPark._(
    id: 915,
    name: "file-display",
    title: "显示文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "显示", "展示"],
    rtl: true,
  );

  /// 显示文件1
  static const IconPark fileDisplayOne = IconPark._(
    id: 916,
    name: "file-display-one",
    title: "显示文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "显示", "展示"],
    rtl: true,
  );

  /// 文档
  static const IconPark fileDoc = IconPark._(
    id: 917,
    name: "file-doc",
    title: "文档",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["文章", "文档", "小说", "合同", "规则", "详情"],
    rtl: true,
  );

  /// 编辑文件
  static const IconPark fileEditing = IconPark._(
    id: 918,
    name: "file-editing",
    title: "编辑文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "编辑"],
    rtl: true,
  );

  /// 编辑文件1
  static const IconPark fileEditingOne = IconPark._(
    id: 919,
    name: "file-editing-one",
    title: "编辑文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "编辑"],
    rtl: true,
  );

  /// 文件-excel
  static const IconPark fileExcel = IconPark._(
    id: 920,
    name: "file-excel",
    title: "文件-excel",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "表格", "数据", "办公", "文稿"],
    rtl: true,
  );

  /// 文件失败
  static const IconPark fileFailed = IconPark._(
    id: 921,
    name: "file-failed",
    title: "文件失败",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "关闭", "失败"],
    rtl: true,
  );

  /// 文件失败1
  static const IconPark fileFailedOne = IconPark._(
    id: 922,
    name: "file-failed-one",
    title: "文件失败1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "关闭", "失败"],
    rtl: true,
  );

  /// 重点文件
  static const IconPark fileFocus = IconPark._(
    id: 923,
    name: "file-focus",
    title: "重点文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "重点", "星星"],
    rtl: true,
  );

  /// 重点文件1
  static const IconPark fileFocusOne = IconPark._(
    id: 924,
    name: "file-focus-one",
    title: "重点文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "重点", "星星"],
    rtl: true,
  );

  /// 文件-gif
  static const IconPark fileGif = IconPark._(
    id: 925,
    name: "file-gif",
    title: "文件-gif",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "动图", "GIF", "文件"],
    rtl: true,
  );

  /// 井号文件
  static const IconPark fileHash = IconPark._(
    id: 926,
    name: "file-hash",
    title: "井号文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "井号"],
    rtl: true,
  );

  /// 井号文件1
  static const IconPark fileHashOne = IconPark._(
    id: 927,
    name: "file-hash-one",
    title: "井号文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "井号"],
    rtl: true,
  );

  /// 隐藏文件
  static const IconPark fileHiding = IconPark._(
    id: 928,
    name: "file-hiding",
    title: "隐藏文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "隐藏"],
    rtl: true,
  );

  /// 隐藏文件1
  static const IconPark fileHidingOne = IconPark._(
    id: 929,
    name: "file-hiding-one",
    title: "隐藏文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "隐藏"],
    rtl: true,
  );

  /// 文件-jpg
  static const IconPark fileJpg = IconPark._(
    id: 930,
    name: "file-jpg",
    title: "文件-jpg",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "图像", "照片", "JPG", "文件"],
    rtl: true,
  );

  /// 加密文件
  static const IconPark fileLock = IconPark._(
    id: 931,
    name: "file-lock",
    title: "加密文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "锁定"],
    rtl: true,
  );

  /// 加密文件1
  static const IconPark fileLockOne = IconPark._(
    id: 932,
    name: "file-lock-one",
    title: "加密文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "锁定"],
    rtl: true,
  );

  /// 音乐文件
  static const IconPark fileMusic = IconPark._(
    id: 933,
    name: "file-music",
    title: "音乐文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "音乐"],
    rtl: true,
  );

  /// 音乐文件1
  static const IconPark fileMusicOne = IconPark._(
    id: 934,
    name: "file-music-one",
    title: "音乐文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "音乐"],
    rtl: true,
  );

  /// 文件-pdf
  static const IconPark filePdf = IconPark._(
    id: 935,
    name: "file-pdf",
    title: "文件-pdf",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "PDF", "文件"],
    rtl: true,
  );

  /// pdf文件
  static const IconPark filePdfOne = IconPark._(
    id: 936,
    name: "file-pdf-one",
    title: "pdf文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["pdf文档", "文件"],
    rtl: true,
  );

  /// ppt文件
  static const IconPark filePpt = IconPark._(
    id: 937,
    name: "file-ppt",
    title: "ppt文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["幻灯片", "展示", "预览", "汇报", "演示"],
    rtl: true,
  );

  /// 文件保护
  static const IconPark fileProtection = IconPark._(
    id: 938,
    name: "file-protection",
    title: "文件保护",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "安全", "保护"],
    rtl: true,
  );

  /// 文件保护1
  static const IconPark fileProtectionOne = IconPark._(
    id: 939,
    name: "file-protection-one",
    title: "文件保护1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "安全", "保护"],
    rtl: true,
  );

  /// 优质文件
  static const IconPark fileQuality = IconPark._(
    id: 940,
    name: "file-quality",
    title: "优质文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "优质"],
    rtl: true,
  );

  /// 优质文件1
  static const IconPark fileQualityOne = IconPark._(
    id: 941,
    name: "file-quality-one",
    title: "优质文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "优质"],
    rtl: true,
  );

  /// 存疑文件
  static const IconPark fileQuestion = IconPark._(
    id: 942,
    name: "file-question",
    title: "存疑文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["疑问", "问好"],
    rtl: true,
  );

  /// 移除文件
  static const IconPark fileRemoval = IconPark._(
    id: 943,
    name: "file-removal",
    title: "移除文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "移除"],
    rtl: true,
  );

  /// 移除文件1
  static const IconPark fileRemovalOne = IconPark._(
    id: 944,
    name: "file-removal-one",
    title: "移除文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "移除"],
    rtl: true,
  );

  /// 文件查找
  static const IconPark fileSearch = IconPark._(
    id: 945,
    name: "file-search",
    title: "文件查找",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["查找", "搜索", "检索"],
    rtl: true,
  );

  /// 文件搜索1
  static const IconPark fileSearchOne = IconPark._(
    id: 946,
    name: "file-search-one",
    title: "文件搜索1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "搜索"],
    rtl: true,
  );

  /// 文件搜索
  static const IconPark fileSearchTwo = IconPark._(
    id: 947,
    name: "file-search-two",
    title: "文件搜索",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "搜索"],
    rtl: true,
  );

  /// 文件设置
  static const IconPark fileSettings = IconPark._(
    id: 948,
    name: "file-settings",
    title: "文件设置",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "设置"],
    rtl: true,
  );

  /// 文件设置1
  static const IconPark fileSettingsOne = IconPark._(
    id: 949,
    name: "file-settings-one",
    title: "文件设置1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "设置"],
    rtl: true,
  );

  /// 人事文件
  static const IconPark fileStaff = IconPark._(
    id: 950,
    name: "file-staff",
    title: "人事文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "人员", "人力"],
    rtl: true,
  );

  /// 人事文件1
  static const IconPark fileStaffOne = IconPark._(
    id: 951,
    name: "file-staff-one",
    title: "人事文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "人员", "人力"],
    rtl: true,
  );

  /// 成功文件
  static const IconPark fileSuccess = IconPark._(
    id: 952,
    name: "file-success",
    title: "成功文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "成功", "正确"],
    rtl: true,
  );

  /// 成功文件1
  static const IconPark fileSuccessOne = IconPark._(
    id: 953,
    name: "file-success-one",
    title: "成功文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "成功", "正确"],
    rtl: true,
  );

  /// 文本文件
  static const IconPark fileText = IconPark._(
    id: 954,
    name: "file-text",
    title: "文本文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "字体", "文本"],
    rtl: true,
  );

  /// 文本文件1
  static const IconPark fileTextOne = IconPark._(
    id: 955,
    name: "file-text-one",
    title: "文本文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "字体", "文本"],
    rtl: true,
  );

  /// 警示文件
  static const IconPark fileTips = IconPark._(
    id: 956,
    name: "file-tips",
    title: "警示文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["提示", "报错"],
    rtl: true,
  );

  /// 警示文件1
  static const IconPark fileTipsOne = IconPark._(
    id: 957,
    name: "file-tips-one",
    title: "警示文件1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["提示", "报错"],
    rtl: true,
  );

  /// 文件-txt
  static const IconPark fileTxt = IconPark._(
    id: 958,
    name: "file-txt",
    title: "文件-txt",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文本文件", "文稿", "写字", "文字"],
    rtl: true,
  );

  /// txt文件
  static const IconPark fileTxtOne = IconPark._(
    id: 959,
    name: "file-txt-one",
    title: "txt文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["文章", "文档", "小说", "合同", "规则", "详情"],
    rtl: true,
  );

  /// 文件撤销
  static const IconPark fileWithdrawal = IconPark._(
    id: 960,
    name: "file-withdrawal",
    title: "文件撤销",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["撤销", "返回"],
    rtl: true,
  );

  /// 文件撤销1
  static const IconPark fileWithdrawalOne = IconPark._(
    id: 961,
    name: "file-withdrawal-one",
    title: "文件撤销1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["撤销", "返回"],
    rtl: true,
  );

  /// 文件-word
  static const IconPark fileWord = IconPark._(
    id: 962,
    name: "file-word",
    title: "文件-word",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件", "文档", "文字", "Word", "办公", "文案"],
    rtl: true,
  );

  /// 压缩文件
  static const IconPark fileZip = IconPark._(
    id: 963,
    name: "file-zip",
    title: "压缩文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["文件", "压缩", "解压包", "下载", "资料", "文档", "资源包"],
    rtl: true,
  );

  /// 填充
  static const IconPark fill = IconPark._(
    id: 964,
    name: "fill",
    title: "填充",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "夏立诚",
    tag: ["填充", "空", "排除", "颜色面板"],
    rtl: true,
  );

  /// 胶片
  static const IconPark film = IconPark._(
    id: 965,
    name: "film",
    title: "胶片",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 筛选
  static const IconPark filter = IconPark._(
    id: 966,
    name: "filter",
    title: "筛选",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["漏斗", "筛选", "过滤"],
    rtl: true,
  );

  /// 筛选1
  static const IconPark filterOne = IconPark._(
    id: 967,
    name: "filter-one",
    title: "筛选1",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["过滤", "筛查", "箭头", "方向"],
    rtl: true,
  );

  /// 金融
  static const IconPark finance = IconPark._(
    id: 968,
    name: "finance",
    title: "金融",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["钱", "钱包", "财产", "金融", "金钱"],
    rtl: false,
  );

  /// 理财
  static const IconPark financing = IconPark._(
    id: 969,
    name: "financing",
    title: "理财",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["货币兑换", "钱币", "金属钱币", "财产", "铜钱"],
    rtl: false,
  );

  /// 理财
  static const IconPark financingOne = IconPark._(
    id: 970,
    name: "financing-one",
    title: "理财",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["货币兑换", "财富", "钱袋子"],
    rtl: true,
  );

  /// 融资2
  static const IconPark financingTwo = IconPark._(
    id: 971,
    name: "financing-two",
    title: "融资2",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["汇款", "集资"],
    rtl: true,
  );

  /// 查找
  static const IconPark find = IconPark._(
    id: 972,
    name: "find",
    title: "查找",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["查询", "搜索", "搜寻", "放大镜", "搜索列表"],
    rtl: true,
  );

  /// 搜查
  static const IconPark findOne = IconPark._(
    id: 973,
    name: "find-one",
    title: "搜查",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["扫描", "检索", "搜索", "查找", "寻找"],
    rtl: true,
  );

  /// 指甲
  static const IconPark fingernail = IconPark._(
    id: 974,
    name: "fingernail",
    title: "指甲",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["美甲", "指甲"],
    rtl: true,
  );

  /// 指纹
  static const IconPark fingerprint = IconPark._(
    id: 975,
    name: "fingerprint",
    title: "指纹",
    category: "Hands",
    categoryCN: "手势动作",
    author: "金磊",
    tag: ["指纹", "安全", "解锁", "认证", "验证"],
    rtl: true,
  );

  /// 指纹
  static const IconPark fingerprintThree = IconPark._(
    id: 976,
    name: "fingerprint-three",
    title: "指纹",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["指纹", "身份", "识别", "解锁", "验证", "安全", "认证"],
    rtl: true,
  );

  /// 指纹
  static const IconPark fingerprintTwo = IconPark._(
    id: 977,
    name: "fingerprint-two",
    title: "指纹",
    category: "Hands",
    categoryCN: "手势动作",
    author: "金磊",
    tag: ["指纹", "安全", "解锁", "认证", "验证"],
    rtl: true,
  );

  /// 火热
  static const IconPark fire = IconPark._(
    id: 978,
    name: "fire",
    title: "火热",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "常留留",
    tag: ["火热", "热门", "流行", "火", "热", "夏天"],
    rtl: true,
  );

  /// 灭火器
  static const IconPark fireExtinguisher = IconPark._(
    id: 979,
    name: "fire-extinguisher",
    title: "灭火器",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "金磊",
    tag: ["灭火器", "救火", "扑灭", "安全", "消防队"],
    rtl: true,
  );

  /// 灭火器
  static const IconPark fireExtinguisherOne = IconPark._(
    id: 980,
    name: "fire-extinguisher-one",
    title: "灭火器",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["灭火"],
    rtl: true,
  );

  /// 火堆
  static const IconPark fireTwo = IconPark._(
    id: 981,
    name: "fire-two",
    title: "火堆",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["火", "柴火", "热", "燃烧"],
    rtl: true,
  );

  /// 礼花
  static const IconPark fireworks = IconPark._(
    id: 982,
    name: "fireworks",
    title: "礼花",
    category: "Others",
    categoryCN: "其它",
    author: "白明泽",
    tag: ["礼花", "庆祝", "欢庆", "节日"],
    rtl: true,
  );

  /// 第一
  static const IconPark first = IconPark._(
    id: 983,
    name: "first",
    title: "第一",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["一", "手指", "食指", "手势"],
    rtl: true,
  );

  /// 急救箱
  static const IconPark firstAidKit = IconPark._(
    id: 984,
    name: "first-aid-kit",
    title: "急救箱",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 鱼
  static const IconPark fish = IconPark._(
    id: 985,
    name: "fish",
    title: "鱼",
    category: "Foods",
    categoryCN: "食品",
    author: "史晓彤",
    tag: ["鱼", "食物", "美食"],
    rtl: true,
  );

  /// 鱼
  static const IconPark fishOne = IconPark._(
    id: 986,
    name: "fish-one",
    title: "鱼",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 垂钓
  static const IconPark fishing = IconPark._(
    id: 987,
    name: "fishing",
    title: "垂钓",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["钓鱼", "垂钓", "平静"],
    rtl: true,
  );

  /// 拳头
  static const IconPark fist = IconPark._(
    id: 988,
    name: "fist",
    title: "拳头",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["石头", "拳"],
    rtl: true,
  );

  /// 健身
  static const IconPark fitness = IconPark._(
    id: 989,
    name: "fitness",
    title: "健身",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 五
  static const IconPark five = IconPark._(
    id: 990,
    name: "five",
    title: "五",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["五", "手指", "手势", "手掌"],
    rtl: true,
  );

  /// 五个椭圆
  static const IconPark fiveEllipses = IconPark._(
    id: 991,
    name: "five-ellipses",
    title: "五个椭圆",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["五个椭圆", "排列"],
    rtl: false,
  );

  /// 五
  static const IconPark fiveFive = IconPark._(
    id: 992,
    name: "five-five",
    title: "五",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["五", "手指", "手势", "手掌"],
    rtl: true,
  );

  /// 按键五
  static const IconPark fiveKey = IconPark._(
    id: 993,
    name: "five-key",
    title: "按键五",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["五", "5", "按键"],
    rtl: true,
  );

  /// 五星徽章
  static const IconPark fiveStarBadge = IconPark._(
    id: 994,
    name: "five-star-badge",
    title: "五星徽章",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["五星徽章"],
    rtl: false,
  );

  /// 旗子
  static const IconPark flag = IconPark._(
    id: 995,
    name: "flag",
    title: "旗子",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["旗子", "旗帜"],
    rtl: true,
  );

  /// 闪付
  static const IconPark flashPayment = IconPark._(
    id: 996,
    name: "flash-payment",
    title: "闪付",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["闪电", "快速", "能量", "速度"],
    rtl: true,
  );

  /// 闪光模式
  static const IconPark flashlamp = IconPark._(
    id: 997,
    name: "flashlamp",
    title: "闪光模式",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["闪电", "闪光", "快速", "能量", "电池"],
    rtl: true,
  );

  /// 手电筒
  static const IconPark flashlight = IconPark._(
    id: 998,
    name: "flashlight",
    title: "手电筒",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["手电", "光线", "电灯", "电器", "手电筒"],
    rtl: false,
  );

  /// 三角杯
  static const IconPark flask = IconPark._(
    id: 999,
    name: "flask",
    title: "三角杯",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "白明泽",
    tag: ["三角杯", "试验", "酒杯", "测量", "化学"],
    rtl: false,
  );

  /// 飞行气流
  static const IconPark flightAirflow = IconPark._(
    id: 1000,
    name: "flight-airflow",
    title: "飞行气流",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["飞行中", "飞行平稳", "飞行气流"],
    rtl: true,
  );

  /// 飞行安全
  static const IconPark flightSafety = IconPark._(
    id: 1001,
    name: "flight-safety",
    title: "飞行安全",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["飞行安全", "飞行保险"],
    rtl: true,
  );

  /// 翻转镜头
  static const IconPark flipCamera = IconPark._(
    id: 1002,
    name: "flip-camera",
    title: "翻转镜头",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["翻转镜头"],
    rtl: true,
  );

  /// 水平翻转
  static const IconPark flipHorizontally = IconPark._(
    id: 1003,
    name: "flip-horizontally",
    title: "水平翻转",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["调整", "左右镜像", "软件功能"],
    rtl: false,
  );

  /// 垂直翻转
  static const IconPark flipVertically = IconPark._(
    id: 1004,
    name: "flip-vertically",
    title: "垂直翻转",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["调整", "上下镜像", "软件功能"],
    rtl: true,
  );

  /// 勾引
  static const IconPark flirt = IconPark._(
    id: 1005,
    name: "flirt",
    title: "勾引",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["引诱", "勾引", "引诱"],
    rtl: true,
  );

  /// 漂浮圈
  static const IconPark float = IconPark._(
    id: 1006,
    name: "float",
    title: "漂浮圈",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["漂浮", "游泳圈"],
    rtl: false,
  );

  /// 地板
  static const IconPark floorTile = IconPark._(
    id: 1007,
    name: "floor-tile",
    title: "地板",
    category: "Life",
    categoryCN: "生活",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 电台
  static const IconPark fm = IconPark._(
    id: 1008,
    name: "fm",
    title: "电台",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["收音机", "电台节目", "无线广播", "广播"],
    rtl: false,
  );

  /// 对焦
  static const IconPark focus = IconPark._(
    id: 1009,
    name: "focus",
    title: "对焦",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["对焦", "精准", "镜头", "瞄准"],
    rtl: false,
  );

  /// 对焦1
  static const IconPark focusOne = IconPark._(
    id: 1010,
    name: "focus-one",
    title: "对焦1",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["定位", "扫描"],
    rtl: true,
  );

  /// 大雾
  static const IconPark fog = IconPark._(
    id: 1011,
    name: "fog",
    title: "大雾",
    category: "Weather",
    categoryCN: "天气",
    author: "齐奉飞",
    tag: ["大雾", "雾霾", "云雾"],
    rtl: true,
  );

  /// 向上收起
  static const IconPark foldUpOne = IconPark._(
    id: 1012,
    name: "fold-up-one",
    title: "向上收起",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["缩小", "收起"],
    rtl: false,
  );

  /// 文件夹
  static const IconPark folder = IconPark._(
    id: 1013,
    name: "folder",
    title: "文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "张蔓",
    tag: ["文件夹", "文件本", "机密文件", "信封"],
    rtl: true,
  );

  /// 禁用文件夹
  static const IconPark folderBlock = IconPark._(
    id: 1014,
    name: "folder-block",
    title: "禁用文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["禁用文件", "文件夹"],
    rtl: true,
  );

  /// 禁用文件夹1
  static const IconPark folderBlockOne = IconPark._(
    id: 1015,
    name: "folder-block-one",
    title: "禁用文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["禁用文件", "文件夹"],
    rtl: true,
  );

  /// 文件夹-关
  static const IconPark folderClose = IconPark._(
    id: 1016,
    name: "folder-close",
    title: "文件夹-关",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件夹", "关闭", "私密文件"],
    rtl: true,
  );

  /// 代码文件夹
  static const IconPark folderCode = IconPark._(
    id: 1017,
    name: "folder-code",
    title: "代码文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["代码文件", "文件夹", "展开文件"],
    rtl: true,
  );

  /// 代码文件夹1
  static const IconPark folderCodeOne = IconPark._(
    id: 1018,
    name: "folder-code-one",
    title: "代码文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["代码文件", "文件夹", "展开文件"],
    rtl: true,
  );

  /// 转换文件夹
  static const IconPark folderConversion = IconPark._(
    id: 1019,
    name: "folder-conversion",
    title: "转换文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["转换文件", "文件夹"],
    rtl: true,
  );

  /// 转换文件夹1
  static const IconPark folderConversionOne = IconPark._(
    id: 1020,
    name: "folder-conversion-one",
    title: "转换文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["转换文件", "文件夹"],
    rtl: true,
  );

  /// 文件夹-下载
  static const IconPark folderDownload = IconPark._(
    id: 1021,
    name: "folder-download",
    title: "文件夹-下载",
    category: "Office",
    categoryCN: "办公文档",
    author: "常留留",
    tag: ["文件夹", "下载文件", "保存本地"],
    rtl: true,
  );

  /// 失败文件夹
  static const IconPark folderFailed = IconPark._(
    id: 1022,
    name: "folder-failed",
    title: "失败文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["失败文件", "文件夹", "关闭", "删除"],
    rtl: true,
  );

  /// 失败文件夹1
  static const IconPark folderFailedOne = IconPark._(
    id: 1023,
    name: "folder-failed-one",
    title: "失败文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["失败文件", "文件夹", "关闭", "删除"],
    rtl: true,
  );

  /// 收藏文件夹
  static const IconPark folderFocus = IconPark._(
    id: 1024,
    name: "folder-focus",
    title: "收藏文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["收藏文件", "文件夹", "星级文件"],
    rtl: true,
  );

  /// 收藏文件夹1
  static const IconPark folderFocusOne = IconPark._(
    id: 1025,
    name: "folder-focus-one",
    title: "收藏文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["收藏文件", "文件夹", "星级文件", "标记"],
    rtl: true,
  );

  /// 加密文件夹
  static const IconPark folderLock = IconPark._(
    id: 1026,
    name: "folder-lock",
    title: "加密文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["加密文件", "文件夹"],
    rtl: true,
  );

  /// 加密文件夹1
  static const IconPark folderLockOne = IconPark._(
    id: 1027,
    name: "folder-lock-one",
    title: "加密文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["加密文件", "私密文件", "文件夹"],
    rtl: true,
  );

  /// 文件夹-删除
  static const IconPark folderMinus = IconPark._(
    id: 1028,
    name: "folder-minus",
    title: "文件夹-删除",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件夹", "删除", "办公", "减去"],
    rtl: true,
  );

  /// 音乐文件夹
  static const IconPark folderMusic = IconPark._(
    id: 1029,
    name: "folder-music",
    title: "音乐文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["音乐文件", "文件夹"],
    rtl: true,
  );

  /// 音乐文件夹1
  static const IconPark folderMusicOne = IconPark._(
    id: 1030,
    name: "folder-music-one",
    title: "音乐文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["音乐文件", "文件夹"],
    rtl: true,
  );

  /// 文件夹1
  static const IconPark folderOne = IconPark._(
    id: 1031,
    name: "folder-one",
    title: "文件夹1",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 文件夹-开
  static const IconPark folderOpen = IconPark._(
    id: 1032,
    name: "folder-open",
    title: "文件夹-开",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件夹", "办公", "打开", "文档"],
    rtl: true,
  );

  /// 文件夹-添加
  static const IconPark folderPlus = IconPark._(
    id: 1033,
    name: "folder-plus",
    title: "文件夹-添加",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件夹", "添加", "办公", "编辑"],
    rtl: true,
  );

  /// 文件夹保护
  static const IconPark folderProtection = IconPark._(
    id: 1034,
    name: "folder-protection",
    title: "文件夹保护",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件保护", "文件夹"],
    rtl: true,
  );

  /// 文件夹保护1
  static const IconPark folderProtectionOne = IconPark._(
    id: 1035,
    name: "folder-protection-one",
    title: "文件夹保护1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件保护", "文件夹"],
    rtl: true,
  );

  /// 高质量文件夹
  static const IconPark folderQuality = IconPark._(
    id: 1036,
    name: "folder-quality",
    title: "高质量文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["钻石文件", "文件夹"],
    rtl: true,
  );

  /// 高质量文件夹1
  static const IconPark folderQualityOne = IconPark._(
    id: 1037,
    name: "folder-quality-one",
    title: "高质量文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["钻石文件", "文件夹"],
    rtl: true,
  );

  /// 搜索文件夹
  static const IconPark folderSearch = IconPark._(
    id: 1038,
    name: "folder-search",
    title: "搜索文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["搜索文件", "文件夹"],
    rtl: true,
  );

  /// 搜索文件夹1
  static const IconPark folderSearchOne = IconPark._(
    id: 1039,
    name: "folder-search-one",
    title: "搜索文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["搜索文件", "文件夹"],
    rtl: true,
  );

  /// 文件夹设置
  static const IconPark folderSettings = IconPark._(
    id: 1040,
    name: "folder-settings",
    title: "文件夹设置",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件设置", "文件夹"],
    rtl: true,
  );

  /// 文件夹设置1
  static const IconPark folderSettingsOne = IconPark._(
    id: 1041,
    name: "folder-settings-one",
    title: "文件夹设置1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件设置", "文件夹"],
    rtl: true,
  );

  /// 成功文件夹
  static const IconPark folderSuccess = IconPark._(
    id: 1042,
    name: "folder-success",
    title: "成功文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["成功文件", "文件夹", "完成"],
    rtl: true,
  );

  /// 成功文件夹1
  static const IconPark folderSuccessOne = IconPark._(
    id: 1043,
    name: "folder-success-one",
    title: "成功文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["成功文件", "文件夹", "完成"],
    rtl: true,
  );

  /// 文件夹-上传
  static const IconPark folderUpload = IconPark._(
    id: 1044,
    name: "folder-upload",
    title: "文件夹-上传",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["文件夹", "上传文件", "本地上传"],
    rtl: true,
  );

  /// 退出文件夹
  static const IconPark folderWithdrawal = IconPark._(
    id: 1045,
    name: "folder-withdrawal",
    title: "退出文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["退出文件", "文件夹", "转发"],
    rtl: true,
  );

  /// 退出文件夹1
  static const IconPark folderWithdrawalOne = IconPark._(
    id: 1046,
    name: "folder-withdrawal-one",
    title: "退出文件夹1",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["退出文件", "文件夹", "转发"],
    rtl: true,
  );

  /// 按跟进日期排序
  static const IconPark followUpDateSort = IconPark._(
    id: 1047,
    name: "follow-up-date-sort",
    title: "按跟进日期排序",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["跟进", "箭头", "下一步", "排序", "图表", "数据"],
    rtl: true,
  );

  /// 字体搜索
  static const IconPark fontSearch = IconPark._(
    id: 1048,
    name: "font-search",
    title: "字体搜索",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["字体", "检索", "搜索", "查找"],
    rtl: true,
  );

  /// 字号大小
  static const IconPark fontSize = IconPark._(
    id: 1049,
    name: "font-size",
    title: "字号大小",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["字号大小", "文字", "字体样式"],
    rtl: true,
  );

  /// 字体大小
  static const IconPark fontSizeTwo = IconPark._(
    id: 1050,
    name: "font-size-two",
    title: "字体大小",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["字体大小", "编辑", "调整"],
    rtl: true,
  );

  /// 脚
  static const IconPark foot = IconPark._(
    id: 1051,
    name: "foot",
    title: "脚",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 足球
  static const IconPark football = IconPark._(
    id: 1052,
    name: "football",
    title: "足球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "齐奉飞",
    tag: ["足球", "运动", "体育"],
    rtl: false,
  );

  /// 禁止
  static const IconPark forbid = IconPark._(
    id: 1053,
    name: "forbid",
    title: "禁止",
    category: "Character",
    categoryCN: "符号标识",
    author: "齐奉飞",
    tag: ["禁止", "不允许"],
    rtl: true,
  );

  /// 分叉
  static const IconPark fork = IconPark._(
    id: 1054,
    name: "fork",
    title: "分叉",
    category: "Connect",
    categoryCN: "链接",
    author: "齐奉飞",
    tag: ["交叉", "拷贝代码", "复制", "Git"],
    rtl: false,
  );

  /// 叉子勺子
  static const IconPark forkSpoon = IconPark._(
    id: 1055,
    name: "fork-spoon",
    title: "叉子勺子",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["叉子勺子", "餐饮", "吃饭", "工具"],
    rtl: true,
  );

  /// 表格
  static const IconPark form = IconPark._(
    id: 1056,
    name: "form",
    title: "表格",
    category: "Charts",
    categoryCN: "数据图表",
    author: "刘心乐",
    tag: ["表格", "图表", "数据", "列表", "排版"],
    rtl: false,
  );

  /// 形式
  static const IconPark formOne = IconPark._(
    id: 1057,
    name: "form-one",
    title: "形式",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["布局", "样式", "模块", "单元"],
    rtl: true,
  );

  /// 格式
  static const IconPark format = IconPark._(
    id: 1058,
    name: "format",
    title: "格式",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["类型", "分类", "清除", "刷子"],
    rtl: true,
  );

  /// 格式刷
  static const IconPark formatBrush = IconPark._(
    id: 1059,
    name: "format-brush",
    title: "格式刷",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["格式", "刷子", "粉刷", "上色", "装修"],
    rtl: true,
  );

  /// 公式
  static const IconPark formula = IconPark._(
    id: 1060,
    name: "formula",
    title: "公式",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["公式", "算法", "计算", "复杂", "数学"],
    rtl: true,
  );

  /// 粉底液
  static const IconPark foundationMakeup = IconPark._(
    id: 1061,
    name: "foundation-makeup",
    title: "粉底液",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["泡沫", "乳液"],
    rtl: true,
  );

  /// 四
  static const IconPark four = IconPark._(
    id: 1062,
    name: "four",
    title: "四",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["四", "手指", "手势"],
    rtl: true,
  );

  /// 四个箭头
  static const IconPark fourArrows = IconPark._(
    id: 1063,
    name: "four-arrows",
    title: "四个箭头",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["箭头", "雪花", "旋转", "抽象"],
    rtl: true,
  );

  /// 四
  static const IconPark fourFour = IconPark._(
    id: 1064,
    name: "four-four",
    title: "四",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["四", "手指", "手势"],
    rtl: true,
  );

  /// 按键四
  static const IconPark fourKey = IconPark._(
    id: 1065,
    name: "four-key",
    title: "按键四",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["四", "4", "按键"],
    rtl: true,
  );

  /// 四片叶子
  static const IconPark fourLeaves = IconPark._(
    id: 1066,
    name: "four-leaves",
    title: "四片叶子",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["四片叶子"],
    rtl: false,
  );

  /// 四点连接
  static const IconPark fourPointConnection = IconPark._(
    id: 1067,
    name: "four-point-connection",
    title: "四点连接",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["锚点", "抽象"],
    rtl: false,
  );

  /// 四点连接
  static const IconPark fourRoundPointConnection = IconPark._(
    id: 1068,
    name: "four-round-point-connection",
    title: "四点连接",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["四点连接", "抽象", "关联", "添加"],
    rtl: true,
  );

  /// foursquare
  static const IconPark foursquare = IconPark._(
    id: 1069,
    name: "foursquare",
    title: "foursquare",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["社交", "logo", "沟通", "foursquare"],
    rtl: true,
  );

  /// 冻结列
  static const IconPark freezeColumn = IconPark._(
    id: 1070,
    name: "freeze-column",
    title: "冻结列",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["固定首列", "阴影", "范围", "排版"],
    rtl: true,
  );

  /// 冻结行
  static const IconPark freezeLine = IconPark._(
    id: 1071,
    name: "freeze-line",
    title: "冻结行",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["固定首行", "阴影", "范围", "排版"],
    rtl: false,
  );

  /// 冻结行列
  static const IconPark freezingLineColumn = IconPark._(
    id: 1072,
    name: "freezing-line-column",
    title: "冻结行列",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["固定首行首列", "阴影", "范围", "排版"],
    rtl: true,
  );

  /// 炸薯条
  static const IconPark frenchFries = IconPark._(
    id: 1073,
    name: "french-fries",
    title: "炸薯条",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["薯条", "炸土豆", "土豆条", "零食"],
    rtl: true,
  );

  /// 朋友圈
  static const IconPark friendsCircle = IconPark._(
    id: 1074,
    name: "friends-circle",
    title: "朋友圈",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["朋友圈", "快门", "微信", "拍照", "社交", "晒图", "logo", "螺旋", "循环旋转"],
    rtl: true,
  );

  /// 军舰
  static const IconPark frigate = IconPark._(
    id: 1075,
    name: "frigate",
    title: "军舰",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 青蛙
  static const IconPark frog = IconPark._(
    id: 1076,
    name: "frog",
    title: "青蛙",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 别嘴生气
  static const IconPark frowningFaceWhitOpenMouth = IconPark._(
    id: 1077,
    name: "frowning-face-whit-open-mouth",
    title: "别嘴生气",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["别嘴生气", "表情", "惊呆"],
    rtl: false,
  );

  /// 果树
  static const IconPark fruiter = IconPark._(
    id: 1078,
    name: "fruiter",
    title: "果树",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 礼服长裙
  static const IconPark fullDressLonguette = IconPark._(
    id: 1079,
    name: "full-dress-longuette",
    title: "礼服长裙",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["礼服", "裙子", "婚纱", "服装", "连衣裙"],
    rtl: false,
  );

  /// 全局放大
  static const IconPark fullScreen = IconPark._(
    id: 1080,
    name: "full-screen",
    title: "全局放大",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["全屏", "放大", "扩展"],
    rtl: false,
  );

  /// 全局放大1
  static const IconPark fullScreenOne = IconPark._(
    id: 1081,
    name: "full-screen-one",
    title: "全局放大1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["全屏", "打开", "展开", "放大"],
    rtl: false,
  );

  /// 全屏播放
  static const IconPark fullScreenPlay = IconPark._(
    id: 1082,
    name: "full-screen-play",
    title: "全屏播放",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["全屏播放", "播放", "媒体", "投屏"],
    rtl: true,
  );

  /// 全局放大2
  static const IconPark fullScreenTwo = IconPark._(
    id: 1083,
    name: "full-screen-two",
    title: "全局放大2",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["放大", "全屏"],
    rtl: true,
  );

  /// 选择
  static const IconPark fullSelection = IconPark._(
    id: 1084,
    name: "full-selection",
    title: "选择",
    category: "Edit",
    categoryCN: "编辑",
    author: "杨威",
    tag: ["更换文件", "全部选择"],
    rtl: true,
  );

  /// 全宽
  static const IconPark fullwidth = IconPark._(
    id: 1085,
    name: "fullwidth",
    title: "全宽",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["全宽", "满宽", "扩大"],
    rtl: false,
  );

  /// 基金
  static const IconPark funds = IconPark._(
    id: 1086,
    name: "funds",
    title: "基金",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["资金", "财务", "成本", "金币", "存款", "储蓄", "金融", "统计"],
    rtl: true,
  );

  /// 未来大厦
  static const IconPark futureBuildOne = IconPark._(
    id: 1087,
    name: "future-build-one",
    title: "未来大厦",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "房子", "大厦", "建筑", "办公楼"],
    rtl: false,
  );

  /// 未来建筑
  static const IconPark futureBuildThree = IconPark._(
    id: 1088,
    name: "future-build-three",
    title: "未来建筑",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "房子", "楼房", "大厦", "建筑", "办公楼"],
    rtl: false,
  );

  /// 未来魔都
  static const IconPark futureBuildTwo = IconPark._(
    id: 1089,
    name: "future-build-two",
    title: "未来魔都",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "房子", "楼房", "大厦"],
    rtl: false,
  );

  /// 游戏
  static const IconPark game = IconPark._(
    id: 1090,
    name: "game",
    title: "游戏",
    category: "Game",
    categoryCN: "游戏",
    author: "白明泽",
    tag: ["游戏", "娱乐", "玩耍"],
    rtl: true,
  );

  /// 游戏机
  static const IconPark gameConsole = IconPark._(
    id: 1091,
    name: "game-console",
    title: "游戏机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["游戏", "电子", "设备", "娱乐", "上瘾", "消遣", "沉迷", "活动"],
    rtl: true,
  );

  /// 移动游戏机
  static const IconPark gameConsoleOne = IconPark._(
    id: 1092,
    name: "game-console-one",
    title: "移动游戏机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["游戏机", "游戏手柄"],
    rtl: true,
  );

  /// 游戏表情
  static const IconPark gameEmoji = IconPark._(
    id: 1093,
    name: "game-emoji",
    title: "游戏表情",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["游戏表情", "图形拼接", "抽象"],
    rtl: true,
  );

  /// 游戏手柄
  static const IconPark gameHandle = IconPark._(
    id: 1094,
    name: "game-handle",
    title: "游戏手柄",
    category: "Game",
    categoryCN: "游戏",
    author: "白明泽",
    tag: ["游戏", "手柄", "操作", "玩"],
    rtl: true,
  );

  /// 游戏机
  static const IconPark gamePs = IconPark._(
    id: 1095,
    name: "game-ps",
    title: "游戏机",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["游戏机", "索尼", "游戏", "图形拼接", "抽象"],
    rtl: true,
  );

  /// 游戏手柄
  static const IconPark gameThree = IconPark._(
    id: 1096,
    name: "game-three",
    title: "游戏手柄",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["游戏机", "游戏手柄", "控制器", "遥控器"],
    rtl: true,
  );

  /// 游戏
  static const IconPark gameTwo = IconPark._(
    id: 1097,
    name: "game-two",
    title: "游戏",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["游戏", "手柄", "操作", "玩"],
    rtl: false,
  );

  /// 游戏机
  static const IconPark gamepad = IconPark._(
    id: 1098,
    name: "gamepad",
    title: "游戏机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 车库
  static const IconPark garage = IconPark._(
    id: 1099,
    name: "garage",
    title: "车库",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["门", "车库", "卷帘门", "收缩门", "仓库"],
    rtl: false,
  );

  /// 大蒜
  static const IconPark garlic = IconPark._(
    id: 1100,
    name: "garlic",
    title: "大蒜",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["大蒜", "蒜头", "蔬菜", "蒜"],
    rtl: true,
  );

  /// 气体
  static const IconPark gas = IconPark._(
    id: 1101,
    name: "gas",
    title: "气体",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 肠胃
  static const IconPark gastrointestinal = IconPark._(
    id: 1102,
    name: "gastrointestinal",
    title: "肠胃",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["内科", "胃", "器官"],
    rtl: true,
  );

  /// 大门
  static const IconPark gate = IconPark._(
    id: 1103,
    name: "gate",
    title: "大门",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["门", "建筑", "寺庙", "亭子", "景区"],
    rtl: false,
  );

  /// 检票机
  static const IconPark gateMachine = IconPark._(
    id: 1104,
    name: "gate-machine",
    title: "检票机",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["检票机", "闸机", "检票", "过关"],
    rtl: true,
  );

  /// 纱布
  static const IconPark gauze = IconPark._(
    id: 1105,
    name: "gauze",
    title: "纱布",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 拍卖
  static const IconPark gavel = IconPark._(
    id: 1106,
    name: "gavel",
    title: "拍卖",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 双子座
  static const IconPark gemini = IconPark._(
    id: 1107,
    name: "gemini",
    title: "双子座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 全科
  static const IconPark generalBranch = IconPark._(
    id: 1108,
    name: "general-branch",
    title: "全科",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["添加", "科室", "全部科室"],
    rtl: false,
  );

  /// 几何花
  static const IconPark geometricFlowers = IconPark._(
    id: 1109,
    name: "geometric-flowers",
    title: "几何花",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["几何", "圆环", "抽象", "花形", "环绕"],
    rtl: false,
  );

  /// 病菌
  static const IconPark germs = IconPark._(
    id: 1110,
    name: "germs",
    title: "病菌",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["细菌", "病毒", "菌体", "病菌", "细小"],
    rtl: true,
  );

  /// 幽灵
  static const IconPark ghost = IconPark._(
    id: 1111,
    name: "ghost",
    title: "幽灵",
    category: "Game",
    categoryCN: "游戏",
    author: "白明泽",
    tag: ["幽灵", "游戏", "恐怖", "可怕"],
    rtl: true,
  );

  /// 礼物
  static const IconPark gift = IconPark._(
    id: 1112,
    name: "gift",
    title: "礼物",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["礼盒", "礼品", "惊喜", "神秘"],
    rtl: false,
  );

  /// 礼盒
  static const IconPark giftBag = IconPark._(
    id: 1113,
    name: "gift-bag",
    title: "礼盒",
    category: "Money",
    categoryCN: "电商财产",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 礼物盒
  static const IconPark giftBox = IconPark._(
    id: 1114,
    name: "gift-box",
    title: "礼物盒",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["礼物盒", "神秘"],
    rtl: true,
  );

  /// 女孩
  static const IconPark girl = IconPark._(
    id: 1115,
    name: "girl",
    title: "女孩",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["人", "性别", "女"],
    rtl: false,
  );

  /// 女孩1
  static const IconPark girlOne = IconPark._(
    id: 1116,
    name: "girl-one",
    title: "女孩1",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["人", "性别", "女"],
    rtl: false,
  );

  /// 女孩2
  static const IconPark girlTwo = IconPark._(
    id: 1117,
    name: "girl-two",
    title: "女孩2",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["人", "性别", "女"],
    rtl: false,
  );

  /// github
  static const IconPark github = IconPark._(
    id: 1118,
    name: "github",
    title: "github ",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["代码共享社区", "开发", "社区", "logo", "小猫"],
    rtl: true,
  );

  /// github-one
  static const IconPark githubOne = IconPark._(
    id: 1119,
    name: "github-one",
    title: "github-one",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["代码共享社区", "开发", "社区", "logo", "小猫"],
    rtl: true,
  );

  /// gitlab
  static const IconPark gitlab = IconPark._(
    id: 1120,
    name: "gitlab",
    title: "gitlab",
    category: "Brand",
    categoryCN: "品牌",
    author: "杨威",
    tag: ["代码共享社区", "开发", "社区"],
    rtl: false,
  );

  /// 眼镜
  static const IconPark glasses = IconPark._(
    id: 1121,
    name: "glasses",
    title: "眼镜",
    category: "Clothes",
    categoryCN: "服饰",
    author: "金磊",
    tag: ["眼镜", "近视", "镜片", "观察", "搜索"],
    rtl: false,
  );

  /// 眼镜
  static const IconPark glassesOne = IconPark._(
    id: 1122,
    name: "glasses-one",
    title: "眼镜",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["眼镜", "墨镜", "复古镜", "圆镜", "太阳镜"],
    rtl: false,
  );

  /// 眼镜3
  static const IconPark glassesThree = IconPark._(
    id: 1123,
    name: "glasses-three",
    title: "眼镜3",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 全球
  static const IconPark globe = IconPark._(
    id: 1124,
    name: "globe",
    title: "全球",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["全球", "地球仪", "玩具"],
    rtl: true,
  );

  /// 胶手套
  static const IconPark glove = IconPark._(
    id: 1125,
    name: "glove",
    title: "胶手套",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["胶手套", "手套", "保暖", "橡胶手套", "塑胶手套"],
    rtl: true,
  );

  /// 前进
  static const IconPark goAhead = IconPark._(
    id: 1126,
    name: "go-ahead",
    title: "前进",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 下一曲
  static const IconPark goEnd = IconPark._(
    id: 1127,
    name: "go-end",
    title: "下一曲",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["下一个", "下一首", "右", "箭头"],
    rtl: true,
  );

  /// 继续
  static const IconPark goOn = IconPark._(
    id: 1128,
    name: "go-on",
    title: "继续",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["继续", "箭头", "下一步", "前进"],
    rtl: true,
  );

  /// 上一曲
  static const IconPark goStart = IconPark._(
    id: 1129,
    name: "go-start",
    title: "上一曲",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["上一个", "上一首", "左", "箭头"],
    rtl: true,
  );

  /// 高脚杯
  static const IconPark goblet = IconPark._(
    id: 1130,
    name: "goblet",
    title: "高脚杯",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["高脚杯", "玻璃杯", "红酒杯"],
    rtl: false,
  );

  /// 高脚杯裂开
  static const IconPark gobletCracking = IconPark._(
    id: 1131,
    name: "goblet-cracking",
    title: "高脚杯裂开",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["高脚杯裂开", "破碎"],
    rtl: true,
  );

  /// 高脚杯满了
  static const IconPark gobletFull = IconPark._(
    id: 1132,
    name: "goblet-full",
    title: "高脚杯满了",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["高脚杯", "玻璃杯", "酒杯"],
    rtl: true,
  );

  /// 高脚杯
  static const IconPark gobletOne = IconPark._(
    id: 1133,
    name: "goblet-one",
    title: "高脚杯",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["杯子", "酒杯", "玻璃杯"],
    rtl: true,
  );

  /// 金牌
  static const IconPark goldMedal = IconPark._(
    id: 1134,
    name: "gold-medal",
    title: "金牌",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["金牌", "奖牌", "第一名"],
    rtl: true,
  );

  /// 金牌
  static const IconPark goldMedalTwo = IconPark._(
    id: 1135,
    name: "gold-medal-two",
    title: "金牌",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["金牌", "奖牌", "第一名"],
    rtl: true,
  );

  /// 高尔夫球场
  static const IconPark golfCourse = IconPark._(
    id: 1136,
    name: "golf-course",
    title: "高尔夫球场",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["高尔夫球场", "运动"],
    rtl: true,
  );

  /// 功夫
  static const IconPark gongfu = IconPark._(
    id: 1137,
    name: "gongfu",
    title: "功夫",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 好的
  static const IconPark good = IconPark._(
    id: 1138,
    name: "good",
    title: "好的",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["好", "认可", "肯定", "赞"],
    rtl: true,
  );

  /// 优秀
  static const IconPark goodOne = IconPark._(
    id: 1139,
    name: "good-one",
    title: "优秀",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["赞", "好的", "认可"],
    rtl: true,
  );

  /// 赞
  static const IconPark goodTwo = IconPark._(
    id: 1140,
    name: "good-two",
    title: "赞",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["好", "认可", "肯定"],
    rtl: true,
  );

  /// 谷歌
  static const IconPark google = IconPark._(
    id: 1141,
    name: "google",
    title: "谷歌",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["搜索", "search", "company", "Google", "LLC", "logo"],
    rtl: true,
  );

  /// 谷歌广告
  static const IconPark googleAds = IconPark._(
    id: 1142,
    name: "google-ads",
    title: "谷歌广告",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["广告", "谷歌", "logo"],
    rtl: true,
  );

  /// 运动相机
  static const IconPark gopro = IconPark._(
    id: 1143,
    name: "gopro",
    title: "运动相机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "探头", "抓拍", "偷拍", "电影", "放映"],
    rtl: true,
  );

  /// 汽车导航
  static const IconPark gps = IconPark._(
    id: 1144,
    name: "gps",
    title: "汽车导航",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["汽车导航"],
    rtl: false,
  );

  /// 图形设计
  static const IconPark graphicDesign = IconPark._(
    id: 1145,
    name: "graphic-design",
    title: "图形设计",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["图形拼接", "几何", "组合", "叠加"],
    rtl: true,
  );

  /// 图形组合
  static const IconPark graphicDesignTwo = IconPark._(
    id: 1146,
    name: "graphic-design-two",
    title: "图形组合",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["图形组合", "拼接", "组合", "几何"],
    rtl: false,
  );

  /// 圆形组合
  static const IconPark graphicStitching = IconPark._(
    id: 1147,
    name: "graphic-stitching",
    title: "圆形组合",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆形组合", "组合", "拼接", "花形"],
    rtl: false,
  );

  /// 圆形组合
  static const IconPark graphicStitchingFour = IconPark._(
    id: 1148,
    name: "graphic-stitching-four",
    title: "圆形组合",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["连接", "抽象", "选中锚点"],
    rtl: true,
  );

  /// 圆形组合
  static const IconPark graphicStitchingThree = IconPark._(
    id: 1149,
    name: "graphic-stitching-three",
    title: "圆形组合",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["方形", "连接", "抽象"],
    rtl: false,
  );

  /// 长城
  static const IconPark greatWall = IconPark._(
    id: 1150,
    name: "great-wall",
    title: "长城",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["墙壁", "城墙", "长城", "景区"],
    rtl: false,
  );

  /// 温室房
  static const IconPark greenHouse = IconPark._(
    id: 1151,
    name: "green-house",
    title: "温室房",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "房子", "楼房", "大厦"],
    rtl: false,
  );

  /// 绿色新能源
  static const IconPark greenNewEnergy = IconPark._(
    id: 1152,
    name: "green-new-energy",
    title: "绿色新能源",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["绿色新能源"],
    rtl: false,
  );

  /// 四宫格
  static const IconPark gridFour = IconPark._(
    id: 1153,
    name: "grid-four",
    title: "四宫格",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["四宫格", "网格"],
    rtl: false,
  );

  /// 九宫格
  static const IconPark gridNine = IconPark._(
    id: 1154,
    name: "grid-nine",
    title: "九宫格",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["九宫格", "表格", "插入表格", "网格"],
    rtl: false,
  );

  /// 16宫格
  static const IconPark gridSixteen = IconPark._(
    id: 1155,
    name: "grid-sixteen",
    title: "16宫格",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["十六宫格", "网格"],
    rtl: false,
  );

  /// 网格3
  static const IconPark gridThree = IconPark._(
    id: 1156,
    name: "grid-three",
    title: "网格3",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["网格", "三个格子", "分布", "布局", "排版"],
    rtl: true,
  );

  /// 网格2
  static const IconPark gridTwo = IconPark._(
    id: 1157,
    name: "grid-two",
    title: "网格2",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["网格", "四个格子", "方格"],
    rtl: false,
  );

  /// 呲牙张嘴
  static const IconPark grimacingFace = IconPark._(
    id: 1158,
    name: "grimacing-face",
    title: "呲牙张嘴",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["呲牙张嘴", "表情", "害怕", "恐慌"],
    rtl: false,
  );

  /// 开心
  static const IconPark grinningFace = IconPark._(
    id: 1159,
    name: "grinning-face",
    title: "开心",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["开心", "表情", "笑"],
    rtl: false,
  );

  /// 张嘴笑
  static const IconPark grinningFaceWithOpenMouth = IconPark._(
    id: 1160,
    name: "grinning-face-with-open-mouth",
    title: "张嘴笑",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["张嘴笑", "表情", "开心"],
    rtl: false,
  );

  /// 笑眯眼
  static const IconPark grinningFaceWithSquintingEyes = IconPark._(
    id: 1161,
    name: "grinning-face-with-squinting-eyes",
    title: "笑眯眼",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["笑眯眼", "表情", "开心", "快乐"],
    rtl: false,
  );

  /// 闭眼笑
  static const IconPark grinningFaceWithTightlyClosedEyes = IconPark._(
    id: 1162,
    name: "grinning-face-with-tightly-closed-eyes",
    title: "闭眼笑",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["闭眼笑", "表情", "眯眼"],
    rtl: false,
  );

  /// 张嘴闭眼笑
  static const IconPark grinningFaceWithTightlyClosedEyesOpenMouth = IconPark._(
    id: 1163,
    name: "grinning-face-with-tightly-closed-eyes-open-mouth",
    title: "张嘴闭眼笑",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["张嘴闭眼笑", "表情", "开心"],
    rtl: false,
  );

  /// 成组
  static const IconPark group = IconPark._(
    id: 1164,
    name: "group",
    title: "成组",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["组合", "成组", "打组", "选中"],
    rtl: true,
  );

  /// 指示牌
  static const IconPark guideBoard = IconPark._(
    id: 1165,
    name: "guide-board",
    title: "指示牌",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "白明泽",
    tag: ["指示牌", "方向"],
    rtl: true,
  );

  /// 体操2
  static const IconPark gymnastics = IconPark._(
    id: 1166,
    name: "gymnastics",
    title: "体操2",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["体操", "运动", "跳舞", "跳动", "活动", "训练", "舞蹈", "挥舞", "舞动", "放松", "热身", "体育"],
    rtl: true,
  );

  /// 体操1
  static const IconPark gymnasticsOne = IconPark._(
    id: 1167,
    name: "gymnastics-one",
    title: "体操1",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["体操", "运动", "跳舞", "跳动", "活动", "训练", "舞蹈", "挥舞", "舞动", "放松", "热身", "体育"],
    rtl: true,
  );

  /// h
  static const IconPark h = IconPark._(
    id: 1168,
    name: "h",
    title: "h",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["字号", "字体", "标题"],
    rtl: false,
  );

  /// 标题
  static const IconPark h1 = IconPark._(
    id: 1169,
    name: "h1",
    title: "标题",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["标题1", "文字", "文本", "第一级别标题"],
    rtl: true,
  );

  /// 标题1
  static const IconPark h2 = IconPark._(
    id: 1170,
    name: "h2",
    title: "标题1",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["标题2", "文字", "文本", "第二级别标题"],
    rtl: true,
  );

  /// 标题2
  static const IconPark h3 = IconPark._(
    id: 1171,
    name: "h3",
    title: "标题2",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["标题3", "文字", "文本", "第三级别标题"],
    rtl: true,
  );

  /// 发梳
  static const IconPark hairBrush = IconPark._(
    id: 1172,
    name: "hair-brush",
    title: "发梳",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["梳子"],
    rtl: true,
  );

  /// 发夹
  static const IconPark hairClip = IconPark._(
    id: 1173,
    name: "hair-clip",
    title: "发夹",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["夹子"],
    rtl: true,
  );

  /// 吹风机
  static const IconPark hairDryer = IconPark._(
    id: 1174,
    name: "hair-dryer",
    title: "吹风机",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["吹风机"],
    rtl: true,
  );

  /// 吹风机
  static const IconPark hairDryerOne = IconPark._(
    id: 1175,
    name: "hair-dryer-one",
    title: "吹风机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["吹风", "吹头发", "加热", "热风", "吹风", "吹造型"],
    rtl: true,
  );

  /// 光晕
  static const IconPark halo = IconPark._(
    id: 1176,
    name: "halo",
    title: "光晕",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["虚线圆环", "光照", "扩散", "焦距"],
    rtl: true,
  );

  /// 汉堡
  static const IconPark hamburger = IconPark._(
    id: 1177,
    name: "hamburger",
    title: "汉堡",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["汉堡", "美食", "餐饮", "快餐"],
    rtl: false,
  );

  /// 汉堡图标
  static const IconPark hamburgerButton = IconPark._(
    id: 1178,
    name: "hamburger-button",
    title: "汉堡图标",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["导航", "菜单", "更多", "展开"],
    rtl: false,
  );

  /// 汉堡
  static const IconPark hamburgerOne = IconPark._(
    id: 1179,
    name: "hamburger-one",
    title: "汉堡",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["汉堡包", "面包", "食物", "美食", "食品", "餐饮"],
    rtl: true,
  );

  /// 铁锤
  static const IconPark hammerAndAnvil = IconPark._(
    id: 1180,
    name: "hammer-and-anvil",
    title: "铁锤",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["锤子", "铁具", "工具"],
    rtl: true,
  );

  /// 护手霜
  static const IconPark handCream = IconPark._(
    id: 1181,
    name: "hand-cream",
    title: "护手霜",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["面霜", "洗化"],
    rtl: true,
  );

  /// 向下指
  static const IconPark handDown = IconPark._(
    id: 1182,
    name: "hand-down",
    title: "向下指",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["向下", "下面", "手", "手势", "hand"],
    rtl: true,
  );

  /// 手动拖动
  static const IconPark handDrag = IconPark._(
    id: 1183,
    name: "hand-drag",
    title: "手动拖动",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["拖动", "滑动", "手滑单手滑动", "右滑"],
    rtl: true,
  );

  /// 向左指
  static const IconPark handLeft = IconPark._(
    id: 1184,
    name: "hand-left",
    title: "向左指",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["向左", "左边", "手", "手势", "hand"],
    rtl: true,
  );

  /// 手绘板
  static const IconPark handPaintedPlate = IconPark._(
    id: 1185,
    name: "hand-painted-plate",
    title: "手绘板",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["绘制", "绘画", "控制板", "触控板", "手绘"],
    rtl: true,
  );

  /// 向右指
  static const IconPark handRight = IconPark._(
    id: 1186,
    name: "hand-right",
    title: "向右指",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["向右", "右边", "手", "手势", "hand"],
    rtl: true,
  );

  /// 向上指
  static const IconPark handUp = IconPark._(
    id: 1187,
    name: "hand-up",
    title: "向上指",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["手", "hand", "手势", "向上", "上面"],
    rtl: true,
  );

  /// 手提包
  static const IconPark handbag = IconPark._(
    id: 1188,
    name: "handbag",
    title: "手提包",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["皮包", "公文包", "包包", "电脑包"],
    rtl: false,
  );

  /// 掌机
  static const IconPark handheld = IconPark._(
    id: 1189,
    name: "handheld",
    title: "掌机",
    category: "Game",
    categoryCN: "游戏",
    author: "白明泽",
    tag: ["掌机", "手机", "游戏机", "主机"],
    rtl: true,
  );

  /// 手柄A
  static const IconPark handleA = IconPark._(
    id: 1190,
    name: "handle-a",
    title: "手柄A",
    category: "Game",
    categoryCN: "游戏",
    author: "李宁",
    tag: ["a"],
    rtl: false,
  );

  /// 手柄B
  static const IconPark handleB = IconPark._(
    id: 1191,
    name: "handle-b",
    title: "手柄B",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["b"],
    rtl: true,
  );

  /// 手柄C
  static const IconPark handleC = IconPark._(
    id: 1192,
    name: "handle-c",
    title: "手柄C",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["c"],
    rtl: true,
  );

  /// 手柄下
  static const IconPark handleDown = IconPark._(
    id: 1193,
    name: "handle-down",
    title: "手柄下",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["下"],
    rtl: false,
  );

  /// 手柄左
  static const IconPark handleLeft = IconPark._(
    id: 1194,
    name: "handle-left",
    title: "手柄左",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["左"],
    rtl: true,
  );

  /// 手柄右
  static const IconPark handleRight = IconPark._(
    id: 1195,
    name: "handle-right",
    title: "手柄右",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["右"],
    rtl: true,
  );

  /// 手柄圆圈
  static const IconPark handleRound = IconPark._(
    id: 1196,
    name: "handle-round",
    title: "手柄圆圈",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["圆形"],
    rtl: false,
  );

  /// 手柄方形
  static const IconPark handleSquare = IconPark._(
    id: 1197,
    name: "handle-square",
    title: "手柄方形",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["方形"],
    rtl: false,
  );

  /// 手柄三角形
  static const IconPark handleTriangle = IconPark._(
    id: 1198,
    name: "handle-triangle",
    title: "手柄三角形",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["三角形"],
    rtl: false,
  );

  /// 手柄上
  static const IconPark handleUp = IconPark._(
    id: 1199,
    name: "handle-up",
    title: "手柄上",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["上"],
    rtl: false,
  );

  /// 手柄X
  static const IconPark handleX = IconPark._(
    id: 1200,
    name: "handle-x",
    title: "手柄X",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["x"],
    rtl: false,
  );

  /// 手柄Y
  static const IconPark handleY = IconPark._(
    id: 1201,
    name: "handle-y",
    title: "手柄Y",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["y"],
    rtl: false,
  );

  /// 手柄Z
  static const IconPark handleZ = IconPark._(
    id: 1202,
    name: "handle-z",
    title: "手柄Z",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["z"],
    rtl: true,
  );

  /// 举手
  static const IconPark hands = IconPark._(
    id: 1203,
    name: "hands",
    title: "举手",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "常留留",
    tag: ["手", "听课", "教学", "这里", "抬手"],
    rtl: true,
  );

  /// 洗手
  static const IconPark handwashing = IconPark._(
    id: 1204,
    name: "handwashing",
    title: "洗手",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["洗手", "水资源", "清洁"],
    rtl: true,
  );

  /// 洗手液
  static const IconPark handwashingFluid = IconPark._(
    id: 1205,
    name: "handwashing-fluid",
    title: "洗手液",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["酒精", "清洁", "洗手液", "滴露"],
    rtl: true,
  );

  /// 中式汉服
  static const IconPark hanfuChineseStyle = IconPark._(
    id: 1206,
    name: "hanfu-chinese-style",
    title: "中式汉服",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["上衣", "服装", "汉服", "外套", "衣服"],
    rtl: false,
  );

  /// 晾衣架
  static const IconPark hanger = IconPark._(
    id: 1207,
    name: "hanger",
    title: "晾衣架",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["危险", "挂钩", "晾衣架"],
    rtl: true,
  );

  /// 衣架
  static const IconPark hangerOne = IconPark._(
    id: 1208,
    name: "hanger-one",
    title: "衣架",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["撑衣架", "衣帽架"],
    rtl: true,
  );

  /// 衣架
  static const IconPark hangerTwo = IconPark._(
    id: 1209,
    name: "hanger-two",
    title: "衣架",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["衣架", "晒衣服", "晾衣服"],
    rtl: true,
  );

  /// 硬盘
  static const IconPark hardDisk = IconPark._(
    id: 1210,
    name: "hard-disk",
    title: "硬盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["储存", "存储", "移动硬盘", "store"],
    rtl: true,
  );

  /// 移动硬盘
  static const IconPark hardDiskOne = IconPark._(
    id: 1211,
    name: "hard-disk-one",
    title: "移动硬盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: true,
  );

  /// 危害
  static const IconPark harm = IconPark._(
    id: 1212,
    name: "harm",
    title: "危害",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "白明泽",
    tag: ["危险", "防护", "盾牌", "防护失败"],
    rtl: true,
  );

  /// 井号键
  static const IconPark hashtagKey = IconPark._(
    id: 1213,
    name: "hashtag-key",
    title: "井号键",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["井号", "按键"],
    rtl: false,
  );

  /// 帽子
  static const IconPark hat = IconPark._(
    id: 1214,
    name: "hat",
    title: "帽子",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["帽子", "服装", "道具", "魔术"],
    rtl: false,
  );

  /// HDD
  static const IconPark hdd = IconPark._(
    id: 1215,
    name: "hdd",
    title: "HDD",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "hdd"],
    rtl: true,
  );

  /// HDMI线
  static const IconPark hdmiCable = IconPark._(
    id: 1216,
    name: "hdmi-cable",
    title: "HDMI线",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "数据线", "hdmi"],
    rtl: false,
  );

  /// HDMI接口
  static const IconPark hdmiConnector = IconPark._(
    id: 1217,
    name: "hdmi-connector",
    title: "HDMI接口",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "数据线", "hdmi"],
    rtl: false,
  );

  /// 耳机声音
  static const IconPark headphoneSound = IconPark._(
    id: 1218,
    name: "headphone-sound",
    title: "耳机声音",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["耳机声音"],
    rtl: true,
  );

  /// 耳机
  static const IconPark headset = IconPark._(
    id: 1219,
    name: "headset",
    title: "耳机",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "齐奉飞",
    tag: ["耳麦", "客服", "耳机"],
    rtl: false,
  );

  /// 耳机
  static const IconPark headsetOne = IconPark._(
    id: 1220,
    name: "headset-one",
    title: "耳机",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "齐奉飞",
    tag: ["客服", "二级", "耳麦", "服务"],
    rtl: false,
  );

  /// 耳机
  static const IconPark headsetTwo = IconPark._(
    id: 1221,
    name: "headset-two",
    title: "耳机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["听筒", "收音器", "扩音器", "音响"],
    rtl: true,
  );

  /// 头饰
  static const IconPark headwear = IconPark._(
    id: 1222,
    name: "headwear",
    title: "头饰",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["装饰", "发夹", "发箍"],
    rtl: true,
  );

  /// 健康
  static const IconPark health = IconPark._(
    id: 1223,
    name: "health",
    title: "健康",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["医疗", "体检", "logo"],
    rtl: true,
  );

  /// 保健品
  static const IconPark healthProducts = IconPark._(
    id: 1224,
    name: "health-products",
    title: "保健品",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["药品", "保健"],
    rtl: true,
  );

  /// 健康认知
  static const IconPark healthyRecognition = IconPark._(
    id: 1225,
    name: "healthy-recognition",
    title: "健康认知",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["心", "健康", "收藏", "喜欢"],
    rtl: false,
  );

  /// 心脏
  static const IconPark heart = IconPark._(
    id: 1226,
    name: "heart",
    title: "心脏",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["心", "脉搏", "跳动", "器官", "心脏", "医疗"],
    rtl: true,
  );

  /// 心形气球
  static const IconPark heartBallon = IconPark._(
    id: 1227,
    name: "heart-ballon",
    title: "心形气球",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["气球", "升空", "起飞"],
    rtl: true,
  );

  /// 心率
  static const IconPark heartRate = IconPark._(
    id: 1228,
    name: "heart-rate",
    title: "心率",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 心跳
  static const IconPark heartbeat = IconPark._(
    id: 1229,
    name: "heartbeat",
    title: "心跳",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["心跳", "呼吸", "喘气", "心脏", "心电图", "跳动", "心脏", "体育"],
    rtl: true,
  );

  /// 加热电阻
  static const IconPark heaterResistor = IconPark._(
    id: 1230,
    name: "heater-resistor",
    title: "加热电阻",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["电阻"],
    rtl: true,
  );

  /// 重金属
  static const IconPark heavyMetal = IconPark._(
    id: 1231,
    name: "heavy-metal",
    title: "重金属",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["金属", "黄金", "金条", "金融", "财务", "财富"],
    rtl: true,
  );

  /// 大雨
  static const IconPark heavyRain = IconPark._(
    id: 1232,
    name: "heavy-rain",
    title: "大雨",
    category: "Weather",
    categoryCN: "天气",
    author: "齐奉飞",
    tag: ["大雨", "下雨", "洪水"],
    rtl: true,
  );

  /// 大风
  static const IconPark heavyWind = IconPark._(
    id: 1233,
    name: "heavy-wind",
    title: "大风",
    category: "Weather",
    categoryCN: "天气",
    author: "",
    tag: ["风"],
    rtl: true,
  );

  /// 头盔
  static const IconPark helmet = IconPark._(
    id: 1234,
    name: "helmet",
    title: "头盔",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["头盔", "橄榄球头盔", "铁盔", "盔", "护具", "防护", "半盔", "全盔", "帽子", "安全"],
    rtl: true,
  );

  /// 安全帽
  static const IconPark helmetOne = IconPark._(
    id: 1235,
    name: "helmet-one",
    title: "安全帽",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["安全", "帽子"],
    rtl: false,
  );

  /// 帮助
  static const IconPark help = IconPark._(
    id: 1236,
    name: "help",
    title: "帮助",
    category: "Character",
    categoryCN: "符号标识",
    author: "刘心乐",
    tag: ["问题", "疑问", "帮助"],
    rtl: true,
  );

  /// 帮助中心
  static const IconPark helpcenter = IconPark._(
    id: 1237,
    name: "helpcenter",
    title: "帮助中心",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["问题", "疑问", "帮助"],
    rtl: true,
  );

  /// 六边形1
  static const IconPark hexagonOne = IconPark._(
    id: 1238,
    name: "hexagon-one",
    title: "六边形1",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 六边条
  static const IconPark hexagonStrip = IconPark._(
    id: 1239,
    name: "hexagon-strip",
    title: "六边条",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["六边条", "花形", "组合图形"],
    rtl: false,
  );

  /// 六边立体
  static const IconPark hexagonal = IconPark._(
    id: 1240,
    name: "hexagonal",
    title: "六边立体",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["六边立体", "花纹"],
    rtl: false,
  );

  /// 打招呼
  static const IconPark hi = IconPark._(
    id: 1241,
    name: "hi",
    title: "打招呼",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["手掌", "手势"],
    rtl: true,
  );

  /// 高跟鞋
  static const IconPark highHeeledShoes = IconPark._(
    id: 1242,
    name: "high-heeled-shoes",
    title: "高跟鞋",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["鞋子", "皮鞋", "高跟鞋"],
    rtl: true,
  );

  /// 高亮
  static const IconPark highLight = IconPark._(
    id: 1243,
    name: "high-light",
    title: "高亮",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["高亮", "荧光笔", "划重点", "突出", "口红"],
    rtl: true,
  );

  /// 高铁
  static const IconPark highSpeedRail = IconPark._(
    id: 1244,
    name: "high-speed-rail",
    title: "高铁",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 河马
  static const IconPark hippo = IconPark._(
    id: 1245,
    name: "hippo",
    title: "河马",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 直方图
  static const IconPark histogram = IconPark._(
    id: 1246,
    name: "histogram",
    title: "直方图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["折线图", "数据分析", "图表"],
    rtl: true,
  );

  /// 历史记录
  static const IconPark history = IconPark._(
    id: 1247,
    name: "history",
    title: "历史记录",
    category: "Time",
    categoryCN: "时间日期",
    author: "常留留",
    tag: ["历史", "记录", "时光机"],
    rtl: true,
  );

  /// 历史搜索
  static const IconPark historyQuery = IconPark._(
    id: 1248,
    name: "history-query",
    title: "历史搜索",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["搜索"],
    rtl: true,
  );

  /// 曲棍球
  static const IconPark hockey = IconPark._(
    id: 1249,
    name: "hockey",
    title: "曲棍球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["打", "运动", "比赛", "体育", "球类", "球", "进球", "运球", "助攻", "棍球"],
    rtl: true,
  );

  /// 承接
  static const IconPark hold = IconPark._(
    id: 1250,
    name: "hold",
    title: "承接",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["拿起", "拱手"],
    rtl: true,
  );

  /// 托起
  static const IconPark holdInterface = IconPark._(
    id: 1251,
    name: "hold-interface",
    title: "托起",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["拿起", "拱手", "交接"],
    rtl: true,
  );

  /// 孕育
  static const IconPark holdSeeds = IconPark._(
    id: 1252,
    name: "hold-seeds",
    title: "孕育",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["拿起", "拱手", "交接"],
    rtl: true,
  );

  /// 牵手
  static const IconPark holdingHands = IconPark._(
    id: 1253,
    name: "holding-hands",
    title: "牵手",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["握手", "携手", "合作"],
    rtl: true,
  );

  /// 圣剑
  static const IconPark holySword = IconPark._(
    id: 1254,
    name: "holy-sword",
    title: "圣剑",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["剑", "刺刀", "刀刃", "武器"],
    rtl: false,
  );

  /// 首页
  static const IconPark home = IconPark._(
    id: 1255,
    name: "home",
    title: "首页",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["首页", "房子", "主页", "家"],
    rtl: false,
  );

  /// 首页
  static const IconPark homeTwo = IconPark._(
    id: 1256,
    name: "home-two",
    title: "首页",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["首页", "家", "主页", "店铺", "房子"],
    rtl: false,
  );

  /// 民宿
  static const IconPark homestay = IconPark._(
    id: 1257,
    name: "homestay",
    title: "民宿",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["民宿", "酒店", "度假", "农家乐", "度假村"],
    rtl: true,
  );

  /// 蜂蜜
  static const IconPark honey = IconPark._(
    id: 1258,
    name: "honey",
    title: "蜂蜜",
    category: "Foods",
    categoryCN: "食品",
    author: "常留留",
    tag: ["滋补", "补品", "养生", "蜂蜜"],
    rtl: true,
  );

  /// 蜂蜜
  static const IconPark honeyOne = IconPark._(
    id: 1259,
    name: "honey-one",
    title: "蜂蜜",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["糖", "甜品", "甜食", "蜜糖"],
    rtl: true,
  );

  /// 水平间距
  static const IconPark horizontalSpacingBetweenItems = IconPark._(
    id: 1260,
    name: "horizontal-spacing-between-items",
    title: "水平间距",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["水平间距", "平行"],
    rtl: false,
  );

  /// 水平整理
  static const IconPark horizontalTidyUp = IconPark._(
    id: 1261,
    name: "horizontal-tidy-up",
    title: "水平整理",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["水平间距", "平行"],
    rtl: false,
  );

  /// 水平居中对齐
  static const IconPark horizontallyCentered = IconPark._(
    id: 1262,
    name: "horizontally-centered",
    title: "水平居中对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["水平间距", "平行", "居中对齐"],
    rtl: false,
  );

  /// 生肖马
  static const IconPark horseZodiac = IconPark._(
    id: 1263,
    name: "horse-zodiac",
    title: "生肖马",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 医院
  static const IconPark hospital = IconPark._(
    id: 1264,
    name: "hospital",
    title: "医院",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["就医", "看病", "就诊", "医疗"],
    rtl: true,
  );

  /// 病床
  static const IconPark hospitalBed = IconPark._(
    id: 1265,
    name: "hospital-bed",
    title: "病床",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 医院4
  static const IconPark hospitalFour = IconPark._(
    id: 1266,
    name: "hospital-four",
    title: "医院4",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 医院3
  static const IconPark hospitalThree = IconPark._(
    id: 1267,
    name: "hospital-three",
    title: "医院3",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 医院
  static const IconPark hospitalTwo = IconPark._(
    id: 1268,
    name: "hospital-two",
    title: "医院",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["医疗", "建筑", "医院", "药品", "治疗", "护理", "健康"],
    rtl: true,
  );

  /// 热气球
  static const IconPark hotAirBalloon = IconPark._(
    id: 1269,
    name: "hot-air-balloon",
    title: "热气球",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["气球", "热气球", "氢气球"],
    rtl: true,
  );

  /// 火锅
  static const IconPark hotPot = IconPark._(
    id: 1270,
    name: "hot-pot",
    title: "火锅",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["食物", "火锅", "火苗", "煮饭", "烹饪", "美味"],
    rtl: false,
  );

  /// 火锅
  static const IconPark hotPotOne = IconPark._(
    id: 1271,
    name: "hot-pot-one",
    title: "火锅",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["餐饮", "火锅", "美食", "铜锅", "涮锅"],
    rtl: true,
  );

  /// 酒店
  static const IconPark hotel = IconPark._(
    id: 1272,
    name: "hotel",
    title: "酒店",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "房子", "大厦", "办公楼"],
    rtl: false,
  );

  /// 请勿打扫
  static const IconPark hotelDoNotClean = IconPark._(
    id: 1273,
    name: "hotel-do-not-clean",
    title: "请勿打扫",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["请勿打扫", "房间"],
    rtl: true,
  );

  /// 请打扫
  static const IconPark hotelPleaseClean = IconPark._(
    id: 1274,
    name: "hotel-please-clean",
    title: "请打扫",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["请打扫", "房间"],
    rtl: true,
  );

  /// 沙漏
  static const IconPark hourglass = IconPark._(
    id: 1275,
    name: "hourglass",
    title: "沙漏",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["沙子", "时间", "计时"],
    rtl: true,
  );

  /// 沙漏满
  static const IconPark hourglassFull = IconPark._(
    id: 1276,
    name: "hourglass-full",
    title: "沙漏满",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["沙漏", "等待", "时间", "加载"],
    rtl: false,
  );

  /// 沙漏空
  static const IconPark hourglassNull = IconPark._(
    id: 1277,
    name: "hourglass-null",
    title: "沙漏空",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["沙漏", "等待", "时间", "加载"],
    rtl: false,
  );

  /// html5
  static const IconPark htmlFive = IconPark._(
    id: 1278,
    name: "html-five",
    title: "html5",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["研发", "前端", "代码", "盾牌", "游戏"],
    rtl: true,
  );

  /// 从动装置
  static const IconPark huntingGear = IconPark._(
    id: 1279,
    name: "hunting-gear",
    title: "从动装置",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["组件", "配置", "驱动", "装置", "从动"],
    rtl: true,
  );

  /// 抖音火山
  static const IconPark huoshanzhibo = IconPark._(
    id: 1280,
    name: "huoshanzhibo",
    title: "抖音火山",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["音乐", "抖音火山版", "logo"],
    rtl: true,
  );

  /// 苹果电脑iMac
  static const IconPark iMac = IconPark._(
    id: 1281,
    name: "i-mac",
    title: "苹果电脑iMac",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["iMac", "苹果电脑", "电脑", "设备", "硬件", "PC"],
    rtl: true,
  );

  /// 冰激凌
  static const IconPark icecream = IconPark._(
    id: 1282,
    name: "icecream",
    title: "冰激凌",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["零食", "冷食", "冰", "凉食", "雪糕", "冰淇淋"],
    rtl: false,
  );

  /// 冰棍4
  static const IconPark icecreamFive = IconPark._(
    id: 1283,
    name: "icecream-five",
    title: "冰棍4",
    category: "Foods",
    categoryCN: "食品",
    author: "齐奉飞",
    tag: ["零食", "冷食", "冰", "凉食", "雪糕"],
    rtl: false,
  );

  /// 冰激凌
  static const IconPark icecreamFour = IconPark._(
    id: 1284,
    name: "icecream-four",
    title: "冰激凌",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["冰淇淋", "冷饮", "雪糕", "冰淇淋"],
    rtl: true,
  );

  /// 雪糕
  static const IconPark icecreamOne = IconPark._(
    id: 1285,
    name: "icecream-one",
    title: "雪糕",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["零食", "冷食", "冰", "凉食", "雪糕"],
    rtl: true,
  );

  /// 冰棍
  static const IconPark icecreamThree = IconPark._(
    id: 1286,
    name: "icecream-three",
    title: "冰棍",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["零食", "冷食", "冰", "凉食", "雪糕"],
    rtl: true,
  );

  /// 冰激凌
  static const IconPark icecreamTwo = IconPark._(
    id: 1287,
    name: "icecream-two",
    title: "冰激凌",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["零食", "冷食", "冰", "凉食", "雪糕", "冰淇淋"],
    rtl: false,
  );

  /// 名片
  static const IconPark idCard = IconPark._(
    id: 1288,
    name: "id-card",
    title: "名片",
    category: "Others",
    categoryCN: "其它",
    author: "白明泽",
    tag: ["名片", "卡片", "证件"],
    rtl: true,
  );

  /// 身份证
  static const IconPark idCardH = IconPark._(
    id: 1289,
    name: "id-card-h",
    title: "身份证",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["身份证", "ID", "工牌", "卡片"],
    rtl: true,
  );

  /// 身份证
  static const IconPark idCardV = IconPark._(
    id: 1290,
    name: "id-card-v",
    title: "身份证",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["身份证", "ID", "工牌", "卡片"],
    rtl: true,
  );

  /// 图片文件
  static const IconPark imageFiles = IconPark._(
    id: 1291,
    name: "image-files",
    title: "图片文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["图片", "图形", "图像", "影相"],
    rtl: true,
  );

  /// 失衡天平
  static const IconPark imbalance = IconPark._(
    id: 1292,
    name: "imbalance",
    title: "失衡天平",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "金磊",
    tag: ["失衡天平", "比重", "测量", "衡量", "不公平"],
    rtl: true,
  );

  /// 进出口
  static const IconPark importAndExport = IconPark._(
    id: 1293,
    name: "import-and-export",
    title: "进出口",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["进口", "出口"],
    rtl: true,
  );

  /// 飞行巡航
  static const IconPark inFlight = IconPark._(
    id: 1294,
    name: "in-flight",
    title: "飞行巡航",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["环球旅行", "周游世界", "飞行"],
    rtl: true,
  );

  /// 收件箱
  static const IconPark inbox = IconPark._(
    id: 1295,
    name: "inbox",
    title: "收件箱",
    category: "Office",
    categoryCN: "办公文档",
    author: "白明泽",
    tag: ["收件箱", "信箱", "邮箱", "邮件", "信件"],
    rtl: false,
  );

  /// 收件箱下载
  static const IconPark inboxDownloadR = IconPark._(
    id: 1296,
    name: "inbox-download-r",
    title: "收件箱下载",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["收件箱", "下载", "下传"],
    rtl: false,
  );

  /// 收件下载
  static const IconPark inboxIn = IconPark._(
    id: 1297,
    name: "inbox-in",
    title: "收件下载",
    category: "Office",
    categoryCN: "办公文档",
    author: "白明泽",
    tag: ["收件箱", "信箱", "邮箱", "邮件", "信件", "下载", "接收"],
    rtl: false,
  );

  /// 收件上载
  static const IconPark inboxOut = IconPark._(
    id: 1298,
    name: "inbox-out",
    title: "收件上载",
    category: "Office",
    categoryCN: "办公文档",
    author: "白明泽",
    tag: ["收件箱", "信箱", "邮箱", "邮件", "信件", "上传", "上载", "发送"],
    rtl: false,
  );

  /// 收件箱
  static const IconPark inboxR = IconPark._(
    id: 1299,
    name: "inbox-r",
    title: "收件箱",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["收件箱", "文件", "信封", "邮件"],
    rtl: false,
  );

  /// 收件成功
  static const IconPark inboxSuccess = IconPark._(
    id: 1300,
    name: "inbox-success",
    title: "收件成功",
    category: "Office",
    categoryCN: "办公文档",
    author: "白明泽",
    tag: ["收件箱", "收件", "成功", "完成", "邮件", "信件"],
    rtl: true,
  );

  /// 收件箱成功
  static const IconPark inboxSuccessR = IconPark._(
    id: 1301,
    name: "inbox-success-r",
    title: "收件箱成功",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["收件箱", "成功", "发送成功"],
    rtl: true,
  );

  /// 收件箱上传
  static const IconPark inboxUploadR = IconPark._(
    id: 1302,
    name: "inbox-upload-r",
    title: "收件箱上传",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["收件箱", "上载", "上传"],
    rtl: false,
  );

  /// 包容网关
  static const IconPark inclusiveGateway = IconPark._(
    id: 1303,
    name: "inclusive-gateway",
    title: "包容网关",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "常留留",
    tag: ["网关", "菱形", "抽象", "几何"],
    rtl: false,
  );

  /// 转入
  static const IconPark income = IconPark._(
    id: 1304,
    name: "income",
    title: "转入",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["钱", "消费", "收入", "到账"],
    rtl: true,
  );

  /// 收入
  static const IconPark incomeOne = IconPark._(
    id: 1305,
    name: "income-one",
    title: "收入",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["钱", "消费", "收入", "到账"],
    rtl: true,
  );

  /// 输入
  static const IconPark incoming = IconPark._(
    id: 1306,
    name: "incoming",
    title: "输入",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["输入", "传入", "数据", "录入", "线", "输入数据"],
    rtl: true,
  );

  /// 涨幅
  static const IconPark increase = IconPark._(
    id: 1307,
    name: "increase",
    title: "涨幅",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["增长", "上升", "提升", "升高"],
    rtl: true,
  );

  /// 增加小数位
  static const IconPark increaseTheScale = IconPark._(
    id: 1308,
    name: "increase-the-scale",
    title: "增加小数位",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["小数位", "增加", "增加位数"],
    rtl: true,
  );

  /// 左缩进
  static const IconPark indentLeft = IconPark._(
    id: 1309,
    name: "indent-left",
    title: "左缩进",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["左缩进"],
    rtl: true,
  );

  /// 右缩进
  static const IconPark indentRight = IconPark._(
    id: 1310,
    name: "indent-right",
    title: "右缩进",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["右缩进"],
    rtl: true,
  );

  /// 食指
  static const IconPark indexFinger = IconPark._(
    id: 1311,
    name: "index-finger",
    title: "食指",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["手指", "手势", "指", "指引"],
    rtl: true,
  );

  /// 感应锁
  static const IconPark inductionLock = IconPark._(
    id: 1312,
    name: "induction-lock",
    title: "感应锁",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["锁", "电子", "感应"],
    rtl: true,
  );

  /// 电子秤
  static const IconPark industrialScales = IconPark._(
    id: 1313,
    name: "industrial-scales",
    title: "电子秤",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["测量称"],
    rtl: false,
  );

  /// 信息
  static const IconPark info = IconPark._(
    id: 1314,
    name: "info",
    title: "信息",
    category: "Character",
    categoryCN: "符号标识",
    author: "刘心乐",
    tag: ["注解", "信息", "提示"],
    rtl: true,
  );

  /// 点滴
  static const IconPark infusion = IconPark._(
    id: 1315,
    name: "infusion",
    title: "点滴",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 打针
  static const IconPark injection = IconPark._(
    id: 1316,
    name: "injection",
    title: "打针",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["麻醉", "麻醉科"],
    rtl: true,
  );

  /// 块公式
  static const IconPark inline = IconPark._(
    id: 1317,
    name: "inline",
    title: "块公式",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["公式"],
    rtl: true,
  );

  /// 内左下投影
  static const IconPark innerShadowBottomLeft = IconPark._(
    id: 1318,
    name: "inner-shadow-bottom-left",
    title: "内左下投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["圆", "左下投影", "内阴影"],
    rtl: true,
  );

  /// 内右下投影
  static const IconPark innerShadowBottomRight = IconPark._(
    id: 1319,
    name: "inner-shadow-bottom-right",
    title: "内右下投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["圆", "右下投影"],
    rtl: true,
  );

  /// 内下投影
  static const IconPark innerShadowDown = IconPark._(
    id: 1320,
    name: "inner-shadow-down",
    title: "内下投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["圆", "下投影", "内阴影"],
    rtl: false,
  );

  /// 内左投影
  static const IconPark innerShadowLeft = IconPark._(
    id: 1321,
    name: "inner-shadow-left",
    title: "内左投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["圆", "左投影", "内阴影"],
    rtl: true,
  );

  /// 内右投影
  static const IconPark innerShadowRight = IconPark._(
    id: 1322,
    name: "inner-shadow-right",
    title: "内右投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["圆", "右投影", "内阴影"],
    rtl: true,
  );

  /// 内左上投影
  static const IconPark innerShadowTopLeft = IconPark._(
    id: 1323,
    name: "inner-shadow-top-left",
    title: "内左上投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["圆", "左上投影", "内阴影"],
    rtl: true,
  );

  /// 内右上投影
  static const IconPark innerShadowTopRight = IconPark._(
    id: 1324,
    name: "inner-shadow-top-right",
    title: "内右上投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["圆", "右上投影", "内阴影"],
    rtl: true,
  );

  /// 内上投影
  static const IconPark innerShadowUp = IconPark._(
    id: 1325,
    name: "inner-shadow-up",
    title: "内上投影",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["圆", "上投影", "内阴影"],
    rtl: false,
  );

  /// 插卡
  static const IconPark insertCard = IconPark._(
    id: 1326,
    name: "insert-card",
    title: "插卡",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["插卡", "插入", "卡槽", "取款机"],
    rtl: true,
  );

  /// 插入表
  static const IconPark insertTable = IconPark._(
    id: 1327,
    name: "insert-table",
    title: "插入表",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["表格", "图表", "插入", "网格"],
    rtl: false,
  );

  /// 检查
  static const IconPark inspection = IconPark._(
    id: 1328,
    name: "inspection",
    title: "检查",
    category: "Office",
    categoryCN: "办公文档",
    author: "张蔓",
    tag: ["检查", "查找", "精确", "日历"],
    rtl: true,
  );

  /// instagram
  static const IconPark instagram = IconPark._(
    id: 1329,
    name: "instagram",
    title: "instagram",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["小视频", "短视频", "logo", "社交", "图片分享", "国际社交", "社交平台"],
    rtl: true,
  );

  /// instagram
  static const IconPark instagramOne = IconPark._(
    id: 1330,
    name: "instagram-one",
    title: "instagram",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["小视频", "短视频", "logo", "社交", "图片分享", "国际社交", "社交平台"],
    rtl: true,
  );

  /// 安装
  static const IconPark install = IconPark._(
    id: 1331,
    name: "install",
    title: "安装",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["下", "箱子", "盒子", "下载"],
    rtl: false,
  );

  /// 指令
  static const IconPark instruction = IconPark._(
    id: 1332,
    name: "instruction",
    title: "指令",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["代码", "编程", "命令"],
    rtl: true,
  );

  /// 对讲机
  static const IconPark intercom = IconPark._(
    id: 1333,
    name: "intercom",
    title: "对讲机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["联系", "沟通", "对话", "连接", "交流", "电话", "通讯"],
    rtl: true,
  );

  /// 半自动模式
  static const IconPark intermediateMode = IconPark._(
    id: 1334,
    name: "intermediate-mode",
    title: "半自动模式",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["模式", "亮度", "对比度"],
    rtl: true,
  );

  /// 内部数据

  static const IconPark internalData = IconPark._(
    id: 1335,
    name: "internal-data",
    title: "内部数据",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["内部数据", "数据", "数据展示", "音调"],
    rtl: true,
  );

  /// 内部扩大
  static const IconPark internalExpansion = IconPark._(
    id: 1336,
    name: "internal-expansion",
    title: "内部扩大",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["内部缩小"],
    rtl: true,
  );

  /// 内部缩小
  static const IconPark internalReduction = IconPark._(
    id: 1337,
    name: "internal-reduction",
    title: "内部缩小",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["内部扩大"],
    rtl: true,
  );

  /// 内部传输
  static const IconPark internalTransmission = IconPark._(
    id: 1338,
    name: "internal-transmission",
    title: "内部传输",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["内部传输", "输送文件", "接收文件"],
    rtl: true,
  );

  /// 国际化
  static const IconPark international = IconPark._(
    id: 1339,
    name: "international",
    title: "国际化",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "常留留",
    tag: ["非中国区", "全球", "地球", "国际", "地图"],
    rtl: true,
  );

  /// 相交选择
  static const IconPark intersectSelection = IconPark._(
    id: 1340,
    name: "intersect-selection",
    title: "相交选择",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["合并", "并拢", "交集", "相交"],
    rtl: true,
  );

  /// 交集
  static const IconPark intersection = IconPark._(
    id: 1341,
    name: "intersection",
    title: "交集",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["复制", "粘贴", "重合", "交集"],
    rtl: true,
  );

  /// 失效文件
  static const IconPark invalidFiles = IconPark._(
    id: 1342,
    name: "invalid-files",
    title: "失效文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["失效", "禁用", "无效", "终止"],
    rtl: true,
  );

  /// 反转镜头
  static const IconPark invertCamera = IconPark._(
    id: 1343,
    name: "invert-camera",
    title: "反转镜头",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["旋转", "反转镜头"],
    rtl: true,
  );

  /// 左转
  static const IconPark invertLeft = IconPark._(
    id: 1344,
    name: "invert-left",
    title: "左转",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 右转
  static const IconPark invertRight = IconPark._(
    id: 1345,
    name: "invert-right",
    title: "右转",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 人脸识别
  static const IconPark iosFaceRecognition = IconPark._(
    id: 1346,
    name: "ios-face-recognition",
    title: "人脸识别",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["人脸识别", "面部识别"],
    rtl: true,
  );

  /// Ipad
  static const IconPark ipad = IconPark._(
    id: 1347,
    name: "ipad",
    title: "Ipad",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["电脑", "屏幕", "平板", "移动电脑"],
    rtl: false,
  );

  /// 平板电脑
  static const IconPark ipadOne = IconPark._(
    id: 1348,
    name: "ipad-one",
    title: "平板电脑",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["电脑", "屏幕", "平板", "移动电脑"],
    rtl: true,
  );

  /// 苹果手机
  static const IconPark iphone = IconPark._(
    id: 1349,
    name: "iphone",
    title: "苹果手机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["手机", "苹果", "apple", "移动设备"],
    rtl: false,
  );

  /// ipo
  static const IconPark ipo = IconPark._(
    id: 1350,
    name: "ipo",
    title: "ipo",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 熨斗
  static const IconPark iron = IconPark._(
    id: 1351,
    name: "iron",
    title: "熨斗",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["熨斗"],
    rtl: true,
  );

  /// 熨斗坏了
  static const IconPark ironDisable = IconPark._(
    id: 1352,
    name: "iron-disable",
    title: "熨斗坏了",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["熨斗坏了"],
    rtl: true,
  );

  /// 熨斗
  static const IconPark ironThree = IconPark._(
    id: 1353,
    name: "iron-three",
    title: "熨斗",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["熨斗"],
    rtl: true,
  );

  /// 熨斗
  static const IconPark ironTwo = IconPark._(
    id: 1354,
    name: "iron-two",
    title: "熨斗",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["熨斗"],
    rtl: true,
  );

  /// 智能手表
  static const IconPark iwatch = IconPark._(
    id: 1355,
    name: "iwatch",
    title: "智能手表",
    category: "Time",
    categoryCN: "时间日期",
    author: "常留留",
    tag: ["smart", "watches", "手表", "时间", "打电话"],
    rtl: true,
  );

  /// 智能手表
  static const IconPark iwatchOne = IconPark._(
    id: 1356,
    name: "iwatch-one",
    title: "智能手表",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["手表", "智能", "时间", "精准", "电子", "多功能", "闹钟", "计时", "日历"],
    rtl: true,
  );

  /// 苹果智能手表
  static const IconPark iwatchTwo = IconPark._(
    id: 1357,
    name: "iwatch-two",
    title: "苹果智能手表",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["计时器", "手表", "时间", "智能手表", "机械表"],
    rtl: true,
  );

  /// 首饰
  static const IconPark jewelry = IconPark._(
    id: 1358,
    name: "jewelry",
    title: "首饰",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["雪花膏", "首饰盒", "面霜"],
    rtl: false,
  );

  /// 今日头条
  static const IconPark jinritoutiao = IconPark._(
    id: 1359,
    name: "jinritoutiao",
    title: "今日头条",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["今日头条", "字节跳动", "新闻", "logo"],
    rtl: true,
  );

  /// 旅行
  static const IconPark journey = IconPark._(
    id: 1360,
    name: "journey",
    title: "旅行",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["环球旅行", "周游世界", "绕地飞行"],
    rtl: true,
  );

  /// 游戏摇杆
  static const IconPark joystick = IconPark._(
    id: 1361,
    name: "joystick",
    title: "游戏摇杆",
    category: "Game",
    categoryCN: "游戏",
    author: "白明泽",
    tag: ["游戏", "操作", "摇杆", "手柄"],
    rtl: true,
  );

  /// 果饮
  static const IconPark juice = IconPark._(
    id: 1362,
    name: "juice",
    title: "果饮",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水杯", "果汁", "汽水", "咖啡", "奶茶"],
    rtl: true,
  );

  /// 跳
  static const IconPark jump = IconPark._(
    id: 1363,
    name: "jump",
    title: "跳",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// kagi图
  static const IconPark kagiMap = IconPark._(
    id: 1364,
    name: "kagi-map",
    title: "kagi图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据", "图表", "城市剪影"],
    rtl: true,
  );

  /// 热水壶
  static const IconPark kettle = IconPark._(
    id: 1365,
    name: "kettle",
    title: "热水壶",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["水壶", "茶器", "加热", "烧水", "咖啡", "容器", "被子", "水杯"],
    rtl: true,
  );

  /// 水壶
  static const IconPark kettleOne = IconPark._(
    id: 1366,
    name: "kettle-one",
    title: "水壶",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["水壶", "壶", "热水壶", "容器"],
    rtl: true,
  );

  /// 钥匙
  static const IconPark key = IconPark._(
    id: 1367,
    name: "key",
    title: "钥匙",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "常留留",
    tag: ["钥匙", "答案", "开锁", "方法", "密码"],
    rtl: true,
  );

  /// 钥匙1
  static const IconPark keyOne = IconPark._(
    id: 1368,
    name: "key-one",
    title: "钥匙1",
    category: "Edit",
    categoryCN: "编辑",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 钥匙2
  static const IconPark keyTwo = IconPark._(
    id: 1369,
    name: "key-two",
    title: "钥匙2",
    category: "Edit",
    categoryCN: "编辑",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 键盘
  static const IconPark keyboard = IconPark._(
    id: 1370,
    name: "keyboard",
    title: "键盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "白明泽",
    tag: ["输入", "键盘", "按键"],
    rtl: false,
  );

  /// 键盘
  static const IconPark keyboardOne = IconPark._(
    id: 1371,
    name: "keyboard-one",
    title: "键盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["控制", "输入", "敲打", "编码", "写代码", "点击", "指令", "按键"],
    rtl: true,
  );

  /// 钥匙孔
  static const IconPark keyhole = IconPark._(
    id: 1372,
    name: "keyhole",
    title: "钥匙孔",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "金磊",
    tag: ["钥匙孔"],
    rtl: false,
  );

  /// 关键线
  static const IconPark keyline = IconPark._(
    id: 1373,
    name: "keyline",
    title: "关键线",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["关键线", "背景", "底纹", "仅用"],
    rtl: false,
  );

  /// 菜刀
  static const IconPark kitchenKnife = IconPark._(
    id: 1374,
    name: "kitchen-knife",
    title: "菜刀",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["菜刀", "切菜", "刀", "厨房用品"],
    rtl: true,
  );

  /// 刀子叉子
  static const IconPark knifeFork = IconPark._(
    id: 1375,
    name: "knife-fork",
    title: "刀子叉子",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["刀叉", "餐饮", "吃饭", "工具"],
    rtl: true,
  );

  /// 树袋熊
  static const IconPark koalaBear = IconPark._(
    id: 1376,
    name: "koala-bear",
    title: "树袋熊",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 功夫
  static const IconPark kungfu = IconPark._(
    id: 1377,
    name: "kungfu",
    title: "功夫",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["武打", "功夫", "练功", "训练", "习武", "踢脚", "抬腿", "舞蹈", "体操", "压腿", "放松", "热身", "体育"],
    rtl: true,
  );

  /// 标签
  static const IconPark label = IconPark._(
    id: 1378,
    name: "label",
    title: "标签",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["标记", "页签"],
    rtl: false,
  );

  /// 梯子
  static const IconPark ladder = IconPark._(
    id: 1379,
    name: "ladder",
    title: "梯子",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 梯子1
  static const IconPark ladderOne = IconPark._(
    id: 1380,
    name: "ladder-one",
    title: "梯子1",
    category: "Industry",
    categoryCN: "工业",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 节能灯
  static const IconPark lamp = IconPark._(
    id: 1381,
    name: "lamp",
    title: "节能灯",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["灯光", "电器", "灯具", "节能", "光亮"],
    rtl: false,
  );

  /// 观测仪
  static const IconPark landSurveying = IconPark._(
    id: 1382,
    name: "land-surveying",
    title: "观测仪",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["水平仪", "探测仪", "观察器", "勘探器"],
    rtl: true,
  );

  /// 降落
  static const IconPark landing = IconPark._(
    id: 1383,
    name: "landing",
    title: "降落",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 风景区
  static const IconPark landscape = IconPark._(
    id: 1384,
    name: "landscape",
    title: "风景区",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["山水", "风景", "景区", "景点", "自然", "户外", "环境"],
    rtl: true,
  );

  /// 笔记本
  static const IconPark laptop = IconPark._(
    id: 1385,
    name: "laptop",
    title: "笔记本",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["笔记本", "硬件", "计算机", "电脑", "网络", "屏幕"],
    rtl: false,
  );

  /// 笔记本电脑
  static const IconPark laptopComputer = IconPark._(
    id: 1386,
    name: "laptop-computer",
    title: "笔记本电脑",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["移动电脑", "笔记本"],
    rtl: false,
  );

  /// 笔记本电脑
  static const IconPark laptopOne = IconPark._(
    id: 1387,
    name: "laptop-one",
    title: "笔记本电脑",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 飞书
  static const IconPark lark = IconPark._(
    id: 1388,
    name: "lark",
    title: "飞书",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["协作", "办公", "logo", "字节跳动", "飞书", "飞机"],
    rtl: true,
  );

  /// 飞书1
  static const IconPark larkOne = IconPark._(
    id: 1389,
    name: "lark-one",
    title: "飞书1",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["协作", "办公", "logo", "字节跳动", "飞书", "飞机"],
    rtl: true,
  );

  /// 晶格图案
  static const IconPark latticePattern = IconPark._(
    id: 1390,
    name: "lattice-pattern",
    title: "晶格图案",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["晶格", "编织", "背景", "图案"],
    rtl: true,
  );

  /// 图层
  static const IconPark layers = IconPark._(
    id: 1391,
    name: "layers",
    title: "图层",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["推广管理", "管理", "集合", "多层", "叠加"],
    rtl: false,
  );

  /// 布局5
  static const IconPark layoutFive = IconPark._(
    id: 1392,
    name: "layout-five",
    title: "布局5",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版"],
    rtl: true,
  );

  /// 布局4
  static const IconPark layoutFour = IconPark._(
    id: 1393,
    name: "layout-four",
    title: "布局4",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版", "交错"],
    rtl: true,
  );

  /// 布局1
  static const IconPark layoutOne = IconPark._(
    id: 1394,
    name: "layout-one",
    title: "布局1",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版"],
    rtl: true,
  );

  /// 布局3
  static const IconPark layoutThree = IconPark._(
    id: 1395,
    name: "layout-three",
    title: "布局3",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版"],
    rtl: true,
  );

  /// 布局2
  static const IconPark layoutTwo = IconPark._(
    id: 1396,
    name: "layout-two",
    title: "布局2",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版", "中间"],
    rtl: false,
  );

  /// 叶子
  static const IconPark leaf = IconPark._(
    id: 1397,
    name: "leaf",
    title: "叶子",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["植物", "生物", "叶子", "树叶", "大树", "生命", "活力", "环保", "新能源"],
    rtl: true,
  );

  /// 树叶
  static const IconPark leaves = IconPark._(
    id: 1398,
    name: "leaves",
    title: "树叶",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["树叶", "植物", "环保", "无污染", "生命力"],
    rtl: true,
  );

  /// 叶子1
  static const IconPark leavesOne = IconPark._(
    id: 1399,
    name: "leaves-one",
    title: "叶子1",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 叶子
  static const IconPark leavesTwo = IconPark._(
    id: 1400,
    name: "leaves-two",
    title: "叶子",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 发光二极管
  static const IconPark ledDiode = IconPark._(
    id: 1401,
    name: "led-diode",
    title: "发光二极管",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["提示灯", "报警器", "报警灯"],
    rtl: false,
  );

  /// 左
  static const IconPark left = IconPark._(
    id: 1402,
    name: "left",
    title: "左",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["返回", "向左", "箭头", "上一个", "方向"],
    rtl: true,
  );

  /// 左对齐
  static const IconPark leftAlignment = IconPark._(
    id: 1403,
    name: "left-alignment",
    title: "左对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["靠左", "左边", "对齐方式", "排版方式", "左对齐"],
    rtl: true,
  );

  /// 左右分支
  static const IconPark leftAndRightBranch = IconPark._(
    id: 1404,
    name: "left-and-right-branch",
    title: "左右分支",
    category: "Connect",
    categoryCN: "链接",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 左栏
  static const IconPark leftBar = IconPark._(
    id: 1405,
    name: "left-bar",
    title: "左栏",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版", "左"],
    rtl: true,
  );

  /// 左分支
  static const IconPark leftBranch = IconPark._(
    id: 1406,
    name: "left-branch",
    title: "左分支",
    category: "Connect",
    categoryCN: "链接",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 左-圆
  static const IconPark leftC = IconPark._(
    id: 1407,
    name: "left-c",
    title: "左-圆",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["上一个", "箭头", "左", "圆圈箭头"],
    rtl: true,
  );

  /// 向左展开
  static const IconPark leftExpand = IconPark._(
    id: 1408,
    name: "left-expand",
    title: "向左展开",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["展开", "收起", "左展开"],
    rtl: true,
  );

  /// 左1
  static const IconPark leftOne = IconPark._(
    id: 1409,
    name: "left-one",
    title: "左1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["返回", "向左", "箭头", "上一个", "方向"],
    rtl: true,
  );

  /// 左-小
  static const IconPark leftSmall = IconPark._(
    id: 1410,
    name: "left-small",
    title: "左-小",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向左", "箭头", "方向"],
    rtl: true,
  );

  /// 左下-小
  static const IconPark leftSmallDown = IconPark._(
    id: 1411,
    name: "left-small-down",
    title: "左下-小",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["左下-小", "方向", "箭头"],
    rtl: true,
  );

  /// 左上-小
  static const IconPark leftSmallUp = IconPark._(
    id: 1412,
    name: "left-small-up",
    title: "左上-小",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["左上-小", "方向", "箭头"],
    rtl: true,
  );

  /// 左箭头-方
  static const IconPark leftSquare = IconPark._(
    id: 1413,
    name: "left-square",
    title: "左箭头-方",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["上一个", "箭头", "方形箭头", "左"],
    rtl: true,
  );

  /// 左1
  static const IconPark leftTwo = IconPark._(
    id: 1414,
    name: "left-two",
    title: "左1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "左", "指针", "方向"],
    rtl: true,
  );

  /// 柠檬
  static const IconPark lemon = IconPark._(
    id: 1415,
    name: "lemon",
    title: "柠檬",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水果", "食物", "茶"],
    rtl: true,
  );

  /// 镜头对准
  static const IconPark lensAlignment = IconPark._(
    id: 1416,
    name: "lens-alignment",
    title: "镜头对准",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["镜头对准", "瞄准", "选中"],
    rtl: false,
  );

  /// 狮子座
  static const IconPark leo = IconPark._(
    id: 1417,
    name: "leo",
    title: "狮子座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 级别
  static const IconPark level = IconPark._(
    id: 1418,
    name: "level",
    title: "级别",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["层次", "等级", "高度"],
    rtl: false,
  );

  /// 水平校准
  static const IconPark levelAdjustment = IconPark._(
    id: 1419,
    name: "level-adjustment",
    title: "水平校准",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["水平校准", "裁切", "分割"],
    rtl: true,
  );

  /// 八级标题
  static const IconPark levelEightTitle = IconPark._(
    id: 1420,
    name: "level-eight-title",
    title: "八级标题",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["8号字体", "第八级别标题", "八级"],
    rtl: true,
  );

  /// 五级标题
  static const IconPark levelFiveTitle = IconPark._(
    id: 1421,
    name: "level-five-title",
    title: "五级标题",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["5号字体", "第五级别标题", "五级"],
    rtl: true,
  );

  /// 四级标题
  static const IconPark levelFourTitle = IconPark._(
    id: 1422,
    name: "level-four-title",
    title: "四级标题",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["4号字体", "第四级别标题", "四级"],
    rtl: true,
  );

  /// 九级标题
  static const IconPark levelNineTitle = IconPark._(
    id: 1423,
    name: "level-nine-title",
    title: "九级标题",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["9号字体", "第九级别标题", "九级"],
    rtl: true,
  );

  /// 七级标题
  static const IconPark levelSevenTitle = IconPark._(
    id: 1424,
    name: "level-seven-title",
    title: "七级标题",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["7号字体", "第七级别标题", "七级"],
    rtl: true,
  );

  /// 六级标题
  static const IconPark levelSixTitle = IconPark._(
    id: 1425,
    name: "level-six-title",
    title: "六级标题",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["6号字体", "第六级别标题", "六级"],
    rtl: true,
  );

  /// 天秤座
  static const IconPark libra = IconPark._(
    id: 1426,
    name: "libra",
    title: "天秤座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 救生圈
  static const IconPark lifebuoy = IconPark._(
    id: 1427,
    name: "lifebuoy",
    title: "救生圈",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["救生圈"],
    rtl: false,
  );

  /// 光源
  static const IconPark light = IconPark._(
    id: 1428,
    name: "light",
    title: "光源",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["散射", "散射光", "发光", "照射", "节能", "luminous", "键盘"],
    rtl: false,
  );

  /// 灯塔
  static const IconPark lightHouse = IconPark._(
    id: 1429,
    name: "light-house",
    title: "灯塔",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["阁楼", "房子", "灯塔建筑"],
    rtl: false,
  );

  /// 轻会员
  static const IconPark lightMember = IconPark._(
    id: 1430,
    name: "light-member",
    title: "轻会员",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["会员", "VIP", "客户", "顾客"],
    rtl: true,
  );

  /// 小雨
  static const IconPark lightRain = IconPark._(
    id: 1431,
    name: "light-rain",
    title: "小雨",
    category: "Weather",
    categoryCN: "天气",
    author: "齐奉飞",
    tag: ["下雨", "小雨"],
    rtl: true,
  );

  /// 闪电
  static const IconPark lightning = IconPark._(
    id: 1432,
    name: "lightning",
    title: "闪电",
    category: "Base",
    categoryCN: "基础",
    author: "金磊",
    tag: ["闪电", "天气预报", "打雷", "下雨"],
    rtl: true,
  );

  /// 喜欢
  static const IconPark like = IconPark._(
    id: 1433,
    name: "like",
    title: "喜欢",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["关注", "收藏", "爱心", "喜欢", "热爱"],
    rtl: false,
  );

  /// 林肯
  static const IconPark lincoln = IconPark._(
    id: 1434,
    name: "lincoln",
    title: "林肯",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["汽车", "加工厂", "logo", "标志", "标识"],
    rtl: false,
  );

  /// 链接
  static const IconPark link = IconPark._(
    id: 1435,
    name: "link",
    title: "链接",
    category: "Office",
    categoryCN: "办公文档",
    author: "刘心乐",
    tag: ["回形针", "附件", "文件", "链接"],
    rtl: true,
  );

  /// 断开连接
  static const IconPark linkBreak = IconPark._(
    id: 1436,
    name: "link-break",
    title: "断开连接",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["禁止使用", "插入", "终止", "解绑"],
    rtl: false,
  );

  /// 云运行
  static const IconPark linkCloud = IconPark._(
    id: 1437,
    name: "link-cloud",
    title: "云运行",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["云", "转化", "传输", "运行"],
    rtl: true,
  );

  /// 云中断
  static const IconPark linkCloudFaild = IconPark._(
    id: 1438,
    name: "link-cloud-faild",
    title: "云中断",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["云中断", "终止", "错误", "出错"],
    rtl: true,
  );

  /// 云连接
  static const IconPark linkCloudSucess = IconPark._(
    id: 1439,
    name: "link-cloud-sucess",
    title: "云连接",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["云连接", "成功", "上传成功"],
    rtl: true,
  );

  /// 链接4
  static const IconPark linkFour = IconPark._(
    id: 1440,
    name: "link-four",
    title: "链接4",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["连接", "接口", "按钮", "指示灯", "插口", "充电口"],
    rtl: false,
  );

  /// 接入链接
  static const IconPark linkIn = IconPark._(
    id: 1441,
    name: "link-in",
    title: "接入链接",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["接入", "锁定", "双向接入"],
    rtl: true,
  );

  /// 链接中断
  static const IconPark linkInterrupt = IconPark._(
    id: 1442,
    name: "link-interrupt",
    title: "链接中断",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["断开", "禁止", "错误", "出错", "失败", "解绑"],
    rtl: true,
  );

  /// 左链接
  static const IconPark linkLeft = IconPark._(
    id: 1443,
    name: "link-left",
    title: "左链接",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["返回", "向左", "上一步", "移出"],
    rtl: true,
  );

  /// 链接
  static const IconPark linkOne = IconPark._(
    id: 1444,
    name: "link-one",
    title: "链接",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["链接", "链条", "锁链", "绑定"],
    rtl: true,
  );

  /// 向外连接
  static const IconPark linkOut = IconPark._(
    id: 1445,
    name: "link-out",
    title: "向外连接",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["链接", "左右", "数据", "向外", "双向移出"],
    rtl: false,
  );

  /// 右连接
  static const IconPark linkRight = IconPark._(
    id: 1446,
    name: "link-right",
    title: "右连接",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["导出", "向右", "下一步", "移出"],
    rtl: true,
  );

  /// 链接
  static const IconPark linkThree = IconPark._(
    id: 1447,
    name: "link-three",
    title: "链接",
    category: "Connect",
    categoryCN: "链接",
    author: "张蔓",
    tag: ["链接", "组合", "合并", "绑定"],
    rtl: true,
  );

  /// 链接
  static const IconPark linkTwo = IconPark._(
    id: 1448,
    name: "link-two",
    title: "链接",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["链接", "关联", "绑定"],
    rtl: true,
  );

  /// 唇彩
  static const IconPark lipGloss = IconPark._(
    id: 1449,
    name: "lip-gloss",
    title: "唇彩",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["唇膏"],
    rtl: true,
  );

  /// 唇纹身
  static const IconPark lipTattoo = IconPark._(
    id: 1450,
    name: "lip-tattoo",
    title: "唇纹身",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["嘴", "唇膏", "护唇"],
    rtl: true,
  );

  /// 口红
  static const IconPark lipstick = IconPark._(
    id: 1451,
    name: "lipstick",
    title: "口红",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["化妆品", "口红", "美妆"],
    rtl: true,
  );

  /// 口红1
  static const IconPark lipstickOne = IconPark._(
    id: 1452,
    name: "lipstick-one",
    title: "口红1",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 鸡尾酒
  static const IconPark liqueur = IconPark._(
    id: 1453,
    name: "liqueur",
    title: "鸡尾酒",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["酒水", "果汁", "汽水", "鸡尾酒"],
    rtl: true,
  );

  /// 列表
  static const IconPark list = IconPark._(
    id: 1454,
    name: "list",
    title: "列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["目录", "清单", "完成目录", "任务清单"],
    rtl: true,
  );

  /// 添加列表
  static const IconPark listAdd = IconPark._(
    id: 1455,
    name: "list-add",
    title: "添加列表",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["列表", "添加", "菜单"],
    rtl: true,
  );

  /// 字母列表
  static const IconPark listAlphabet = IconPark._(
    id: 1456,
    name: "list-alphabet",
    title: "字母列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["字母列表", "段落", "文字排列"],
    rtl: true,
  );

  /// 列表
  static const IconPark listBottom = IconPark._(
    id: 1457,
    name: "list-bottom",
    title: "列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["列表", "底部", "最后", "目录"],
    rtl: true,
  );

  /// 多选列表
  static const IconPark listCheckbox = IconPark._(
    id: 1458,
    name: "list-checkbox",
    title: "多选列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["多选列表", "序列", "图文"],
    rtl: true,
  );

  /// 失败列表
  static const IconPark listFail = IconPark._(
    id: 1459,
    name: "list-fail",
    title: "失败列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["失败列表"],
    rtl: true,
  );

  /// 列表
  static const IconPark listMiddle = IconPark._(
    id: 1460,
    name: "list-middle",
    title: "列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["列表", "中间", "居中", "目录"],
    rtl: true,
  );

  /// 数字列表
  static const IconPark listNumbers = IconPark._(
    id: 1461,
    name: "list-numbers",
    title: "数字列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["数字列表", "段落", "文字排列"],
    rtl: true,
  );

  /// 列表
  static const IconPark listOne = IconPark._(
    id: 1462,
    name: "list-one",
    title: "列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["排列", "列表", "左对齐"],
    rtl: true,
  );

  /// 成功列表
  static const IconPark listSuccess = IconPark._(
    id: 1463,
    name: "list-success",
    title: "成功列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["成功列表"],
    rtl: true,
  );

  /// 列表
  static const IconPark listTop = IconPark._(
    id: 1464,
    name: "list-top",
    title: "列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["列表", "顶部", "最前", "目录"],
    rtl: true,
  );

  /// 列表2
  static const IconPark listTwo = IconPark._(
    id: 1465,
    name: "list-two",
    title: "列表2",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["目录", "清单", "完成目录", "任务清单"],
    rtl: true,
  );

  /// 列表视图
  static const IconPark listView = IconPark._(
    id: 1466,
    name: "list-view",
    title: "列表视图",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["列表", "表单"],
    rtl: true,
  );

  /// 加载
  static const IconPark loading = IconPark._(
    id: 1467,
    name: "loading",
    title: "加载",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["等待", "加载", "转圈", "循环"],
    rtl: true,
  );

  /// 加载4
  static const IconPark loadingFour = IconPark._(
    id: 1468,
    name: "loading-four",
    title: "加载4",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["等待", "加载", "转圈", "循环"],
    rtl: true,
  );

  /// 加载
  static const IconPark loadingOne = IconPark._(
    id: 1469,
    name: "loading-one",
    title: "加载",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["等待", "加载", "转圈", "缓冲"],
    rtl: false,
  );

  /// 加载
  static const IconPark loadingThree = IconPark._(
    id: 1470,
    name: "loading-three",
    title: "加载",
    category: "Time",
    categoryCN: "时间日期",
    author: "金磊",
    tag: ["等待", "加载", "转圈", "缓冲"],
    rtl: false,
  );

  /// 加载
  static const IconPark loadingTwo = IconPark._(
    id: 1471,
    name: "loading-two",
    title: "加载",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["等待", "加载", "转圈", "缓冲"],
    rtl: false,
  );

  /// 已定位
  static const IconPark local = IconPark._(
    id: 1472,
    name: "local",
    title: "已定位",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "齐奉飞",
    tag: ["位置", "坐标", "地点"],
    rtl: false,
  );

  /// 本地
  static const IconPark localPin = IconPark._(
    id: 1473,
    name: "local-pin",
    title: "本地",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["本地", "游戏", "摇杆", "图钉", "出行", "交通"],
    rtl: false,
  );

  /// 本地
  static const IconPark localTwo = IconPark._(
    id: 1474,
    name: "local-two",
    title: "本地",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["本地", "地表", "地点", "地图", "出行", "交通", "运输"],
    rtl: false,
  );

  /// 锁定
  static const IconPark lock = IconPark._(
    id: 1475,
    name: "lock",
    title: "锁定",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["锁定", "锁死", "关闭", "保密"],
    rtl: false,
  );

  /// 关锁
  static const IconPark lockOne = IconPark._(
    id: 1476,
    name: "lock-one",
    title: "关锁",
    category: "Edit",
    categoryCN: "编辑",
    author: "杨威",
    tag: ["锁定", "锁死", "关闭", "保密"],
    rtl: false,
  );

  /// 计算机锁定
  static const IconPark lockingComputer = IconPark._(
    id: 1477,
    name: "locking-computer",
    title: "计算机锁定",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 笔记本电脑锁定
  static const IconPark lockingLaptop = IconPark._(
    id: 1478,
    name: "locking-laptop",
    title: "笔记本电脑锁定",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 图片锁定
  static const IconPark lockingPicture = IconPark._(
    id: 1479,
    name: "locking-picture",
    title: "图片锁定",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 锁定网页
  static const IconPark lockingWeb = IconPark._(
    id: 1480,
    name: "locking-web",
    title: "锁定网页",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 日志
  static const IconPark log = IconPark._(
    id: 1481,
    name: "log",
    title: "日志",
    category: "Office",
    categoryCN: "办公文档",
    author: "刘心乐",
    tag: ["日志", "笔记本", "记录", "文档", "文本"],
    rtl: true,
  );

  /// 进入
  static const IconPark login = IconPark._(
    id: 1482,
    name: "login",
    title: "进入",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["进入", "向左", "箭头"],
    rtl: true,
  );

  /// 退出
  static const IconPark logout = IconPark._(
    id: 1483,
    name: "logout",
    title: "退出",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["退出", "向右", "箭头"],
    rtl: true,
  );

  /// 棒棒糖
  static const IconPark lollipop = IconPark._(
    id: 1484,
    name: "lollipop",
    title: "棒棒糖",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["棒棒糖", "零食", "甜食", "糖果"],
    rtl: true,
  );

  /// 循环一次
  static const IconPark loopOnce = IconPark._(
    id: 1485,
    name: "loop-once",
    title: "循环一次",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["循环", "单次循环", "播放", "返回", "单曲循环"],
    rtl: true,
  );

  /// 乳液
  static const IconPark lotion = IconPark._(
    id: 1486,
    name: "lotion",
    title: "乳液",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["泡沫", "乳液"],
    rtl: false,
  );

  /// 莲花
  static const IconPark lotus = IconPark._(
    id: 1487,
    name: "lotus",
    title: "莲花",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 哭
  static const IconPark loudlyCryingFace = IconPark._(
    id: 1488,
    name: "loudly-crying-face",
    title: "哭",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["哭", "表情", "难过"],
    rtl: false,
  );

  /// 张嘴哭
  static const IconPark loudlyCryingFaceWhitOpenMouth = IconPark._(
    id: 1489,
    name: "loudly-crying-face-whit-open-mouth",
    title: "张嘴哭",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["张嘴哭", "表情", "痛哭", "难过"],
    rtl: false,
  );

  /// 爱心
  static const IconPark loveAndHelp = IconPark._(
    id: 1490,
    name: "love-and-help",
    title: "爱心",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 下分支
  static const IconPark lowerBranch = IconPark._(
    id: 1491,
    name: "lower-branch",
    title: "下分支",
    category: "Connect",
    categoryCN: "链接",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 行李箱
  static const IconPark luggage = IconPark._(
    id: 1492,
    name: "luggage",
    title: "行李箱",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["行李", "行李箱"],
    rtl: false,
  );

  /// 发光
  static const IconPark luminous = IconPark._(
    id: 1493,
    name: "luminous",
    title: "发光",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["散射", "散射光", "光源", "照射", "节能", "light", "键盘"],
    rtl: true,
  );

  /// 肺
  static const IconPark lung = IconPark._(
    id: 1494,
    name: "lung",
    title: "肺",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["呼吸", "呼吸道", "呼吸科", "器官", "肺"],
    rtl: true,
  );

  /// 访达
  static const IconPark macFinder = IconPark._(
    id: 1495,
    name: "mac-finder",
    title: "访达",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["访达", "文件管理", "我的电脑"],
    rtl: true,
  );

  /// 夏威夷果
  static const IconPark macadamiaNut = IconPark._(
    id: 1496,
    name: "macadamia-nut",
    title: "夏威夷果",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["夏威夷果", "坚果"],
    rtl: true,
  );

  /// 魔法棒
  static const IconPark magic = IconPark._(
    id: 1497,
    name: "magic",
    title: "魔法棒",
    category: "Others",
    categoryCN: "其它",
    author: "齐奉飞",
    tag: ["魔法", "魔术", "神奇", "变化"],
    rtl: true,
  );

  /// 魔术帽
  static const IconPark magicHat = IconPark._(
    id: 1498,
    name: "magic-hat",
    title: "魔术帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["帽子", "魔术", "高帽", "道具"],
    rtl: true,
  );

  /// 魔法棒
  static const IconPark magicWand = IconPark._(
    id: 1499,
    name: "magic-wand",
    title: "魔法棒",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["魔法棒", "滤镜", "特效", "美颜"],
    rtl: true,
  );

  /// 磁铁
  static const IconPark magnet = IconPark._(
    id: 1500,
    name: "magnet",
    title: "磁铁",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["磁铁", "吸引", "正负极", "磁力", "物理", "电力"],
    rtl: false,
  );

  /// 邮件
  static const IconPark mail = IconPark._(
    id: 1501,
    name: "mail",
    title: "邮件",
    category: "Office",
    categoryCN: "办公文档",
    author: "常留留",
    tag: ["信封", "消息", "邮件", "文件"],
    rtl: false,
  );

  /// 邮件下载
  static const IconPark mailDownload = IconPark._(
    id: 1502,
    name: "mail-download",
    title: "邮件下载",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["邮件下载", "信封", "邮件", "邮寄", "文件"],
    rtl: false,
  );

  /// 邮件编辑
  static const IconPark mailEdit = IconPark._(
    id: 1503,
    name: "mail-edit",
    title: "邮件编辑",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "编辑邮件"],
    rtl: true,
  );

  /// 已读邮件
  static const IconPark mailOpen = IconPark._(
    id: 1504,
    name: "mail-open",
    title: "已读邮件",
    category: "Office",
    categoryCN: "办公文档",
    author: "白明泽",
    tag: ["已读邮件", "邮箱", "邮件", "信息", "邮箱", "打开", "收件"],
    rtl: false,
  );

  /// 邮件包
  static const IconPark mailPackage = IconPark._(
    id: 1505,
    name: "mail-package",
    title: "邮件包",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "邮件组"],
    rtl: false,
  );

  /// 邮件查阅
  static const IconPark mailReview = IconPark._(
    id: 1506,
    name: "mail-review",
    title: "邮件查阅",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "查看"],
    rtl: true,
  );

  /// 邮件打开
  static const IconPark mailUnpacking = IconPark._(
    id: 1507,
    name: "mail-unpacking",
    title: "邮件打开",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "打开"],
    rtl: false,
  );

  /// 邮件1
  static const IconPark maillOne = IconPark._(
    id: 1508,
    name: "maill-one",
    title: "邮件1",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["信息", "讯息", "交流", "社交", "logo"],
    rtl: false,
  );

  /// 美容
  static const IconPark makeups = IconPark._(
    id: 1509,
    name: "makeups",
    title: "美容",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["面膜", "护肤", "美妆"],
    rtl: true,
  );

  /// 男性
  static const IconPark male = IconPark._(
    id: 1510,
    name: "male",
    title: "男性",
    category: "Base",
    categoryCN: "基础",
    author: "刘心乐",
    tag: ["男", "性别", "符号"],
    rtl: true,
  );

  /// 购物袋
  static const IconPark mallBag = IconPark._(
    id: 1511,
    name: "mall-bag",
    title: "购物袋",
    category: "Money",
    categoryCN: "电商财产",
    author: "刘心乐",
    tag: ["袋子", "购物袋", "逛街"],
    rtl: false,
  );

  /// 手动挡
  static const IconPark manualGear = IconPark._(
    id: 1512,
    name: "manual-gear",
    title: "手动挡",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["手动挡", "汽车"],
    rtl: true,
  );

  /// 多对多
  static const IconPark manyToMany = IconPark._(
    id: 1513,
    name: "many-to-many",
    title: "多对多",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["多对多", "n:n", "N:N"],
    rtl: true,
  );

  /// 地图距离
  static const IconPark mapDistance = IconPark._(
    id: 1514,
    name: "map-distance",
    title: "地图距离",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "白明泽",
    tag: ["地图", "距离", "出行", "交通", "方向", "位置", "路线", "导航"],
    rtl: true,
  );

  /// 地图
  static const IconPark mapDraw = IconPark._(
    id: 1515,
    name: "map-draw",
    title: "地图",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["地图", "位置", "地理", "方位", "方向", "交通", "定位"],
    rtl: true,
  );

  /// 地图道路
  static const IconPark mapRoad = IconPark._(
    id: 1516,
    name: "map-road",
    title: "地图道路",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "白明泽",
    tag: ["地图", "道路", "交通", "出行"],
    rtl: false,
  );

  /// 地图
  static const IconPark mapRoadTwo = IconPark._(
    id: 1517,
    name: "map-road-two",
    title: "地图",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["地图", "地点", "地图", "出行", "交通", "运输"],
    rtl: true,
  );

  /// 地图
  static const IconPark mapTwo = IconPark._(
    id: 1518,
    name: "map-two",
    title: "地图",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["地图", "地点", "地图", "出行", "交通", "运输"],
    rtl: true,
  );

  /// 垂直居中
  static const IconPark margin = IconPark._(
    id: 1519,
    name: "margin",
    title: "垂直居中",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版", "垂直"],
    rtl: false,
  );

  /// 水平居中
  static const IconPark marginOne = IconPark._(
    id: 1520,
    name: "margin-one",
    title: "水平居中",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版", "水平"],
    rtl: false,
  );

  /// 标记
  static const IconPark mark = IconPark._(
    id: 1521,
    name: "mark",
    title: "标记",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "齐奉飞",
    tag: ["旗帜", "旗子", "记号", "活动"],
    rtl: true,
  );

  /// 易拍
  static const IconPark market = IconPark._(
    id: 1522,
    name: "market",
    title: "易拍",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["巨量创意", "易拍", "广告拍摄", "滤镜", "编辑视频", "oceanengine", "logo"],
    rtl: true,
  );

  /// 市场分析
  static const IconPark marketAnalysis = IconPark._(
    id: 1523,
    name: "market-analysis",
    title: "市场分析",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["分析", "数据", "趋势"],
    rtl: true,
  );

  /// 睫毛膏
  static const IconPark mascara = IconPark._(
    id: 1524,
    name: "mascara",
    title: "睫毛膏",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["睫毛刷", "美妆", "化妆"],
    rtl: true,
  );

  /// 口罩
  static const IconPark mask = IconPark._(
    id: 1525,
    name: "mask",
    title: "口罩",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["传染", "传染科", "雾霾", "生病", "口罩"],
    rtl: true,
  );

  /// 面具
  static const IconPark maskOne = IconPark._(
    id: 1526,
    name: "mask-one",
    title: "面具",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "常留留",
    tag: ["补水", "保湿", "美白", "敷面膜", "面膜", "医美"],
    rtl: false,
  );

  /// 遮罩
  static const IconPark maskTwo = IconPark._(
    id: 1527,
    name: "mask-two",
    title: "遮罩",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["遮罩", "蒙版", "阴影"],
    rtl: true,
  );

  /// 马斯洛金字塔
  static const IconPark maslowPyramids = IconPark._(
    id: 1528,
    name: "maslow-pyramids",
    title: "马斯洛金字塔",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["需求层次理论", "金字塔需求"],
    rtl: false,
  );

  /// 按摩椅
  static const IconPark massageChair = IconPark._(
    id: 1529,
    name: "massage-chair",
    title: "按摩椅",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["椅子", "凳子", "办公", "按摩椅"],
    rtl: false,
  );

  /// 按摩椅1
  static const IconPark massageChairOne = IconPark._(
    id: 1530,
    name: "massage-chair-one",
    title: "按摩椅1",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["椅子", "凳子", "办公"],
    rtl: false,
  );

  /// 按摩椅
  static const IconPark massageTable = IconPark._(
    id: 1531,
    name: "massage-table",
    title: "按摩椅",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["椅子", "床"],
    rtl: true,
  );

  /// 主机
  static const IconPark master = IconPark._(
    id: 1532,
    name: "master",
    title: "主机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["储存器", "服务器", "管理器"],
    rtl: true,
  );

  /// 素材
  static const IconPark material = IconPark._(
    id: 1533,
    name: "material",
    title: "素材",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "齐奉飞",
    tag: ["用户素材", "图像", "素材"],
    rtl: true,
  );

  /// 材料3
  static const IconPark materialThree = IconPark._(
    id: 1534,
    name: "material-three",
    title: "材料3",
    category: "Charts",
    categoryCN: "数据图表",
    author: "齐奉飞",
    tag: ["图片集", "照片", "相册"],
    rtl: true,
  );

  /// 材质
  static const IconPark materialTwo = IconPark._(
    id: 1535,
    name: "material-two",
    title: "材质",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["材质", "拍摄", "设置", "摄像"],
    rtl: true,
  );

  /// 最大值
  static const IconPark maximum = IconPark._(
    id: 1536,
    name: "maximum",
    title: "最大值",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["最大", "极限", "数值", "数据", "图表", "曲线"],
    rtl: true,
  );

  /// 玛雅
  static const IconPark maya = IconPark._(
    id: 1537,
    name: "maya",
    title: "玛雅",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "房子", "楼房", "建筑"],
    rtl: false,
  );

  /// 马尤拉手势
  static const IconPark mayuraGesture = IconPark._(
    id: 1538,
    name: "mayura-gesture",
    title: "马尤拉手势",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["手", "手势"],
    rtl: true,
  );

  /// 我的
  static const IconPark me = IconPark._(
    id: 1539,
    name: "me",
    title: "我的",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "刘心乐",
    tag: ["个人中心", "用户", "人", "头像", "圆形头像"],
    rtl: false,
  );

  /// 计量杯
  static const IconPark measuringCup = IconPark._(
    id: 1540,
    name: "measuring-cup",
    title: "计量杯",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["计量杯", "量杯", "厨房厨具"],
    rtl: true,
  );

  /// 徽章
  static const IconPark medalOne = IconPark._(
    id: 1541,
    name: "medal-one",
    title: "徽章",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 剪映
  static const IconPark mediaeditor = IconPark._(
    id: 1542,
    name: "mediaeditor",
    title: "剪映",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["软件", "应用", "工具", "设计", "视频", "剪辑", "logo"],
    rtl: true,
  );

  /// 医疗箱
  static const IconPark medicalBox = IconPark._(
    id: 1543,
    name: "medical-box",
    title: "医疗箱",
    category: "Health",
    categoryCN: "医疗健康",
    author: "齐奉飞",
    tag: ["药箱", "急诊箱"],
    rtl: true,
  );

  /// 医疗档案
  static const IconPark medicalFiles = IconPark._(
    id: 1544,
    name: "medical-files",
    title: "医疗档案",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["档案", "文件", "收藏文件", "医疗"],
    rtl: true,
  );

  /// 医学标志
  static const IconPark medicalMark = IconPark._(
    id: 1545,
    name: "medical-mark",
    title: "医学标志",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 准时吃药
  static const IconPark medicationTime = IconPark._(
    id: 1546,
    name: "medication-time",
    title: "准时吃药",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["按时", "准时"],
    rtl: true,
  );

  /// 药罐
  static const IconPark medicineBottle = IconPark._(
    id: 1547,
    name: "medicine-bottle",
    title: "药罐",
    category: "Health",
    categoryCN: "医疗健康",
    author: "齐奉飞",
    tag: ["西药", "药瓶"],
    rtl: true,
  );

  /// 药瓶
  static const IconPark medicineBottleOne = IconPark._(
    id: 1548,
    name: "medicine-bottle-one",
    title: "药瓶",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 药箱
  static const IconPark medicineChest = IconPark._(
    id: 1549,
    name: "medicine-chest",
    title: "药箱",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 储存卡
  static const IconPark memory = IconPark._(
    id: 1550,
    name: "memory",
    title: "储存卡",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: true,
  );

  /// 存储卡
  static const IconPark memoryCard = IconPark._(
    id: 1551,
    name: "memory-card",
    title: "存储卡",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: true,
  );

  /// 记忆卡
  static const IconPark memoryCardOne = IconPark._(
    id: 1552,
    name: "memory-card-one",
    title: "记忆卡",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: true,
  );

  /// 储存器
  static const IconPark memoryOne = IconPark._(
    id: 1553,
    name: "memory-one",
    title: "储存器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: true,
  );

  /// 男士外套
  static const IconPark menJacket = IconPark._(
    id: 1554,
    name: "men-jacket",
    title: "男士外套",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["上衣", "服装", "汉服", "外套", "衣服"],
    rtl: false,
  );

  /// 收起菜单
  static const IconPark menuFold = IconPark._(
    id: 1555,
    name: "menu-fold",
    title: "收起菜单",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["收起", "左侧收起", "侧边收起"],
    rtl: true,
  );

  /// 收起菜单1
  static const IconPark menuFoldOne = IconPark._(
    id: 1556,
    name: "menu-fold-one",
    title: "收起菜单1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["展开", "侧边展开"],
    rtl: true,
  );

  /// 展开菜单
  static const IconPark menuUnfold = IconPark._(
    id: 1557,
    name: "menu-unfold",
    title: "展开菜单",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["展开", "右侧展开", "侧边展开"],
    rtl: true,
  );

  /// 展开菜单1
  static const IconPark menuUnfoldOne = IconPark._(
    id: 1558,
    name: "menu-unfold-one",
    title: "展开菜单1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["收起", "侧边收起"],
    rtl: true,
  );

  /// 合并
  static const IconPark merge = IconPark._(
    id: 1559,
    name: "merge",
    title: "合并",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["交叉", "合并", "交集"],
    rtl: true,
  );

  /// 合并单元格
  static const IconPark mergeCells = IconPark._(
    id: 1560,
    name: "merge-cells",
    title: "合并单元格",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["合并单元格", "表格", "操作"],
    rtl: false,
  );

  /// 信息
  static const IconPark message = IconPark._(
    id: 1561,
    name: "message",
    title: "信息",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "金磊",
    tag: ["聊天", "消息", "社交", "通讯", "沟通"],
    rtl: true,
  );

  /// 表情信息
  static const IconPark messageEmoji = IconPark._(
    id: 1562,
    name: "message-emoji",
    title: "表情信息",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["对话", "评论", "聊天", "消息", "通知"],
    rtl: true,
  );

  /// 信息失败
  static const IconPark messageFailed = IconPark._(
    id: 1563,
    name: "message-failed",
    title: "信息失败",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["对话", "评论", "聊天", "消息", "通知", "失败"],
    rtl: true,
  );

  /// 消息
  static const IconPark messageOne = IconPark._(
    id: 1564,
    name: "message-one",
    title: "消息",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "常留留",
    tag: ["信息", "聊天", "通知", "社交", "沟通"],
    rtl: true,
  );

  /// 信息加密
  static const IconPark messagePrivacy = IconPark._(
    id: 1565,
    name: "message-privacy",
    title: "信息加密",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["对话", "评论", "聊天", "消息", "通知", "加密", "安全"],
    rtl: true,
  );

  /// 信息搜索
  static const IconPark messageSearch = IconPark._(
    id: 1566,
    name: "message-search",
    title: "信息搜索",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["对话", "评论", "聊天", "消息", "通知", "搜索"],
    rtl: true,
  );

  /// 信息安全
  static const IconPark messageSecurity = IconPark._(
    id: 1567,
    name: "message-security",
    title: "信息安全",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["对话", "评论", "聊天", "消息", "通知", "加密", "安全"],
    rtl: true,
  );

  /// 信息已发送
  static const IconPark messageSent = IconPark._(
    id: 1568,
    name: "message-sent",
    title: "信息已发送",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "金磊",
    tag: ["发送信息", "消息", "完成"],
    rtl: true,
  );

  /// 信息成功
  static const IconPark messageSuccess = IconPark._(
    id: 1569,
    name: "message-success",
    title: "信息成功",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["对话", "评论", "聊天", "消息", "通知", "发送"],
    rtl: true,
  );

  /// 未读消息
  static const IconPark messageUnread = IconPark._(
    id: 1570,
    name: "message-unread",
    title: "未读消息",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "常留留",
    tag: ["信息", "聊天", "通知", "社交", "沟通", "新消息", "评论"],
    rtl: true,
  );

  /// 短信
  static const IconPark messages = IconPark._(
    id: 1571,
    name: "messages",
    title: "短信",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["信息", "讯息", "交流", "社交", "logo"],
    rtl: true,
  );

  /// 短信1
  static const IconPark messagesOne = IconPark._(
    id: 1572,
    name: "messages-one",
    title: "短信1",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["信息", "讯息", "交流", "社交", "logo"],
    rtl: true,
  );

  /// 微型SD
  static const IconPark microSd = IconPark._(
    id: 1573,
    name: "micro-sd",
    title: "微型SD",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["卡", "储存", "信号", "流量"],
    rtl: true,
  );

  /// 微单
  static const IconPark microSlrCamera = IconPark._(
    id: 1574,
    name: "micro-slr-camera",
    title: "微单",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["微单", "摄影", "设备", "相机", "镜头"],
    rtl: true,
  );

  /// 麦克风
  static const IconPark microphone = IconPark._(
    id: 1575,
    name: "microphone",
    title: "麦克风",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["话筒", "收音器", "音乐", "乐器", "扩音器", "耳麦", "麦霸"],
    rtl: false,
  );

  /// 收音器
  static const IconPark microphoneOne = IconPark._(
    id: 1576,
    name: "microphone-one",
    title: "收音器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["广播", "话筒", "扩音器", "麦克风"],
    rtl: true,
  );

  /// 显微镜
  static const IconPark microscope = IconPark._(
    id: 1577,
    name: "microscope",
    title: "显微镜",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["观察", "高倍镜", "病理科"],
    rtl: true,
  );

  /// 显微镜
  static const IconPark microscopeOne = IconPark._(
    id: 1578,
    name: "microscope-one",
    title: "显微镜",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["镜子", "放大", "仪器", "实验", "望远镜", "探测仪"],
    rtl: true,
  );

  /// 微波炉
  static const IconPark microwaveOven = IconPark._(
    id: 1579,
    name: "microwave-oven",
    title: "微波炉",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["加热", "电器", "烤箱", "容器", "冰箱", "收纳箱"],
    rtl: true,
  );

  /// 微波炉
  static const IconPark microwaves = IconPark._(
    id: 1580,
    name: "microwaves",
    title: "微波炉",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["加热器", "烹饪机", "做饭"],
    rtl: true,
  );

  /// 中指
  static const IconPark middleFinger = IconPark._(
    id: 1581,
    name: "middle-finger",
    title: "中指",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["手指", "手势"],
    rtl: true,
  );

  /// 牛奶
  static const IconPark milk = IconPark._(
    id: 1582,
    name: "milk",
    title: "牛奶",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水杯", "果汁", "汽水", "奶茶"],
    rtl: true,
  );

  /// 牛奶
  static const IconPark milkOne = IconPark._(
    id: 1583,
    name: "milk-one",
    title: "牛奶",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["牛奶", "盒装", "乳品", "牛奶盒", "牛奶杯"],
    rtl: true,
  );

  /// 最小值
  static const IconPark min = IconPark._(
    id: 1584,
    name: "min",
    title: "最小值",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["最小", "极限", "数值", "数据", "图表", "曲线"],
    rtl: true,
  );

  /// 脑图
  static const IconPark mindMapping = IconPark._(
    id: 1585,
    name: "mind-mapping",
    title: "脑图",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["脑图", "思维导图", "结构图", "框架图"],
    rtl: true,
  );

  /// 大纲视图
  static const IconPark mindmapList = IconPark._(
    id: 1586,
    name: "mindmap-list",
    title: "大纲视图",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["大纲视图", "列表"],
    rtl: true,
  );

  /// 思维导图
  static const IconPark mindmapMap = IconPark._(
    id: 1587,
    name: "mindmap-map",
    title: "思维导图",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["思维导图", "脑图", "逻辑"],
    rtl: true,
  );

  /// 微型存储卡
  static const IconPark miniSdCard = IconPark._(
    id: 1588,
    name: "mini-sd-card",
    title: "微型存储卡",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["微型SD卡", "SD", "储存", "存储", "store"],
    rtl: true,
  );

  /// 减
  static const IconPark minus = IconPark._(
    id: 1589,
    name: "minus",
    title: "减",
    category: "Character",
    categoryCN: "符号标识",
    author: "常留留",
    tag: ["减号", "去除", "减少"],
    rtl: false,
  );

  /// 移到底部
  static const IconPark minusTheBottom = IconPark._(
    id: 1590,
    name: "minus-the-bottom",
    title: "移到底部",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["移到底部", "置于底部", "下移", "复制"],
    rtl: true,
  );

  /// 移到顶部
  static const IconPark minusTheTop = IconPark._(
    id: 1591,
    name: "minus-the-top",
    title: "移到顶部",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["移到顶部", "置于顶部", "上移", "复制"],
    rtl: true,
  );

  /// 镜子
  static const IconPark mirror = IconPark._(
    id: 1592,
    name: "mirror",
    title: "镜子",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["镜子", "化妆镜", "正面", "照"],
    rtl: false,
  );

  /// 镜子
  static const IconPark mirrorOne = IconPark._(
    id: 1593,
    name: "mirror-one",
    title: "镜子",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "张蔓",
    tag: ["镜子", "化妆镜", "美状镜"],
    rtl: false,
  );

  /// 镜子2
  static const IconPark mirrorTwo = IconPark._(
    id: 1594,
    name: "mirror-two",
    title: "镜子2",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["镜子"],
    rtl: false,
  );

  /// 半圆
  static const IconPark misalignedSemicircle = IconPark._(
    id: 1595,
    name: "misaligned-semicircle",
    title: "半圆",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["半圆", "切割", "抽象"],
    rtl: true,
  );

  /// 三菱
  static const IconPark mitsubishi = IconPark._(
    id: 1596,
    name: "mitsubishi",
    title: "三菱",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["汽车", "三角形", "菱形", "logo"],
    rtl: false,
  );

  /// 修改
  static const IconPark modify = IconPark._(
    id: 1597,
    name: "modify",
    title: "修改",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["错误", "修改", "直尺"],
    rtl: true,
  );

  /// 修改
  static const IconPark modifyTwo = IconPark._(
    id: 1598,
    name: "modify-two",
    title: "修改",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["橡皮", "修改", "涂抹", "擦除"],
    rtl: true,
  );

  /// 摄像
  static const IconPark monitor = IconPark._(
    id: 1599,
    name: "monitor",
    title: "摄像",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "刘心乐",
    tag: ["拍摄", "录像", "摄像机", "影像", "电影"],
    rtl: true,
  );

  /// 监控摄像头
  static const IconPark monitorCamera = IconPark._(
    id: 1600,
    name: "monitor-camera",
    title: "监控摄像头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "白明泽",
    tag: ["监控", "摄像头", "网络摄像头", "摄像机", "摄像机", "摄像头", "监视"],
    rtl: false,
  );

  /// 关闭摄像
  static const IconPark monitorOff = IconPark._(
    id: 1601,
    name: "monitor-off",
    title: "关闭摄像",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["拍摄", "录像", "摄像机", "影像", "电影", "关闭"],
    rtl: true,
  );

  /// 显示器
  static const IconPark monitorOne = IconPark._(
    id: 1602,
    name: "monitor-one",
    title: "显示器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["屏幕", "显示屏", "电脑", "监测台", "窗口", "电视", "电影", "节目", "电视剧"],
    rtl: true,
  );

  /// 音波控制
  static const IconPark monitorTwo = IconPark._(
    id: 1603,
    name: "monitor-two",
    title: "音波控制",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["音频", "音量", "语音", "录音", "波纹", "声音"],
    rtl: true,
  );

  /// 猴
  static const IconPark monkey = IconPark._(
    id: 1604,
    name: "monkey",
    title: "猴",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 生肖猴
  static const IconPark monkeyZodiac = IconPark._(
    id: 1605,
    name: "monkey-zodiac",
    title: "生肖猴",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 纪念碑
  static const IconPark monumentOne = IconPark._(
    id: 1606,
    name: "monument-one",
    title: "纪念碑",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["石碑、纪念碑", "标志"],
    rtl: false,
  );

  /// 纪念碑
  static const IconPark monumentTwo = IconPark._(
    id: 1607,
    name: "monument-two",
    title: "纪念碑",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["石碑、纪念碑", "标志"],
    rtl: true,
  );

  /// 月亮
  static const IconPark moon = IconPark._(
    id: 1608,
    name: "moon",
    title: "月亮",
    category: "Weather",
    categoryCN: "天气",
    author: "常留留",
    tag: ["夜晚", "月亮", "黑夜", "晚上", "月牙", "黑暗"],
    rtl: true,
  );

  /// 更多
  static const IconPark more = IconPark._(
    id: 1609,
    name: "more",
    title: "更多",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["点", "三点", "更多"],
    rtl: false,
  );

  /// 更多
  static const IconPark moreApp = IconPark._(
    id: 1610,
    name: "more-app",
    title: "更多",
    category: "Base",
    categoryCN: "基础",
    author: "金磊",
    tag: ["更多", "全部", "应用"],
    rtl: true,
  );

  /// 更多
  static const IconPark moreFour = IconPark._(
    id: 1611,
    name: "more-four",
    title: "更多",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["更多", "编辑", "其他", "分类"],
    rtl: false,
  );

  /// 更多1
  static const IconPark moreOne = IconPark._(
    id: 1612,
    name: "more-one",
    title: "更多1",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["点", "三点", "更多"],
    rtl: false,
  );

  /// 更多3
  static const IconPark moreThree = IconPark._(
    id: 1613,
    name: "more-three",
    title: "更多3",
    category: "Character",
    categoryCN: "符号标识",
    author: "常留留",
    tag: ["更多", "圆形"],
    rtl: false,
  );

  /// 更多2
  static const IconPark moreTwo = IconPark._(
    id: 1614,
    name: "more-two",
    title: "更多2",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["更多", "圆形", "三点"],
    rtl: false,
  );

  /// 马赛克
  static const IconPark mosaic = IconPark._(
    id: 1615,
    name: "mosaic",
    title: "马赛克",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["模糊", "虚化", "遮盖", "擦除", "马赛克"],
    rtl: true,
  );

  /// 山
  static const IconPark mountain = IconPark._(
    id: 1616,
    name: "mountain",
    title: "山",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 摩托
  static const IconPark mounted = IconPark._(
    id: 1617,
    name: "mounted",
    title: "摩托",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 鼠标
  static const IconPark mouse = IconPark._(
    id: 1618,
    name: "mouse",
    title: "鼠标",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["鼠标", "配件", "设备", "网络"],
    rtl: true,
  );

  /// 鼠标
  static const IconPark mouseOne = IconPark._(
    id: 1619,
    name: "mouse-one",
    title: "鼠标",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["点击", "移动", "指引", "选择", "按键", "控制"],
    rtl: true,
  );

  /// 生肖鼠
  static const IconPark mouseZodiac = IconPark._(
    id: 1620,
    name: "mouse-zodiac",
    title: "生肖鼠",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 嘴巴
  static const IconPark mouth = IconPark._(
    id: 1621,
    name: "mouth",
    title: "嘴巴",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "金磊",
    tag: ["嘴巴", "美妆", "化妆", "时尚", "器官", "口", "说话"],
    rtl: false,
  );

  /// 移动
  static const IconPark move = IconPark._(
    id: 1622,
    name: "move",
    title: "移动",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["滑动", "侧滑"],
    rtl: true,
  );

  /// 向内移动
  static const IconPark moveIn = IconPark._(
    id: 1623,
    name: "move-in",
    title: "向内移动",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["移动", "剧中", "聚合", "合并"],
    rtl: false,
  );

  /// 移动
  static const IconPark moveInOne = IconPark._(
    id: 1624,
    name: "move-in-one",
    title: "移动",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["移动", "指向", "拉伸", "点击"],
    rtl: true,
  );

  /// 移动
  static const IconPark moveOne = IconPark._(
    id: 1625,
    name: "move-one",
    title: "移动",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["移动", "飞机", "选中", "箭头"],
    rtl: true,
  );

  /// 电影
  static const IconPark movie = IconPark._(
    id: 1626,
    name: "movie",
    title: "电影",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["视频", "胶片", "电影", "电视", "录音机"],
    rtl: true,
  );

  /// 影视板
  static const IconPark movieBoard = IconPark._(
    id: 1627,
    name: "movie-board",
    title: "影视板",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["影视板"],
    rtl: true,
  );

  /// 图片
  static const IconPark movingPicture = IconPark._(
    id: 1628,
    name: "moving-picture",
    title: "图片",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 多圆形
  static const IconPark multiCircular = IconPark._(
    id: 1629,
    name: "multi-circular",
    title: "多圆形",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["多圆形", "圆形", "叠加", "缩放", "圆形拼接"],
    rtl: false,
  );

  /// 多功能刀
  static const IconPark multiFunctionKnife = IconPark._(
    id: 1630,
    name: "multi-function-knife",
    title: "多功能刀",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["多功能刀", "武器", "瑞士", "军刀"],
    rtl: true,
  );

  /// 多图轮播
  static const IconPark multiPictureCarousel = IconPark._(
    id: 1631,
    name: "multi-picture-carousel",
    title: "多图轮播",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["多图轮播"],
    rtl: false,
  );

  /// 多方形
  static const IconPark multiRectangle = IconPark._(
    id: 1632,
    name: "multi-rectangle",
    title: "多方形",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["多方形", "方形", "叠加", "缩放", "方形拼接"],
    rtl: true,
  );

  /// 多圆环
  static const IconPark multiRing = IconPark._(
    id: 1633,
    name: "multi-ring",
    title: "多圆环",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["关联", "圆环", "交集", "抽象", "花形"],
    rtl: false,
  );

  /// 多三角
  static const IconPark multiTriangular = IconPark._(
    id: 1634,
    name: "multi-triangular",
    title: "多三角",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["多三角", "锐度", "面积"],
    rtl: true,
  );

  /// 多三角
  static const IconPark multiTriangularFour = IconPark._(
    id: 1635,
    name: "multi-triangular-four",
    title: "多三角",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["多三角", "三角拼接"],
    rtl: false,
  );

  /// 多三角
  static const IconPark multiTriangularThree = IconPark._(
    id: 1636,
    name: "multi-triangular-three",
    title: "多三角",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["多三角", "三角拼接", "组合"],
    rtl: false,
  );

  /// 多三角
  static const IconPark multiTriangularTwo = IconPark._(
    id: 1637,
    name: "multi-triangular-two",
    title: "多三角",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["多三角", "三角拼接", "组合"],
    rtl: false,
  );

  /// 多播
  static const IconPark multicast = IconPark._(
    id: 1638,
    name: "multicast",
    title: "多播",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["组播", "节点传输", "多节点", "通信"],
    rtl: true,
  );

  /// 多层圆球
  static const IconPark multilayerSphere = IconPark._(
    id: 1639,
    name: "multilayer-sphere",
    title: "多层圆球",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["多层圆球", "阴影", "叠加", "面积"],
    rtl: false,
  );

  /// 肌肉
  static const IconPark muscle = IconPark._(
    id: 1640,
    name: "muscle",
    title: "肌肉",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["武打", "功夫", "练功", "训练", "习武", "踢脚", "抬腿", "舞蹈", "体操", "放松", "热身", "健身", "健壮", "健康", "力量", "体育"],
    rtl: true,
  );

  /// 博物馆
  static const IconPark museumOne = IconPark._(
    id: 1641,
    name: "museum-one",
    title: "博物馆",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["展览馆", "大会堂", "政府", "机构"],
    rtl: false,
  );

  /// 博物馆
  static const IconPark museumTwo = IconPark._(
    id: 1642,
    name: "museum-two",
    title: "博物馆",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["展览馆", "大会堂", "政府", "机构"],
    rtl: false,
  );

  /// 音乐
  static const IconPark music = IconPark._(
    id: 1643,
    name: "music",
    title: "音乐",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["音乐", "乐符", "歌曲", "歌声", "播放"],
    rtl: true,
  );

  /// 音乐cd
  static const IconPark musicCd = IconPark._(
    id: 1644,
    name: "music-cd",
    title: "音乐cd",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 音乐菜单
  static const IconPark musicList = IconPark._(
    id: 1645,
    name: "music-list",
    title: "音乐菜单",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["列表", "菜单"],
    rtl: true,
  );

  /// 音乐菜单
  static const IconPark musicMenu = IconPark._(
    id: 1646,
    name: "music-menu",
    title: "音乐菜单",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 音乐
  static const IconPark musicOne = IconPark._(
    id: 1647,
    name: "music-one",
    title: "音乐",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["音乐", "乐符", "歌曲", "歌声", "播放"],
    rtl: true,
  );

  /// 音乐律动
  static const IconPark musicRhythm = IconPark._(
    id: 1648,
    name: "music-rhythm",
    title: "音乐律动",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["音乐律动"],
    rtl: true,
  );

  /// 静音
  static const IconPark mute = IconPark._(
    id: 1649,
    name: "mute",
    title: "静音",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["静音", "安静", "音量"],
    rtl: true,
  );

  /// 指甲油
  static const IconPark nailPolish = IconPark._(
    id: 1650,
    name: "nail-polish",
    title: "指甲油",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["行李箱", "手提箱", "指甲油", "美甲"],
    rtl: false,
  );

  /// 指甲油1
  static const IconPark nailPolishOne = IconPark._(
    id: 1651,
    name: "nail-polish-one",
    title: "指甲油1",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 鼻腔
  static const IconPark nasal = IconPark._(
    id: 1652,
    name: "nasal",
    title: "鼻腔",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["鼻子", "呼吸", "耳鼻喉", "耳鼻喉科"],
    rtl: true,
  );

  /// 自然模式
  static const IconPark naturalMode = IconPark._(
    id: 1653,
    name: "natural-mode",
    title: "自然模式",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["花朵", "植物"],
    rtl: true,
  );

  /// 导航
  static const IconPark navigation = IconPark._(
    id: 1654,
    name: "navigation",
    title: "导航",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "常留留",
    tag: ["指针", "方向", "指引", "指针", "导航"],
    rtl: false,
  );

  /// 领带
  static const IconPark necktie = IconPark._(
    id: 1655,
    name: "necktie",
    title: "领带",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["领结", "领带"],
    rtl: false,
  );

  /// 针
  static const IconPark needle = IconPark._(
    id: 1656,
    name: "needle",
    title: "针",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 消极动态
  static const IconPark negativeDynamics = IconPark._(
    id: 1657,
    name: "negative-dynamics",
    title: "消极动态",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["动态", "消极", "负向数据", "图表"],
    rtl: true,
  );

  /// 嵌套箭头
  static const IconPark nestedArrows = IconPark._(
    id: 1658,
    name: "nested-arrows",
    title: "嵌套箭头",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["嵌套箭头", "关联", "连接"],
    rtl: true,
  );

  /// 燕窝
  static const IconPark nests = IconPark._(
    id: 1659,
    name: "nests",
    title: "燕窝",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["补品", "滋补", "养生", "动物", "燕窝"],
    rtl: true,
  );

  /// 云办公
  static const IconPark networkDrive = IconPark._(
    id: 1660,
    name: "network-drive",
    title: "云办公",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["云", "服务", "办公"],
    rtl: true,
  );

  /// 网络节点
  static const IconPark networkTree = IconPark._(
    id: 1661,
    name: "network-tree",
    title: "网络节点",
    category: "Connect",
    categoryCN: "链接",
    author: "金磊",
    tag: ["网络", "结构", "节点", "联通", "信息", "传输", "信号"],
    rtl: true,
  );

  /// 神经
  static const IconPark neural = IconPark._(
    id: 1662,
    name: "neural",
    title: "神经",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["神经科", "精神", "神经元", "医疗"],
    rtl: true,
  );

  /// 正常标签
  static const IconPark neutralFace = IconPark._(
    id: 1663,
    name: "neutral-face",
    title: "正常标签",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["正常标签", "表情", "无语"],
    rtl: false,
  );

  /// 新传入
  static const IconPark newAfferent = IconPark._(
    id: 1664,
    name: "new-afferent",
    title: "新传入",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 计算机
  static const IconPark newComputer = IconPark._(
    id: 1665,
    name: "new-computer",
    title: "计算机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 电子签-新
  static const IconPark newDianziqian = IconPark._(
    id: 1666,
    name: "new-dianziqian",
    title: "电子签-新",
    category: "Brand",
    categoryCN: "品牌",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 新传出
  static const IconPark newEfferent = IconPark._(
    id: 1667,
    name: "new-efferent",
    title: "新传出",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 飞书-新
  static const IconPark newLark = IconPark._(
    id: 1668,
    name: "new-lark",
    title: "飞书-新",
    category: "Brand",
    categoryCN: "品牌",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 新图片
  static const IconPark newPicture = IconPark._(
    id: 1669,
    name: "new-picture",
    title: "新图片",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 创建
  static const IconPark newlybuild = IconPark._(
    id: 1670,
    name: "newlybuild",
    title: "创建",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["新建", "增加", "创建"],
    rtl: true,
  );

  /// 报纸折叠
  static const IconPark newspaperFolding = IconPark._(
    id: 1671,
    name: "newspaper-folding",
    title: "报纸折叠",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["报纸折叠", "纸张", "折页", "传单"],
    rtl: true,
  );

  /// 下一步
  static const IconPark next = IconPark._(
    id: 1672,
    name: "next",
    title: "下一步",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["进一步", "向右", "下一级"],
    rtl: true,
  );

  /// 按键九
  static const IconPark nineKey = IconPark._(
    id: 1673,
    name: "nine-key",
    title: "按键九",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["九", "9", "按键"],
    rtl: true,
  );

  /// 九点连接
  static const IconPark ninePointsConnected = IconPark._(
    id: 1674,
    name: "nine-points-connected",
    title: "九点连接",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["九点连接", "抽象"],
    rtl: true,
  );

  /// 任天堂游戏机
  static const IconPark nintendoSwitch = IconPark._(
    id: 1675,
    name: "nintendo-switch",
    title: "任天堂游戏机",
    category: "Game",
    categoryCN: "游戏",
    author: "金磊",
    tag: ["游戏机", "任天堂", "娱乐", "玩啥", "电子游戏", "掌机"],
    rtl: true,
  );

  /// 核磁共振
  static const IconPark nmr = IconPark._(
    id: 1676,
    name: "nmr",
    title: "核磁共振",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["影像科", "影像", "检查", "医疗"],
    rtl: true,
  );

  /// 禁止拍照
  static const IconPark noShooting = IconPark._(
    id: 1677,
    name: "no-shooting",
    title: "禁止拍照",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["禁止"],
    rtl: true,
  );

  /// 方头节点
  static const IconPark nodeFlat = IconPark._(
    id: 1678,
    name: "node-flat",
    title: "方头节点",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["端点类型", "方头节点"],
    rtl: true,
  );

  /// 圆头节点
  static const IconPark nodeRound = IconPark._(
    id: 1679,
    name: "node-round",
    title: "圆头节点",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["端点类型", "圆点节点"],
    rtl: true,
  );

  /// 平头节点
  static const IconPark nodeSquare = IconPark._(
    id: 1680,
    name: "node-square",
    title: "平头节点",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["端点类型", "平头节点"],
    rtl: true,
  );

  /// 面条
  static const IconPark noodles = IconPark._(
    id: 1681,
    name: "noodles",
    title: "面条",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["面条", "美食", "饮食", "饥饿", "吃饭", "午餐", "早餐", "晚餐"],
    rtl: true,
  );

  /// 笔记本
  static const IconPark notebook = IconPark._(
    id: 1682,
    name: "notebook",
    title: "笔记本",
    category: "Office",
    categoryCN: "办公文档",
    author: "刘心乐",
    tag: ["文档", "通讯录", "文本", "文件", "笔记本"],
    rtl: true,
  );

  /// 笔记本和笔
  static const IconPark notebookAndPen = IconPark._(
    id: 1683,
    name: "notebook-and-pen",
    title: "笔记本和笔",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["笔记本和笔", "学习用品", "办公用品"],
    rtl: true,
  );

  /// 笔记本
  static const IconPark notebookOne = IconPark._(
    id: 1684,
    name: "notebook-one",
    title: "笔记本",
    category: "Office",
    categoryCN: "办公文档",
    author: "刘心乐",
    tag: ["文档", "通讯录", "文件", "笔记本", "文本"],
    rtl: true,
  );

  /// 记事本
  static const IconPark notepad = IconPark._(
    id: 1685,
    name: "notepad",
    title: "记事本",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["记录", "账单", "条例", "画板", "黏贴板", "公告板"],
    rtl: false,
  );

  /// 笔记
  static const IconPark notes = IconPark._(
    id: 1686,
    name: "notes",
    title: "笔记",
    category: "Office",
    categoryCN: "办公文档",
    author: "刘心乐",
    tag: ["文件", "纸张", "文本", "列表", "文档"],
    rtl: true,
  );

  /// 核电厂
  static const IconPark nuclearPlant = IconPark._(
    id: 1687,
    name: "nuclear-plant",
    title: "核电厂",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["厂房", "发电厂", "试验场", "工地", "化工厂"],
    rtl: true,
  );

  /// 护士帽
  static const IconPark nurseCap = IconPark._(
    id: 1688,
    name: "nurse-cap",
    title: "护士帽",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 坚果
  static const IconPark nut = IconPark._(
    id: 1689,
    name: "nut",
    title: "坚果",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["坚果", "零食", "食品", "炒货", "果脯"],
    rtl: true,
  );

  /// 营养
  static const IconPark nutrition = IconPark._(
    id: 1690,
    name: "nutrition",
    title: "营养",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["米饭", "午饭", "午餐", "饭", "营养科"],
    rtl: true,
  );

  /// 巨量引擎
  static const IconPark oceanengine = IconPark._(
    id: 1691,
    name: "oceanengine",
    title: "巨量引擎",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["巨量引擎", "广告投放", "广告", "变现", "营销"],
    rtl: true,
  );

  /// 八边形
  static const IconPark octagon = IconPark._(
    id: 1692,
    name: "octagon",
    title: "八边形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 全局缩小
  static const IconPark offScreen = IconPark._(
    id: 1693,
    name: "off-screen",
    title: "全局缩小",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["退出全屏", "收起", "缩进", "缩放"],
    rtl: false,
  );

  /// 全局缩小1
  static const IconPark offScreenOne = IconPark._(
    id: 1694,
    name: "off-screen-one",
    title: "全局缩小1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["缩小", "收起", "缩放"],
    rtl: false,
  );

  /// 全局缩小2
  static const IconPark offScreenTwo = IconPark._(
    id: 1695,
    name: "off-screen-two",
    title: "全局缩小2",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["缩小", "小屏"],
    rtl: true,
  );

  /// 工业油漆
  static const IconPark oilIndustry = IconPark._(
    id: 1696,
    name: "oil-industry",
    title: "工业油漆",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["油"],
    rtl: true,
  );

  /// 认可
  static const IconPark okay = IconPark._(
    id: 1697,
    name: "okay",
    title: "认可",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["三", "手指", "手势", "OK", "肯定", "胜利"],
    rtl: true,
  );

  /// 一
  static const IconPark one = IconPark._(
    id: 1698,
    name: "one",
    title: "一",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["一", "手指", "食指", "手势"],
    rtl: true,
  );

  /// 按键一
  static const IconPark oneKey = IconPark._(
    id: 1699,
    name: "one-key",
    title: "按键一",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["一", "1", "按键"],
    rtl: true,
  );

  /// 一
  static const IconPark oneOne = IconPark._(
    id: 1700,
    name: "one-one",
    title: "一",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["一", "手指", "食指", "手势"],
    rtl: true,
  );

  /// 旋转
  static const IconPark oneThirdRotation = IconPark._(
    id: 1701,
    name: "one-third-rotation",
    title: "旋转",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["旋转", "箭头", "循环", "风扇"],
    rtl: true,
  );

  /// 一对多
  static const IconPark oneToMany = IconPark._(
    id: 1702,
    name: "one-to-many",
    title: "一对多",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["一对多", "1:n", "比例"],
    rtl: true,
  );

  /// 一对一
  static const IconPark oneToOne = IconPark._(
    id: 1703,
    name: "one-to-one",
    title: "一对一",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["1:1", "等比", "等比例", "一比一", "比例"],
    rtl: true,
  );

  /// 连体衣
  static const IconPark onesies = IconPark._(
    id: 1704,
    name: "onesies",
    title: "连体衣",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["衣服", "童装", "上衣"],
    rtl: false,
  );

  /// 线上办公室
  static const IconPark onlineMeeting = IconPark._(
    id: 1705,
    name: "online-meeting",
    title: "线上办公室",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "金磊",
    tag: ["线上办公室", "语音会议", "视频中"],
    rtl: true,
  );

  /// 打开
  static const IconPark open = IconPark._(
    id: 1706,
    name: "open",
    title: "打开",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["张开双手", "鼓掌", "手势", "动作"],
    rtl: true,
  );

  /// 开户
  static const IconPark openAnAccount = IconPark._(
    id: 1707,
    name: "open-an-account",
    title: "开户",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["创建"],
    rtl: true,
  );

  /// 开门
  static const IconPark openDoor = IconPark._(
    id: 1708,
    name: "open-door",
    title: "开门",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["开门", "打开", "立体", "透视", "拉门", "出去"],
    rtl: true,
  );

  /// 打开
  static const IconPark openOne = IconPark._(
    id: 1709,
    name: "open-one",
    title: "打开",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["打开", "钥匙", "开启"],
    rtl: true,
  );

  /// 美化
  static const IconPark optimize = IconPark._(
    id: 1710,
    name: "optimize",
    title: "美化",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["魔棒", "优化", "星星", "幸运棒"],
    rtl: true,
  );

  /// 自选
  static const IconPark optional = IconPark._(
    id: 1711,
    name: "optional",
    title: "自选",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["行情", "趋势", "数据"],
    rtl: true,
  );

  /// 橙子
  static const IconPark orange = IconPark._(
    id: 1712,
    name: "orange",
    title: "橙子",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水果"],
    rtl: true,
  );

  /// 柠檬片
  static const IconPark orangeOne = IconPark._(
    id: 1713,
    name: "orange-one",
    title: "柠檬片",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["柠檬片", "柠檬", "水果", "柠檬干"],
    rtl: true,
  );

  /// 橙子建站
  static const IconPark orangeStation = IconPark._(
    id: 1714,
    name: "orange-station",
    title: "橙子建站",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["智能建站", "落地页", "智能设计平台", "oceanengine", "H5"],
    rtl: true,
  );

  /// 订单
  static const IconPark order = IconPark._(
    id: 1715,
    name: "order",
    title: "订单",
    category: "Office",
    categoryCN: "办公文档",
    author: "白明泽",
    tag: ["抢单", "文档", "发票", "记录", "计分牌", "电磁", "充电中"],
    rtl: true,
  );

  /// 有序列表
  static const IconPark orderedList = IconPark._(
    id: 1716,
    name: "ordered-list",
    title: "有序列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["列表", "序列", "排序"],
    rtl: true,
  );

  /// 骨科
  static const IconPark orthopedic = IconPark._(
    id: 1717,
    name: "orthopedic",
    title: "骨科",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["骨头", "器官"],
    rtl: true,
  );

  /// 震荡器
  static const IconPark oscillator = IconPark._(
    id: 1718,
    name: "oscillator",
    title: "震荡器",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 其他
  static const IconPark other = IconPark._(
    id: 1719,
    name: "other",
    title: "其他",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["其他科室", "添加", "新建", "增加"],
    rtl: false,
  );

  /// 出库
  static const IconPark outbound = IconPark._(
    id: 1720,
    name: "outbound",
    title: "出库",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["出库", "导出", "传输"],
    rtl: true,
  );

  /// 户外
  static const IconPark outdoor = IconPark._(
    id: 1721,
    name: "outdoor",
    title: "户外",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "齐奉飞",
    tag: ["户外", "运动", "体育", "锻炼", "旅游"],
    rtl: true,
  );

  /// 传出
  static const IconPark outgoing = IconPark._(
    id: 1722,
    name: "outgoing",
    title: "传出",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["传出", "传送", "输出", "数据", "线", "传出数据"],
    rtl: true,
  );

  /// 椭圆爱心
  static const IconPark ovalLove = IconPark._(
    id: 1723,
    name: "oval-love",
    title: "椭圆爱心",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["椭圆爱心", "喜欢", "拼接"],
    rtl: false,
  );

  /// 椭圆爱心
  static const IconPark ovalLoveTwo = IconPark._(
    id: 1724,
    name: "oval-love-two",
    title: "椭圆爱心",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["椭圆爱心", "喜欢", "拼接"],
    rtl: true,
  );

  /// 椭圆形
  static const IconPark ovalOne = IconPark._(
    id: 1725,
    name: "oval-one",
    title: "椭圆形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 电烤箱
  static const IconPark oven = IconPark._(
    id: 1726,
    name: "oven",
    title: "电烤箱",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["电烤箱", "烤箱", "家电"],
    rtl: true,
  );

  /// 托盘
  static const IconPark ovenTray = IconPark._(
    id: 1727,
    name: "oven-tray",
    title: "托盘",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["托盘", "盘子", "厨具"],
    rtl: false,
  );

  /// 整体缩小
  static const IconPark overallReduction = IconPark._(
    id: 1728,
    name: "overall-reduction",
    title: "整体缩小",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["整体缩小", "缩放"],
    rtl: true,
  );

  /// 猫头鹰
  static const IconPark owl = IconPark._(
    id: 1729,
    name: "owl",
    title: "猫头鹰",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 奶嘴
  static const IconPark pacifier = IconPark._(
    id: 1730,
    name: "pacifier",
    title: "奶嘴",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["奶嘴"],
    rtl: true,
  );

  /// 平板电脑
  static const IconPark pad = IconPark._(
    id: 1731,
    name: "pad",
    title: "平板电脑",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["电脑", "平板", "pad", "游戏", "设备"],
    rtl: true,
  );

  /// 页面
  static const IconPark page = IconPark._(
    id: 1732,
    name: "page",
    title: "页面",
    category: "Components",
    categoryCN: "界面组件",
    author: "刘心乐",
    tag: ["网页", "布局", "排版", "模块", "页面", "划分"],
    rtl: true,
  );

  /// 页面模版
  static const IconPark pageTemplate = IconPark._(
    id: 1733,
    name: "page-template",
    title: "页面模版",
    category: "Components",
    categoryCN: "界面组件",
    author: "常留留",
    tag: ["页面", "模版", "布局"],
    rtl: true,
  );

  /// 宝塔
  static const IconPark pagoda = IconPark._(
    id: 1734,
    name: "pagoda",
    title: "宝塔",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "房子", "大厦", "塔", "建筑"],
    rtl: false,
  );

  /// 化妆刷
  static const IconPark paint = IconPark._(
    id: 1735,
    name: "paint",
    title: "化妆刷",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["刷子", "扫把", "化妆刷", "清洁", "扫除"],
    rtl: true,
  );

  /// 彩蛋
  static const IconPark paintedEggshell = IconPark._(
    id: 1736,
    name: "painted-eggshell",
    title: "彩蛋",
    category: "Foods",
    categoryCN: "食品",
    author: "常留留",
    tag: ["egg", "鸡蛋", "雨滴", "鸭蛋", "彩蛋"],
    rtl: true,
  );

  /// 绘制屏
  static const IconPark paintedScreen = IconPark._(
    id: 1737,
    name: "painted-screen",
    title: "绘制屏",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["触控板", "绘制", "屏幕", "平板电脑"],
    rtl: true,
  );

  /// 宫殿
  static const IconPark palace = IconPark._(
    id: 1738,
    name: "palace",
    title: "宫殿",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["银行", "建筑", "房子", "宫殿", "居住", "亭子", "景区"],
    rtl: false,
  );

  /// 手掌
  static const IconPark palm = IconPark._(
    id: 1739,
    name: "palm",
    title: "手掌",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["五", "手指", "手势", "手掌"],
    rtl: true,
  );

  /// 熊猫
  static const IconPark panda = IconPark._(
    id: 1740,
    name: "panda",
    title: "熊猫",
    category: "Animals",
    categoryCN: "动物",
    author: "",
    tag: [],
    rtl: false,
  );

  /// 穿山甲
  static const IconPark pangle = IconPark._(
    id: 1741,
    name: "pangle",
    title: "穿山甲",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["穿山甲", "广告", "logo"],
    rtl: true,
  );

  /// 全景水平
  static const IconPark panoramaHorizontal = IconPark._(
    id: 1742,
    name: "panorama-horizontal",
    title: "全景水平",
    category: "Health",
    categoryCN: "医疗健康",
    author: "金磊",
    tag: ["水平线", "全景", "拍照", "360度"],
    rtl: false,
  );

  /// 内裤
  static const IconPark panties = IconPark._(
    id: 1743,
    name: "panties",
    title: "内裤",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["裤", "短裤", "内裤", "泳裤"],
    rtl: false,
  );

  /// 钞票
  static const IconPark paperMoney = IconPark._(
    id: 1744,
    name: "paper-money",
    title: "钞票",
    category: "Money",
    categoryCN: "电商财产",
    author: "白明泽",
    tag: ["钞票", "钱财", "财产", "资金", "金融", "经济"],
    rtl: false,
  );

  /// 钞票
  static const IconPark paperMoneyTwo = IconPark._(
    id: 1745,
    name: "paper-money-two",
    title: "钞票",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["钞票", "钱", "财富", "资金", "投资", "美元"],
    rtl: false,
  );

  /// 纸船
  static const IconPark paperShip = IconPark._(
    id: 1746,
    name: "paper-ship",
    title: "纸船",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["船", "模型"],
    rtl: false,
  );

  /// 回形针
  static const IconPark paperclip = IconPark._(
    id: 1747,
    name: "paperclip",
    title: "回形针",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["夹子", "针", "页签"],
    rtl: true,
  );

  /// 抛物线
  static const IconPark parabola = IconPark._(
    id: 1748,
    name: "parabola",
    title: "抛物线",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["抛物线", "试验", "数学", "教育", "科学"],
    rtl: true,
  );

  /// 降落伞
  static const IconPark parachute = IconPark._(
    id: 1749,
    name: "parachute",
    title: "降落伞",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "白明泽",
    tag: ["降落伞", "跳伞", "运动", "体育", "危险"],
    rtl: false,
  );

  /// 字母段落
  static const IconPark paragraphAlphabet = IconPark._(
    id: 1750,
    name: "paragraph-alphabet",
    title: "字母段落",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["字母段落", "文案"],
    rtl: true,
  );

  /// 段落折行
  static const IconPark paragraphBreak = IconPark._(
    id: 1751,
    name: "paragraph-break",
    title: "段落折行",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["段落", "表格排版", "段落折行", "内容折行"],
    rtl: true,
  );

  /// 段落折行
  static const IconPark paragraphBreakTwo = IconPark._(
    id: 1752,
    name: "paragraph-break-two",
    title: "段落折行",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["段落折行"],
    rtl: true,
  );

  /// 段落截断
  static const IconPark paragraphCut = IconPark._(
    id: 1753,
    name: "paragraph-cut",
    title: "段落截断",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["段落", "表格排版", "段落截断", "内容截断"],
    rtl: true,
  );

  /// 矩形段落
  static const IconPark paragraphRectangle = IconPark._(
    id: 1754,
    name: "paragraph-rectangle",
    title: "矩形段落",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["矩形段落"],
    rtl: true,
  );

  /// 圆形段落
  static const IconPark paragraphRound = IconPark._(
    id: 1755,
    name: "paragraph-round",
    title: "圆形段落",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["圆形段落"],
    rtl: true,
  );

  /// 三角段落
  static const IconPark paragraphTriangle = IconPark._(
    id: 1756,
    name: "paragraph-triangle",
    title: "三角段落",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["三角段落"],
    rtl: true,
  );

  /// 段落溢出
  static const IconPark paragraphUnfold = IconPark._(
    id: 1757,
    name: "paragraph-unfold",
    title: "段落溢出",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["段落", "表格排版", "段落溢出", "内容溢出"],
    rtl: true,
  );

  /// 并行网关
  static const IconPark parallelGateway = IconPark._(
    id: 1758,
    name: "parallel-gateway",
    title: "并行网关",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "常留留",
    tag: ["并行", "菱形", "抽象", "几何"],
    rtl: false,
  );

  /// 平行四边形
  static const IconPark parallelogram = IconPark._(
    id: 1759,
    name: "parallelogram",
    title: "平行四边形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 育儿书
  static const IconPark parentingBook = IconPark._(
    id: 1760,
    name: "parenting-book",
    title: "育儿书",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["书籍", "阅读"],
    rtl: true,
  );

  /// 停车场
  static const IconPark parking = IconPark._(
    id: 1761,
    name: "parking",
    title: "停车场",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "齐奉飞",
    tag: ["停车", "坐标", "地图", "停车位", "标记"],
    rtl: true,
  );

  /// 气球
  static const IconPark partyBalloon = IconPark._(
    id: 1762,
    name: "party-balloon",
    title: "气球",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["气球", "起飞", "升空"],
    rtl: true,
  );

  /// 护照
  static const IconPark passport = IconPark._(
    id: 1763,
    name: "passport",
    title: "护照",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["护照", "身份证"],
    rtl: true,
  );

  /// 护照
  static const IconPark passportOne = IconPark._(
    id: 1764,
    name: "passport-one",
    title: "护照",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["护照", "护照夹", "证件"],
    rtl: true,
  );

  /// 暂停
  static const IconPark pause = IconPark._(
    id: 1765,
    name: "pause",
    title: "暂停",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["停止播放", "暂停", "播放中"],
    rtl: true,
  );

  /// 暂停
  static const IconPark pauseOne = IconPark._(
    id: 1766,
    name: "pause-one",
    title: "暂停",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["停止播放", "暂停", "播放中"],
    rtl: false,
  );

  /// 支付码
  static const IconPark payCode = IconPark._(
    id: 1767,
    name: "pay-code",
    title: "支付码",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["支付", "支付宝", "扫码", "支付", "花钱", "财产"],
    rtl: false,
  );

  /// 付款码
  static const IconPark payCodeOne = IconPark._(
    id: 1768,
    name: "pay-code-one",
    title: "付款码",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["二维码", "扫码", "扫描", "识别", "支付"],
    rtl: true,
  );

  /// 支付码
  static const IconPark payCodeTwo = IconPark._(
    id: 1769,
    name: "pay-code-two",
    title: "支付码",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["条形码", "扫码", "识别", "支付"],
    rtl: false,
  );

  /// 币种兑换
  static const IconPark paymentMethod = IconPark._(
    id: 1770,
    name: "payment-method",
    title: "币种兑换",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["支付", "钱", "兑换", "交易"],
    rtl: true,
  );

  /// paypal
  static const IconPark paypal = IconPark._(
    id: 1771,
    name: "paypal",
    title: "paypal",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["支付", "转账", "logo", "paypal"],
    rtl: true,
  );

  /// 桃子
  static const IconPark peach = IconPark._(
    id: 1772,
    name: "peach",
    title: "桃子",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水果"],
    rtl: true,
  );

  /// 梨子
  static const IconPark pear = IconPark._(
    id: 1773,
    name: "pear",
    title: "梨子",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水果"],
    rtl: true,
  );

  /// 东方明珠
  static const IconPark pearlOfTheOrient = IconPark._(
    id: 1774,
    name: "pearl-of-the-orient",
    title: "东方明珠",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["阁楼", "楼房", "大厦", "办公楼", "塔", "建筑"],
    rtl: false,
  );

  /// 豌豆角
  static const IconPark peas = IconPark._(
    id: 1775,
    name: "peas",
    title: "豌豆角",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["豌豆角", "豆角", "蔬菜"],
    rtl: true,
  );

  /// 铅笔
  static const IconPark pencil = IconPark._(
    id: 1776,
    name: "pencil",
    title: "铅笔",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 三角旗
  static const IconPark pennant = IconPark._(
    id: 1777,
    name: "pennant",
    title: "三角旗",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["三角旗", "旗帜"],
    rtl: true,
  );

  /// 五边形
  static const IconPark pentagonOne = IconPark._(
    id: 1778,
    name: "pentagon-one",
    title: "五边形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 人员
  static const IconPark people = IconPark._(
    id: 1779,
    name: "people",
    title: "人员",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: ["用户", "客户", "个人中心", "账户中心", "我的", "员工"],
    rtl: false,
  );

  /// 人员下
  static const IconPark peopleBottom = IconPark._(
    id: 1780,
    name: "people-bottom",
    title: "人员下",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 人像卡片下
  static const IconPark peopleBottomCard = IconPark._(
    id: 1781,
    name: "people-bottom-card",
    title: "人像卡片下",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 删除用户
  static const IconPark peopleDelete = IconPark._(
    id: 1782,
    name: "people-delete",
    title: "删除用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["删除用户"],
    rtl: true,
  );

  /// 删除用户
  static const IconPark peopleDeleteOne = IconPark._(
    id: 1783,
    name: "people-delete-one",
    title: "删除用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["删除用户"],
    rtl: true,
  );

  /// 用户下载
  static const IconPark peopleDownload = IconPark._(
    id: 1784,
    name: "people-download",
    title: "用户下载",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["用户下载"],
    rtl: true,
  );

  /// 人员左
  static const IconPark peopleLeft = IconPark._(
    id: 1785,
    name: "people-left",
    title: "人员左",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 减少人群
  static const IconPark peopleMinus = IconPark._(
    id: 1786,
    name: "people-minus",
    title: "减少人群",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: ["添加", "用户", "客户"],
    rtl: true,
  );

  /// 减少人群
  static const IconPark peopleMinusOne = IconPark._(
    id: 1787,
    name: "people-minus-one",
    title: "减少人群",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: ["添加", "用户", "客户"],
    rtl: true,
  );

  /// 添加人群
  static const IconPark peoplePlus = IconPark._(
    id: 1788,
    name: "people-plus",
    title: "添加人群",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: ["减少", "用户", "客户", "删除"],
    rtl: true,
  );

  /// 添加人群
  static const IconPark peoplePlusOne = IconPark._(
    id: 1789,
    name: "people-plus-one",
    title: "添加人群",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: ["减少", "用户", "客户", "删除"],
    rtl: true,
  );

  /// 人员右
  static const IconPark peopleRight = IconPark._(
    id: 1790,
    name: "people-right",
    title: "人员右",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 人身安全
  static const IconPark peopleSafe = IconPark._(
    id: 1791,
    name: "people-safe",
    title: "人身安全",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 人身安全1
  static const IconPark peopleSafeOne = IconPark._(
    id: 1792,
    name: "people-safe-one",
    title: "人身安全1",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 搜索用户
  static const IconPark peopleSearch = IconPark._(
    id: 1793,
    name: "people-search",
    title: "搜索用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: ["搜索用户"],
    rtl: true,
  );

  /// 搜索用户
  static const IconPark peopleSearchOne = IconPark._(
    id: 1794,
    name: "people-search-one",
    title: "搜索用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["搜索用户"],
    rtl: true,
  );

  /// 人员说话
  static const IconPark peopleSpeak = IconPark._(
    id: 1795,
    name: "people-speak",
    title: "人员说话",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 人员上
  static const IconPark peopleTop = IconPark._(
    id: 1796,
    name: "people-top",
    title: "人员上",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 人像卡片上
  static const IconPark peopleTopCard = IconPark._(
    id: 1797,
    name: "people-top-card",
    title: "人像卡片上",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 人员屏蔽
  static const IconPark peopleUnknown = IconPark._(
    id: 1798,
    name: "people-unknown",
    title: "人员屏蔽",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 用户上传
  static const IconPark peopleUpload = IconPark._(
    id: 1799,
    name: "people-upload",
    title: "用户上传",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["用户上传"],
    rtl: true,
  );

  /// 人群
  static const IconPark peoples = IconPark._(
    id: 1800,
    name: "peoples",
    title: "人群",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: ["用户", "客户", "员工", "多人"],
    rtl: true,
  );

  /// 人群
  static const IconPark peoplesTwo = IconPark._(
    id: 1801,
    name: "peoples-two",
    title: "人群",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["人群", "好多人"],
    rtl: false,
  );

  /// 百分号
  static const IconPark percentage = IconPark._(
    id: 1802,
    name: "percentage",
    title: "百分号",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["符号", "算法", "比例", "占比", "百分比"],
    rtl: true,
  );

  /// 演出
  static const IconPark performance = IconPark._(
    id: 1803,
    name: "performance",
    title: "演出",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["演出", "音乐", "表演", "娱乐", "歌曲", "播放"],
    rtl: true,
  );

  /// 香水
  static const IconPark perfume = IconPark._(
    id: 1804,
    name: "perfume",
    title: "香水",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["香水", "瓶子", "容器", "玻璃瓶"],
    rtl: true,
  );

  /// 香水瓶
  static const IconPark perfumerBottle = IconPark._(
    id: 1805,
    name: "perfumer-bottle",
    title: "香水瓶",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["瓶子"],
    rtl: false,
  );

  /// 经期
  static const IconPark period = IconPark._(
    id: 1806,
    name: "period",
    title: "经期",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["女性", "生理期", "生殖"],
    rtl: false,
  );

  /// 权限
  static const IconPark permissions = IconPark._(
    id: 1807,
    name: "permissions",
    title: "权限",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["限制", "身份", "角色", "账户", "个人中心"],
    rtl: true,
  );

  /// 收藏好友
  static const IconPark personalCollection = IconPark._(
    id: 1808,
    name: "personal-collection",
    title: "收藏好友",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 个人隐私
  static const IconPark personalPrivacy = IconPark._(
    id: 1809,
    name: "personal-privacy",
    title: "个人隐私",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 透视
  static const IconPark perspective = IconPark._(
    id: 1810,
    name: "perspective",
    title: "透视",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["透视", "网格"],
    rtl: true,
  );

  /// 农药
  static const IconPark pesticide = IconPark._(
    id: 1811,
    name: "pesticide",
    title: "农药",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["药品", "毒药", "肥料", "药瓶", "医药", "牛奶"],
    rtl: true,
  );

  /// 汽油
  static const IconPark petrol = IconPark._(
    id: 1812,
    name: "petrol",
    title: "汽油",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["机油", "油"],
    rtl: false,
  );

  /// 手机
  static const IconPark phone = IconPark._(
    id: 1813,
    name: "phone",
    title: "手机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["Phone", "电话", "通信", "手机"],
    rtl: false,
  );

  /// 电话亭
  static const IconPark phoneBooth = IconPark._(
    id: 1814,
    name: "phone-booth",
    title: "电话亭",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["公共电话", "单间"],
    rtl: true,
  );

  /// 电话呼叫
  static const IconPark phoneCall = IconPark._(
    id: 1815,
    name: "phone-call",
    title: "电话呼叫",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["通话记录", "电话", "呼叫", "通话"],
    rtl: true,
  );

  /// 电话拨入
  static const IconPark phoneIncoming = IconPark._(
    id: 1816,
    name: "phone-incoming",
    title: "电话拨入",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["拨入", "呼叫", "电话", "通话"],
    rtl: true,
  );

  /// 电话拨入
  static const IconPark phoneIncomingOne = IconPark._(
    id: 1817,
    name: "phone-incoming-one",
    title: "电话拨入",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["拨入", "电话", "接收", "通话", "呼叫"],
    rtl: true,
  );

  /// 电话错过
  static const IconPark phoneMissed = IconPark._(
    id: 1818,
    name: "phone-missed",
    title: "电话错过",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "常留留",
    tag: ["电话", "呼叫失败", "通话", "错过", "静音"],
    rtl: true,
  );

  /// 电话关闭
  static const IconPark phoneOff = IconPark._(
    id: 1819,
    name: "phone-off",
    title: "电话关闭",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "常留留",
    tag: ["电话", "呼叫", "通话", "关闭通话", "关闭联系"],
    rtl: true,
  );

  /// 电话
  static const IconPark phoneOne = IconPark._(
    id: 1820,
    name: "phone-one",
    title: "电话",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["通话", "拨号", "转接", "接通", "交流", "沟通", "会议", "语音", "求救", "报警"],
    rtl: true,
  );

  /// 电拨拨出
  static const IconPark phoneOutgoing = IconPark._(
    id: 1821,
    name: "phone-outgoing",
    title: "电拨拨出",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["拨出", "呼叫", "通话", "电话", "接收"],
    rtl: true,
  );

  /// 电拨拨出
  static const IconPark phoneOutgoingOne = IconPark._(
    id: 1822,
    name: "phone-outgoing-one",
    title: "电拨拨出",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["拨出", "电话", "呼叫", "通话"],
    rtl: true,
  );

  /// 电话
  static const IconPark phoneTelephone = IconPark._(
    id: 1823,
    name: "phone-telephone",
    title: "电话",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "齐奉飞",
    tag: ["电话", "呼叫", "通话"],
    rtl: true,
  );

  /// 电话2
  static const IconPark phoneTwo = IconPark._(
    id: 1824,
    name: "phone-two",
    title: "电话2",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["通话", "交流", "沟通", "社交", "logo", "电话"],
    rtl: true,
  );

  /// 视频电话
  static const IconPark phoneVideoCall = IconPark._(
    id: 1825,
    name: "phone-video-call",
    title: "视频电话",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "金磊",
    tag: ["视频电话", "通话"],
    rtl: true,
  );

  /// 留声机
  static const IconPark phonograph = IconPark._(
    id: 1826,
    name: "phonograph",
    title: "留声机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["音乐", "声音", "歌曲", "歌声", "歌曲"],
    rtl: true,
  );

  /// 旅行照
  static const IconPark photograph = IconPark._(
    id: 1827,
    name: "photograph",
    title: "旅行照",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["照片", "风景照", "摄影", "拍照"],
    rtl: true,
  );

  /// 钢琴
  static const IconPark piano = IconPark._(
    id: 1828,
    name: "piano",
    title: "钢琴",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["键盘", "琴键", "音乐"],
    rtl: true,
  );

  /// 照片
  static const IconPark pic = IconPark._(
    id: 1829,
    name: "pic",
    title: "照片",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["图片", "画面", "图形"],
    rtl: true,
  );

  /// 图片1
  static const IconPark picOne = IconPark._(
    id: 1830,
    name: "pic-one",
    title: "图片1",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "李宁",
    tag: ["照片", "相册"],
    rtl: true,
  );

  /// 图片
  static const IconPark picture = IconPark._(
    id: 1831,
    name: "picture",
    title: "图片",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["图片", "图形", "图像", "影相"],
    rtl: true,
  );

  /// 相册
  static const IconPark pictureAlbum = IconPark._(
    id: 1832,
    name: "picture-album",
    title: "相册",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 图片
  static const IconPark pictureOne = IconPark._(
    id: 1833,
    name: "picture-one",
    title: "图片",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["图片", "照片"],
    rtl: true,
  );

  /// 进度
  static const IconPark pie = IconPark._(
    id: 1834,
    name: "pie",
    title: "进度",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["进度", "百分比", "饼图", "划分"],
    rtl: true,
  );

  /// 进度5
  static const IconPark pieFive = IconPark._(
    id: 1835,
    name: "pie-five",
    title: "进度5",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["进度", "百分比", "饼图", "划分"],
    rtl: true,
  );

  /// 进度4
  static const IconPark pieFour = IconPark._(
    id: 1836,
    name: "pie-four",
    title: "进度4",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["进度", "百分比", "饼图", "划分"],
    rtl: true,
  );

  /// 进度1
  static const IconPark pieOne = IconPark._(
    id: 1837,
    name: "pie-one",
    title: "进度1",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["进度", "百分比", "饼图", "划分"],
    rtl: true,
  );

  /// 进度7
  static const IconPark pieSeven = IconPark._(
    id: 1838,
    name: "pie-seven",
    title: "进度7",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["进度", "百分比", "饼图", "划分"],
    rtl: true,
  );

  /// 进度6
  static const IconPark pieSix = IconPark._(
    id: 1839,
    name: "pie-six",
    title: "进度6",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["进度", "百分比", "饼图", "划分"],
    rtl: true,
  );

  /// 进度3
  static const IconPark pieThree = IconPark._(
    id: 1840,
    name: "pie-three",
    title: "进度3",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["进度", "百分比", "饼图", "划分"],
    rtl: true,
  );

  /// 进度2
  static const IconPark pieTwo = IconPark._(
    id: 1841,
    name: "pie-two",
    title: "进度2",
    category: "Charts",
    categoryCN: "数据图表",
    author: "白明泽",
    tag: ["进度", "百分比", "饼图", "划分"],
    rtl: true,
  );

  /// 猪
  static const IconPark pig = IconPark._(
    id: 1842,
    name: "pig",
    title: "猪",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 生肖猪
  static const IconPark pigZodiac = IconPark._(
    id: 1843,
    name: "pig-zodiac",
    title: "生肖猪",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 鸽子
  static const IconPark pigeon = IconPark._(
    id: 1844,
    name: "pigeon",
    title: "鸽子",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 药丸2
  static const IconPark pill = IconPark._(
    id: 1845,
    name: "pill",
    title: "药丸2",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 药丸
  static const IconPark pills = IconPark._(
    id: 1846,
    name: "pills",
    title: "药丸",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["药", "生病", "吃药", "看医生"],
    rtl: true,
  );

  /// 大头钉
  static const IconPark pin = IconPark._(
    id: 1847,
    name: "pin",
    title: "大头钉",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["钉子"],
    rtl: true,
  );

  /// 菠萝
  static const IconPark pineapple = IconPark._(
    id: 1848,
    name: "pineapple",
    title: "菠萝",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["菠萝", "水果", "生鲜"],
    rtl: true,
  );

  /// 风车
  static const IconPark pinwheel = IconPark._(
    id: 1849,
    name: "pinwheel",
    title: "风车",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["风车", "风轮", "旋风", "旋转"],
    rtl: true,
  );

  /// 双鱼座
  static const IconPark pisces = IconPark._(
    id: 1850,
    name: "pisces",
    title: "双鱼座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 数据透视表
  static const IconPark pivotTable = IconPark._(
    id: 1851,
    name: "pivot-table",
    title: "数据透视表",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据", "透视", "表格", "交互式表格"],
    rtl: true,
  );

  /// 计划
  static const IconPark plan = IconPark._(
    id: 1852,
    name: "plan",
    title: "计划",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["计划", "日期", "排期", "日历", "规划"],
    rtl: true,
  );

  /// 星球
  static const IconPark planet = IconPark._(
    id: 1853,
    name: "planet",
    title: "星球",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["星球", "地球", "环绕", "卫星", "宇宙", "浏览器"],
    rtl: true,
  );

  /// 整形科
  static const IconPark plasticSurgery = IconPark._(
    id: 1854,
    name: "plastic-surgery",
    title: "整形科",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["整容", "美容", "整容手术", "医疗美容", "女人", "女士", "女性", "美女", "女性用户"],
    rtl: true,
  );

  /// 调色盘
  static const IconPark platte = IconPark._(
    id: 1855,
    name: "platte",
    title: "调色盘",
    category: "Components",
    categoryCN: "界面组件",
    author: "金磊",
    tag: ["调色盘", "美术", "绘画", "颜色", "主题", "绘画"],
    rtl: true,
  );

  /// 播放
  static const IconPark play = IconPark._(
    id: 1856,
    name: "play",
    title: "播放",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "齐奉飞",
    tag: ["视频", "播放", "播放器", "媒体"],
    rtl: true,
  );

  /// 打篮球
  static const IconPark playBasketball = IconPark._(
    id: 1857,
    name: "play-basketball",
    title: "打篮球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["篮球", "球类", "球", "运动", "扣篮", "远投", "传球", "助攻", "体育"],
    rtl: true,
  );

  /// 循环播放
  static const IconPark playCycle = IconPark._(
    id: 1858,
    name: "play-cycle",
    title: "循环播放",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["刷新", "循环", "播放", "单曲循环"],
    rtl: true,
  );

  /// 播放一次
  static const IconPark playOnce = IconPark._(
    id: 1859,
    name: "play-once",
    title: "播放一次",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "播放", "循环", "单次循环"],
    rtl: true,
  );

  /// 播放
  static const IconPark playOne = IconPark._(
    id: 1860,
    name: "play-one",
    title: "播放",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "齐奉飞",
    tag: ["视频", "播放", "播放器", "媒体"],
    rtl: true,
  );

  /// 播放器
  static const IconPark playTwo = IconPark._(
    id: 1861,
    name: "play-two",
    title: "播放器",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["播放", "视频"],
    rtl: true,
  );

  /// 打排球
  static const IconPark playVolleyball = IconPark._(
    id: 1862,
    name: "play-volleyball",
    title: "打排球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["打排球", "排球", "运动", "体育", "拍", "打", "扣", "球类", "球"],
    rtl: true,
  );

  /// 播放出错
  static const IconPark playWrong = IconPark._(
    id: 1863,
    name: "play-wrong",
    title: "播放出错",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["播放", "终止", "出错"],
    rtl: true,
  );

  /// 播放进度
  static const IconPark playbackProgress = IconPark._(
    id: 1864,
    name: "playback-progress",
    title: "播放进度",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["播放进度", "视频", "屏幕"],
    rtl: true,
  );

  /// 插头
  static const IconPark plug = IconPark._(
    id: 1865,
    name: "plug",
    title: "插头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["插头", "插座", "电力"],
    rtl: false,
  );

  /// 插电头
  static const IconPark plugOne = IconPark._(
    id: 1866,
    name: "plug-one",
    title: "插电头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["电器", "电源", "充电器", "插排", "插座"],
    rtl: true,
  );

  /// 加
  static const IconPark plus = IconPark._(
    id: 1867,
    name: "plus",
    title: "加",
    category: "Character",
    categoryCN: "符号标识",
    author: "常留留",
    tag: ["新建", "增加", "创建"],
    rtl: false,
  );

  /// 加号
  static const IconPark plusCross = IconPark._(
    id: 1868,
    name: "plus-cross",
    title: "加号",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["加号", "符号", "加法", "红十字", "医疗", "医院"],
    rtl: false,
  );

  /// 指向
  static const IconPark point = IconPark._(
    id: 1869,
    name: "point",
    title: "指向",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["一", "手指", "食指", "手势"],
    rtl: true,
  );

  /// 指出
  static const IconPark pointOut = IconPark._(
    id: 1870,
    name: "point-out",
    title: "指出",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["一", "手指", "食指", "手势"],
    rtl: true,
  );

  /// 精灵球1
  static const IconPark pokeballOne = IconPark._(
    id: 1871,
    name: "pokeball-one",
    title: "精灵球1",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["求", "玩具", "精灵"],
    rtl: false,
  );

  /// 扑克
  static const IconPark poker = IconPark._(
    id: 1872,
    name: "poker",
    title: "扑克",
    category: "Game",
    categoryCN: "游戏",
    author: "白明泽",
    tag: ["扑克", "赌博", "运气", "魔术"],
    rtl: true,
  );

  /// 爆米花
  static const IconPark popcorn = IconPark._(
    id: 1873,
    name: "popcorn",
    title: "爆米花",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["爆米花", "娱乐", "食物", "电影", "肥胖"],
    rtl: true,
  );

  /// 爆米花
  static const IconPark popcornOne = IconPark._(
    id: 1874,
    name: "popcorn-one",
    title: "爆米花",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["玉米", "爆米花", "零食", "食物"],
    rtl: false,
  );

  /// 积极动态
  static const IconPark positiveDynamics = IconPark._(
    id: 1875,
    name: "positive-dynamics",
    title: "积极动态",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["动态", "积极", "正向数据", "图表"],
    rtl: true,
  );

  /// 铁锅
  static const IconPark pot = IconPark._(
    id: 1876,
    name: "pot",
    title: "铁锅",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["铁锅", "煎锅", "炒锅", "厨具"],
    rtl: true,
  );

  /// 电位器
  static const IconPark potentiometer = IconPark._(
    id: 1877,
    name: "potentiometer",
    title: "电位器",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["电"],
    rtl: true,
  );

  /// 井号
  static const IconPark pound = IconPark._(
    id: 1878,
    name: "pound",
    title: "井号",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["井号", "符号", "字符", "话题", "编辑", "裁切"],
    rtl: false,
  );

  /// 井号
  static const IconPark poundSign = IconPark._(
    id: 1879,
    name: "pound-sign",
    title: "井号",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["井号", "网格", "编辑"],
    rtl: true,
  );

  /// 愤怒
  static const IconPark poutingFace = IconPark._(
    id: 1880,
    name: "pouting-face",
    title: "愤怒",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["愤怒", "表情", "生气"],
    rtl: false,
  );

  /// 搽粉
  static const IconPark powder = IconPark._(
    id: 1881,
    name: "powder",
    title: "搽粉",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["香薰", "瓶子"],
    rtl: false,
  );

  /// 开关
  static const IconPark power = IconPark._(
    id: 1882,
    name: "power",
    title: "开关",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["关闭", "启动", "阀门", "switch", "退出", "注销"],
    rtl: false,
  );

  /// 插头2
  static const IconPark powerSupply = IconPark._(
    id: 1883,
    name: "power-supply",
    title: "插头2",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["电器", "通电", "断电", "插板", "插座", "插头", "转接头", "充电器"],
    rtl: true,
  );

  /// 插头1
  static const IconPark powerSupplyOne = IconPark._(
    id: 1884,
    name: "power-supply-one",
    title: "插头1",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["电器", "通电", "断电", "插板", "插座", "插头", "转接头", "充电器"],
    rtl: true,
  );

  /// 幻灯片
  static const IconPark powerpoint = IconPark._(
    id: 1885,
    name: "powerpoint",
    title: "幻灯片",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["幻灯片"],
    rtl: true,
  );

  /// 幻灯片
  static const IconPark ppt = IconPark._(
    id: 1886,
    name: "ppt",
    title: "幻灯片",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["幻灯片", "播放", "延时", "投影"],
    rtl: true,
  );

  /// 孕妇
  static const IconPark pregnantWomen = IconPark._(
    id: 1887,
    name: "pregnant-women",
    title: "孕妇",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["怀孕", "胎儿", "妈妈", "孕产期"],
    rtl: true,
  );

  /// 学前班
  static const IconPark preschool = IconPark._(
    id: 1888,
    name: "preschool",
    title: "学前班",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["教育", "算数", "计算", "知识"],
    rtl: false,
  );

  /// 处方
  static const IconPark prescription = IconPark._(
    id: 1889,
    name: "prescription",
    title: "处方",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["药单", "看医生", "看病", "添加", "添加文件", "文件"],
    rtl: true,
  );

  /// 点击
  static const IconPark press = IconPark._(
    id: 1890,
    name: "press",
    title: "点击",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["按动", "触发", "轻点"],
    rtl: true,
  );

  /// 预览-关闭
  static const IconPark previewClose = IconPark._(
    id: 1891,
    name: "preview-close",
    title: "预览-关闭",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["隐藏", "不可见", "眼睛", "关闭"],
    rtl: false,
  );

  /// 预览-关闭
  static const IconPark previewCloseOne = IconPark._(
    id: 1892,
    name: "preview-close-one",
    title: "预览-关闭",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["隐藏", "不可见", "眼睛", "关闭"],
    rtl: true,
  );

  /// 预览-打开
  static const IconPark previewOpen = IconPark._(
    id: 1893,
    name: "preview-open",
    title: "预览-打开",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["可见", "眼睛", "打开", "展现", "睁开"],
    rtl: false,
  );

  /// 打印机
  static const IconPark printer = IconPark._(
    id: 1894,
    name: "printer",
    title: "打印机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["打印机", "打印", "设备", "纸张", "输出", "硬件"],
    rtl: false,
  );

  /// 打印机
  static const IconPark printerOne = IconPark._(
    id: 1895,
    name: "printer-one",
    title: "打印机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["打印", "印刷", "印制", "复制", "机器", "设备"],
    rtl: false,
  );

  /// 打印机
  static const IconPark printerTwo = IconPark._(
    id: 1896,
    name: "printer-two",
    title: "打印机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["打印", "印刷", "印制", "复制", "机器", "设备"],
    rtl: true,
  );

  /// 监狱
  static const IconPark prison = IconPark._(
    id: 1897,
    name: "prison",
    title: "监狱",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["囚禁", "牢房", "游戏", "建筑"],
    rtl: true,
  );

  /// 纹路
  static const IconPark processLine = IconPark._(
    id: 1898,
    name: "process-line",
    title: "纹路",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["纹路", "河流", "小溪", "雾气", "水汽"],
    rtl: true,
  );

  /// 投影仪
  static const IconPark projector = IconPark._(
    id: 1899,
    name: "projector",
    title: "投影仪",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["投影仪", "播放", "幻灯片", "演讲"],
    rtl: true,
  );

  /// 投影机
  static const IconPark projectorOne = IconPark._(
    id: 1900,
    name: "projector-one",
    title: "投影机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "电影", "放映"],
    rtl: true,
  );

  /// 放映机
  static const IconPark projectorThree = IconPark._(
    id: 1901,
    name: "projector-three",
    title: "放映机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "电影", "放映"],
    rtl: true,
  );

  /// 投影仪
  static const IconPark projectorTwo = IconPark._(
    id: 1902,
    name: "projector-two",
    title: "投影仪",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["投影仪", "设备", "投影", "投屏", "播放", "演示"],
    rtl: false,
  );

  /// 比例缩放
  static const IconPark proportionalScaling = IconPark._(
    id: 1903,
    name: "proportional-scaling",
    title: "比例缩放",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["三角", "层次", "比例缩放"],
    rtl: true,
  );

  /// 保护
  static const IconPark protect = IconPark._(
    id: 1904,
    name: "protect",
    title: "保护",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "白明泽",
    tag: ["安全", "防卫", "防护", "盾牌", "安全通过", "安保"],
    rtl: true,
  );

  /// 保护
  static const IconPark protection = IconPark._(
    id: 1905,
    name: "protection",
    title: "保护",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "常留留",
    tag: ["雨伞", "保护", "下雨", "庇护", "防护", "安全", "天气", "护盾"],
    rtl: true,
  );

  /// 卫生间
  static const IconPark publicToilet = IconPark._(
    id: 1906,
    name: "public-toilet",
    title: "卫生间",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["厕所", "男女", "卫生间", "洗手间"],
    rtl: true,
  );

  /// 拉门
  static const IconPark pullDoor = IconPark._(
    id: 1907,
    name: "pull-door",
    title: "拉门",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["拉门", "开门", "打开", "出去", "立体", "透视"],
    rtl: true,
  );

  /// 推送请求
  static const IconPark pullRequests = IconPark._(
    id: 1908,
    name: "pull-requests",
    title: "推送请求",
    category: "Connect",
    categoryCN: "链接",
    author: "齐奉飞",
    tag: ["推动", "消息", "Git"],
    rtl: true,
  );

  /// 南瓜
  static const IconPark pumpkin = IconPark._(
    id: 1909,
    name: "pumpkin",
    title: "南瓜",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["蔬菜", "水果"],
    rtl: true,
  );

  /// 纯天然
  static const IconPark pureNatural = IconPark._(
    id: 1910,
    name: "pure-natural",
    title: "纯天然",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["绿色", "天然", "无公害", "健康"],
    rtl: true,
  );

  /// 推门
  static const IconPark pushDoor = IconPark._(
    id: 1911,
    name: "push-door",
    title: "推门",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["推门", "开门", "打开", "进入"],
    rtl: true,
  );

  /// 图钉
  static const IconPark pushpin = IconPark._(
    id: 1912,
    name: "pushpin",
    title: "图钉",
    category: "Edit",
    categoryCN: "编辑",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 拼图
  static const IconPark puzzle = IconPark._(
    id: 1913,
    name: "puzzle",
    title: "拼图",
    category: "Game",
    categoryCN: "游戏",
    author: "齐奉飞",
    tag: ["拼图", "版图", "拼接", "组合", "游戏"],
    rtl: true,
  );

  /// 金字塔
  static const IconPark pyramid = IconPark._(
    id: 1914,
    name: "pyramid",
    title: "金字塔",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["山脉", "户外", "金字塔", "雪山"],
    rtl: true,
  );

  /// 金字塔
  static const IconPark pyramidOne = IconPark._(
    id: 1915,
    name: "pyramid-one",
    title: "金字塔",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["金字塔", "日出", "景点"],
    rtl: true,
  );

  /// 青鸟线索通
  static const IconPark qingniaoClue = IconPark._(
    id: 1916,
    name: "qingniao-clue",
    title: "青鸟线索通",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["商业化品牌", "品牌广告", "oceanengine", "logo"],
    rtl: true,
  );

  /// 企业号
  static const IconPark qiyehao = IconPark._(
    id: 1917,
    name: "qiyehao",
    title: "企业号",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["企业号", "logo"],
    rtl: true,
  );

  /// 四棱锥
  static const IconPark quadrangularPyramid = IconPark._(
    id: 1918,
    name: "quadrangular-pyramid",
    title: "四棱锥",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["四棱锥", "立体", "钻石"],
    rtl: false,
  );

  /// 四边形
  static const IconPark quadrilateral = IconPark._(
    id: 1919,
    name: "quadrilateral",
    title: "四边形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 引用
  static const IconPark quote = IconPark._(
    id: 1920,
    name: "quote",
    title: "引用",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["引号", "引用", "附言"],
    rtl: true,
  );

  /// 兔子
  static const IconPark rabbit = IconPark._(
    id: 1921,
    name: "rabbit",
    title: "兔子",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 生肖兔
  static const IconPark rabbitZodiac = IconPark._(
    id: 1922,
    name: "rabbit-zodiac",
    title: "生肖兔",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 雷达
  static const IconPark radar = IconPark._(
    id: 1923,
    name: "radar",
    title: "雷达",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["雷达", "瞄准", "聚焦", "关注", "锁定", "定位"],
    rtl: false,
  );

  /// 雷达图
  static const IconPark radarChart = IconPark._(
    id: 1924,
    name: "radar-chart",
    title: "雷达图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["雷达图", "蜘蛛网", "雷达", "图谱"],
    rtl: false,
  );

  /// 雷达3
  static const IconPark radarThree = IconPark._(
    id: 1925,
    name: "radar-three",
    title: "雷达3",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 雷达
  static const IconPark radarTwo = IconPark._(
    id: 1926,
    name: "radar-two",
    title: "雷达",
    category: "Time",
    categoryCN: "时间日期",
    author: "金磊",
    tag: ["雷达", "转动", "扫描", "侦查"],
    rtl: true,
  );

  /// 辐射
  static const IconPark radiation = IconPark._(
    id: 1927,
    name: "radiation",
    title: "辐射",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "白明泽",
    tag: ["辐射", "有害", "毒害", "危险", "警示", "风扇"],
    rtl: false,
  );

  /// 收音机
  static const IconPark radio = IconPark._(
    id: 1928,
    name: "radio",
    title: "收音机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["新闻", "播报机", "播音", "音响", "广播", "通知", "喇叭", "声音", "乐器", "听音乐", "听书"],
    rtl: true,
  );

  /// 广播保姆
  static const IconPark radioNanny = IconPark._(
    id: 1929,
    name: "radio-nanny",
    title: "广播保姆",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["遥控器", "播放器", "广播"],
    rtl: true,
  );

  /// 收音机
  static const IconPark radioOne = IconPark._(
    id: 1930,
    name: "radio-one",
    title: "收音机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["播音", "音响", "广播", "通知", "喇叭", "声音", "乐器", "听音乐", "听书"],
    rtl: true,
  );

  /// 单选
  static const IconPark radioTwo = IconPark._(
    id: 1931,
    name: "radio-two",
    title: "单选",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 萝卜
  static const IconPark radish = IconPark._(
    id: 1932,
    name: "radish",
    title: "萝卜",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["蔬菜", "水果"],
    rtl: true,
  );

  /// 圆萝卜
  static const IconPark radishOne = IconPark._(
    id: 1933,
    name: "radish-one",
    title: "圆萝卜",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["圆萝卜", "萝卜", "蔬菜", "水萝卜"],
    rtl: true,
  );

  /// 铁路
  static const IconPark railway = IconPark._(
    id: 1934,
    name: "railway",
    title: "铁路",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["铁路", "陆运", "运输"],
    rtl: true,
  );

  /// 排行榜
  static const IconPark ranking = IconPark._(
    id: 1935,
    name: "ranking",
    title: "排行榜",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["排行榜", "柱状图", "奖牌", "排名", "热榜"],
    rtl: true,
  );

  /// 排行榜
  static const IconPark rankingList = IconPark._(
    id: 1936,
    name: "ranking-list",
    title: "排行榜",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["排行", "排名", "榜单"],
    rtl: true,
  );

  /// 拨浪鼓
  static const IconPark rattle = IconPark._(
    id: 1937,
    name: "rattle",
    title: "拨浪鼓",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["鼓", "玩具"],
    rtl: true,
  );

  /// 拨浪鼓1
  static const IconPark rattleOne = IconPark._(
    id: 1938,
    name: "rattle-one",
    title: "拨浪鼓1",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["鼓", "玩具"],
    rtl: true,
  );

  /// 剃刀
  static const IconPark razor = IconPark._(
    id: 1939,
    name: "razor",
    title: "剃刀",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 读书
  static const IconPark readBook = IconPark._(
    id: 1940,
    name: "read-book",
    title: "读书",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 接收库
  static const IconPark receive = IconPark._(
    id: 1941,
    name: "receive",
    title: "接收库",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["收纳", "容纳", "接收", "回收箱"],
    rtl: true,
  );

  /// 接收器
  static const IconPark receiver = IconPark._(
    id: 1942,
    name: "receiver",
    title: "接收器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["信号", "接收", "卫星", "发现"],
    rtl: true,
  );

  /// 按最近浏览量排序
  static const IconPark recentViewsSort = IconPark._(
    id: 1943,
    name: "recent-views-sort",
    title: "按最近浏览量排序",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["排序", "浏览", "最近", "查看数据"],
    rtl: true,
  );

  /// 唱片集
  static const IconPark record = IconPark._(
    id: 1944,
    name: "record",
    title: "唱片集",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 光盘
  static const IconPark recordDisc = IconPark._(
    id: 1945,
    name: "record-disc",
    title: "光盘",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["光盘", "音乐", "磁盘", "播放", "复古"],
    rtl: true,
  );

  /// 播放器
  static const IconPark recordPlayer = IconPark._(
    id: 1946,
    name: "record-player",
    title: "播放器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["播放", "音响", "广播", "通知", "喇叭", "声音", "乐器", "听音乐"],
    rtl: true,
  );

  /// 矩形
  static const IconPark rectangle = IconPark._(
    id: 1947,
    name: "rectangle",
    title: "矩形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 矩形1
  static const IconPark rectangleOne = IconPark._(
    id: 1948,
    name: "rectangle-one",
    title: "矩形1",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 小矩形
  static const IconPark rectangleSmall = IconPark._(
    id: 1949,
    name: "rectangle-small",
    title: "小矩形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 矩形撕裂
  static const IconPark rectangleTear = IconPark._(
    id: 1950,
    name: "rectangle-tear",
    title: "矩形撕裂",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["矩形撕裂", "销毁", "扯开"],
    rtl: true,
  );

  /// 大X
  static const IconPark rectangleX = IconPark._(
    id: 1951,
    name: "rectangle-x",
    title: "大X",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["大X", "抽象", "关闭", "错误"],
    rtl: false,
  );

  /// 图形连接
  static const IconPark rectangularCircularConnection = IconPark._(
    id: 1952,
    name: "rectangular-circular-connection",
    title: "图形连接",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["图形连接", "链接", "抽象"],
    rtl: true,
  );

  /// 图形分割
  static const IconPark rectangularCircularSeparation = IconPark._(
    id: 1953,
    name: "rectangular-circular-separation",
    title: "图形分割",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["图形分割", "抽象", "分裂", "翘板", "平衡"],
    rtl: true,
  );

  /// 矩形椎体
  static const IconPark rectangularVertebra = IconPark._(
    id: 1954,
    name: "rectangular-vertebra",
    title: "矩形椎体",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["矩形椎体", "容器", "梯形"],
    rtl: false,
  );

  /// 回收站
  static const IconPark recycleBin = IconPark._(
    id: 1955,
    name: "recycle-bin",
    title: "回收站",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "常留留",
    tag: ["回收站", "回收", "垃圾桶", "恢复", "积累"],
    rtl: true,
  );

  /// 可回收
  static const IconPark recycling = IconPark._(
    id: 1956,
    name: "recycling",
    title: "可回收",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["组件", "循环", "可持续", "新能源", "环保"],
    rtl: true,
  );

  /// 回收池
  static const IconPark recyclingPool = IconPark._(
    id: 1957,
    name: "recycling-pool",
    title: "回收池",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["聚合", "收拢", "回收", "沉淀"],
    rtl: true,
  );

  /// 红十字
  static const IconPark redCross = IconPark._(
    id: 1958,
    name: "red-cross",
    title: "红十字",
    category: "Health",
    categoryCN: "医疗健康",
    author: "金磊",
    tag: ["红十字", "医疗", "救援", "医院", "急救中心"],
    rtl: false,
  );

  /// 红包
  static const IconPark redEnvelope = IconPark._(
    id: 1959,
    name: "red-envelope",
    title: "红包",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["钱", "红包"],
    rtl: false,
  );

  /// 红包
  static const IconPark redEnvelopes = IconPark._(
    id: 1960,
    name: "red-envelopes",
    title: "红包",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["红包", "钱"],
    rtl: false,
  );

  /// 重新
  static const IconPark redo = IconPark._(
    id: 1961,
    name: "redo",
    title: "重新",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["重做", "再做", "刷新", "旋转"],
    rtl: true,
  );

  /// 减少
  static const IconPark reduce = IconPark._(
    id: 1962,
    name: "reduce",
    title: "减少",
    category: "Character",
    categoryCN: "符号标识",
    author: "常留留",
    tag: ["未全选", "复选框", "减去", "去除"],
    rtl: false,
  );

  /// 减少小数位
  static const IconPark reduceDecimalPlaces = IconPark._(
    id: 1963,
    name: "reduce-decimal-places",
    title: "减少小数位",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["小数位", "减少位数"],
    rtl: true,
  );

  /// 减少
  static const IconPark reduceOne = IconPark._(
    id: 1964,
    name: "reduce-one",
    title: "减少",
    category: "Character",
    categoryCN: "符号标识",
    author: "常留留",
    tag: ["未全选", "减号", "不允许", "禁止"],
    rtl: false,
  );

  /// 收缩
  static const IconPark reduceTwo = IconPark._(
    id: 1965,
    name: "reduce-two",
    title: "收缩",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["收缩", "游戏", "方向", "左右", "手柄"],
    rtl: false,
  );

  /// 减少用户
  static const IconPark reduceUser = IconPark._(
    id: 1966,
    name: "reduce-user",
    title: "减少用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["减少", "精简", "用户", "人群", "我的", "个人中心", "人"],
    rtl: false,
  );

  /// 线轮
  static const IconPark reel = IconPark._(
    id: 1967,
    name: "reel",
    title: "线轮",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["线", "轮", "绳"],
    rtl: false,
  );

  /// 三角形
  static const IconPark refraction = IconPark._(
    id: 1968,
    name: "refraction",
    title: "三角形",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["三菱镜", "多进少出", "抽象", "几何"],
    rtl: true,
  );

  /// 刷新
  static const IconPark refresh = IconPark._(
    id: 1969,
    name: "refresh",
    title: "刷新",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["刷新", "旋转", "切换", "重置", "更新"],
    rtl: true,
  );

  /// 刷新
  static const IconPark refreshOne = IconPark._(
    id: 1970,
    name: "refresh-one",
    title: "刷新",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["旋转", "刷新", "循环", "逆转", "转动"],
    rtl: true,
  );

  /// 冰箱
  static const IconPark refrigerator = IconPark._(
    id: 1971,
    name: "refrigerator",
    title: "冰箱",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["冰箱", "电器", "厨房厨具", "电冰箱"],
    rtl: true,
  );

  /// 驳回
  static const IconPark reject = IconPark._(
    id: 1972,
    name: "reject",
    title: "驳回",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["拒绝", "驳回", "拒绝", "不通过", "有问题"],
    rtl: true,
  );

  /// 关系链
  static const IconPark relationalGraph = IconPark._(
    id: 1973,
    name: "relational-graph",
    title: "关系链",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["连接", "关系链", "发散", "跳跃"],
    rtl: true,
  );

  /// 笑眯眼
  static const IconPark relievedFace = IconPark._(
    id: 1974,
    name: "relieved-face",
    title: "笑眯眼",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["笑眯眼", "表情", "羞涩"],
    rtl: false,
  );

  /// 重装
  static const IconPark reload = IconPark._(
    id: 1975,
    name: "reload",
    title: "重装",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["更新", "画圈", "转动", "指向"],
    rtl: true,
  );

  /// 提醒
  static const IconPark remind = IconPark._(
    id: 1976,
    name: "remind",
    title: "提醒",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["提示", "消息", "警示", "警钟", "铃铛"],
    rtl: false,
  );

  /// 无效提醒
  static const IconPark remindDisable = IconPark._(
    id: 1977,
    name: "remind-disable",
    title: "无效提醒",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["闹钟", "提醒", "无效", "时间", "超时"],
    rtl: false,
  );

  /// 遥控器
  static const IconPark remoteControl = IconPark._(
    id: 1978,
    name: "remote-control",
    title: "遥控器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["控制", "遥控", "开关", "调节", "调整", "命令", "传感器", "感应器"],
    rtl: true,
  );

  /// 遥控器
  static const IconPark remoteControlOne = IconPark._(
    id: 1979,
    name: "remote-control-one",
    title: "遥控器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["控制", "遥控", "开关", "调节", "调整", "命令", "传感器", "感应器"],
    rtl: true,
  );

  /// 肾
  static const IconPark renal = IconPark._(
    id: 1980,
    name: "renal",
    title: "肾",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["泌尿科", "肾脏", "排泄", "代谢", "器官"],
    rtl: true,
  );

  /// 雷诺
  static const IconPark renault = IconPark._(
    id: 1981,
    name: "renault",
    title: "雷诺",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["四边形", "汽车", "logo", "标志", "标识"],
    rtl: false,
  );

  /// 编辑
  static const IconPark repair = IconPark._(
    id: 1982,
    name: "repair",
    title: "编辑",
    category: "Edit",
    categoryCN: "编辑",
    author: "张蔓",
    tag: ["编辑", "代码", "文案", "写字", "输入"],
    rtl: true,
  );

  /// 播放5次
  static const IconPark replayFive = IconPark._(
    id: 1983,
    name: "replay-five",
    title: "播放5次",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["重播", "循环"],
    rtl: true,
  );

  /// 重新播放
  static const IconPark replayMusic = IconPark._(
    id: 1984,
    name: "replay-music",
    title: "重新播放",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["循环", "重新", "重复"],
    rtl: true,
  );

  /// 举报
  static const IconPark report = IconPark._(
    id: 1985,
    name: "report",
    title: "举报",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "白明泽",
    tag: ["举报", "检举", "告发", "报告", "警报", "灯", "警示", "灵感"],
    rtl: true,
  );

  /// 重新定位
  static const IconPark repositioning = IconPark._(
    id: 1986,
    name: "repositioning",
    title: "重新定位",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["定位", "位置", "刷新位置"],
    rtl: true,
  );

  /// 电阻器
  static const IconPark resistor = IconPark._(
    id: 1987,
    name: "resistor",
    title: "电阻器",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["电阻"],
    rtl: false,
  );

  /// 抱拳
  static const IconPark respect = IconPark._(
    id: 1988,
    name: "respect",
    title: "抱拳",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["佩服", "膜拜", "崇拜", "恳求"],
    rtl: true,
  );

  /// 休闲
  static const IconPark resting = IconPark._(
    id: 1989,
    name: "resting",
    title: "休闲",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["遮阳伞", "躺椅", "遮阳", "休息", "小憩"],
    rtl: true,
  );

  /// 复古包
  static const IconPark retroBag = IconPark._(
    id: 1990,
    name: "retro-bag",
    title: "复古包",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["包包", "复古包", "皮包", "手提包", "小包"],
    rtl: false,
  );

  /// 返回
  static const IconPark return_ = IconPark._(
    id: 1991,
    name: "return",
    title: "返回",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["重做", "返回", "箭头"],
    rtl: true,
  );

  /// 镜头反转
  static const IconPark reverseLens = IconPark._(
    id: 1992,
    name: "reverse-lens",
    title: "镜头反转",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["相机", "镜头", "反转"],
    rtl: true,
  );

  /// 反转相机
  static const IconPark reverseLensOne = IconPark._(
    id: 1993,
    name: "reverse-lens-one",
    title: "反转相机",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["镜头", "相机", "反转"],
    rtl: true,
  );

  /// 同向运行
  static const IconPark reverseOperationIn = IconPark._(
    id: 1994,
    name: "reverse-operation-in",
    title: "同向运行",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["同向运行", "汇集", "方向", "传递"],
    rtl: true,
  );

  /// 逆向运行
  static const IconPark reverseOperationOut = IconPark._(
    id: 1995,
    name: "reverse-operation-out",
    title: "逆向运行",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["逆向运行", "反向", "散发", "左右", "方向"],
    rtl: true,
  );

  /// 逆向旋转
  static const IconPark reverseRotation = IconPark._(
    id: 1996,
    name: "reverse-rotation",
    title: "逆向旋转",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["逆向", "逆时针", "逆时针旋转", "旋转", "转动", "箭头"],
    rtl: true,
  );

  /// 米饭
  static const IconPark rice = IconPark._(
    id: 1997,
    name: "rice",
    title: "米饭",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["大米", "主食", "谷物", "农作物"],
    rtl: true,
  );

  /// 骑自行车
  static const IconPark riding = IconPark._(
    id: 1998,
    name: "riding",
    title: "骑自行车",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["骑行", "运动", "比赛", "自行车", "冲刺", "两轮车", "轮胎", "速度", "健身", "力量", "体育"],
    rtl: true,
  );

  /// 骑术
  static const IconPark ridingOne = IconPark._(
    id: 1999,
    name: "riding-one",
    title: "骑术",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["骑马", "游玩", "户外"],
    rtl: true,
  );

  /// 右
  static const IconPark right = IconPark._(
    id: 2000,
    name: "right",
    title: "右",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["下一个", "向右", "箭头", "方向"],
    rtl: true,
  );

  /// 直角形
  static const IconPark rightAngle = IconPark._(
    id: 2001,
    name: "right-angle",
    title: "直角形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 右栏
  static const IconPark rightBar = IconPark._(
    id: 2002,
    name: "right-bar",
    title: "右栏",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版", "右"],
    rtl: true,
  );

  /// 右分支
  static const IconPark rightBranch = IconPark._(
    id: 2003,
    name: "right-branch",
    title: "右分支",
    category: "Connect",
    categoryCN: "链接",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 右分支1
  static const IconPark rightBranchOne = IconPark._(
    id: 2004,
    name: "right-branch-one",
    title: "右分支1",
    category: "Connect",
    categoryCN: "链接",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 右分支2
  static const IconPark rightBranchTwo = IconPark._(
    id: 2005,
    name: "right-branch-two",
    title: "右分支2",
    category: "Connect",
    categoryCN: "链接",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 右-圆
  static const IconPark rightC = IconPark._(
    id: 2006,
    name: "right-c",
    title: "右-圆",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["下一个", "箭头", "右", "圆圈箭头"],
    rtl: true,
  );

  /// 向右展开
  static const IconPark rightExpand = IconPark._(
    id: 2007,
    name: "right-expand",
    title: "向右展开",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["展开", "收起", "右展开"],
    rtl: true,
  );

  /// 右1
  static const IconPark rightOne = IconPark._(
    id: 2008,
    name: "right-one",
    title: "右1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["下一个", "向右", "箭头", "方向"],
    rtl: true,
  );

  /// 右运行
  static const IconPark rightRun = IconPark._(
    id: 2009,
    name: "right-run",
    title: "右运行",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["右运行", "右看齐", "方向"],
    rtl: true,
  );

  /// 右-小
  static const IconPark rightSmall = IconPark._(
    id: 2010,
    name: "right-small",
    title: "右-小",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "向右", "方向"],
    rtl: true,
  );

  /// 右下-小
  static const IconPark rightSmallDown = IconPark._(
    id: 2011,
    name: "right-small-down",
    title: "右下-小",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["右下-小", "方向", "箭头"],
    rtl: true,
  );

  /// 右上-小
  static const IconPark rightSmallUp = IconPark._(
    id: 2012,
    name: "right-small-up",
    title: "右上-小",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["右上-小", "方向", "箭头"],
    rtl: true,
  );

  /// 右箭头-方
  static const IconPark rightSquare = IconPark._(
    id: 2013,
    name: "right-square",
    title: "右箭头-方",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["下一个", "箭头", "方形箭头", "右"],
    rtl: true,
  );

  /// 右1
  static const IconPark rightTwo = IconPark._(
    id: 2014,
    name: "right-two",
    title: "右1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "右", "指针", "方向"],
    rtl: true,
  );

  /// 正确用户
  static const IconPark rightUser = IconPark._(
    id: 2015,
    name: "right-user",
    title: "正确用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["正确", "用户", "精准", "完成"],
    rtl: true,
  );

  /// 圆环
  static const IconPark ring = IconPark._(
    id: 2016,
    name: "ring",
    title: "圆环",
    category: "Connect",
    categoryCN: "链接",
    author: "常留留",
    tag: ["循环", "环形", "连接", "开源库"],
    rtl: false,
  );

  /// 圆环
  static const IconPark ringOne = IconPark._(
    id: 2017,
    name: "ring-one",
    title: "圆环",
    category: "Connect",
    categoryCN: "链接",
    author: "常留留",
    tag: ["循环", "环形", "连接", "合作"],
    rtl: false,
  );

  /// 吊环
  static const IconPark rings = IconPark._(
    id: 2018,
    name: "rings",
    title: "吊环",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["训练", "舞蹈", "体操", "放松", "热身", "健身", "健壮", "健康", "力量", "运动", "拉伸", "吊起", "技术", "技巧", "体育"],
    rtl: false,
  );

  /// 波纹
  static const IconPark ripple = IconPark._(
    id: 2019,
    name: "ripple",
    title: "波纹",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["波纹"],
    rtl: true,
  );

  /// 道路
  static const IconPark road = IconPark._(
    id: 2020,
    name: "road",
    title: "道路",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "白明泽",
    tag: ["道路", "交通", "运输"],
    rtl: false,
  );

  /// 路锥
  static const IconPark roadCone = IconPark._(
    id: 2021,
    name: "road-cone",
    title: "路锥",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["道路", "警示", "安全", "交通"],
    rtl: false,
  );

  /// 马路1
  static const IconPark roadOne = IconPark._(
    id: 2022,
    name: "road-one",
    title: "马路1",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 方向标识
  static const IconPark roadSign = IconPark._(
    id: 2023,
    name: "road-sign",
    title: "方向标识",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["方向标识", "方向", "指示牌", "单方向", "交通"],
    rtl: true,
  );

  /// 方向标识
  static const IconPark roadSignBoth = IconPark._(
    id: 2024,
    name: "road-sign-both",
    title: "方向标识",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["方向标识", "方向", "指示牌", "多方向", "渠道"],
    rtl: true,
  );

  /// 机器人2
  static const IconPark robot = IconPark._(
    id: 2025,
    name: "robot",
    title: "机器人2",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["控制", "遥控", "调整", "命令", "执行", "客服"],
    rtl: true,
  );

  /// 机器人1
  static const IconPark robotOne = IconPark._(
    id: 2026,
    name: "robot-one",
    title: "机器人1",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["控制", "遥控", "调整", "命令", "执行", "客服"],
    rtl: true,
  );

  /// 机器人2
  static const IconPark robotTwo = IconPark._(
    id: 2027,
    name: "robot-two",
    title: "机器人2",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["智能", "机床", "机器"],
    rtl: false,
  );

  /// 摇滚指
  static const IconPark rock = IconPark._(
    id: 2028,
    name: "rock",
    title: "摇滚指",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["弹手", "手指", "手势"],
    rtl: true,
  );

  /// 摇滚手势
  static const IconPark rockGesture = IconPark._(
    id: 2029,
    name: "rock-gesture",
    title: "摇滚手势",
    category: "Hands",
    categoryCN: "手势动作",
    author: "金磊",
    tag: ["摇滚手势", "爱你", "爱心", "摇滚", "手势", "姿势", "态度", "乐队"],
    rtl: true,
  );

  /// 火箭
  static const IconPark rocket = IconPark._(
    id: 2030,
    name: "rocket",
    title: "火箭",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "白明泽",
    tag: ["火箭", "发射", "上升", "速度"],
    rtl: false,
  );

  /// 火箭
  static const IconPark rocketOne = IconPark._(
    id: 2031,
    name: "rocket-one",
    title: "火箭",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["飞行器", "推动器", "发射器", "航天器", "宇宙飞船"],
    rtl: true,
  );

  /// 摇马
  static const IconPark rockingHorse = IconPark._(
    id: 2032,
    name: "rocking-horse",
    title: "摇马",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["马"],
    rtl: true,
  );

  /// 溜冰鞋
  static const IconPark rollerskates = IconPark._(
    id: 2033,
    name: "rollerskates",
    title: "溜冰鞋",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["鞋子", "滑冰", "溜冰", "轮滑", "滑行", "滑走", "运动", "训练", "技术", "技巧", "体育"],
    rtl: true,
  );

  /// 连体衣
  static const IconPark romper = IconPark._(
    id: 2034,
    name: "romper",
    title: "连体衣",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["衣服", "童装", "上衣"],
    rtl: false,
  );

  /// 跳绳
  static const IconPark ropeSkipping = IconPark._(
    id: 2035,
    name: "rope-skipping",
    title: "跳绳",
    category: "Sports",
    categoryCN: "体育运动",
    author: "金磊",
    tag: ["跳绳", "绳子"],
    rtl: true,
  );

  /// 跳绳
  static const IconPark ropeSkippingOne = IconPark._(
    id: 2036,
    name: "rope-skipping-one",
    title: "跳绳",
    category: "Sports",
    categoryCN: "体育运动",
    author: "",
    tag: ["绳子", "跳"],
    rtl: false,
  );

  /// 旋转
  static const IconPark rotate = IconPark._(
    id: 2037,
    name: "rotate",
    title: "旋转",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["旋转", "翻转", "90", "度旋转", "抛出", "移动"],
    rtl: true,
  );

  /// 旋转
  static const IconPark rotateOne = IconPark._(
    id: 2038,
    name: "rotate-one",
    title: "旋转",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["中心", "焦点", "雷达", "转动", "统计", "图表", "铃铛"],
    rtl: true,
  );

  /// 旋转添加
  static const IconPark rotatingAdd = IconPark._(
    id: 2039,
    name: "rotating-add",
    title: "旋转添加",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["旋转", "添加", "转动", "箭头", "加号"],
    rtl: true,
  );

  /// 正向旋转
  static const IconPark rotatingForward = IconPark._(
    id: 2040,
    name: "rotating-forward",
    title: "正向旋转",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["正向", "顺时针", "顺时针旋转", "旋转", "转动", "箭头"],
    rtl: true,
  );

  /// 旋转
  static const IconPark rotation = IconPark._(
    id: 2041,
    name: "rotation",
    title: "旋转",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["加载", "圆", "旋转"],
    rtl: true,
  );

  /// 横向旋转
  static const IconPark rotationHorizontal = IconPark._(
    id: 2042,
    name: "rotation-horizontal",
    title: "横向旋转",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["旋转", "横向", "水平旋转", "环绕"],
    rtl: true,
  );

  /// 角度
  static const IconPark rotationOne = IconPark._(
    id: 2043,
    name: "rotation-one",
    title: "角度",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["角度", "90度", "数学", "测量"],
    rtl: true,
  );

  /// 纵向旋转
  static const IconPark rotationVertical = IconPark._(
    id: 2044,
    name: "rotation-vertical",
    title: "纵向旋转",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["旋转", "纵向", "旋转", "环绕"],
    rtl: true,
  );

  /// 圆形
  static const IconPark round = IconPark._(
    id: 2045,
    name: "round",
    title: "圆形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 圆形卡钳
  static const IconPark roundCaliper = IconPark._(
    id: 2046,
    name: "round-caliper",
    title: "圆形卡钳",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆形卡钳", "循环", "风扇", "螺丝帽"],
    rtl: false,
  );

  /// 圆形扭曲
  static const IconPark roundDistortion = IconPark._(
    id: 2047,
    name: "round-distortion",
    title: "圆形扭曲",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆形扭曲", "风扇", "旋转", "循环"],
    rtl: false,
  );

  /// 圆形遮罩
  static const IconPark roundMask = IconPark._(
    id: 2048,
    name: "round-mask",
    title: "圆形遮罩",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆形遮罩", "面积", "比例", "抽象"],
    rtl: false,
  );

  /// 圆形插座
  static const IconPark roundSocket = IconPark._(
    id: 2049,
    name: "round-socket",
    title: "圆形插座",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["圆形插座", "电源", "危险", "插件", "三角插口"],
    rtl: false,
  );

  /// 往返飞
  static const IconPark roundTrip = IconPark._(
    id: 2050,
    name: "round-trip",
    title: "往返飞",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["往返", "往返旅行"],
    rtl: true,
  );

  /// 路由器
  static const IconPark router = IconPark._(
    id: 2051,
    name: "router",
    title: "路由器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["路由器", "路由", "网络", "设备", "硬件", "存储", "信号"],
    rtl: true,
  );

  /// 路由器
  static const IconPark routerOne = IconPark._(
    id: 2052,
    name: "router-one",
    title: "路由器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["wifi", "信号", "发射器", "无线网", "流量", "接收器", "雷达"],
    rtl: true,
  );

  /// 行高度
  static const IconPark rowHeight = IconPark._(
    id: 2053,
    name: "row-height",
    title: "行高度",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["行高", "高度", "行间距"],
    rtl: true,
  );

  /// 划船
  static const IconPark rowing = IconPark._(
    id: 2054,
    name: "rowing",
    title: "划船",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["滑动", "船", "滑行", "拨动", "前进", "划龙舟", "划水", "体育"],
    rtl: true,
  );

  /// RS
  static const IconPark rsMale = IconPark._(
    id: 2055,
    name: "rs-male",
    title: "RS",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "数据"],
    rtl: false,
  );

  /// 订阅
  static const IconPark rss = IconPark._(
    id: 2056,
    name: "rss",
    title: "订阅",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["订阅", "关注", "标记", "便签", "标签"],
    rtl: false,
  );

  /// 橄榄球
  static const IconPark rugby = IconPark._(
    id: 2057,
    name: "rugby",
    title: "橄榄球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "齐奉飞",
    tag: ["橄榄球", "运动", "体育"],
    rtl: true,
  );

  /// 橄榄球1
  static const IconPark rugbyOne = IconPark._(
    id: 2058,
    name: "rugby-one",
    title: "橄榄球1",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["球类", "球", "运动", "橄榄球", "美式足球", "美式体育"],
    rtl: false,
  );

  /// 尺子2
  static const IconPark ruleTwo = IconPark._(
    id: 2059,
    name: "rule-two",
    title: "尺子2",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 尺子
  static const IconPark ruler = IconPark._(
    id: 2060,
    name: "ruler",
    title: "尺子",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "金磊",
    tag: ["度量", "尺子", "距离", "长度", "刻度", "测量"],
    rtl: true,
  );

  /// 尺子1
  static const IconPark rulerOne = IconPark._(
    id: 2061,
    name: "ruler-one",
    title: "尺子1",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "史晓彤",
    tag: ["尺子", "标尺", "拦截", "刻度", "测量"],
    rtl: true,
  );

  /// 左运行
  static const IconPark runLeft = IconPark._(
    id: 2062,
    name: "run-left",
    title: "左运行",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["左运行", "左看齐", "方向"],
    rtl: true,
  );

  /// 底部连接
  static const IconPark sTurnDown = IconPark._(
    id: 2063,
    name: "s-turn-down",
    title: "底部连接",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["底部连接", "流转", "传输", "串联"],
    rtl: true,
  );

  /// 左侧连接
  static const IconPark sTurnLeft = IconPark._(
    id: 2064,
    name: "s-turn-left",
    title: "左侧连接",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["左侧连接", "流转", "传输", "串联"],
    rtl: true,
  );

  /// 右侧连接
  static const IconPark sTurnRight = IconPark._(
    id: 2065,
    name: "s-turn-right",
    title: "右侧连接",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["右侧连接", "流转", "传输", "串联"],
    rtl: true,
  );

  /// 顶部连接
  static const IconPark sTurnUp = IconPark._(
    id: 2066,
    name: "s-turn-up",
    title: "顶部连接",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["上侧连接", "传输", "串联", "流转"],
    rtl: true,
  );

  /// 安全检索
  static const IconPark safeRetrieval = IconPark._(
    id: 2067,
    name: "safe-retrieval",
    title: "安全检索",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 射手座
  static const IconPark sagittarius = IconPark._(
    id: 2068,
    name: "sagittarius",
    title: "射手座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 帆船
  static const IconPark sailboat = IconPark._(
    id: 2069,
    name: "sailboat",
    title: "帆船",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["船", "舰", "渔船", "港口", "航行", "旅游"],
    rtl: true,
  );

  /// 帆船1
  static const IconPark sailboatOne = IconPark._(
    id: 2070,
    name: "sailboat-one",
    title: "帆船1",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 航行
  static const IconPark sailing = IconPark._(
    id: 2071,
    name: "sailing",
    title: "航行",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["航行", "帆船", "船舶"],
    rtl: true,
  );

  /// 销售
  static const IconPark salesReport = IconPark._(
    id: 2072,
    name: "sales-report",
    title: "销售",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "常留留",
    tag: ["销售", "售卖", "数据", "抽象", "六边形"],
    rtl: true,
  );

  /// 凉鞋
  static const IconPark sandals = IconPark._(
    id: 2073,
    name: "sandals",
    title: "凉鞋",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["拖鞋", "凉拖", "度假", "休闲", "人字拖"],
    rtl: true,
  );

  /// 沙尘暴
  static const IconPark sandstorm = IconPark._(
    id: 2074,
    name: "sandstorm",
    title: "沙尘暴",
    category: "Weather",
    categoryCN: "天气",
    author: "齐奉飞",
    tag: ["沙尘暴", "浮尘", "大风", "坏天气"],
    rtl: true,
  );

  /// 三明治
  static const IconPark sandwich = IconPark._(
    id: 2075,
    name: "sandwich",
    title: "三明治",
    category: "Foods",
    categoryCN: "食品",
    author: "史晓彤",
    tag: ["三明治", "早餐", "切角"],
    rtl: true,
  );

  /// 三明治
  static const IconPark sandwichOne = IconPark._(
    id: 2076,
    name: "sandwich-one",
    title: "三明治",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["三明治", "热狗", "食品", "面包"],
    rtl: true,
  );

  /// 树苗
  static const IconPark sapling = IconPark._(
    id: 2077,
    name: "sapling",
    title: "树苗",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["节能", "环保", "新能源", "植物", "树木", "幼小", "苗木"],
    rtl: true,
  );

  /// 保存
  static const IconPark save = IconPark._(
    id: 2078,
    name: "save",
    title: "保存",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["保存", "存储", "暂存", "草稿", "文件"],
    rtl: true,
  );

  /// 保存硬盘
  static const IconPark saveOne = IconPark._(
    id: 2079,
    name: "save-one",
    title: "保存硬盘",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["保存", "存储", "暂存", "硬盘", "文件"],
    rtl: true,
  );

  /// 等比缩放
  static const IconPark scale = IconPark._(
    id: 2080,
    name: "scale",
    title: "等比缩放",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["等比缩放"],
    rtl: true,
  );

  /// 测量
  static const IconPark scaleOne = IconPark._(
    id: 2081,
    name: "scale-one",
    title: "测量",
    category: "Industry",
    categoryCN: "工业",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 大葱
  static const IconPark scallion = IconPark._(
    id: 2082,
    name: "scallion",
    title: "大葱",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["大葱", "葱头", "葱蒜", "蔬菜"],
    rtl: true,
  );

  /// 扫描
  static const IconPark scan = IconPark._(
    id: 2083,
    name: "scan",
    title: "扫描",
    category: "Edit",
    categoryCN: "编辑",
    author: "史晓彤",
    tag: ["识别", "扫描", "扫码", "聚焦", "添加"],
    rtl: false,
  );

  /// 扫码
  static const IconPark scanCode = IconPark._(
    id: 2084,
    name: "scan-code",
    title: "扫码",
    category: "Money",
    categoryCN: "电商财产",
    author: "白明泽",
    tag: ["扫一扫", "登录", "扫码", "二维码", "扫描"],
    rtl: false,
  );

  /// 扫描设置
  static const IconPark scanSetting = IconPark._(
    id: 2085,
    name: "scan-setting",
    title: "扫描设置",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["设置", "扫描", "打印", "方向", "按键", "扫描"],
    rtl: false,
  );

  /// 扫描
  static const IconPark scanning = IconPark._(
    id: 2086,
    name: "scanning",
    title: "扫描",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["扫描", "聚焦", "识别", "扫码"],
    rtl: false,
  );

  /// 扫描
  static const IconPark scanningTwo = IconPark._(
    id: 2087,
    name: "scanning-two",
    title: "扫描",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["扫描", "聚焦", "识别", "扫码"],
    rtl: false,
  );

  /// 分散对齐
  static const IconPark scatterAlignment = IconPark._(
    id: 2088,
    name: "scatter-alignment",
    title: "分散对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["文本对齐", "对齐方式", "排版方式", "分散"],
    rtl: true,
  );

  /// 日程表
  static const IconPark schedule = IconPark._(
    id: 2089,
    name: "schedule",
    title: "日程表",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["时间", "日历", "课程表", "日程", "记录", "牌子"],
    rtl: true,
  );

  /// 学校
  static const IconPark school = IconPark._(
    id: 2090,
    name: "school",
    title: "学校",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["政府", "机构", "房子", "办公楼", "学校"],
    rtl: true,
  );

  /// 剪刀
  static const IconPark scissors = IconPark._(
    id: 2091,
    name: "scissors",
    title: "剪刀",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["剪刀", "剪切", "裁剪"],
    rtl: true,
  );

  /// 比分牌
  static const IconPark scoreboard = IconPark._(
    id: 2092,
    name: "scoreboard",
    title: "比分牌",
    category: "Sports",
    categoryCN: "体育运动",
    author: "",
    tag: ["比分", "统计牌"],
    rtl: true,
  );

  /// 天蝎座
  static const IconPark scorpio = IconPark._(
    id: 2093,
    name: "scorpio",
    title: "天蝎座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 屏幕旋转
  static const IconPark screenRotation = IconPark._(
    id: 2094,
    name: "screen-rotation",
    title: "屏幕旋转",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["旋转", "屏幕", "转动", "竖转横"],
    rtl: true,
  );

  /// 截屏
  static const IconPark screenshot = IconPark._(
    id: 2095,
    name: "screenshot",
    title: "截屏",
    category: "Edit",
    categoryCN: "编辑",
    author: "白明泽",
    tag: ["截屏", "录频", "裁剪", "截图", "剪刀"],
    rtl: false,
  );

  /// 截图
  static const IconPark screenshotOne = IconPark._(
    id: 2096,
    name: "screenshot-one",
    title: "截图",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["聚焦", "对准", "截图", "扩展", "扫描"],
    rtl: false,
  );

  /// 截屏
  static const IconPark screenshotTwo = IconPark._(
    id: 2097,
    name: "screenshot-two",
    title: "截屏",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["截屏", "录屏", "界面", "剪刀"],
    rtl: true,
  );

  /// 螺丝刀
  static const IconPark screwdriver = IconPark._(
    id: 2098,
    name: "screwdriver",
    title: "螺丝刀",
    category: "Industry",
    categoryCN: "工业",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// SD卡
  static const IconPark sd = IconPark._(
    id: 2099,
    name: "sd",
    title: "SD卡",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["卡", "储存", "信号", "流量"],
    rtl: true,
  );

  /// 存储卡
  static const IconPark sdCard = IconPark._(
    id: 2100,
    name: "sd-card",
    title: "存储卡",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["SD", "secure", "digital", "memory", "card", "储存", "存储", "store", "card", "芯片"],
    rtl: true,
  );

  /// 印章
  static const IconPark seal = IconPark._(
    id: 2101,
    name: "seal",
    title: "印章",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["打印", "印制", "复印", "标记", "认证", "审批", "审核", "确认"],
    rtl: true,
  );

  /// 搜索
  static const IconPark search = IconPark._(
    id: 2102,
    name: "search",
    title: "搜索",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["搜索", "查找", "放大镜"],
    rtl: true,
  );

  /// 座位
  static const IconPark seat = IconPark._(
    id: 2103,
    name: "seat",
    title: "座位",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 安全
  static const IconPark security = IconPark._(
    id: 2104,
    name: "security",
    title: "安全",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["保护伞", "雨伞"],
    rtl: true,
  );

  /// 安全台
  static const IconPark securityStall = IconPark._(
    id: 2105,
    name: "security-stall",
    title: "安全台",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["高台", "观景台", "裁判台", "电话亭"],
    rtl: false,
  );

  /// 幼苗
  static const IconPark seedling = IconPark._(
    id: 2106,
    name: "seedling",
    title: "幼苗",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 选中
  static const IconPark selected = IconPark._(
    id: 2107,
    name: "selected",
    title: "选中",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["选中", "命中", "缩放"],
    rtl: false,
  );

  /// 选中焦点
  static const IconPark selectedFocus = IconPark._(
    id: 2108,
    name: "selected-focus",
    title: "选中焦点",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["选中焦点", "锚点", "图形"],
    rtl: false,
  );

  /// 自拍杆
  static const IconPark selfie = IconPark._(
    id: 2109,
    name: "selfie",
    title: "自拍杆",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["自拍", "自拍杆", "拍照", "拍摄", "摄影"],
    rtl: true,
  );

  /// 发送
  static const IconPark send = IconPark._(
    id: 2110,
    name: "send",
    title: "发送",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["飞机", "发送", "飞书", "导航"],
    rtl: true,
  );

  /// 下层
  static const IconPark sendBackward = IconPark._(
    id: 2111,
    name: "send-backward",
    title: "下层",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["下层", "底层", "向下"],
    rtl: false,
  );

  /// 发送邮件
  static const IconPark sendEmail = IconPark._(
    id: 2112,
    name: "send-email",
    title: "发送邮件",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "转发"],
    rtl: true,
  );

  /// 发送1
  static const IconPark sendOne = IconPark._(
    id: 2113,
    name: "send-one",
    title: "发送1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["飞机", "发送", "飞书", "导航"],
    rtl: true,
  );

  /// 移到后面
  static const IconPark sendToBack = IconPark._(
    id: 2114,
    name: "send-to-back",
    title: "移到后面",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["置顶", "筛选", "分类", "分离", "移动"],
    rtl: true,
  );

  /// 最下层
  static const IconPark sentToBack = IconPark._(
    id: 2115,
    name: "sent-to-back",
    title: "最下层",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["最下层", "图层", "层级", "底层"],
    rtl: true,
  );

  /// 搜索引擎
  static const IconPark seo = IconPark._(
    id: 2116,
    name: "seo",
    title: "搜索引擎",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["搜索引擎", "seo", "组件"],
    rtl: true,
  );

  /// 文件夹
  static const IconPark seoFolder = IconPark._(
    id: 2117,
    name: "seo-folder",
    title: "文件夹",
    category: "Office",
    categoryCN: "办公文档",
    author: "张蔓",
    tag: ["文件夹", "收藏", "整理", "收纳", "代码文件"],
    rtl: true,
  );

  /// 服务器
  static const IconPark server = IconPark._(
    id: 2118,
    name: "server",
    title: "服务器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["服务器", "运算", "计算", "机房", "云计算"],
    rtl: true,
  );

  /// 出发
  static const IconPark setOff = IconPark._(
    id: 2119,
    name: "set-off",
    title: "出发",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["出行", "下班", "出发", "动身"],
    rtl: true,
  );

  /// 设置
  static const IconPark setting = IconPark._(
    id: 2120,
    name: "setting",
    title: "设置",
    category: "Base",
    categoryCN: "基础",
    author: "刘心乐",
    tag: ["齿轮", "设置", "螺丝", "螺母", "配置", "工具"],
    rtl: false,
  );

  /// 计算机设置
  static const IconPark settingComputer = IconPark._(
    id: 2121,
    name: "setting-computer",
    title: "计算机设置",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 设置配置
  static const IconPark settingConfig = IconPark._(
    id: 2122,
    name: "setting-config",
    title: "设置配置",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["调节", "音量调节", "设置调节", "音频"],
    rtl: true,
  );

  /// 笔记本电脑设置
  static const IconPark settingLaptop = IconPark._(
    id: 2123,
    name: "setting-laptop",
    title: "笔记本电脑设置",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 设置
  static const IconPark settingOne = IconPark._(
    id: 2124,
    name: "setting-one",
    title: "设置",
    category: "Base",
    categoryCN: "基础",
    author: "刘心乐",
    tag: ["齿轮", "设置", "螺丝", "螺母", "配置", "工具"],
    rtl: false,
  );

  /// 设置
  static const IconPark settingThree = IconPark._(
    id: 2125,
    name: "setting-three",
    title: "设置",
    category: "Base",
    categoryCN: "基础",
    author: "金磊",
    tag: ["太阳能", "阳光", "设置", "配置"],
    rtl: false,
  );

  /// 设置
  static const IconPark settingTwo = IconPark._(
    id: 2126,
    name: "setting-two",
    title: "设置",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["齿轮", "设置", "螺丝", "螺母", "配置", "工具"],
    rtl: false,
  );

  /// 网页设置
  static const IconPark settingWeb = IconPark._(
    id: 2127,
    name: "setting-web",
    title: "网页设置",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 按键七
  static const IconPark sevenKey = IconPark._(
    id: 2128,
    name: "seven-key",
    title: "按键七",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["七", "7", "按键"],
    rtl: true,
  );

  /// 乘凉
  static const IconPark shade = IconPark._(
    id: 2129,
    name: "shade",
    title: "乘凉",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["雨伞", "保护", "休闲"],
    rtl: true,
  );

  /// 震动
  static const IconPark shake = IconPark._(
    id: 2130,
    name: "shake",
    title: "震动",
    category: "Others",
    categoryCN: "其它",
    author: "白明泽",
    tag: ["震动", "颤抖", "抖动", "摇摆"],
    rtl: false,
  );

  /// 分享
  static const IconPark share = IconPark._(
    id: 2131,
    name: "share",
    title: "分享",
    category: "Base",
    categoryCN: "基础",
    author: "刘心乐",
    tag: ["分享", "转发", "跳转", "打开", "窗口", "外链"],
    rtl: true,
  );

  /// 分享
  static const IconPark shareOne = IconPark._(
    id: 2132,
    name: "share-one",
    title: "分享",
    category: "Connect",
    categoryCN: "链接",
    author: "刘心乐",
    tag: ["分享", "转发", "共享", "链接", "连接"],
    rtl: true,
  );

  /// 分享
  static const IconPark shareSys = IconPark._(
    id: 2133,
    name: "share-sys",
    title: "分享",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["分享", "信号", "播音", "投屏"],
    rtl: false,
  );

  /// 分享3
  static const IconPark shareThree = IconPark._(
    id: 2134,
    name: "share-three",
    title: "分享3",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["分享", "跳转", "转发", "返回"],
    rtl: true,
  );

  /// 分享2
  static const IconPark shareTwo = IconPark._(
    id: 2135,
    name: "share-two",
    title: "分享2",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["分享", "跳转", "转发", "返回"],
    rtl: true,
  );

  /// 剃须刀
  static const IconPark shaver = IconPark._(
    id: 2136,
    name: "shaver",
    title: "剃须刀",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["电器", "男士用品", "刮胡刀", "剃胡刀"],
    rtl: true,
  );

  /// 剃须刀
  static const IconPark shaverOne = IconPark._(
    id: 2137,
    name: "shaver-one",
    title: "剃须刀",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "史晓彤",
    tag: ["标签", "书签", "贴纸", "剃须刀"],
    rtl: true,
  );

  /// 刮胡泡
  static const IconPark shaving = IconPark._(
    id: 2138,
    name: "shaving",
    title: "刮胡泡",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["泡沫", "乳液"],
    rtl: true,
  );

  /// 生肖羊
  static const IconPark sheepZodiac = IconPark._(
    id: 2139,
    name: "sheep-zodiac",
    title: "生肖羊",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 安全
  static const IconPark shield = IconPark._(
    id: 2140,
    name: "shield",
    title: "安全",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "齐奉飞",
    tag: ["安全", "保护", "护盾", "防护", "安保"],
    rtl: false,
  );

  /// 安全增加
  static const IconPark shieldAdd = IconPark._(
    id: 2141,
    name: "shield-add",
    title: "安全增加",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "齐奉飞",
    tag: ["安全", "保护", "增加防护", "医疗", "安保"],
    rtl: false,
  );

  /// 船
  static const IconPark ship = IconPark._(
    id: 2142,
    name: "ship",
    title: "船",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "白明泽",
    tag: ["船", "舰船", "出行", "海洋", "运输", "交通"],
    rtl: false,
  );

  /// 商店
  static const IconPark shop = IconPark._(
    id: 2143,
    name: "shop",
    title: "商店",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["商店", "购物", "商场", "门店"],
    rtl: true,
  );

  /// 购物车
  static const IconPark shopping = IconPark._(
    id: 2144,
    name: "shopping",
    title: "购物车",
    category: "Money",
    categoryCN: "电商财产",
    author: "刘心乐",
    tag: ["购物车", "买东西", "消费"],
    rtl: true,
  );

  /// 购物袋
  static const IconPark shoppingBag = IconPark._(
    id: 2145,
    name: "shopping-bag",
    title: "购物袋",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["购物袋", "快消品", "逛街", "包包", "手提袋", "购物车", "消费"],
    rtl: false,
  );

  /// 购物袋1
  static const IconPark shoppingBagOne = IconPark._(
    id: 2146,
    name: "shopping-bag-one",
    title: "购物袋1",
    category: "Money",
    categoryCN: "电商财产",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 购物车
  static const IconPark shoppingCart = IconPark._(
    id: 2147,
    name: "shopping-cart",
    title: "购物车",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["购物", "买东西", "购物卡", "消费"],
    rtl: true,
  );

  /// 添加购物车
  static const IconPark shoppingCartAdd = IconPark._(
    id: 2148,
    name: "shopping-cart-add",
    title: "添加购物车",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["购物车", "添加", "买东西", "购物"],
    rtl: true,
  );

  /// 删除购物车
  static const IconPark shoppingCartDel = IconPark._(
    id: 2149,
    name: "shopping-cart-del",
    title: "删除购物车",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["购物车", "退货", "删除", "移除"],
    rtl: true,
  );

  /// 购物车1
  static const IconPark shoppingCartOne = IconPark._(
    id: 2150,
    name: "shopping-cart-one",
    title: "购物车1",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["购物车", "消费", "买东西", "电商", "商超"],
    rtl: true,
  );

  /// 购物车2
  static const IconPark shoppingCartTwo = IconPark._(
    id: 2151,
    name: "shopping-cart-two",
    title: "购物车2",
    category: "Money",
    categoryCN: "电商财产",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 商圈
  static const IconPark shoppingMall = IconPark._(
    id: 2152,
    name: "shopping-mall",
    title: "商圈",
    category: "Build",
    categoryCN: "建筑",
    author: "常留留",
    tag: ["购物", "商城", "购买", "城市", "楼房", "建筑"],
    rtl: true,
  );

  /// 短裙
  static const IconPark shortSkirt = IconPark._(
    id: 2153,
    name: "short-skirt",
    title: "短裙",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["裙子", "舞蹈裙", "短裙"],
    rtl: true,
  );

  /// 短裤
  static const IconPark shorts = IconPark._(
    id: 2154,
    name: "shorts",
    title: "短裤",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["短裤", "运动裤", "训练裤"],
    rtl: false,
  );

  /// 单肩包
  static const IconPark shoulderBag = IconPark._(
    id: 2155,
    name: "shoulder-bag",
    title: "单肩包",
    category: "Money",
    categoryCN: "电商财产",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 铁铲
  static const IconPark shovel = IconPark._(
    id: 2156,
    name: "shovel",
    title: "铁铲",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["餐具", "工具", "铁铲", "锅铲"],
    rtl: false,
  );

  /// 铲子
  static const IconPark shovelOne = IconPark._(
    id: 2157,
    name: "shovel-one",
    title: "铲子",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["餐具", "工具", "铁铲", "锅铲"],
    rtl: false,
  );

  /// 淋浴喷头
  static const IconPark showerHead = IconPark._(
    id: 2158,
    name: "shower-head",
    title: "淋浴喷头",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["淋浴喷头", "酒店", "洗澡"],
    rtl: true,
  );

  /// 大虾
  static const IconPark shrimp = IconPark._(
    id: 2159,
    name: "shrimp",
    title: "大虾",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["大虾", "虾", "水产", "海鲜", "生鲜", "虾仁"],
    rtl: true,
  );

  /// 洗牌
  static const IconPark shuffle = IconPark._(
    id: 2160,
    name: "shuffle",
    title: "洗牌",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["混合", "回库", "交叉", "箭头"],
    rtl: true,
  );

  /// 洗牌
  static const IconPark shuffleOne = IconPark._(
    id: 2161,
    name: "shuffle-one",
    title: "洗牌",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["刷新", "混合", "回库", "交叉", "随机"],
    rtl: true,
  );

  /// 快门优先
  static const IconPark shutterPriority = IconPark._(
    id: 2162,
    name: "shutter-priority",
    title: "快门优先",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["相机", "快门", "照相"],
    rtl: true,
  );

  /// 病床
  static const IconPark sickbed = IconPark._(
    id: 2163,
    name: "sickbed",
    title: "病床",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 信号
  static const IconPark signal = IconPark._(
    id: 2164,
    name: "signal",
    title: "信号",
    category: "Others",
    categoryCN: "其它",
    author: "齐奉飞",
    tag: ["信号源", "消息", "来信"],
    rtl: true,
  );

  /// 信号
  static const IconPark signalOne = IconPark._(
    id: 2165,
    name: "signal-one",
    title: "信号",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["信号源", "消息", "基站"],
    rtl: false,
  );

  /// 信号强度
  static const IconPark signalStrength = IconPark._(
    id: 2166,
    name: "signal-strength",
    title: "信号强度",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["信号强度"],
    rtl: false,
  );

  /// 信号塔
  static const IconPark signalTower = IconPark._(
    id: 2167,
    name: "signal-tower",
    title: "信号塔",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["信号", "发射器", "接收器", "电子卫星", "检测器", "探测仪", "雷达", "防御", "干扰器"],
    rtl: true,
  );

  /// 信号塔
  static const IconPark signalTowerOne = IconPark._(
    id: 2168,
    name: "signal-tower-one",
    title: "信号塔",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["电塔", "网络塔", "信号塔"],
    rtl: false,
  );

  /// 电话卡
  static const IconPark sim = IconPark._(
    id: 2169,
    name: "sim",
    title: "电话卡",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["电话卡", "sim", "卡", "5G", "卡"],
    rtl: true,
  );

  /// 储存卡
  static const IconPark simCard = IconPark._(
    id: 2170,
    name: "sim-card",
    title: "储存卡",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["移动卡", "卡片", "手机卡", "流量卡", "电话卡", "芯片"],
    rtl: true,
  );

  /// 单人床
  static const IconPark singleBed = IconPark._(
    id: 2171,
    name: "single-bed",
    title: "单人床",
    category: "Life",
    categoryCN: "生活",
    author: "金磊",
    tag: ["单人床", "睡觉", "酒店", "休息"],
    rtl: false,
  );

  /// 正弦曲线
  static const IconPark sinusoid = IconPark._(
    id: 2172,
    name: "sinusoid",
    title: "正弦曲线",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["正玄曲线", "科学", "数学", "教育", "物理"],
    rtl: true,
  );

  /// 吸管杯
  static const IconPark sippyCup = IconPark._(
    id: 2173,
    name: "sippy-cup",
    title: "吸管杯",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["杯子", "吸管"],
    rtl: true,
  );

  /// 六
  static const IconPark six = IconPark._(
    id: 2174,
    name: "six",
    title: "六",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["六", "手指", "手势"],
    rtl: true,
  );

  /// 圆形连接
  static const IconPark sixCircularConnection = IconPark._(
    id: 2175,
    name: "six-circular-connection",
    title: "圆形连接",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆形连接", "原子", "抽象"],
    rtl: false,
  );

  /// 按键六
  static const IconPark sixKey = IconPark._(
    id: 2176,
    name: "six-key",
    title: "按键六",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["六", "6", "按键"],
    rtl: true,
  );

  /// 六个点
  static const IconPark sixPoints = IconPark._(
    id: 2177,
    name: "six-points",
    title: "六个点",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["六个点", "原子", "抽象"],
    rtl: false,
  );

  /// 滑板
  static const IconPark skate = IconPark._(
    id: 2178,
    name: "skate",
    title: "滑板",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["板", "滑冰", "溜冰", "轮滑", "滑行", "滑走", "运动", "训练", "技术", "技巧", "体育"],
    rtl: true,
  );

  /// 冰鞋
  static const IconPark skates = IconPark._(
    id: 2179,
    name: "skates",
    title: "冰鞋",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["鞋子", "靴子", "滑冰鞋", "棉鞋"],
    rtl: true,
  );

  /// 溜冰鞋
  static const IconPark skating = IconPark._(
    id: 2180,
    name: "skating",
    title: "溜冰鞋",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["鞋子", "滑冰", "溜冰", "轮滑", "滑行", "滑走", "运动", "训练", "技术", "技巧", "体育"],
    rtl: true,
  );

  /// sketch
  static const IconPark sketch = IconPark._(
    id: 2181,
    name: "sketch",
    title: "sketch",
    category: "Brand",
    categoryCN: "品牌",
    author: "",
    tag: ["sketch", "logo", "设计软件", "应用", "工具"],
    rtl: false,
  );

  /// 滑雪
  static const IconPark skiingNordic = IconPark._(
    id: 2182,
    name: "skiing-nordic",
    title: "滑雪",
    category: "Sports",
    categoryCN: "体育运动",
    author: "",
    tag: ["滑车"],
    rtl: true,
  );

  /// 骷髅
  static const IconPark skull = IconPark._(
    id: 2183,
    name: "skull",
    title: "骷髅",
    category: "Game",
    categoryCN: "游戏",
    author: "白明泽",
    tag: ["鼓楼", "恐怖", "危险", "骨头"],
    rtl: false,
  );

  /// 附件
  static const IconPark slave = IconPark._(
    id: 2184,
    name: "slave",
    title: "附件",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["数据", "传输", "链接"],
    rtl: true,
  );

  /// 树叶
  static const IconPark sleaves = IconPark._(
    id: 2185,
    name: "sleaves",
    title: "树叶",
    category: "Others",
    categoryCN: "其它",
    author: "齐奉飞",
    tag: ["叶子", "树叶", "叶", "标本", "植物", "树木", "草"],
    rtl: true,
  );

  /// 睡眠
  static const IconPark sleep = IconPark._(
    id: 2186,
    name: "sleep",
    title: "睡眠",
    category: "Base",
    categoryCN: "基础",
    author: "常留留",
    tag: ["睡眠", "夜晚", "打呼噜", "酣睡", "休息", "黑夜"],
    rtl: true,
  );

  /// 睡觉
  static const IconPark sleepOne = IconPark._(
    id: 2187,
    name: "sleep-one",
    title: "睡觉",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["睡"],
    rtl: true,
  );

  /// 睡觉
  static const IconPark sleepTwo = IconPark._(
    id: 2188,
    name: "sleep-two",
    title: "睡觉",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 幻灯片
  static const IconPark slide = IconPark._(
    id: 2189,
    name: "slide",
    title: "幻灯片",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["数据看版", "销售提报", "文稿演示", "屏幕", "投屏"],
    rtl: true,
  );

  /// 幻灯片
  static const IconPark slideTwo = IconPark._(
    id: 2190,
    name: "slide-two",
    title: "幻灯片",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["幻灯片", "播放", "PPT", "投影"],
    rtl: false,
  );

  /// 水平拖动
  static const IconPark slidingHorizontal = IconPark._(
    id: 2191,
    name: "sliding-horizontal",
    title: "水平拖动",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["水平拖动", "双方向", "方向", "箭头", "左右"],
    rtl: false,
  );

  /// 垂直拖动
  static const IconPark slidingVertical = IconPark._(
    id: 2192,
    name: "sliding-vertical",
    title: "垂直拖动",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["垂直拖动", "双方向", "方向", "箭头", "上下"],
    rtl: false,
  );

  /// 轻微沮丧
  static const IconPark slightlyFrowningFaceWhitOpenMouth = IconPark._(
    id: 2193,
    name: "slightly-frowning-face-whit-open-mouth",
    title: "轻微沮丧",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["轻微沮丧", "表情", "痛苦", "纠结"],
    rtl: false,
  );

  /// 微笑
  static const IconPark slightlySmilingFace = IconPark._(
    id: 2194,
    name: "slightly-smiling-face",
    title: "微笑",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["微笑", "表情", "开心"],
    rtl: false,
  );

  /// 拖鞋
  static const IconPark slippers = IconPark._(
    id: 2195,
    name: "slippers",
    title: "拖鞋",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["鞋子", "凉鞋", "拖鞋"],
    rtl: true,
  );

  /// 拖鞋
  static const IconPark slippersOne = IconPark._(
    id: 2196,
    name: "slippers-one",
    title: "拖鞋",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["鞋子", "凉鞋", "拖鞋"],
    rtl: true,
  );

  /// 囧笑
  static const IconPark slyFaceWhitSmile = IconPark._(
    id: 2197,
    name: "sly-face-whit-smile",
    title: "囧笑",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["囧笑", "表情", "尴尬"],
    rtl: false,
  );

  /// 智能优化
  static const IconPark smartOptimization = IconPark._(
    id: 2198,
    name: "smart-optimization",
    title: "智能优化",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["智能优化", "抽象", "圆环", "花形"],
    rtl: false,
  );

  /// 笑脸
  static const IconPark smilingFace = IconPark._(
    id: 2199,
    name: "smiling-face",
    title: "笑脸",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["笑脸", "表情"],
    rtl: false,
  );

  /// 笑眯眼
  static const IconPark smilingFaceWithSquintingEyes = IconPark._(
    id: 2200,
    name: "smiling-face-with-squinting-eyes",
    title: "笑眯眼",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["笑眯眼", "表情", "开心"],
    rtl: false,
  );

  /// 小食
  static const IconPark snacks = IconPark._(
    id: 2201,
    name: "snacks",
    title: "小食",
    category: "Foods",
    categoryCN: "食品",
    author: "常留留",
    tag: ["小吃", "零食", "食物", "饮料", "咖啡", "奶茶", "果汁"],
    rtl: false,
  );

  /// 生肖蛇
  static const IconPark snakeZodiac = IconPark._(
    id: 2202,
    name: "snake-zodiac",
    title: "生肖蛇",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 下雪
  static const IconPark snow = IconPark._(
    id: 2203,
    name: "snow",
    title: "下雪",
    category: "Weather",
    categoryCN: "天气",
    author: "",
    tag: ["雪"],
    rtl: true,
  );

  /// 雪花
  static const IconPark snowflake = IconPark._(
    id: 2204,
    name: "snowflake",
    title: "雪花",
    category: "Weather",
    categoryCN: "天气",
    author: "齐奉飞",
    tag: ["雪花", "下雪", "天气", "寒冷", "大雪"],
    rtl: false,
  );

  /// 雪人
  static const IconPark snowman = IconPark._(
    id: 2205,
    name: "snowman",
    title: "雪人",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 泡泡
  static const IconPark soapBubble = IconPark._(
    id: 2206,
    name: "soap-bubble",
    title: "泡泡",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["泡沫", "气泡"],
    rtl: true,
  );

  /// 足球
  static const IconPark soccer = IconPark._(
    id: 2207,
    name: "soccer",
    title: "足球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["踢足球", "足球", "运动", "体育", "运球", "打球", "踢", "跑动", "助攻"],
    rtl: false,
  );

  /// 足球1
  static const IconPark soccerOne = IconPark._(
    id: 2208,
    name: "soccer-one",
    title: "足球1",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["踢足球", "足球", "运动", "体育", "运球", "过人", "变向", "射门", "打球", "踢", "跑动", "助攻"],
    rtl: true,
  );

  /// 袜子
  static const IconPark socks = IconPark._(
    id: 2209,
    name: "socks",
    title: "袜子",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["袜子", "服装", "儿童袜"],
    rtl: true,
  );

  /// 沙发
  static const IconPark sofa = IconPark._(
    id: 2210,
    name: "sofa",
    title: "沙发",
    category: "Life",
    categoryCN: "生活",
    author: "白明泽",
    tag: ["沙发", "家居", "家具", "装修"],
    rtl: false,
  );

  /// 沙发
  static const IconPark sofaTwo = IconPark._(
    id: 2211,
    name: "sofa-two",
    title: "沙发",
    category: "Life",
    categoryCN: "生活",
    author: "常留留",
    tag: ["居家", "home", "家居", "家具", "装修", "家装"],
    rtl: false,
  );

  /// 垒球
  static const IconPark softball = IconPark._(
    id: 2212,
    name: "softball",
    title: "垒球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["棒球", "球类", "球", "弹性球", "体育"],
    rtl: true,
  );

  /// 太阳能
  static const IconPark solarEnergy = IconPark._(
    id: 2213,
    name: "solar-energy",
    title: "太阳能",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["新能源", "蓄电池", "资源", "能量"],
    rtl: false,
  );

  /// 太阳能
  static const IconPark solarEnergyOne = IconPark._(
    id: 2214,
    name: "solar-energy-one",
    title: "太阳能",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["灯具"],
    rtl: false,
  );

  /// 固态硬盘
  static const IconPark solidStateDisk = IconPark._(
    id: 2215,
    name: "solid-state-disk",
    title: "固态硬盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["储存", "存储", "硬盘", "store"],
    rtl: true,
  );

  /// 巫师帽
  static const IconPark sorcererHat = IconPark._(
    id: 2216,
    name: "sorcerer-hat",
    title: "巫师帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["帽子", "尖角帽", "哈利波特", "魔法帽"],
    rtl: true,
  );

  /// 排序
  static const IconPark sort = IconPark._(
    id: 2217,
    name: "sort",
    title: "排序",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["排序", "上下", "顺序", "排列"],
    rtl: false,
  );

  /// 降序排序
  static const IconPark sortAmountDown = IconPark._(
    id: 2218,
    name: "sort-amount-down",
    title: "降序排序",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["筛选", "排序", "降序", "顺序"],
    rtl: true,
  );

  /// 升序排序
  static const IconPark sortAmountUp = IconPark._(
    id: 2219,
    name: "sort-amount-up",
    title: "升序排序",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["筛选", "排序", "升序", "顺序"],
    rtl: true,
  );

  /// 排序
  static const IconPark sortFour = IconPark._(
    id: 2220,
    name: "sort-four",
    title: "排序",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["序列", "排列", "调整顺序", "顺序", "箭头"],
    rtl: false,
  );

  /// 排序1
  static const IconPark sortOne = IconPark._(
    id: 2221,
    name: "sort-one",
    title: "排序1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["顺序", "排序", "排列"],
    rtl: true,
  );

  /// 排序3
  static const IconPark sortThree = IconPark._(
    id: 2222,
    name: "sort-three",
    title: "排序3",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["排序", "上下", "顺序", "排列"],
    rtl: true,
  );

  /// 排序2
  static const IconPark sortTwo = IconPark._(
    id: 2223,
    name: "sort-two",
    title: "排序2",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["排序", "上下", "顺序", "排列"],
    rtl: true,
  );

  /// 音响
  static const IconPark sound = IconPark._(
    id: 2224,
    name: "sound",
    title: "音响",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["声音", "音乐", "乐器", "扩音器", "喇叭"],
    rtl: true,
  );

  /// 音响
  static const IconPark soundOne = IconPark._(
    id: 2225,
    name: "sound-one",
    title: "音响",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["声音", "音乐", "乐器", "扩音器", "喇叭"],
    rtl: true,
  );

  /// 音波
  static const IconPark soundWave = IconPark._(
    id: 2226,
    name: "sound-wave",
    title: "音波",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "齐奉飞",
    tag: ["音频", "音量", "语音", "录音", "波纹", "声音"],
    rtl: false,
  );

  /// 网页代码
  static const IconPark sourceCode = IconPark._(
    id: 2227,
    name: "source-code",
    title: "网页代码",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 榨汁机
  static const IconPark soybeanMilkMaker = IconPark._(
    id: 2228,
    name: "soybean-milk-maker",
    title: "榨汁机",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["榨汁机", "榨汁", "豆浆机", "厨房厨具"],
    rtl: true,
  );

  /// 蜡烛沐浴
  static const IconPark spaCandle = IconPark._(
    id: 2229,
    name: "spa-candle",
    title: "蜡烛沐浴",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["蜡烛", "烛光"],
    rtl: true,
  );

  /// 太空殖民地
  static const IconPark spaceColony = IconPark._(
    id: 2230,
    name: "space-colony",
    title: "太空殖民地",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "房子", "办公楼", "建筑"],
    rtl: true,
  );

  /// 扳手
  static const IconPark spanner = IconPark._(
    id: 2231,
    name: "spanner",
    title: "扳手",
    category: "Industry",
    categoryCN: "工业",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 音响
  static const IconPark speaker = IconPark._(
    id: 2232,
    name: "speaker",
    title: "音响",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["音乐", "音响", "设备", "声音", "家庭影院"],
    rtl: false,
  );

  /// 喇叭
  static const IconPark speakerOne = IconPark._(
    id: 2233,
    name: "speaker-one",
    title: "喇叭",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["声音", "音乐", "乐器", "扩音器", "喇叭"],
    rtl: true,
  );

  /// 速度
  static const IconPark speed = IconPark._(
    id: 2234,
    name: "speed",
    title: "速度",
    category: "Time",
    categoryCN: "时间日期",
    author: "刘心乐",
    tag: ["速率", "速度表", "仪表盘"],
    rtl: true,
  );

  /// 速度
  static const IconPark speedOne = IconPark._(
    id: 2235,
    name: "speed-one",
    title: "速度",
    category: "Time",
    categoryCN: "时间日期",
    author: "刘心乐",
    tag: ["速率", "速度表", "仪表盘"],
    rtl: true,
  );

  /// 精子
  static const IconPark sperm = IconPark._(
    id: 2236,
    name: "sperm",
    title: "精子",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["男科", "生殖", "繁衍"],
    rtl: true,
  );

  /// 圆球
  static const IconPark sphere = IconPark._(
    id: 2237,
    name: "sphere",
    title: "圆球",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["圆球", "球体", "地球", "纬度"],
    rtl: false,
  );

  /// 弹指
  static const IconPark spiderMan = IconPark._(
    id: 2238,
    name: "spider-man",
    title: "弹指",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["弹手", "手指", "手势"],
    rtl: true,
  );

  /// 钉鞋
  static const IconPark spikedshoes = IconPark._(
    id: 2239,
    name: "spikedshoes",
    title: "钉鞋",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["鞋子", "跑步", "运动", "训练", "技术", "技巧", "体育", "鞋"],
    rtl: true,
  );

  /// 陀螺
  static const IconPark spinningTop = IconPark._(
    id: 2240,
    name: "spinning-top",
    title: "陀螺",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["旋转", "陀螺仪", "转动", "转", "平衡", "速度"],
    rtl: false,
  );

  /// 分裂
  static const IconPark split = IconPark._(
    id: 2241,
    name: "split",
    title: "分裂",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["图层", "双层", "上层"],
    rtl: true,
  );

  /// 分离
  static const IconPark splitBranch = IconPark._(
    id: 2242,
    name: "split-branch",
    title: "分离",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["分离", "编辑", "对比", "抽象"],
    rtl: true,
  );

  /// 拆分单元格
  static const IconPark splitCells = IconPark._(
    id: 2243,
    name: "split-cells",
    title: "拆分单元格",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["拆分单元格", "表格", "操作"],
    rtl: false,
  );

  /// 左下分支
  static const IconPark splitTurnDownLeft = IconPark._(
    id: 2244,
    name: "split-turn-down-left",
    title: "左下分支",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["思维导图", "分支", "分散"],
    rtl: true,
  );

  /// 右下分支
  static const IconPark splitTurnDownRight = IconPark._(
    id: 2245,
    name: "split-turn-down-right",
    title: "右下分支",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["思维导图", "分支", "分散"],
    rtl: true,
  );

  /// 铁勺
  static const IconPark spoon = IconPark._(
    id: 2246,
    name: "spoon",
    title: "铁勺",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["餐具", "工具", "勺子", "铁勺"],
    rtl: false,
  );

  /// 运动
  static const IconPark sport = IconPark._(
    id: 2247,
    name: "sport",
    title: "运动",
    category: "Sports",
    categoryCN: "体育运动",
    author: "常留留",
    tag: ["跑步", "健康", "活力"],
    rtl: true,
  );

  /// 运动
  static const IconPark sporting = IconPark._(
    id: 2248,
    name: "sporting",
    title: "运动",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 方形
  static const IconPark square = IconPark._(
    id: 2249,
    name: "square",
    title: "方形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 小方形
  static const IconPark squareSmall = IconPark._(
    id: 2250,
    name: "square-small",
    title: "小方形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// SSD
  static const IconPark ssd = IconPark._(
    id: 2251,
    name: "ssd",
    title: "SSD",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["储存器", "服务器", "管理器"],
    rtl: true,
  );

  /// 堆栈灯
  static const IconPark stackLight = IconPark._(
    id: 2252,
    name: "stack-light",
    title: "堆栈灯",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["提示灯", "导向灯"],
    rtl: true,
  );

  /// 邮票
  static const IconPark stamp = IconPark._(
    id: 2253,
    name: "stamp",
    title: "邮票",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["邮票"],
    rtl: false,
  );

  /// 站起来
  static const IconPark standUp = IconPark._(
    id: 2254,
    name: "stand-up",
    title: "站起来",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 订书机
  static const IconPark stapler = IconPark._(
    id: 2255,
    name: "stapler",
    title: "订书机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["工具", "打穿", "订书", "砌书"],
    rtl: true,
  );

  /// 星星
  static const IconPark star = IconPark._(
    id: 2256,
    name: "star",
    title: "星星",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["收藏", "已收藏", "取消收藏", "评分", "评价", "打分", "星级", "五角星"],
    rtl: false,
  );

  /// 星星
  static const IconPark starOne = IconPark._(
    id: 2257,
    name: "star-one",
    title: "星星",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["已收藏", "取消收藏", "评分", "评价", "打分", "星级", "qq空间"],
    rtl: true,
  );

  /// 按开始时间排序
  static const IconPark startTimeSort = IconPark._(
    id: 2258,
    name: "start-time-sort",
    title: "按开始时间排序",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["排序", "序列", "按时间排序", "开始"],
    rtl: true,
  );

  /// 方向盘
  static const IconPark steeringWheel = IconPark._(
    id: 2259,
    name: "steering-wheel",
    title: "方向盘",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["方向盘", "汽车"],
    rtl: false,
  );

  /// 童车
  static const IconPark steoller = IconPark._(
    id: 2260,
    name: "steoller",
    title: "童车",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["车子", "儿童车"],
    rtl: true,
  );

  /// 嵌套图形
  static const IconPark stereoNesting = IconPark._(
    id: 2261,
    name: "stereo-nesting",
    title: "嵌套图形",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["嵌套图形", "抽象", "标志", "logo"],
    rtl: true,
  );

  /// 立体声
  static const IconPark stereoOne = IconPark._(
    id: 2262,
    name: "stereo-one",
    title: "立体声",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["声音", "音乐", "乐器", "扩音器", "喇叭"],
    rtl: true,
  );

  /// 立体透视
  static const IconPark stereoPerspective = IconPark._(
    id: 2263,
    name: "stereo-perspective",
    title: "立体透视",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["立体透视", "立方体", "容器", "方形"],
    rtl: true,
  );

  /// 听诊器
  static const IconPark stethoscope = IconPark._(
    id: 2264,
    name: "stethoscope",
    title: "听诊器",
    category: "Health",
    categoryCN: "医疗健康",
    author: "金磊",
    tag: ["医疗", "医生", "治疗", "监测", "大夫", "护士", "药物"],
    rtl: true,
  );

  /// 贴纸
  static const IconPark stickers = IconPark._(
    id: 2265,
    name: "stickers",
    title: "贴纸",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["贴画", "插图", "壁纸"],
    rtl: true,
  );

  /// 股市
  static const IconPark stockMarket = IconPark._(
    id: 2266,
    name: "stock-market",
    title: "股市",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["阴线", "阳线", "股市图"],
    rtl: true,
  );

  /// 秒表
  static const IconPark stopwatch = IconPark._(
    id: 2267,
    name: "stopwatch",
    title: "秒表",
    category: "Time",
    categoryCN: "时间日期",
    author: "常留留",
    tag: ["倒计时", "时间", "描边"],
    rtl: true,
  );

  /// 计时器
  static const IconPark stopwatchStart = IconPark._(
    id: 2268,
    name: "stopwatch-start",
    title: "计时器",
    category: "Time",
    categoryCN: "时间日期",
    author: "白明泽",
    tag: ["计时器", "倒计时", "时间", "表"],
    rtl: true,
  );

  /// 储存卡1
  static const IconPark storageCardOne = IconPark._(
    id: 2269,
    name: "storage-card-one",
    title: "储存卡1",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: true,
  );

  /// 储存卡2
  static const IconPark storageCardTwo = IconPark._(
    id: 2270,
    name: "storage-card-two",
    title: "储存卡2",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: true,
  );

  /// 直剃刀
  static const IconPark straightRazor = IconPark._(
    id: 2271,
    name: "straight-razor",
    title: "直剃刀",
    category: "Makeups",
    categoryCN: "化妆美妆",
    author: "齐奉飞",
    tag: ["刀"],
    rtl: true,
  );

  /// 草帽
  static const IconPark strawHat = IconPark._(
    id: 2272,
    name: "straw-hat",
    title: "草帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["帽子", "道具", "草帽"],
    rtl: true,
  );

  /// 伸展
  static const IconPark stretching = IconPark._(
    id: 2273,
    name: "stretching",
    title: "伸展",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["拉伸", "扩展", "拖大", "放大"],
    rtl: true,
  );

  /// 拉伸
  static const IconPark stretchingOne = IconPark._(
    id: 2274,
    name: "stretching-one",
    title: "拉伸",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 删除线
  static const IconPark strikethrough = IconPark._(
    id: 2275,
    name: "strikethrough",
    title: "删除线",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["删除", "线", "切断", "切割"],
    rtl: true,
  );

  /// 保险箱
  static const IconPark strongbox = IconPark._(
    id: 2276,
    name: "strongbox",
    title: "保险箱",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["保险", "箱子", "安全", "稳固"],
    rtl: false,
  );

  /// 减去下一层
  static const IconPark subtractSelection = IconPark._(
    id: 2277,
    name: "subtract-selection",
    title: "减去下一层",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["双层", "减去上层", "排除"],
    rtl: true,
  );

  /// 减去上一层
  static const IconPark subtractSelectionOne = IconPark._(
    id: 2278,
    name: "subtract-selection-one",
    title: "减去上一层",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["双层", "减去上层", "排除"],
    rtl: true,
  );

  /// 地铁
  static const IconPark subway = IconPark._(
    id: 2279,
    name: "subway",
    title: "地铁",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["交通", "火车", "运输", "货运", "电车", "公交车"],
    rtl: false,
  );

  /// 成功
  static const IconPark success = IconPark._(
    id: 2280,
    name: "success",
    title: "成功",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["完成", "成功", "勋章", "胜利", "获胜"],
    rtl: true,
  );

  /// 图片成功
  static const IconPark successPicture = IconPark._(
    id: 2281,
    name: "success-picture",
    title: "图片成功",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 合并
  static const IconPark sum = IconPark._(
    id: 2282,
    name: "sum",
    title: "合并",
    category: "Edit",
    categoryCN: "编辑",
    author: "高亚栋",
    tag: ["并集", "合集", "加选", "融合"],
    rtl: true,
  );

  /// 太阳
  static const IconPark sun = IconPark._(
    id: 2283,
    name: "sun",
    title: "太阳",
    category: "Weather",
    categoryCN: "天气",
    author: "常留留",
    tag: ["太阳", "晴朗", "阳光"],
    rtl: false,
  );

  /// 太阳帽
  static const IconPark sunHat = IconPark._(
    id: 2284,
    name: "sun-hat",
    title: "太阳帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["帽子", "道具", "服装", "连衣裙"],
    rtl: true,
  );

  /// 太阳1
  static const IconPark sunOne = IconPark._(
    id: 2285,
    name: "sun-one",
    title: "太阳1",
    category: "Weather",
    categoryCN: "天气",
    author: "常留留",
    tag: ["阳光", "太阳", "晴朗"],
    rtl: false,
  );

  /// 日光浴
  static const IconPark sunbath = IconPark._(
    id: 2286,
    name: "sunbath",
    title: "日光浴",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["休闲", "休息", "躺椅", "日光浴", "度假", "放松"],
    rtl: true,
  );

  /// 晴天
  static const IconPark sunny = IconPark._(
    id: 2287,
    name: "sunny",
    title: "晴天",
    category: "Weather",
    categoryCN: "天气",
    author: "常留留",
    tag: ["天气", "晴朗", "好心情"],
    rtl: true,
  );

  /// 日出
  static const IconPark sunrise = IconPark._(
    id: 2288,
    name: "sunrise",
    title: "日出",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["日出", "风景"],
    rtl: true,
  );

  /// 落日
  static const IconPark sunset = IconPark._(
    id: 2289,
    name: "sunset",
    title: "落日",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 遮阳篷
  static const IconPark sunshade = IconPark._(
    id: 2290,
    name: "sunshade",
    title: "遮阳篷",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["遮阳伞", "度假", "休闲"],
    rtl: true,
  );

  /// 惊讶张嘴
  static const IconPark surprisedFaceWithOpenBigMouth = IconPark._(
    id: 2291,
    name: "surprised-face-with-open-big-mouth",
    title: "惊讶张嘴",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["惊讶张嘴", "表情"],
    rtl: false,
  );

  /// 惊讶
  static const IconPark surprisedFaceWithOpenMouth = IconPark._(
    id: 2292,
    name: "surprised-face-with-open-mouth",
    title: "惊讶",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["惊讶", "表情", "目瞪口呆"],
    rtl: false,
  );

  /// 监控摄像头
  static const IconPark surveillanceCameras = IconPark._(
    id: 2293,
    name: "surveillance-cameras",
    title: "监控摄像头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["监控摄像头"],
    rtl: true,
  );

  /// 监控摄像头
  static const IconPark surveillanceCamerasOne = IconPark._(
    id: 2294,
    name: "surveillance-cameras-one",
    title: "监控摄像头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "探头", "抓拍", "偷拍"],
    rtl: true,
  );

  /// 监控摄像头
  static const IconPark surveillanceCamerasTwo = IconPark._(
    id: 2295,
    name: "surveillance-cameras-two",
    title: "监控摄像头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["监控摄像头"],
    rtl: true,
  );

  /// 燕子
  static const IconPark swallow = IconPark._(
    id: 2296,
    name: "swallow",
    title: "燕子",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["鸟", "麻雀", "小鸟", "动物", "燕子", "燕窝"],
    rtl: true,
  );

  /// 毛衣
  static const IconPark sweater = IconPark._(
    id: 2297,
    name: "sweater",
    title: "毛衣",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["毛绒", "上衣", "卫衣", "棉衣"],
    rtl: false,
  );

  /// 游泳池
  static const IconPark swimmingPool = IconPark._(
    id: 2298,
    name: "swimming-pool",
    title: "游泳池",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["水池", "游泳", "潜水", "下水", "泡水", "泡澡", "河", "水塘"],
    rtl: true,
  );

  /// 游泳圈
  static const IconPark swimmingRing = IconPark._(
    id: 2299,
    name: "swimming-ring",
    title: "游泳圈",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["救生圈", "气球", "游泳", "下水", "安全", "救生", "圈"],
    rtl: false,
  );

  /// 泳装
  static const IconPark swimsuit = IconPark._(
    id: 2300,
    name: "swimsuit",
    title: "泳装",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["游泳", "泳裤", "泳衣"],
    rtl: false,
  );

  /// 招手
  static const IconPark swing = IconPark._(
    id: 2301,
    name: "swing",
    title: "招手",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["摇手", "再见", "鼓掌", "击掌"],
    rtl: true,
  );

  /// 刷卡
  static const IconPark swipe = IconPark._(
    id: 2302,
    name: "swipe",
    title: "刷卡",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["刷卡", "支付", "识别"],
    rtl: true,
  );

  /// 切换
  static const IconPark switch_ = IconPark._(
    id: 2303,
    name: "switch",
    title: "切换",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["切换", "箭头", "左右箭头", "转换"],
    rtl: true,
  );

  /// 切换按钮
  static const IconPark switchButton = IconPark._(
    id: 2304,
    name: "switch-button",
    title: "切换按钮",
    category: "Components",
    categoryCN: "界面组件",
    author: "金磊",
    tag: ["切换按钮", "开关", "切换", "组合"],
    rtl: true,
  );

  /// 切换对比
  static const IconPark switchContrast = IconPark._(
    id: 2305,
    name: "switch-contrast",
    title: "切换对比",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["切换对比", "对称"],
    rtl: false,
  );

  /// 任天堂游戏
  static const IconPark switchNintendo = IconPark._(
    id: 2306,
    name: "switch-nintendo",
    title: "任天堂游戏",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["手柄", "控制器", "游戏机", "操作器"],
    rtl: true,
  );

  /// 开关
  static const IconPark switchOne = IconPark._(
    id: 2307,
    name: "switch-one",
    title: "开关",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["开关", "控制器", "调节器"],
    rtl: true,
  );

  /// 切换主题
  static const IconPark switchThemes = IconPark._(
    id: 2308,
    name: "switch-themes",
    title: "切换主题",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["切换", "更换", "主题", "上传文件"],
    rtl: true,
  );

  /// 切换轨道
  static const IconPark switchTrack = IconPark._(
    id: 2309,
    name: "switch-track",
    title: "切换轨道",
    category: "Operate",
    categoryCN: "美颜调整",
    author: "金磊",
    tag: ["切换轨道", "切换", "轨道", "线路"],
    rtl: true,
  );

  /// 切换完成
  static const IconPark switchingDone = IconPark._(
    id: 2310,
    name: "switching-done",
    title: "切换完成",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["更换", "完成", "对勾"],
    rtl: true,
  );

  /// 符号
  static const IconPark symbol = IconPark._(
    id: 2311,
    name: "symbol",
    title: "符号",
    category: "Character",
    categoryCN: "符号标识",
    author: "常留留",
    tag: ["标志性", "阿尔法", "符号"],
    rtl: false,
  );

  /// 双X符号
  static const IconPark symbolDoubleX = IconPark._(
    id: 2312,
    name: "symbol-double-x",
    title: "双X符号",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["双X符号", "抽象", "关闭", "道路", "十字路口"],
    rtl: false,
  );

  /// 对称
  static const IconPark symmetry = IconPark._(
    id: 2313,
    name: "symmetry",
    title: "对称",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["对称", "抽象"],
    rtl: false,
  );

  /// 同步
  static const IconPark sync = IconPark._(
    id: 2314,
    name: "sync",
    title: "同步",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["同步", "对齐", "复制", "十字"],
    rtl: true,
  );

  /// 系统
  static const IconPark system = IconPark._(
    id: 2315,
    name: "system",
    title: "系统",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["系统", "更多", "四块"],
    rtl: true,
  );

  /// T恤
  static const IconPark tShirt = IconPark._(
    id: 2316,
    name: "t-shirt",
    title: "T恤",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["衣服", "上衣", "短袖"],
    rtl: false,
  );

  /// 表格
  static const IconPark table = IconPark._(
    id: 2317,
    name: "table",
    title: "表格",
    category: "Office",
    categoryCN: "办公文档",
    author: "金磊",
    tag: ["表格", "笔记本", "纸张", "文件", "文本"],
    rtl: true,
  );

  /// 表格
  static const IconPark tableFile = IconPark._(
    id: 2318,
    name: "table-file",
    title: "表格",
    category: "Components",
    categoryCN: "界面组件",
    author: "白明泽",
    tag: ["表格", "数据", "列表"],
    rtl: false,
  );

  /// 台灯
  static const IconPark tableLamp = IconPark._(
    id: 2319,
    name: "table-lamp",
    title: "台灯",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["台灯", "灯光", "书桌", "电器", "家电"],
    rtl: true,
  );

  /// 报表
  static const IconPark tableReport = IconPark._(
    id: 2320,
    name: "table-report",
    title: "报表",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "常留留",
    tag: ["广告报表", "抽象", "文件"],
    rtl: true,
  );

  /// 乒乓球
  static const IconPark tabletennis = IconPark._(
    id: 2321,
    name: "tabletennis",
    title: "乒乓球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["乒乓球", "乒乓", "运动", "体育", "拍", "打", "扣", "球类", "球"],
    rtl: true,
  );

  /// 标签
  static const IconPark tag_ = IconPark._(
    id: 2322,
    name: "tag",
    title: "标签",
    category: "Base",
    categoryCN: "基础",
    author: "刘心乐",
    tag: ["标记", "便签", "标签", "不关注", "取消订阅"],
    rtl: false,
  );

  /// 标签
  static const IconPark tagOne = IconPark._(
    id: 2323,
    name: "tag-one",
    title: "标签",
    category: "Base",
    categoryCN: "基础",
    author: "刘心乐",
    tag: ["便签", "折扣", "标记", "价签"],
    rtl: true,
  );

  /// 裁剪
  static const IconPark tailoring = IconPark._(
    id: 2324,
    name: "tailoring",
    title: "裁剪",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["裁切", "编辑", "裁剪放大"],
    rtl: true,
  );

  /// 裁剪放大
  static const IconPark tailoringTwo = IconPark._(
    id: 2325,
    name: "tailoring-two",
    title: "裁剪放大",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["裁切", "编辑", "裁剪放大"],
    rtl: true,
  );

  /// 泰姬陵
  static const IconPark tajMahal = IconPark._(
    id: 2326,
    name: "taj-mahal",
    title: "泰姬陵",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "寺庙", "教堂", "办公楼"],
    rtl: false,
  );

  /// 飞机起飞
  static const IconPark takeOff = IconPark._(
    id: 2327,
    name: "take-off",
    title: "飞机起飞",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["飞行", "起飞", "航空", "航空航天", "飞机"],
    rtl: true,
  );

  /// 起飞
  static const IconPark takeOffOne = IconPark._(
    id: 2328,
    name: "take-off-one",
    title: "起飞",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 淘宝
  static const IconPark taobao = IconPark._(
    id: 2329,
    name: "taobao",
    title: "淘宝",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["阿里巴巴", "电商", "购物", "手机购物", "淘宝", "logo"],
    rtl: true,
  );

  /// 磁带
  static const IconPark tape = IconPark._(
    id: 2330,
    name: "tape",
    title: "磁带",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "齐奉飞",
    tag: ["磁带", "音乐", "复古", "收音机、"],
    rtl: false,
  );

  /// 卷尺
  static const IconPark tapeMeasure = IconPark._(
    id: 2331,
    name: "tape-measure",
    title: "卷尺",
    category: "Industry",
    categoryCN: "工业",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 靶子
  static const IconPark target = IconPark._(
    id: 2332,
    name: "target",
    title: "靶子",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["射击", "攻击", "目标"],
    rtl: true,
  );

  /// 靶标
  static const IconPark targetOne = IconPark._(
    id: 2333,
    name: "target-one",
    title: "靶标",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["射击", "打靶", "训练", "射", "精准", "射箭", "比赛", "标靶", "准确", "枪战"],
    rtl: false,
  );

  /// 枪靶
  static const IconPark targetTwo = IconPark._(
    id: 2334,
    name: "target-two",
    title: "枪靶",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["射击", "打靶", "训练", "射", "精准", "射箭", "比赛", "标靶", "准确", "枪战", "扫描"],
    rtl: false,
  );

  /// 金牛座
  static const IconPark taurus = IconPark._(
    id: 2335,
    name: "taurus",
    title: "金牛座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 出租车
  static const IconPark taxi = IconPark._(
    id: 2336,
    name: "taxi",
    title: "出租车",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "白明泽",
    tag: ["出租车", "出行", "交通", "汽车", "付费"],
    rtl: false,
  );

  /// 茶
  static const IconPark tea = IconPark._(
    id: 2337,
    name: "tea",
    title: "茶",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["饮料", "茶饮", "热水", "咖啡", "热牛奶"],
    rtl: true,
  );

  /// 喝茶
  static const IconPark teaDrink = IconPark._(
    id: 2338,
    name: "tea-drink",
    title: "喝茶",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["喝茶", "饮料", "餐饮", "下午茶", "咖啡", "热饮"],
    rtl: true,
  );

  /// 茶壶
  static const IconPark teapot = IconPark._(
    id: 2339,
    name: "teapot",
    title: "茶壶",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["茶壶", "水壶", "热水壶", "泡茶"],
    rtl: true,
  );

  /// 牙齿
  static const IconPark teeth = IconPark._(
    id: 2340,
    name: "teeth",
    title: "牙齿",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["口腔", "齿科", "牙齿", "医疗"],
    rtl: true,
  );

  /// Telegram
  static const IconPark telegram = IconPark._(
    id: 2341,
    name: "telegram",
    title: "Telegram",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["飞机", "logo", "通信软件", "聊天", "社交"],
    rtl: true,
  );

  /// 望远镜
  static const IconPark telescope = IconPark._(
    id: 2342,
    name: "telescope",
    title: "望远镜",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["望远镜", "侦查", "观察", "监视", "工具"],
    rtl: false,
  );

  /// QQ
  static const IconPark tencentQq = IconPark._(
    id: 2343,
    name: "tencent-qq",
    title: "QQ",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["企鹅", "logo", "qq", "通信软件", "聊天", "社交"],
    rtl: true,
  );

  /// 网球
  static const IconPark tennis = IconPark._(
    id: 2344,
    name: "tennis",
    title: "网球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "常留留",
    tag: ["运动", "球", "网球"],
    rtl: true,
  );

  /// 帐篷
  static const IconPark tent = IconPark._(
    id: 2345,
    name: "tent",
    title: "帐篷",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["帐篷", "户外", "露营", "居住", "家"],
    rtl: true,
  );

  /// 帐篷旗帜
  static const IconPark tentBanner = IconPark._(
    id: 2346,
    name: "tent-banner",
    title: "帐篷旗帜",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["帐篷", "户外", "露营", "居住", "家"],
    rtl: true,
  );

  /// 终端
  static const IconPark terminal = IconPark._(
    id: 2347,
    name: "terminal",
    title: "终端",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["技术", "终端", "命令行", "代码框", "程序"],
    rtl: true,
  );

  /// 终止文件
  static const IconPark terminationFile = IconPark._(
    id: 2348,
    name: "termination-file",
    title: "终止文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["无效", "失效", "禁用"],
    rtl: true,
  );

  /// 阳台
  static const IconPark terrace = IconPark._(
    id: 2349,
    name: "terrace",
    title: "阳台",
    category: "Life",
    categoryCN: "生活",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 试管
  static const IconPark testTube = IconPark._(
    id: 2350,
    name: "test-tube",
    title: "试管",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "金磊",
    tag: ["试管", "试验", "化学", "科学", "容器"],
    rtl: false,
  );

  /// 文字
  static const IconPark text = IconPark._(
    id: 2351,
    name: "text",
    title: "文字",
    category: "Edit",
    categoryCN: "编辑",
    author: "白明泽",
    tag: ["文字", "输入", "文本", "文案"],
    rtl: true,
  );

  /// 文字加粗
  static const IconPark textBold = IconPark._(
    id: 2352,
    name: "text-bold",
    title: "文字加粗",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["文字加粗"],
    rtl: true,
  );

  /// 文字斜体
  static const IconPark textItalic = IconPark._(
    id: 2353,
    name: "text-italic",
    title: "文字斜体",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["文字倾斜", "斜体"],
    rtl: true,
  );

  /// 文字讯息
  static const IconPark textMessage = IconPark._(
    id: 2354,
    name: "text-message",
    title: "文字讯息",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["音讯", "消息", "文字", "资讯"],
    rtl: true,
  );

  /// 文字识别
  static const IconPark textRecognition = IconPark._(
    id: 2355,
    name: "text-recognition",
    title: "文字识别",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["识别", "文字", "字体"],
    rtl: false,
  );

  /// 文本旋转-下
  static const IconPark textRotationDown = IconPark._(
    id: 2356,
    name: "text-rotation-down",
    title: "文本旋转-下",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["文本", "编辑", "文字", "旋转", "向下"],
    rtl: true,
  );

  /// 文本旋转-左
  static const IconPark textRotationLeft = IconPark._(
    id: 2357,
    name: "text-rotation-left",
    title: "文本旋转-左",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["文本", "编辑", "文字", "旋转", "向左"],
    rtl: true,
  );

  /// 文本旋转-无
  static const IconPark textRotationNone = IconPark._(
    id: 2358,
    name: "text-rotation-none",
    title: "文本旋转-无",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["文本", "编辑", "文字", "旋转", "向右"],
    rtl: true,
  );

  /// 文本旋转-上
  static const IconPark textRotationUp = IconPark._(
    id: 2359,
    name: "text-rotation-up",
    title: "文本旋转-上",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["文本", "编辑", "文字", "旋转", "向上"],
    rtl: true,
  );

  /// 文本样式
  static const IconPark textStyle = IconPark._(
    id: 2360,
    name: "text-style",
    title: "文本样式",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["文字样式", "文本放大", "选中文字"],
    rtl: false,
  );

  /// 文本样式
  static const IconPark textStyleOne = IconPark._(
    id: 2361,
    name: "text-style-one",
    title: "文本样式",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["文本", "编辑", "文字", "样式", "属性"],
    rtl: true,
  );

  /// 文字下划线
  static const IconPark textUnderline = IconPark._(
    id: 2362,
    name: "text-underline",
    title: "文字下划线",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["下划线", "文字"],
    rtl: true,
  );

  /// 文本换行-溢出
  static const IconPark textWrapOverflow = IconPark._(
    id: 2363,
    name: "text-wrap-overflow",
    title: "文本换行-溢出",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["超出", "溢出", "文本", "换行", "折行"],
    rtl: true,
  );

  /// 文本换行-截断
  static const IconPark textWrapTruncation = IconPark._(
    id: 2364,
    name: "text-wrap-truncation",
    title: "文本换行-截断",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["截断", "省略", "文本省略", "换行"],
    rtl: true,
  );

  /// 文字域
  static const IconPark textarea = IconPark._(
    id: 2365,
    name: "textarea",
    title: "文字域",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["文字"],
    rtl: false,
  );

  /// 纹理
  static const IconPark texture = IconPark._(
    id: 2366,
    name: "texture",
    title: "纹理",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["纹理", "面积", "阴影"],
    rtl: true,
  );

  /// 纹理
  static const IconPark textureTwo = IconPark._(
    id: 2367,
    name: "texture-two",
    title: "纹理",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["纹理", "底图", "图案", "抽象"],
    rtl: true,
  );

  /// 单肩包
  static const IconPark theSingleShoulderBag = IconPark._(
    id: 2368,
    name: "the-single-shoulder-bag",
    title: "单肩包",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["单肩包", "挎包", "小包"],
    rtl: false,
  );

  /// 影院
  static const IconPark theater = IconPark._(
    id: 2369,
    name: "theater",
    title: "影院",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "常留留",
    tag: ["看电影", "幕布", "电影", "IMAX"],
    rtl: false,
  );

  /// 主题
  static const IconPark theme = IconPark._(
    id: 2370,
    name: "theme",
    title: "主题",
    category: "Clothes",
    categoryCN: "服饰",
    author: "白明泽",
    tag: ["主题", "衣服", "服装"],
    rtl: false,
  );

  /// 温度计
  static const IconPark thermometer = IconPark._(
    id: 2371,
    name: "thermometer",
    title: "温度计",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "齐奉飞",
    tag: ["温度计", "测量", "体温", "冷热"],
    rtl: false,
  );

  /// 温度计1
  static const IconPark thermometerOne = IconPark._(
    id: 2372,
    name: "thermometer-one",
    title: "温度计1",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 保温杯
  static const IconPark thermosCup = IconPark._(
    id: 2373,
    name: "thermos-cup",
    title: "保温杯",
    category: "Foods",
    categoryCN: "食品",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 瘦身
  static const IconPark thin = IconPark._(
    id: 2374,
    name: "thin",
    title: "瘦身",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["胸", "身材", "瘦", "女人", "妩媚", "性感"],
    rtl: false,
  );

  /// 思考问题
  static const IconPark thinkingProblem = IconPark._(
    id: 2375,
    name: "thinking-problem",
    title: "思考问题",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["思考问题"],
    rtl: true,
  );

  /// 三
  static const IconPark three = IconPark._(
    id: 2376,
    name: "three",
    title: "三",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["三", "手指", "手势"],
    rtl: true,
  );

  /// 3D眼镜
  static const IconPark threeDGlasses = IconPark._(
    id: 2377,
    name: "three-d-glasses",
    title: "3D眼镜",
    category: "Clothes",
    categoryCN: "服饰",
    author: "常留留",
    tag: ["眼镜", "三维立体", "3d", "三维"],
    rtl: false,
  );

  /// 三个菱形
  static const IconPark threeHexagons = IconPark._(
    id: 2378,
    name: "three-hexagons",
    title: "三个菱形",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["三个菱形", "形状拼接", "组合"],
    rtl: false,
  );

  /// 按键三
  static const IconPark threeKey = IconPark._(
    id: 2379,
    name: "three-key",
    title: "按键三",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["三", "3", "按键"],
    rtl: true,
  );

  /// 三斜杠
  static const IconPark threeSlashes = IconPark._(
    id: 2380,
    name: "three-slashes",
    title: "三斜杠",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["三斜杠", "标志", "平行"],
    rtl: true,
  );

  /// 三
  static const IconPark threeThree = IconPark._(
    id: 2381,
    name: "three-three",
    title: "三",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["三", "手指", "手势"],
    rtl: true,
  );

  /// 三个三角
  static const IconPark threeTriangles = IconPark._(
    id: 2382,
    name: "three-triangles",
    title: "三个三角",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["三个三角", "三角拼接", "组合"],
    rtl: false,
  );

  /// 踩
  static const IconPark thumbsDown = IconPark._(
    id: 2383,
    name: "thumbs-down",
    title: "踩",
    category: "Hands",
    categoryCN: "手势动作",
    author: "刘心乐",
    tag: ["差评", "不赞", "错误"],
    rtl: true,
  );

  /// 赞
  static const IconPark thumbsUp = IconPark._(
    id: 2384,
    name: "thumbs-up",
    title: "赞",
    category: "Hands",
    categoryCN: "手势动作",
    author: "刘心乐",
    tag: ["好评", "点赞", "优秀"],
    rtl: true,
  );

  /// 霹雳接口
  static const IconPark thunderbolt = IconPark._(
    id: 2385,
    name: "thunderbolt",
    title: "霹雳接口",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "数据线", "闪电传输"],
    rtl: true,
  );

  /// 雷雨
  static const IconPark thunderstorm = IconPark._(
    id: 2386,
    name: "thunderstorm",
    title: "雷雨",
    category: "Weather",
    categoryCN: "天气",
    author: "齐奉飞",
    tag: ["雷雨", "打雷", "闪电", "下雨"],
    rtl: true,
  );

  /// 雷雨
  static const IconPark thunderstormOne = IconPark._(
    id: 2387,
    name: "thunderstorm-one",
    title: "雷雨",
    category: "Weather",
    categoryCN: "天气",
    author: "齐奉飞",
    tag: ["雷雨", "打雷", "闪电", "下雨"],
    rtl: true,
  );

  /// 券
  static const IconPark ticket = IconPark._(
    id: 2388,
    name: "ticket",
    title: "券",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["饭票", "电影票", "活动票", "门票", "优惠券"],
    rtl: true,
  );

  /// 票
  static const IconPark ticketOne = IconPark._(
    id: 2389,
    name: "ticket-one",
    title: "票",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["饭票", "电影票", "活动票", "门票", "优惠券"],
    rtl: true,
  );

  /// 票务检查
  static const IconPark ticketsChecked = IconPark._(
    id: 2390,
    name: "tickets-checked",
    title: "票务检查",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["检票", "值机", "票务", "票", "票据", "开票"],
    rtl: true,
  );

  /// 门票
  static const IconPark ticketsOne = IconPark._(
    id: 2391,
    name: "tickets-one",
    title: "门票",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["检票", "值机", "票务", "票", "票据", "机票", "票夹"],
    rtl: true,
  );

  /// 门票
  static const IconPark ticketsTwo = IconPark._(
    id: 2392,
    name: "tickets-two",
    title: "门票",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["检票", "值机", "票务", "票", "票据", "机票", "发票", "收据"],
    rtl: true,
  );

  /// 生肖虎
  static const IconPark tigerZodiac = IconPark._(
    id: 2393,
    name: "tiger-zodiac",
    title: "生肖虎",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 抖音
  static const IconPark tiktok = IconPark._(
    id: 2394,
    name: "tiktok",
    title: "抖音",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["抖音", "短视频", "小视频", "TikTok", "logo", "字节跳动"],
    rtl: true,
  );

  /// 时间
  static const IconPark time = IconPark._(
    id: 2395,
    name: "time",
    title: "时间",
    category: "Time",
    categoryCN: "时间日期",
    author: "齐奉飞",
    tag: ["钟表", "时间", "倒计时"],
    rtl: true,
  );

  /// 定时发送
  static const IconPark timedMail = IconPark._(
    id: 2396,
    name: "timed-mail",
    title: "定时发送",
    category: "Office",
    categoryCN: "办公文档",
    author: "齐奉飞",
    tag: ["邮件", "信件", "文件夹", "定时转发"],
    rtl: true,
  );

  /// 时间线
  static const IconPark timeline = IconPark._(
    id: 2397,
    name: "timeline",
    title: "时间线",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["时间线", "分析", "图表"],
    rtl: true,
  );

  /// 计时器
  static const IconPark timer = IconPark._(
    id: 2398,
    name: "timer",
    title: "计时器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["计时器", "手表", "时间", "智能手表", "机械表"],
    rtl: true,
  );

  /// 提示
  static const IconPark tips = IconPark._(
    id: 2399,
    name: "tips",
    title: "提示",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["灯泡", "创意", "灯光", "灵感"],
    rtl: false,
  );

  /// 提示
  static const IconPark tipsOne = IconPark._(
    id: 2400,
    name: "tips-one",
    title: "提示",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "常留留",
    tag: ["信息提示", "提示", "警示", "报错", "提示信息", "message"],
    rtl: true,
  );

  /// 溜溜球
  static const IconPark tireSwing = IconPark._(
    id: 2401,
    name: "tire-swing",
    title: "溜溜球",
    category: "Baby",
    categoryCN: "母婴儿童",
    author: "齐奉飞",
    tag: ["球", "旋转", "吊球"],
    rtl: true,
  );

  /// 标题级别
  static const IconPark titleLevel = IconPark._(
    id: 2402,
    name: "title-level",
    title: "标题级别",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["字号", "级别", "文字尺寸", "文字大小"],
    rtl: true,
  );

  /// 去底部
  static const IconPark toBottom = IconPark._(
    id: 2403,
    name: "to-bottom",
    title: "去底部",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["下", "底部", "下载", "箭头"],
    rtl: false,
  );

  /// 去底部1
  static const IconPark toBottomOne = IconPark._(
    id: 2404,
    name: "to-bottom-one",
    title: "去底部1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "下", "底部"],
    rtl: false,
  );

  /// 去左侧
  static const IconPark toLeft = IconPark._(
    id: 2405,
    name: "to-left",
    title: "去左侧",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "左"],
    rtl: true,
  );

  /// 去右侧
  static const IconPark toRight = IconPark._(
    id: 2406,
    name: "to-right",
    title: "去右侧",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "右"],
    rtl: true,
  );

  /// 去顶部
  static const IconPark toTop = IconPark._(
    id: 2407,
    name: "to-top",
    title: "去顶部",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["上", "顶部", "上传", "箭头"],
    rtl: false,
  );

  /// 去顶部1
  static const IconPark toTopOne = IconPark._(
    id: 2408,
    name: "to-top-one",
    title: "去顶部1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "上", "顶部"],
    rtl: false,
  );

  /// 马桶
  static const IconPark toilet = IconPark._(
    id: 2409,
    name: "toilet",
    title: "马桶",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["卫生间", "公共厕所"],
    rtl: false,
  );

  /// 番茄
  static const IconPark tomato = IconPark._(
    id: 2410,
    name: "tomato",
    title: "番茄",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水果", "蔬菜", "西红柿"],
    rtl: false,
  );

  /// 工具
  static const IconPark tool = IconPark._(
    id: 2411,
    name: "tool",
    title: "工具",
    category: "Base",
    categoryCN: "基础",
    author: "白明泽",
    tag: ["优化", "扳手", "设置", "工具", "维修"],
    rtl: true,
  );

  /// 工具箱
  static const IconPark toolkit = IconPark._(
    id: 2412,
    name: "toolkit",
    title: "工具箱",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 顶栏
  static const IconPark topBar = IconPark._(
    id: 2413,
    name: "top-bar",
    title: "顶栏",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["布局", "排版", "上"],
    rtl: false,
  );

  /// topbuzz
  static const IconPark topbuzz = IconPark._(
    id: 2414,
    name: "topbuzz",
    title: "topbuzz",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["短视频", "小视频", "Topbuzz", "logo", "字体", "字节跳动"],
    rtl: true,
  );

  /// 话题
  static const IconPark topic = IconPark._(
    id: 2415,
    name: "topic",
    title: "话题",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "常留留",
    tag: ["话题", "辩论", "讨论", "提示", "气泡"],
    rtl: true,
  );

  /// 话题讨论
  static const IconPark topicDiscussion = IconPark._(
    id: 2416,
    name: "topic-discussion",
    title: "话题讨论",
    category: "Communicate",
    categoryCN: "交流沟通",
    author: "金磊",
    tag: ["话题讨论", "提示气泡"],
    rtl: true,
  );

  /// 火炬
  static const IconPark torch = IconPark._(
    id: 2417,
    name: "torch",
    title: "火炬",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["奥运会", "火炬", "火", "传递", "点燃", "燃烧", "火焰", "火把", "照明", "圣火", "生火"],
    rtl: true,
  );

  /// 旅游巴士
  static const IconPark tourBus = IconPark._(
    id: 2418,
    name: "tour-bus",
    title: "旅游巴士",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["陆运", "巴士", "公交", "公交车", "大巴车", "旅行巴士", "旅游巴士"],
    rtl: true,
  );

  /// 毛巾
  static const IconPark towel = IconPark._(
    id: 2419,
    name: "towel",
    title: "毛巾",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["布", "布料", "浴巾", "毛巾", "手绢", "生活用品", "软", "擦", "洗"],
    rtl: true,
  );

  /// 塔楼
  static const IconPark tower = IconPark._(
    id: 2420,
    name: "tower",
    title: "塔楼",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "寺庙", "教堂", "办公楼"],
    rtl: false,
  );

  /// 风笛塔
  static const IconPark towerOfBabel = IconPark._(
    id: 2421,
    name: "tower-of-babel",
    title: "风笛塔",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "寺庙", "教堂", "办公楼"],
    rtl: true,
  );

  /// 比萨斜塔
  static const IconPark towerOfPisa = IconPark._(
    id: 2422,
    name: "tower-of-pisa",
    title: "比萨斜塔",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["城楼", "阁楼", "寺庙", "教堂", "办公楼"],
    rtl: true,
  );

  /// 毒素
  static const IconPark toxins = IconPark._(
    id: 2423,
    name: "toxins",
    title: "毒素",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["有毒害", "有害气体", "恐怖", "有害", "骷髅"],
    rtl: true,
  );

  /// 追踪
  static const IconPark trace = IconPark._(
    id: 2424,
    name: "trace",
    title: "追踪",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["追踪", "查探", "目标", "命中"],
    rtl: true,
  );

  /// 商标符号
  static const IconPark trademark = IconPark._(
    id: 2425,
    name: "trademark",
    title: "商标符号",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["商标符号", "标志"],
    rtl: true,
  );

  /// 中药
  static const IconPark traditionalChineseMedicine = IconPark._(
    id: 2426,
    name: "traditional-chinese-medicine",
    title: "中药",
    category: "Health",
    categoryCN: "医疗健康",
    author: "齐奉飞",
    tag: ["中国", "药材", "中药", "饭", "碗"],
    rtl: true,
  );

  /// 火车
  static const IconPark train = IconPark._(
    id: 2427,
    name: "train",
    title: "火车",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 成交
  static const IconPark transaction = IconPark._(
    id: 2428,
    name: "transaction",
    title: "成交",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["成交单"],
    rtl: true,
  );

  /// 交易清单
  static const IconPark transactionOrder = IconPark._(
    id: 2429,
    name: "transaction-order",
    title: "交易清单",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["交易列表"],
    rtl: true,
  );

  /// 转机
  static const IconPark transfer = IconPark._(
    id: 2430,
    name: "transfer",
    title: "转机",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["转机", "换乘", "移动"],
    rtl: true,
  );

  /// 双向数据互传
  static const IconPark transferData = IconPark._(
    id: 2431,
    name: "transfer-data",
    title: "双向数据互传",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["传输", "传送", "传出", "传入", "互传", "线"],
    rtl: true,
  );

  /// 转变
  static const IconPark transform = IconPark._(
    id: 2432,
    name: "transform",
    title: "转变",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["转化", "连接", "旋转", "回旋", "回传"],
    rtl: true,
  );

  /// 翻译
  static const IconPark translate = IconPark._(
    id: 2433,
    name: "translate",
    title: "翻译",
    category: "Base",
    categoryCN: "基础",
    author: "金磊",
    tag: ["翻译", "多语言", "国际化", "中文", "英文"],
    rtl: true,
  );

  /// 翻译
  static const IconPark translation = IconPark._(
    id: 2434,
    name: "translation",
    title: "翻译",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["文本编辑", "文字旋转", "翻译", "转码"],
    rtl: true,
  );

  /// 运送车
  static const IconPark transport = IconPark._(
    id: 2435,
    name: "transport",
    title: "运送车",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "张文珠",
    tag: ["行李运输", "运送", "运送车", "搬运", "托运"],
    rtl: true,
  );

  /// 送货车
  static const IconPark transporter = IconPark._(
    id: 2436,
    name: "transporter",
    title: "送货车",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["快递车", "运输车"],
    rtl: true,
  );

  /// 梯形
  static const IconPark trapezoid = IconPark._(
    id: 2437,
    name: "trapezoid",
    title: "梯形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 托盘
  static const IconPark tray = IconPark._(
    id: 2438,
    name: "tray",
    title: "托盘",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["托盘", "盘子", "厨具"],
    rtl: true,
  );

  /// 跑步机
  static const IconPark treadmill = IconPark._(
    id: 2439,
    name: "treadmill",
    title: "跑步机",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["跑步", "器材", "工具", "跑", "智能", "电子", "设备"],
    rtl: true,
  );

  /// 跑步机1
  static const IconPark treadmillOne = IconPark._(
    id: 2440,
    name: "treadmill-one",
    title: "跑步机1",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["跑步", "运动", "体育", "跑", "慢跑", "健身", "减脂", "瘦身", "训练"],
    rtl: true,
  );

  /// 跑步机
  static const IconPark treadmillTwo = IconPark._(
    id: 2441,
    name: "treadmill-two",
    title: "跑步机",
    category: "Sports",
    categoryCN: "体育运动",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 宝箱
  static const IconPark treasureChest = IconPark._(
    id: 2442,
    name: "treasure-chest",
    title: "宝箱",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["宝箱", "箱子", "宝贝", "工具箱"],
    rtl: false,
  );

  /// 树
  static const IconPark tree = IconPark._(
    id: 2443,
    name: "tree",
    title: "树",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["节能", "环保", "新能源", "植物", "树木"],
    rtl: true,
  );

  /// 树状图
  static const IconPark treeDiagram = IconPark._(
    id: 2444,
    name: "tree-diagram",
    title: "树状图",
    category: "Connect",
    categoryCN: "链接",
    author: "张蔓",
    tag: ["整理", "树状图", "散发", "分支", "结构"],
    rtl: true,
  );

  /// 树结构
  static const IconPark treeList = IconPark._(
    id: 2445,
    name: "tree-list",
    title: "树结构",
    category: "Components",
    categoryCN: "界面组件",
    author: "金磊",
    tag: ["树结构", "结构", "树", "序列", "排序"],
    rtl: true,
  );

  /// 树1
  static const IconPark treeOne = IconPark._(
    id: 2446,
    name: "tree-one",
    title: "树1",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 树
  static const IconPark treeTwo = IconPark._(
    id: 2447,
    name: "tree-two",
    title: "树",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "杨威",
    tag: ["节能", "环保", "新能源", "植物", "树木"],
    rtl: false,
  );

  /// 趋势
  static const IconPark trend = IconPark._(
    id: 2448,
    name: "trend",
    title: "趋势",
    category: "Money",
    categoryCN: "电商财产",
    author: "白明泽",
    tag: ["上升", "升高", "上调", "调高", "涨幅"],
    rtl: true,
  );

  /// 趋势
  static const IconPark trendTwo = IconPark._(
    id: 2449,
    name: "trend-two",
    title: "趋势",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["趋势", "数据", "涨幅", "增长"],
    rtl: true,
  );

  /// 趋势下降
  static const IconPark trendingDown = IconPark._(
    id: 2450,
    name: "trending-down",
    title: "趋势下降",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["下降", "向下", "降低", "下跌", "趋势"],
    rtl: true,
  );

  /// 趋势上升
  static const IconPark trendingUp = IconPark._(
    id: 2451,
    name: "trending-up",
    title: "趋势上升",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["上升", "向上", "提升", "趋势", "箭头"],
    rtl: true,
  );

  /// 三角形
  static const IconPark triangle = IconPark._(
    id: 2452,
    name: "triangle",
    title: "三角形",
    category: "Graphics",
    categoryCN: "几何图形",
    author: "齐奉飞",
    tag: [],
    rtl: false,
  );

  /// 三角圆矩形
  static const IconPark triangleRoundRectangle = IconPark._(
    id: 2453,
    name: "triangle-round-rectangle",
    title: "三角圆矩形",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["三角圆矩形", "形状拼接"],
    rtl: true,
  );

  /// 三角尺
  static const IconPark triangleRuler = IconPark._(
    id: 2454,
    name: "triangle-ruler",
    title: "三角尺",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "金磊",
    tag: ["三角尺", "长度", "测量", "刻度"],
    rtl: true,
  );

  /// 三棱锥
  static const IconPark triangularPyramid = IconPark._(
    id: 2455,
    name: "triangular-pyramid",
    title: "三棱锥",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["三棱锥", "容器"],
    rtl: false,
  );

  /// 奖杯
  static const IconPark trophy = IconPark._(
    id: 2456,
    name: "trophy",
    title: "奖杯",
    category: "Game",
    categoryCN: "游戏",
    author: "白明泽",
    tag: ["奖杯", "冠军", "比赛", "胜利", "奖励", "荣誉"],
    rtl: false,
  );

  /// 喇叭裤
  static const IconPark trousersBellBottoms = IconPark._(
    id: 2457,
    name: "trousers-bell-bottoms",
    title: "喇叭裤",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["裤子", "长裤", "7分裤", "九分裤", "阔腿裤"],
    rtl: false,
  );

  /// 货车
  static const IconPark truck = IconPark._(
    id: 2458,
    name: "truck",
    title: "货车",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["出行", "货车", "卡车", "皮卡", "硬件", "汽车", "设备", "交通", "运输"],
    rtl: true,
  );

  /// 喇叭
  static const IconPark trumpet = IconPark._(
    id: 2459,
    name: "trumpet",
    title: "喇叭",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["声音", "音乐", "乐器", "扩音器", "喇叭"],
    rtl: true,
  );

  /// 行李箱
  static const IconPark trunk = IconPark._(
    id: 2460,
    name: "trunk",
    title: "行李箱",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["行李", "箱子", "皮箱"],
    rtl: false,
  );

  /// 浴缸
  static const IconPark tub = IconPark._(
    id: 2461,
    name: "tub",
    title: "浴缸",
    category: "Life",
    categoryCN: "生活",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 图虫
  static const IconPark tuchong = IconPark._(
    id: 2462,
    name: "tuchong",
    title: "图虫",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["图片", "创意", "摄影", "logo"],
    rtl: true,
  );

  /// tumblr
  static const IconPark tumblr = IconPark._(
    id: 2463,
    name: "tumblr",
    title: "tumblr",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["图片", "动态", "社交", "logo", "tumblr"],
    rtl: true,
  );

  /// 火鸡
  static const IconPark turkey = IconPark._(
    id: 2464,
    name: "turkey",
    title: "火鸡",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["鸡肉", "鸡腿", "烧鸡", "餐饮", "美食"],
    rtl: true,
  );

  /// 人员调动
  static const IconPark turnAround = IconPark._(
    id: 2465,
    name: "turn-around",
    title: "人员调动",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "齐奉飞",
    tag: [],
    rtl: true,
  );

  /// 关闭蓝牙
  static const IconPark turnOffBluetooth = IconPark._(
    id: 2466,
    name: "turn-off-bluetooth",
    title: "关闭蓝牙",
    category: "Others",
    categoryCN: "其它",
    author: "常留留",
    tag: ["蓝牙", "设备", "无线连接", "关闭蓝牙"],
    rtl: true,
  );

  /// 打开
  static const IconPark turnOn = IconPark._(
    id: 2467,
    name: "turn-on",
    title: "打开",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["按动", "点击", "触发", "触动", "轻点"],
    rtl: true,
  );

  /// 电视
  static const IconPark tv = IconPark._(
    id: 2468,
    name: "tv",
    title: "电视",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["电视", "设备", "综艺", "屏幕", "大屏", "硬件"],
    rtl: true,
  );

  /// 电视
  static const IconPark tvOne = IconPark._(
    id: 2469,
    name: "tv-one",
    title: "电视",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["显示屏", "电影", "投影", "节目", "音乐"],
    rtl: true,
  );

  /// 推特
  static const IconPark twitter = IconPark._(
    id: 2470,
    name: "twitter",
    title: "推特",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["小视频", "短视频", "logo", "新闻", "国际社交", "社交平台"],
    rtl: true,
  );

  /// 二
  static const IconPark two = IconPark._(
    id: 2471,
    name: "two",
    title: "二",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["二", "手指", "胜利"],
    rtl: true,
  );

  /// 二维码
  static const IconPark twoDimensionalCode = IconPark._(
    id: 2472,
    name: "two-dimensional-code",
    title: "二维码",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["扫描", "扫码", "扫一扫", "登录", "付款码", "付款方式"],
    rtl: true,
  );

  /// 二维码
  static const IconPark twoDimensionalCodeOne = IconPark._(
    id: 2473,
    name: "two-dimensional-code-one",
    title: "二维码",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["扫描", "扫码", "扫一扫", "登录", "付款码", "付款方式"],
    rtl: true,
  );

  /// 二维码
  static const IconPark twoDimensionalCodeTwo = IconPark._(
    id: 2474,
    name: "two-dimensional-code-two",
    title: "二维码",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["扫描", "扫码", "扫一扫", "登录", "付款码", "付款方式"],
    rtl: true,
  );

  /// 两个椭圆
  static const IconPark twoEllipses = IconPark._(
    id: 2475,
    name: "two-ellipses",
    title: "两个椭圆",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["两个椭圆", "交叉", "几何", "环绕"],
    rtl: false,
  );

  /// 两个手指
  static const IconPark twoFingers = IconPark._(
    id: 2476,
    name: "two-fingers",
    title: "两个手指",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["手指", "手势"],
    rtl: true,
  );

  /// 两只手
  static const IconPark twoHands = IconPark._(
    id: 2477,
    name: "two-hands",
    title: "两只手",
    category: "Hands",
    categoryCN: "手势动作",
    author: "常留留",
    tag: ["手势", "手", "呵护", "保护"],
    rtl: true,
  );

  /// 按键二
  static const IconPark twoKey = IconPark._(
    id: 2478,
    name: "two-key",
    title: "按键二",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["二", "2", "按键"],
    rtl: true,
  );

  /// 双半圆
  static const IconPark twoSemicircles = IconPark._(
    id: 2479,
    name: "two-semicircles",
    title: "双半圆",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["双半圆", "抽象", "蘑菇"],
    rtl: false,
  );

  /// 星星
  static const IconPark twoTriangles = IconPark._(
    id: 2480,
    name: "two-triangles",
    title: "星星",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["星星", "太阳", "标记", "六星"],
    rtl: false,
  );

  /// 两个三角
  static const IconPark twoTrianglesTwo = IconPark._(
    id: 2481,
    name: "two-triangles-two",
    title: "两个三角",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["两个三角", "形状拼接"],
    rtl: false,
  );

  /// 二
  static const IconPark twoTwo = IconPark._(
    id: 2482,
    name: "two-two",
    title: "二",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["二", "手指", "手势"],
    rtl: true,
  );

  /// 磁带
  static const IconPark typeDrive = IconPark._(
    id: 2483,
    name: "type-drive",
    title: "磁带",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["音乐"],
    rtl: false,
  );

  /// U盘
  static const IconPark uDisk = IconPark._(
    id: 2484,
    name: "u-disk",
    title: "U盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["U盘", "硬盘", "储存", "硬件", "移动", "保存", "文件", "安全"],
    rtl: true,
  );

  /// 上回转
  static const IconPark uTurnDown = IconPark._(
    id: 2485,
    name: "u-turn-down",
    title: "上回转",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["转向", "回转", "返回", "上回转"],
    rtl: true,
  );

  /// 右回转
  static const IconPark uTurnLeft = IconPark._(
    id: 2486,
    name: "u-turn-left",
    title: "右回转",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["转向", "回转", "返回", "右回转"],
    rtl: true,
  );

  /// 左回转
  static const IconPark uTurnRight = IconPark._(
    id: 2487,
    name: "u-turn-right",
    title: "左回转",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["转向", "回转", "返回", "左回转"],
    rtl: true,
  );

  /// 下回转
  static const IconPark uTurnUp = IconPark._(
    id: 2488,
    name: "u-turn-up",
    title: "下回转",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["下回转", "转向", "回转", "返回"],
    rtl: true,
  );

  /// 轻颜相机
  static const IconPark ulikecam = IconPark._(
    id: 2489,
    name: "ulikecam",
    title: "轻颜相机",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["相机", "图片", "美颜", "化妆", "logo"],
    rtl: true,
  );

  /// 雨伞
  static const IconPark umbrella = IconPark._(
    id: 2490,
    name: "umbrella",
    title: "雨伞",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "常留留",
    tag: ["雨伞", "保护", "下雨", "庇护", "防护", "安全", "天气", "护盾"],
    rtl: true,
  );

  /// 雨伞
  static const IconPark umbrellaOne = IconPark._(
    id: 2491,
    name: "umbrella-one",
    title: "雨伞",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "常留留",
    tag: ["雨伞", "保护", "下雨", "庇护", "防护", "安全", "天气", "护盾"],
    rtl: true,
  );

  /// 雨伞
  static const IconPark umbrellaTwo = IconPark._(
    id: 2492,
    name: "umbrella-two",
    title: "雨伞",
    category: "Safe",
    categoryCN: "安全 & 防护",
    author: "史晓彤",
    tag: ["防潮", "雨伞", "保护", "下雨", "庇护", "防护", "安全", "天气", "护盾"],
    rtl: true,
  );

  /// 撤销
  static const IconPark undo = IconPark._(
    id: 2493,
    name: "undo",
    title: "撤销",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["撤销", "返回", "驳回", "刷新", "旋转"],
    rtl: true,
  );

  /// 解组
  static const IconPark ungroup = IconPark._(
    id: 2494,
    name: "ungroup",
    title: "解组",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["组合", "解组"],
    rtl: true,
  );

  /// 单播
  static const IconPark unicast = IconPark._(
    id: 2495,
    name: "unicast",
    title: "单播",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["点对点通信", "节点传输"],
    rtl: true,
  );

  /// 合并选择
  static const IconPark unionSelection = IconPark._(
    id: 2496,
    name: "union-selection",
    title: "合并选择",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["合并", "并拢", "交集"],
    rtl: true,
  );

  /// 宇宙
  static const IconPark universal = IconPark._(
    id: 2497,
    name: "universal",
    title: "宇宙",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 不喜欢
  static const IconPark unlike = IconPark._(
    id: 2498,
    name: "unlike",
    title: "不喜欢",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["取消关注", "取消收藏", "爱心"],
    rtl: true,
  );

  /// 链接断开
  static const IconPark unlink = IconPark._(
    id: 2499,
    name: "unlink",
    title: "链接断开",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["链条", "锁链", "无效链接", "解绑"],
    rtl: true,
  );

  /// 解锁
  static const IconPark unlock = IconPark._(
    id: 2500,
    name: "unlock",
    title: "解锁",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["解锁", "开锁", "锁定", "打开", "开放"],
    rtl: true,
  );

  /// 开锁
  static const IconPark unlockOne = IconPark._(
    id: 2501,
    name: "unlock-one",
    title: "开锁",
    category: "Edit",
    categoryCN: "编辑",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 无序列表
  static const IconPark unorderedList = IconPark._(
    id: 2502,
    name: "unordered-list",
    title: "无序列表",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["无序", "列表", "序列"],
    rtl: true,
  );

  /// 上
  static const IconPark up = IconPark._(
    id: 2503,
    name: "up",
    title: "上",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向上", "箭头", "方向"],
    rtl: false,
  );

  /// 上下楼
  static const IconPark upAndDown = IconPark._(
    id: 2504,
    name: "up-and-down",
    title: "上下楼",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["上下楼", "电梯", "楼梯", "步行梯", "台阶"],
    rtl: true,
  );

  /// 上-圆
  static const IconPark upC = IconPark._(
    id: 2505,
    name: "up-c",
    title: "上-圆",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向上", "箭头", "圆圈箭头"],
    rtl: false,
  );

  /// 上1
  static const IconPark upOne = IconPark._(
    id: 2506,
    name: "up-one",
    title: "上1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向上", "箭头", "方向"],
    rtl: false,
  );

  /// 上-小
  static const IconPark upSmall = IconPark._(
    id: 2507,
    name: "up-small",
    title: "上-小",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "向上", "小箭头", "方向"],
    rtl: false,
  );

  /// 上箭头-方
  static const IconPark upSquare = IconPark._(
    id: 2508,
    name: "up-square",
    title: "上箭头-方",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["向上", "箭头", "方形箭头"],
    rtl: false,
  );

  /// 上1
  static const IconPark upTwo = IconPark._(
    id: 2509,
    name: "up-two",
    title: "上1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "齐奉飞",
    tag: ["箭头", "上", "指针", "方向"],
    rtl: false,
  );

  /// 更新
  static const IconPark updateRotation = IconPark._(
    id: 2510,
    name: "update-rotation",
    title: "更新",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["更新", "旋转", "下载", "最新", "循环"],
    rtl: true,
  );

  /// 上传
  static const IconPark upload = IconPark._(
    id: 2511,
    name: "upload",
    title: "上传",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["向上", "上传", "箭头"],
    rtl: false,
  );

  /// 计算机上传
  static const IconPark uploadComputer = IconPark._(
    id: 2512,
    name: "upload-computer",
    title: "计算机上传",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 笔记本电脑上传
  static const IconPark uploadLaptop = IconPark._(
    id: 2513,
    name: "upload-laptop",
    title: "笔记本电脑上传",
    category: "Hardware",
    categoryCN: "硬件",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 上传日志
  static const IconPark uploadLogs = IconPark._(
    id: 2514,
    name: "upload-logs",
    title: "上传日志",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["日志", "上传文档", "文件"],
    rtl: true,
  );

  /// 上传1
  static const IconPark uploadOne = IconPark._(
    id: 2515,
    name: "upload-one",
    title: "上传1",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["上传", "云上传", "载入"],
    rtl: true,
  );

  /// 图片上传
  static const IconPark uploadPicture = IconPark._(
    id: 2516,
    name: "upload-picture",
    title: "图片上传",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 上传3
  static const IconPark uploadThree = IconPark._(
    id: 2517,
    name: "upload-three",
    title: "上传3",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "常留留",
    tag: ["向上", "载入", "上传"],
    rtl: false,
  );

  /// 上传2
  static const IconPark uploadTwo = IconPark._(
    id: 2518,
    name: "upload-two",
    title: "上传2",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "刘心乐",
    tag: ["上传", "云上传"],
    rtl: true,
  );

  /// 网页上传
  static const IconPark uploadWeb = IconPark._(
    id: 2519,
    name: "upload-web",
    title: "网页上传",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 翻转笑脸
  static const IconPark upsideDownFace = IconPark._(
    id: 2520,
    name: "upside-down-face",
    title: "翻转笑脸",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["翻转笑脸", "表情"],
    rtl: false,
  );

  /// 数据接口
  static const IconPark usb = IconPark._(
    id: 2521,
    name: "usb",
    title: "数据接口",
    category: "Hardware",
    categoryCN: "硬件",
    author: "白明泽",
    tag: ["USB", "设备", "存储", "插口", "接口"],
    rtl: true,
  );

  /// U盘
  static const IconPark usbMemoryStick = IconPark._(
    id: 2522,
    name: "usb-memory-stick",
    title: "U盘",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["usb信号", "储存", "储存"],
    rtl: false,
  );

  /// 微型USB1
  static const IconPark usbMicroOne = IconPark._(
    id: 2523,
    name: "usb-micro-one",
    title: "微型USB1",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "数据线"],
    rtl: false,
  );

  /// 微型USB2
  static const IconPark usbMicroTwo = IconPark._(
    id: 2524,
    name: "usb-micro-two",
    title: "微型USB2",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "数据线"],
    rtl: false,
  );

  /// 数据接口
  static const IconPark usbOne = IconPark._(
    id: 2525,
    name: "usb-one",
    title: "数据接口",
    category: "Hardware",
    categoryCN: "硬件",
    author: "白明泽",
    tag: ["USB", "设备", "存储", "插口", "接口"],
    rtl: false,
  );

  /// TypeC
  static const IconPark usbTypeC = IconPark._(
    id: 2526,
    name: "usb-type-c",
    title: "TypeC",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["接口", "数据线"],
    rtl: false,
  );

  /// 用户
  static const IconPark user = IconPark._(
    id: 2527,
    name: "user",
    title: "用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["账户", "个人中心", "我的", "人群", "人"],
    rtl: false,
  );

  /// 商务用户
  static const IconPark userBusiness = IconPark._(
    id: 2528,
    name: "user-business",
    title: "商务用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["用户", "账户", "人", "很多人", "商务", "领带"],
    rtl: false,
  );

  /// 用户定位
  static const IconPark userPositioning = IconPark._(
    id: 2529,
    name: "user-positioning",
    title: "用户定位",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["定位", "用户", "个人中心", "我的", "人群", "人"],
    rtl: true,
  );

  /// 用户互传
  static const IconPark userToUserTransmission = IconPark._(
    id: 2530,
    name: "user-to-user-transmission",
    title: "用户互传",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "常留留",
    tag: ["相互传输", "用户", "用户之间"],
    rtl: false,
  );

  /// 子宫
  static const IconPark uterus = IconPark._(
    id: 2531,
    name: "uterus",
    title: "子宫",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["女性", "生殖", "繁衍", "器官"],
    rtl: true,
  );

  /// 椰树
  static const IconPark vacation = IconPark._(
    id: 2532,
    name: "vacation",
    title: "椰树",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 吸尘器
  static const IconPark vacuumCleaner = IconPark._(
    id: 2533,
    name: "vacuum-cleaner",
    title: "吸尘器",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["卫生", "打扫", "清除", "干净", "垃圾", "清洗", "电器"],
    rtl: true,
  );

  /// 菜篮子
  static const IconPark vegetableBasket = IconPark._(
    id: 2534,
    name: "vegetable-basket",
    title: "菜篮子",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["菜篮子", "篮子", "蔬菜", "买菜"],
    rtl: true,
  );

  /// 青菜
  static const IconPark vegetables = IconPark._(
    id: 2535,
    name: "vegetables",
    title: "青菜",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["青菜", "白菜", "蔬菜"],
    rtl: true,
  );

  /// 垂直间距
  static const IconPark verticalSpacingBetweenItems = IconPark._(
    id: 2536,
    name: "vertical-spacing-between-items",
    title: "垂直间距",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["垂直间距", "平行"],
    rtl: false,
  );

  /// 垂直整理
  static const IconPark verticalTidyUp = IconPark._(
    id: 2537,
    name: "vertical-tidy-up",
    title: "垂直整理",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["垂直间距", "平行"],
    rtl: false,
  );

  /// 垂直时间线
  static const IconPark verticalTimeline = IconPark._(
    id: 2538,
    name: "vertical-timeline",
    title: "垂直时间线",
    category: "Charts",
    categoryCN: "数据图表",
    author: "常留留",
    tag: ["时间线", "时间", "数据", "分析", "图表"],
    rtl: true,
  );

  /// 垂直居中对齐
  static const IconPark verticallyCentered = IconPark._(
    id: 2539,
    name: "vertically-centered",
    title: "垂直居中对齐",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["垂直间距", "平行", "居中对齐"],
    rtl: false,
  );

  /// 背心
  static const IconPark vest = IconPark._(
    id: 2540,
    name: "vest",
    title: "背心",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["马甲", "衣服", "上衣"],
    rtl: false,
  );

  /// 试管
  static const IconPark vial = IconPark._(
    id: 2541,
    name: "vial",
    title: "试管",
    category: "Measurement",
    categoryCN: "测量 & 试验",
    author: "白明泽",
    tag: ["试管", "试验", "量管", "测量", "测试"],
    rtl: false,
  );

  /// 蚕豆
  static const IconPark viciaFaba = IconPark._(
    id: 2542,
    name: "vicia-faba",
    title: "蚕豆",
    category: "Foods",
    categoryCN: "食品",
    author: "胡玉娜",
    tag: ["蚕豆", "豆子", "蔬菜", "食品"],
    rtl: true,
  );

  /// 视频
  static const IconPark video = IconPark._(
    id: 2543,
    name: "video",
    title: "视频",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["电影", "放映", "播放", "胶片"],
    rtl: true,
  );

  /// 视频会议
  static const IconPark videoConference = IconPark._(
    id: 2544,
    name: "video-conference",
    title: "视频会议",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 视频文件
  static const IconPark videoFile = IconPark._(
    id: 2545,
    name: "video-file",
    title: "视频文件",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["影视", "影片", "录像", "资料"],
    rtl: true,
  );

  /// 视频
  static const IconPark videoOne = IconPark._(
    id: 2546,
    name: "video-one",
    title: "视频",
    category: "Office",
    categoryCN: "办公文档",
    author: "田婧",
    tag: ["摄像", "视频", "电影", "投影", "影像"],
    rtl: true,
  );

  /// 视频
  static const IconPark videoTwo = IconPark._(
    id: 2547,
    name: "video-two",
    title: "视频",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["视频", "影视", "播放", "电影"],
    rtl: true,
  );

  /// 摄像机1
  static const IconPark videocamera = IconPark._(
    id: 2548,
    name: "videocamera",
    title: "摄像机1",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "探头", "抓拍", "偷拍", "电影", "放映"],
    rtl: true,
  );

  /// 摄像机2
  static const IconPark videocameraOne = IconPark._(
    id: 2549,
    name: "videocamera-one",
    title: "摄像机2",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["摄像", "拍摄", "记录", "录像", "录制", "检测", "探头", "抓拍", "偷拍", "电影", "放映"],
    rtl: true,
  );

  /// 维恩图
  static const IconPark viencharts = IconPark._(
    id: 2550,
    name: "viencharts",
    title: "维恩图",
    category: "Charts",
    categoryCN: "数据图表",
    author: "金磊",
    tag: ["数据", "维恩", "图表", "圆环交叉"],
    rtl: false,
  );

  /// 卡片查看模式
  static const IconPark viewGridCard = IconPark._(
    id: 2551,
    name: "view-grid-card",
    title: "卡片查看模式",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["列表模式", "宫格", "应用", "网格视图"],
    rtl: false,
  );

  /// 详情查看模式
  static const IconPark viewGridDetail = IconPark._(
    id: 2552,
    name: "view-grid-detail",
    title: "详情查看模式",
    category: "Edit",
    categoryCN: "编辑",
    author: "刘心乐",
    tag: ["列表模式", "排列方式", "排版"],
    rtl: true,
  );

  /// 列表查看模式
  static const IconPark viewGridList = IconPark._(
    id: 2553,
    name: "view-grid-list",
    title: "列表查看模式",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["列表模式", "排列方式", "顺序", "排版", "左图右文"],
    rtl: true,
  );

  /// 详情列表
  static const IconPark viewList = IconPark._(
    id: 2554,
    name: "view-list",
    title: "详情列表",
    category: "Office",
    categoryCN: "办公文档",
    author: "刘心乐",
    tag: ["list", "列表", "表格", "文件", "文本"],
    rtl: true,
  );

  /// 取景器
  static const IconPark viewfinder = IconPark._(
    id: 2555,
    name: "viewfinder",
    title: "取景器",
    category: "Edit",
    categoryCN: "编辑",
    author: "李宁",
    tag: ["相机", "照相", "拍照", "自动", "取景器"],
    rtl: false,
  );

  /// 火山小视频
  static const IconPark vigo = IconPark._(
    id: 2556,
    name: "vigo",
    title: "火山小视频",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["火山", "小视频", "短视频", "logo", "字节跳动"],
    rtl: true,
  );

  /// VIP
  static const IconPark vip = IconPark._(
    id: 2557,
    name: "vip",
    title: "VIP",
    category: "Character",
    categoryCN: "符号标识",
    author: "金磊",
    tag: ["VIP", "加V", "会员"],
    rtl: true,
  );

  /// vip
  static const IconPark vipOne = IconPark._(
    id: 2558,
    name: "vip-one",
    title: "vip",
    category: "Others",
    categoryCN: "其它",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 处女座
  static const IconPark virgo = IconPark._(
    id: 2559,
    name: "virgo",
    title: "处女座",
    category: "Constellation",
    categoryCN: "星座",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 虚拟现实眼镜
  static const IconPark virtualRealityGlasses = IconPark._(
    id: 2560,
    name: "virtual-reality-glasses",
    title: "虚拟现实眼镜",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["VR", "虚拟现实", "眼睛", "AR", "增强现实", "游戏"],
    rtl: false,
  );

  /// 录音
  static const IconPark voice = IconPark._(
    id: 2561,
    name: "voice",
    title: "录音",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["音量", "语音", "录音", "麦克风"],
    rtl: false,
  );

  /// 语音文字
  static const IconPark voiceInput = IconPark._(
    id: 2562,
    name: "voice-input",
    title: "语音文字",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["语音文字", "语音转文字", "语音入法"],
    rtl: true,
  );

  /// 语音信息
  static const IconPark voiceMessage = IconPark._(
    id: 2563,
    name: "voice-message",
    title: "语音信息",
    category: "Others",
    categoryCN: "其它",
    author: "齐奉飞",
    tag: ["语音", "信息", "声音", "信号"],
    rtl: true,
  );

  /// 关闭录音
  static const IconPark voiceOff = IconPark._(
    id: 2564,
    name: "voice-off",
    title: "关闭录音",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["关闭音量", "关闭语音", "关闭录音", "关闭麦克风", "close"],
    rtl: true,
  );

  /// 声音
  static const IconPark voiceOne = IconPark._(
    id: 2565,
    name: "voice-one",
    title: "声音",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["音频", "音量", "语音", "录音", "声波", "voice"],
    rtl: false,
  );

  /// 语音信息
  static const IconPark voicemail = IconPark._(
    id: 2566,
    name: "voicemail",
    title: "语音信息",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["录音", "磁带", "语音", "语音短信"],
    rtl: false,
  );

  /// 大众
  static const IconPark volkswagen = IconPark._(
    id: 2567,
    name: "volkswagen",
    title: "大众",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["汽车", "加工厂", "logo", "大众"],
    rtl: false,
  );

  /// 排球
  static const IconPark volleyball = IconPark._(
    id: 2568,
    name: "volleyball",
    title: "排球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["球类", "球", "排球", "线球", "圆球", "轮子", "运动", "体育"],
    rtl: true,
  );

  /// 音量减小
  static const IconPark volumeDown = IconPark._(
    id: 2569,
    name: "volume-down",
    title: "音量减小",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["音乐", "音量", "声音", "降低", "无声", "音乐"],
    rtl: true,
  );

  /// 静音
  static const IconPark volumeMute = IconPark._(
    id: 2570,
    name: "volume-mute",
    title: "静音",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["音量关闭", "静音", "声音", "音量", "喇叭", "广播"],
    rtl: true,
  );

  /// 声音-大
  static const IconPark volumeNotice = IconPark._(
    id: 2571,
    name: "volume-notice",
    title: "声音-大",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["音量", "声音", "喇叭", "小声", "广播"],
    rtl: true,
  );

  /// 声音-小
  static const IconPark volumeSmall = IconPark._(
    id: 2572,
    name: "volume-small",
    title: "声音-小",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "常留留",
    tag: ["音量", "声音", "喇叭", "小声", "广播"],
    rtl: true,
  );

  /// 音量增大
  static const IconPark volumeUp = IconPark._(
    id: 2573,
    name: "volume-up",
    title: "音量增大",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "金磊",
    tag: ["音乐", "音量", "声音", "增大", "最大音量", "音乐"],
    rtl: true,
  );

  /// VR 眼镜
  static const IconPark vrGlasses = IconPark._(
    id: 2574,
    name: "vr-glasses",
    title: "VR 眼镜",
    category: "Hardware",
    categoryCN: "硬件",
    author: "金磊",
    tag: ["VR", "眼镜", "眼镜", "虚拟现实", "设备", "游戏"],
    rtl: false,
  );

  /// 腰围
  static const IconPark waistline = IconPark._(
    id: 2575,
    name: "waistline",
    title: "腰围",
    category: "Health",
    categoryCN: "医疗健康",
    author: "杨威",
    tag: [],
    rtl: false,
  );

  /// 钱包
  static const IconPark wallet = IconPark._(
    id: 2576,
    name: "wallet",
    title: "钱包",
    category: "Money",
    categoryCN: "电商财产",
    author: "刘心乐",
    tag: ["钱", "钱包", "资金", "金融", "充值"],
    rtl: true,
  );

  /// 钱包
  static const IconPark walletOne = IconPark._(
    id: 2577,
    name: "wallet-one",
    title: "钱包",
    category: "Money",
    categoryCN: "电商财产",
    author: "史晓彤",
    tag: ["钱包", "消费", "卡包"],
    rtl: true,
  );

  /// 钱包3
  static const IconPark walletThree = IconPark._(
    id: 2578,
    name: "wallet-three",
    title: "钱包3",
    category: "Money",
    categoryCN: "电商财产",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 钱包
  static const IconPark walletTwo = IconPark._(
    id: 2579,
    name: "wallet-two",
    title: "钱包",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["钱包", "金钱", "财富", "理财", "投资"],
    rtl: true,
  );

  /// 入库
  static const IconPark warehousing = IconPark._(
    id: 2580,
    name: "warehousing",
    title: "入库",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "张蔓",
    tag: ["入库", "进入", "输送", "方向"],
    rtl: true,
  );

  /// 洗衣机
  static const IconPark washingMachine = IconPark._(
    id: 2581,
    name: "washing-machine",
    title: "洗衣机",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["卫生", "打扫", "清除", "干净", "垃圾", "清洗", "洗衣服", "除污渍", "电器"],
    rtl: true,
  );

  /// 洗衣机1
  static const IconPark washingMachineOne = IconPark._(
    id: 2582,
    name: "washing-machine-one",
    title: "洗衣机1",
    category: "Hardware",
    categoryCN: "硬件",
    author: "张晏",
    tag: ["卫生", "打扫", "清除", "干净", "垃圾", "清洗", "洗衣服", "除污渍", "电器"],
    rtl: true,
  );

  /// 手表
  static const IconPark watch = IconPark._(
    id: 2583,
    name: "watch",
    title: "手表",
    category: "Time",
    categoryCN: "时间日期",
    author: "金磊",
    tag: ["电子表", "时间", "时区", "指针", "计时", "手表"],
    rtl: true,
  );

  /// 手表
  static const IconPark watchOne = IconPark._(
    id: 2584,
    name: "watch-one",
    title: "手表",
    category: "Hardware",
    categoryCN: "硬件",
    author: "孟祥瑞",
    tag: ["计时器", "手表", "时间", "智能手表", "机械表"],
    rtl: true,
  );

  /// 水资源
  static const IconPark water = IconPark._(
    id: 2585,
    name: "water",
    title: "水资源",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["节能", "环保", "新能源", "水资源"],
    rtl: false,
  );

  /// 水位线
  static const IconPark waterLevel = IconPark._(
    id: 2586,
    name: "water-level",
    title: "水位线",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["水位线", "水滴"],
    rtl: true,
  );

  /// 水缺乏
  static const IconPark waterNo = IconPark._(
    id: 2587,
    name: "water-no",
    title: "水缺乏",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["节能", "环保", "新能源", "水资源", "缺乏", "匮乏"],
    rtl: false,
  );

  /// 水费
  static const IconPark waterRate = IconPark._(
    id: 2588,
    name: "water-rate",
    title: "水费",
    category: "Money",
    categoryCN: "电商财产",
    author: "白明泽",
    tag: ["费用", "水费", "钱", "缴费", "交费"],
    rtl: false,
  );

  /// 水电费
  static const IconPark waterRateTwo = IconPark._(
    id: 2589,
    name: "water-rate-two",
    title: "水电费",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["水电费", "水滴"],
    rtl: false,
  );

  /// 瀑布流横向
  static const IconPark waterfallsH = IconPark._(
    id: 2590,
    name: "waterfalls-h",
    title: "瀑布流横向",
    category: "Base",
    categoryCN: "基础",
    author: "白明泽",
    tag: ["瀑布", "流程", "布局", "排版", "界面", "顺序", "列表"],
    rtl: true,
  );

  /// 瀑布流纵向
  static const IconPark waterfallsV = IconPark._(
    id: 2591,
    name: "waterfalls-v",
    title: "瀑布流纵向",
    category: "Base",
    categoryCN: "基础",
    author: "白明泽",
    tag: ["瀑布", "流程", "布局", "排版", "界面", "顺序", "列表"],
    rtl: true,
  );

  /// 西瓜
  static const IconPark watermelon = IconPark._(
    id: 2592,
    name: "watermelon",
    title: "西瓜",
    category: "Foods",
    categoryCN: "食品",
    author: "金磊",
    tag: ["西瓜", "水果", "美食", "夏天"],
    rtl: false,
  );

  /// 西瓜
  static const IconPark watermelonOne = IconPark._(
    id: 2593,
    name: "watermelon-one",
    title: "西瓜",
    category: "Foods",
    categoryCN: "食品",
    author: "孔维佳",
    tag: ["水果", "瓜"],
    rtl: true,
  );

  /// 水球
  static const IconPark waterpolo = IconPark._(
    id: 2594,
    name: "waterpolo",
    title: "水球",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["运动", "体育", "排球", "水", "训练"],
    rtl: true,
  );

  /// 水球1
  static const IconPark waterpoloOne = IconPark._(
    id: 2595,
    name: "waterpolo-one",
    title: "水球1",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["运动", "体育", "排球", "水", "训练"],
    rtl: true,
  );

  /// 电波
  static const IconPark waves = IconPark._(
    id: 2596,
    name: "waves",
    title: "电波",
    category: "Money",
    categoryCN: "电商财产",
    author: "常留留",
    tag: ["心跳", "脉搏", "趋势", "路径"],
    rtl: true,
  );

  /// 左音波
  static const IconPark wavesLeft = IconPark._(
    id: 2597,
    name: "waves-left",
    title: "左音波",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["音频", "音量", "语音", "录音", "波纹", "声音"],
    rtl: true,
  );

  /// 右音波
  static const IconPark wavesRight = IconPark._(
    id: 2598,
    name: "waves-right",
    title: "右音波",
    category: "Music",
    categoryCN: "多媒体音乐",
    author: "林琳",
    tag: ["音频", "音量", "语音", "录音", "波纹", "声音"],
    rtl: true,
  );

  /// 沮丧
  static const IconPark wearyFace = IconPark._(
    id: 2599,
    name: "weary-face",
    title: "沮丧",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["沮丧", "表情", "哭丧着脸"],
    rtl: false,
  );

  /// 网页
  static const IconPark webPage = IconPark._(
    id: 2600,
    name: "web-page",
    title: "网页",
    category: "Office",
    categoryCN: "办公文档",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 网络摄像头
  static const IconPark webcam = IconPark._(
    id: 2601,
    name: "webcam",
    title: "网络摄像头",
    category: "Hardware",
    categoryCN: "硬件",
    author: "常留留",
    tag: ["摄像头", "拍摄", "摄像机", "镜头", "网络"],
    rtl: false,
  );

  /// 微信
  static const IconPark wechat = IconPark._(
    id: 2602,
    name: "wechat",
    title: "微信",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["聊天", "社交", "沟通", "语音", "logo"],
    rtl: true,
  );

  /// 微博
  static const IconPark weibo = IconPark._(
    id: 2603,
    name: "weibo",
    title: "微博",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["微博", "新浪微博", "logo", "资讯"],
    rtl: true,
  );

  /// 体重
  static const IconPark weight = IconPark._(
    id: 2604,
    name: "weight",
    title: "体重",
    category: "Health",
    categoryCN: "医疗健康",
    author: "常留留",
    tag: ["秤", "重量", "称量"],
    rtl: true,
  );

  /// 举重
  static const IconPark weightlifting = IconPark._(
    id: 2605,
    name: "weightlifting",
    title: "举重",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["运动", "体育", "训练", "举重", "减脂", "重量", "负重", "力量", "比赛", "拉伸"],
    rtl: false,
  );

  /// 微信卡包
  static const IconPark weixinCardsOffers = IconPark._(
    id: 2606,
    name: "weixin-cards-offers",
    title: "微信卡包",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["卡券", "信用卡", "钱包", "优惠券"],
    rtl: true,
  );

  /// 微信收藏
  static const IconPark weixinFavorites = IconPark._(
    id: 2607,
    name: "weixin-favorites",
    title: "微信收藏",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["收藏", "喜欢", "保存", "存储"],
    rtl: false,
  );

  /// 微信游戏
  static const IconPark weixinGames = IconPark._(
    id: 2608,
    name: "weixin-games",
    title: "微信游戏",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["游戏", "玩", "娱乐"],
    rtl: false,
  );

  /// 微信电商
  static const IconPark weixinMarket = IconPark._(
    id: 2609,
    name: "weixin-market",
    title: "微信电商",
    category: "Money",
    categoryCN: "电商财产",
    author: "金磊",
    tag: ["商场", "商城", "电商", "卖东西", "生意", "入口"],
    rtl: false,
  );

  /// 微信小程序
  static const IconPark weixinMiniApp = IconPark._(
    id: 2610,
    name: "weixin-mini-app",
    title: "微信小程序",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["小程序", "图标"],
    rtl: true,
  );

  /// 微信附近的人
  static const IconPark weixinPeopleNearby = IconPark._(
    id: 2611,
    name: "weixin-people-nearby",
    title: "微信附近的人",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["附近的人", "漂流瓶", "地理位置"],
    rtl: false,
  );

  /// 微信扫一扫
  static const IconPark weixinScan = IconPark._(
    id: 2612,
    name: "weixin-scan",
    title: "微信扫一扫",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["扫码", "二维码", "扫描", "扫一扫"],
    rtl: true,
  );

  /// 微信搜索
  static const IconPark weixinSearch = IconPark._(
    id: 2613,
    name: "weixin-search",
    title: "微信搜索",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["搜索", "微信搜索"],
    rtl: true,
  );

  /// 微信摇一摇
  static const IconPark weixinShake = IconPark._(
    id: 2614,
    name: "weixin-shake",
    title: "微信摇一摇",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["摇一摇", "搜索", "互动", "交互"],
    rtl: true,
  );

  /// 微信看一看
  static const IconPark weixinTopStories = IconPark._(
    id: 2615,
    name: "weixin-top-stories",
    title: "微信看一看",
    category: "Others",
    categoryCN: "其它",
    author: "金磊",
    tag: ["文章", "看一看", "信息流"],
    rtl: false,
  );

  /// 鲸鱼
  static const IconPark whale = IconPark._(
    id: 2616,
    name: "whale",
    title: "鲸鱼",
    category: "Animals",
    categoryCN: "动物",
    author: "杨威",
    tag: [],
    rtl: true,
  );

  /// 轮椅
  static const IconPark wheelchair = IconPark._(
    id: 2617,
    name: "wheelchair",
    title: "轮椅",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "金磊",
    tag: ["轮椅", "残疾", "运动"],
    rtl: true,
  );

  /// 旋风
  static const IconPark whirlwind = IconPark._(
    id: 2618,
    name: "whirlwind",
    title: "旋风",
    category: "Abstract",
    categoryCN: "抽象图形",
    author: "金磊",
    tag: ["旋转", "旋风", "循环"],
    rtl: true,
  );

  /// 吹哨
  static const IconPark whistling = IconPark._(
    id: 2619,
    name: "whistling",
    title: "吹哨",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["哨子", "吹哨", "比赛", "声音", "响声", "裁判", "犯规", "铃声", "音乐", "乐器"],
    rtl: true,
  );

  /// 站点加速
  static const IconPark wholeSiteAccelerator = IconPark._(
    id: 2620,
    name: "whole-site-accelerator",
    title: "站点加速",
    category: "Connect",
    categoryCN: "链接",
    author: "高亚栋",
    tag: ["站点加速", "闪电", "连接"],
    rtl: true,
  );

  /// 无线网络
  static const IconPark wifi = IconPark._(
    id: 2621,
    name: "wifi",
    title: "无线网络",
    category: "Others",
    categoryCN: "其它",
    author: "齐奉飞",
    tag: ["Wi-Fi", "无线网", "网络", "信号"],
    rtl: false,
  );

  /// 刮风
  static const IconPark wind = IconPark._(
    id: 2622,
    name: "wind",
    title: "刮风",
    category: "Weather",
    categoryCN: "天气",
    author: "",
    tag: ["风"],
    rtl: true,
  );

  /// 风力发电机
  static const IconPark windTurbine = IconPark._(
    id: 2623,
    name: "wind-turbine",
    title: "风力发电机",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["风车", "发电机"],
    rtl: true,
  );

  /// 风车
  static const IconPark windmill = IconPark._(
    id: 2624,
    name: "windmill",
    title: "风车",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "齐奉飞",
    tag: ["风车", "纸风车", "旋转", "快速", "环保"],
    rtl: true,
  );

  /// 风车
  static const IconPark windmillOne = IconPark._(
    id: 2625,
    name: "windmill-one",
    title: "风车",
    category: "Build",
    categoryCN: "建筑",
    author: "王小犇",
    tag: ["车", "发电车", "风车"],
    rtl: true,
  );

  /// 风车
  static const IconPark windmillTwo = IconPark._(
    id: 2626,
    name: "windmill-two",
    title: "风车",
    category: "Energy",
    categoryCN: "能源 & 生命",
    author: "金磊",
    tag: ["风车", "转动", "旋转", "风景", "发电", "动力"],
    rtl: true,
  );

  /// 微软视窗
  static const IconPark windows = IconPark._(
    id: 2627,
    name: "windows",
    title: "微软视窗",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["微软", "操作系统", "logo"],
    rtl: true,
  );

  /// 翼装飞行
  static const IconPark wingsuitFlying = IconPark._(
    id: 2628,
    name: "wingsuit-flying",
    title: "翼装飞行",
    category: "Sports",
    categoryCN: "体育运动",
    author: "梁超",
    tag: ["飞行", "人", "体育", "运动", "比赛", "超人", "飞人"],
    rtl: false,
  );

  /// 眨眼睛
  static const IconPark winkingFace = IconPark._(
    id: 2629,
    name: "winking-face",
    title: "眨眼睛",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["眨眼睛", "表情", "调皮"],
    rtl: true,
  );

  /// 眨一个眼睛
  static const IconPark winkingFaceWithOpenEyes = IconPark._(
    id: 2630,
    name: "winking-face-with-open-eyes",
    title: "眨一个眼睛",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["眨一个眼睛", "表情", "调皮"],
    rtl: true,
  );

  /// 女人
  static const IconPark woman = IconPark._(
    id: 2631,
    name: "woman",
    title: "女人",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "常留留",
    tag: ["女生", "女士", "妈妈", "阿姨", "女性", "女", "女性用户"],
    rtl: true,
  );

  /// 女
  static const IconPark women = IconPark._(
    id: 2632,
    name: "women",
    title: "女",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "杨威",
    tag: ["用户", "客户", "个人中心", "账户中心", "我的", "员工", "女"],
    rtl: true,
  );

  /// 女大衣
  static const IconPark womenCoat = IconPark._(
    id: 2633,
    name: "women-coat",
    title: "女大衣",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["大衣", "上衣", "衣服", "外套"],
    rtl: false,
  );

  /// 呢帽
  static const IconPark woolenHat = IconPark._(
    id: 2634,
    name: "woolen-hat",
    title: "呢帽",
    category: "Clothes",
    categoryCN: "服饰",
    author: "马玉欣",
    tag: ["帽子", "顶帽", "道具", "针织帽"],
    rtl: true,
  );

  /// 文档
  static const IconPark word = IconPark._(
    id: 2635,
    name: "word",
    title: "文档",
    category: "Edit",
    categoryCN: "编辑",
    author: "夏立诚",
    tag: ["文档", "文案", "文本"],
    rtl: false,
  );

  /// 工作台
  static const IconPark workbench = IconPark._(
    id: 2636,
    name: "workbench",
    title: "工作台",
    category: "Money",
    categoryCN: "电商财产",
    author: "齐奉飞",
    tag: ["电脑", "工作桌", "平台", "行情", "趋势"],
    rtl: true,
  );

  /// 工人
  static const IconPark worker = IconPark._(
    id: 2637,
    name: "worker",
    title: "工人",
    category: "Industry",
    categoryCN: "工业",
    author: "齐奉飞",
    tag: ["打工者", "劳动者", "打工人"],
    rtl: true,
  );

  /// 世界
  static const IconPark world = IconPark._(
    id: 2638,
    name: "world",
    title: "世界",
    category: "Travel",
    categoryCN: "交通旅游",
    author: "常留留",
    tag: ["环球", "地球", "国际", "地图", "地图"],
    rtl: true,
  );

  /// 担心
  static const IconPark worriedFace = IconPark._(
    id: 2639,
    name: "worried-face",
    title: "担心",
    category: "Emoji",
    categoryCN: "表情",
    author: "金磊",
    tag: ["表情", "失败", "哭脸", "不开心", "悲伤"],
    rtl: false,
  );

  /// 写作
  static const IconPark write = IconPark._(
    id: 2640,
    name: "write",
    title: "写作",
    category: "Edit",
    categoryCN: "编辑",
    author: "齐奉飞",
    tag: ["协作", "写字", "编辑", "修改", "输入"],
    rtl: true,
  );

  /// 编辑撰写
  static const IconPark writingFluently = IconPark._(
    id: 2641,
    name: "writing-fluently",
    title: "编辑撰写",
    category: "Edit",
    categoryCN: "编辑",
    author: "金磊",
    tag: ["编辑", "书写", "书法", "记录", "画图", "输入"],
    rtl: true,
  );

  /// 错误用户
  static const IconPark wrongUser = IconPark._(
    id: 2642,
    name: "wrong-user",
    title: "错误用户",
    category: "Peoples",
    categoryCN: "用户人名",
    author: "金磊",
    tag: ["错误", "关闭", "关闭用户权限", "删除用户"],
    rtl: true,
  );

  /// 小度
  static const IconPark xiaodu = IconPark._(
    id: 2643,
    name: "xiaodu",
    title: "小度",
    category: "Brand",
    categoryCN: "品牌",
    author: "金磊",
    tag: ["百度", "小度", "音响", "屏幕音响", "智能音响", "表情"],
    rtl: true,
  );

  /// 小度在家
  static const IconPark xiaoduHome = IconPark._(
    id: 2644,
    name: "xiaodu-home",
    title: "小度在家",
    category: "Build",
    categoryCN: "建筑",
    author: "金磊",
    tag: ["百度", "小度", "音响", "屏幕音响", "智能音响", "音频"],
    rtl: false,
  );

  /// 西瓜视频
  static const IconPark xigua = IconPark._(
    id: 2645,
    name: "xigua",
    title: "西瓜视频",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["西瓜", "视频", "短视频", "logo", "字节跳动"],
    rtl: true,
  );

  /// 幸福里
  static const IconPark xingfuli = IconPark._(
    id: 2646,
    name: "xingfuli",
    title: "幸福里",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["装饰", "家装", "logo"],
    rtl: true,
  );

  /// 星图
  static const IconPark xingtu = IconPark._(
    id: 2647,
    name: "xingtu",
    title: "星图",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["星图", "达人", "撮合", "即合", "oceanengine"],
    rtl: true,
  );

  /// 胜利
  static const IconPark yep = IconPark._(
    id: 2648,
    name: "yep",
    title: "胜利",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["二", "手指", "胜利"],
    rtl: true,
  );

  /// 油管
  static const IconPark youtobe = IconPark._(
    id: 2649,
    name: "youtobe",
    title: "油管",
    category: "Brand",
    categoryCN: "品牌",
    author: "齐奉飞",
    tag: ["视频", "创意", "短视频", "应用平台", "logo"],
    rtl: true,
  );

  /// 优兔
  static const IconPark youtube = IconPark._(
    id: 2650,
    name: "youtube",
    title: "优兔",
    category: "Brand",
    categoryCN: "品牌",
    author: "常留留",
    tag: ["小视频", "短视频", "logo", "社交", "社交平台"],
    rtl: true,
  );

  /// 按键零
  static const IconPark zeroKey = IconPark._(
    id: 2651,
    name: "zero-key",
    title: "按键零",
    category: "Hardware",
    categoryCN: "硬件",
    author: "齐奉飞",
    tag: ["零", "0", "按键"],
    rtl: false,
  );

  /// 资金运营平台
  static const IconPark zijinyunying = IconPark._(
    id: 2652,
    name: "zijinyunying",
    title: "资金运营平台",
    category: "Brand",
    categoryCN: "品牌",
    author: "",
    tag: ["logo", "资金运营平台"],
    rtl: false,
  );

  /// 压缩文件
  static const IconPark zip = IconPark._(
    id: 2653,
    name: "zip",
    title: "压缩文件",
    category: "Edit",
    categoryCN: "编辑",
    author: "常留留",
    tag: ["文件", "压缩包", "ZIP"],
    rtl: true,
  );

  /// 放大
  static const IconPark zoom = IconPark._(
    id: 2654,
    name: "zoom",
    title: "放大",
    category: "Hands",
    categoryCN: "手势动作",
    author: "陈子豪",
    tag: ["滑动", "侧滑"],
    rtl: true,
  );

  /// 放大
  static const IconPark zoomIn = IconPark._(
    id: 2655,
    name: "zoom-in",
    title: "放大",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["搜索", "查找", "放大"],
    rtl: true,
  );

  /// 缩放
  static const IconPark zoomInternal = IconPark._(
    id: 2656,
    name: "zoom-internal",
    title: "缩放",
    category: "Arrows",
    categoryCN: "箭头方向",
    author: "金磊",
    tag: ["缩放", "内缩放", "大小"],
    rtl: true,
  );

  /// 缩小
  static const IconPark zoomOut = IconPark._(
    id: 2657,
    name: "zoom-out",
    title: "缩小",
    category: "Base",
    categoryCN: "基础",
    author: "齐奉飞",
    tag: ["搜索", "查找", "缩小"],
    rtl: true,
  );

  static const Map<String, IconPark> map = {
    "a-cane": aCane,
    "abdominal": abdominal,
    "abnormal": abnormal,
    "acceleration": acceleration,
    "accept-email": acceptEmail,
    "acoustic": acoustic,
    "activity-source": activitySource,
    "ad": ad,
    "ad-product": adProduct,
    "add": add,
    "add-computer": addComputer,
    "add-four": addFour,
    "add-item": addItem,
    "add-mode": addMode,
    "add-music": addMusic,
    "add-one": addOne,
    "add-pic": addPic,
    "add-picture": addPicture,
    "add-print": addPrint,
    "add-subset": addSubset,
    "add-subtract": addSubtract,
    "add-text": addText,
    "add-text-two": addTextTwo,
    "add-three": addThree,
    "add-two": addTwo,
    "add-user": addUser,
    "add-web": addWeb,
    "address-book": addressBook,
    "adjacent-item": adjacentItem,
    "adjustment": adjustment,
    "adobe-illustrate": adobeIllustrate,
    "adobe-indesign": adobeIndesign,
    "adobe-lightroom": adobeLightroom,
    "adobe-photoshop": adobePhotoshop,
    "afferent": afferent,
    "afferent-four": afferentFour,
    "afferent-three": afferentThree,
    "afferent-two": afferentTwo,
    "afro-pick": afroPick,
    "agreement": agreement,
    "aiming": aiming,
    "air-bike": airBike,
    "air-conditioning": airConditioning,
    "airplane": airplane,
    "airplane-window": airplaneWindow,
    "airplane-window-one": airplaneWindowOne,
    "airplay": airplay,
    "airpods": airpods,
    "alarm": alarm,
    "alarm-clock": alarmClock,
    "align-bottom": alignBottom,
    "align-bottom-two": alignBottomTwo,
    "align-horizontal-center-two": alignHorizontalCenterTwo,
    "align-horizontally": alignHorizontally,
    "align-left": alignLeft,
    "align-left-one": alignLeftOne,
    "align-left-two": alignLeftTwo,
    "align-right": alignRight,
    "align-right-one": alignRightOne,
    "align-right-two": alignRightTwo,
    "align-text-both": alignTextBoth,
    "align-text-both-one": alignTextBothOne,
    "align-text-bottom": alignTextBottom,
    "align-text-bottom-one": alignTextBottomOne,
    "align-text-center": alignTextCenter,
    "align-text-center-one": alignTextCenterOne,
    "align-text-left": alignTextLeft,
    "align-text-left-one": alignTextLeftOne,
    "align-text-middle": alignTextMiddle,
    "align-text-middle-one": alignTextMiddleOne,
    "align-text-right": alignTextRight,
    "align-text-right-one": alignTextRightOne,
    "align-text-top": alignTextTop,
    "align-text-top-one": alignTextTopOne,
    "align-top": alignTop,
    "align-top-two": alignTopTwo,
    "align-vertical-center-two": alignVerticalCenterTwo,
    "align-vertically": alignVertically,
    "alignment-bottom-center": alignmentBottomCenter,
    "alignment-bottom-left": alignmentBottomLeft,
    "alignment-bottom-right": alignmentBottomRight,
    "alignment-horizontal-bottom": alignmentHorizontalBottom,
    "alignment-horizontal-center": alignmentHorizontalCenter,
    "alignment-horizontal-top": alignmentHorizontalTop,
    "alignment-left-bottom": alignmentLeftBottom,
    "alignment-left-center": alignmentLeftCenter,
    "alignment-left-top": alignmentLeftTop,
    "alignment-right-bottom": alignmentRightBottom,
    "alignment-right-center": alignmentRightCenter,
    "alignment-right-top": alignmentRightTop,
    "alignment-top-center": alignmentTopCenter,
    "alignment-top-left": alignmentTopLeft,
    "alignment-top-right": alignmentTopRight,
    "alignment-vertical-center": alignmentVerticalCenter,
    "alignment-vertical-left": alignmentVerticalLeft,
    "alignment-vertical-right": alignmentVerticalRight,
    "alipay": alipay,
    "all-application": allApplication,
    "alphabetical-sorting": alphabeticalSorting,
    "alphabetical-sorting-two": alphabeticalSortingTwo,
    "ambulance": ambulance,
    "analysis": analysis,
    "anchor": anchor,
    "anchor-one": anchorOne,
    "anchor-round": anchorRound,
    "anchor-squre": anchorSqure,
    "anchor-two": anchorTwo,
    "android": android,
    "angry-face": angryFace,
    "anguished-face": anguishedFace,
    "announcement": announcement,
    "anti-corrosion": antiCorrosion,
    "aperture-priority": aperturePriority,
    "api": api,
    "api-app": apiApp,
    "app-store": appStore,
    "app-switch": appSwitch,
    "apple": apple,
    "apple-one": appleOne,
    "applet-closed": appletClosed,
    "application": application,
    "application-effect": applicationEffect,
    "application-menu": applicationMenu,
    "application-one": applicationOne,
    "application-two": applicationTwo,
    "appointment": appointment,
    "aquarius": aquarius,
    "arc-de-triomphe": arcDeTriomphe,
    "archers-bow": archersBow,
    "archery": archery,
    "area-map": areaMap,
    "arena": arena,
    "aries": aries,
    "arithmetic": arithmetic,
    "arithmetic-buttons": arithmeticButtons,
    "arithmetic-one": arithmeticOne,
    "arrow-circle-down": arrowCircleDown,
    "arrow-circle-left": arrowCircleLeft,
    "arrow-circle-right": arrowCircleRight,
    "arrow-circle-up": arrowCircleUp,
    "arrow-down": arrowDown,
    "arrow-keys": arrowKeys,
    "arrow-left": arrowLeft,
    "arrow-left-down": arrowLeftDown,
    "arrow-left-up": arrowLeftUp,
    "arrow-right": arrowRight,
    "arrow-right-down": arrowRightDown,
    "arrow-right-up": arrowRightUp,
    "arrow-up": arrowUp,
    "assembly-line": assemblyLine,
    "association": association,
    "asterisk": asterisk,
    "asterisk-key": asteriskKey,
    "astonished-face": astonishedFace,
    "at-sign": atSign,
    "attention": attention,
    "audio-file": audioFile,
    "audit": audit,
    "auto-focus": autoFocus,
    "auto-height-one": autoHeightOne,
    "auto-line-height": autoLineHeight,
    "auto-line-width": autoLineWidth,
    "auto-width": autoWidth,
    "auto-width-one": autoWidthOne,
    "avatar": avatar,
    "average": average,
    "aviation": aviation,
    "avocado": avocado,
    "avocado-one": avocadoOne,
    "baby": baby,
    "baby-app": babyApp,
    "baby-bottle": babyBottle,
    "baby-car-seat": babyCarSeat,
    "baby-feet": babyFeet,
    "baby-meal": babyMeal,
    "baby-mobile": babyMobile,
    "baby-one": babyOne,
    "baby-pants": babyPants,
    "baby-sling": babySling,
    "baby-taste": babyTaste,
    "bachelor-cap": bachelorCap,
    "bachelor-cap-one": bachelorCapOne,
    "bachelor-cap-two": bachelorCapTwo,
    "back": back,
    "back-one": backOne,
    "background-color": backgroundColor,
    "backpack": backpack,
    "bad": bad,
    "bad-one": badOne,
    "bad-two": badTwo,
    "badge": badge,
    "badge-two": badgeTwo,
    "badminton": badminton,
    "baggage-delay": baggageDelay,
    "balance": balance,
    "balance-one": balanceOne,
    "balance-two": balanceTwo,
    "banana": banana,
    "bank": bank,
    "bank-card": bankCard,
    "bank-card-one": bankCardOne,
    "bank-card-two": bankCardTwo,
    "bank-transfer": bankTransfer,
    "baokemeng": baokemeng,
    "bar-code": barCode,
    "barbecue": barbecue,
    "barber-brush": barberBrush,
    "barber-clippers": barberClippers,
    "baseball": baseball,
    "baseball-bat": baseballBat,
    "baseball-cap": baseballCap,
    "basketball": basketball,
    "basketball-clothes": basketballClothes,
    "basketball-one": basketballOne,
    "basketball-stand": basketballStand,
    "bat": bat,
    "battery-charge": batteryCharge,
    "battery-empty": batteryEmpty,
    "battery-failure": batteryFailure,
    "battery-full": batteryFull,
    "battery-storage": batteryStorage,
    "battery-tips": batteryTips,
    "battery-working": batteryWorking,
    "battery-working-one": batteryWorkingOne,
    "beach-umbrella": beachUmbrella,
    "bear": bear,
    "beauty": beauty,
    "beauty-instrument": beautyInstrument,
    "bedside": bedside,
    "bedside-two": bedsideTwo,
    "bee": bee,
    "beer": beer,
    "beer-mug": beerMug,
    "behance": behance,
    "bell-ring": bellRing,
    "belt": belt,
    "benz": benz,
    "bezier-curve": bezierCurve,
    "bib": bib,
    "big-clock": bigClock,
    "big-x": bigX,
    "bike": bike,
    "bill": bill,
    "bird": bird,
    "birthday-cake": birthdayCake,
    "bitcoin": bitcoin,
    "black-eight": blackEight,
    "blackboard": blackboard,
    "blade": blade,
    "bless": bless,
    "block": block,
    "block-eight": blockEight,
    "block-five": blockFive,
    "block-four": blockFour,
    "block-nine": blockNine,
    "block-one": blockOne,
    "block-seven": blockSeven,
    "block-six": blockSix,
    "block-ten": blockTen,
    "block-three": blockThree,
    "block-two": blockTwo,
    "blockchain": blockchain,
    "blocks-and-arrows": blocksAndArrows,
    "bloom": bloom,
    "blossom": blossom,
    "bluetooth": bluetooth,
    "boiler": boiler,
    "bolt-one": boltOne,
    "bone": bone,
    "book": book,
    "book-one": bookOne,
    "book-open": bookOpen,
    "bookmark": bookmark,
    "bookmark-one": bookmarkOne,
    "bookmark-three": bookmarkThree,
    "bookshelf": bookshelf,
    "booster-car-seat": boosterCarSeat,
    "booth": booth,
    "boots": boots,
    "bottle": bottle,
    "bottle-one": bottleOne,
    "bottle-three": bottleThree,
    "bottle-two": bottleTwo,
    "bottom-bar": bottomBar,
    "bottom-bar-one": bottomBarOne,
    "bow": bow,
    "bowl": bowl,
    "bowl-one": bowlOne,
    "bowling": bowling,
    "box": box,
    "boxing": boxing,
    "boxing-one": boxingOne,
    "boy": boy,
    "boy-one": boyOne,
    "boy-stroller": boyStroller,
    "boy-two": boyTwo,
    "brain": brain,
    "brake-pads": brakePads,
    "branch": branch,
    "branch-one": branchOne,
    "branch-two": branchTwo,
    "brdige-three": brdigeThree,
    "bread": bread,
    "bread-machine": breadMachine,
    "bread-one": breadOne,
    "breast-pump": breastPump,
    "bridge-one": bridgeOne,
    "bridge-two": bridgeTwo,
    "briefcase": briefcase,
    "brightness": brightness,
    "bring-forward": bringForward,
    "bring-to-front": bringToFront,
    "bring-to-front-one": bringToFrontOne,
    "broadcast": broadcast,
    "broadcast-one": broadcastOne,
    "broadcast-radio": broadcastRadio,
    "browser": browser,
    "browser-chrome": browserChrome,
    "browser-safari": browserSafari,
    "bubble-chart": bubbleChart,
    "bug": bug,
    "building-four": buildingFour,
    "building-one": buildingOne,
    "building-three": buildingThree,
    "building-two": buildingTwo,
    "bullet-map": bulletMap,
    "bus": bus,
    "bus-one": busOne,
    "bus-two": busTwo,
    "butterfly": butterfly,
    "buy": buy,
    "bydesign": bydesign,
    "bye": bye,
    "bytedance": bytedance,
    "bytedance-applets": bytedanceApplets,
    "bytedance-mini-app": bytedanceMiniApp,
    "cable-car": cableCar,
    "cactus": cactus,
    "cake": cake,
    "cake-five": cakeFive,
    "cake-four": cakeFour,
    "cake-one": cakeOne,
    "cake-three": cakeThree,
    "cake-two": cakeTwo,
    "calculator": calculator,
    "calculator-one": calculatorOne,
    "calendar": calendar,
    "calendar-dot": calendarDot,
    "calendar-thirty": calendarThirty,
    "calendar-thirty-two": calendarThirtyTwo,
    "calendar-three": calendarThree,
    "camera": camera,
    "camera-five": cameraFive,
    "camera-four": cameraFour,
    "camera-one": cameraOne,
    "camera-three": cameraThree,
    "camera-two": cameraTwo,
    "camp": camp,
    "cancer": cancer,
    "candy": candy,
    "canned-fruit": cannedFruit,
    "capricornus": capricornus,
    "car": car,
    "car-battery": carBattery,
    "card-two": cardTwo,
    "cardioelectric": cardioelectric,
    "carousel": carousel,
    "carousel-video": carouselVideo,
    "carrot": carrot,
    "cast-screen": castScreen,
    "castle": castle,
    "cat": cat,
    "category-management": categoryManagement,
    "cattle": cattle,
    "cattle-zodiac": cattleZodiac,
    "caution": caution,
    "cc": cc,
    "cd": cd,
    "ce-marking": ceMarking,
    "cell": cell,
    "center-alignment": centerAlignment,
    "certificate": certificate,
    "chafing-dish": chafingDish,
    "chafing-dish-one": chafingDishOne,
    "chair": chair,
    "chair-one": chairOne,
    "change": change,
    "change-date-sort": changeDateSort,
    "charging-treasure": chargingTreasure,
    "chart-graph": chartGraph,
    "chart-histogram": chartHistogram,
    "chart-histogram-one": chartHistogramOne,
    "chart-histogram-two": chartHistogramTwo,
    "chart-line": chartLine,
    "chart-line-area": chartLineArea,
    "chart-pie": chartPie,
    "chart-pie-one": chartPieOne,
    "chart-proportion": chartProportion,
    "chart-ring": chartRing,
    "chart-scatter": chartScatter,
    "chart-stock": chartStock,
    "check": check,
    "check-correct": checkCorrect,
    "check-in": checkIn,
    "check-one": checkOne,
    "check-small": checkSmall,
    "checkbox": checkbox,
    "checkerboard": checkerboard,
    "checklist": checklist,
    "cheese": cheese,
    "chef-hat": chefHat,
    "chef-hat-one": chefHatOne,
    "cherry": cherry,
    "chess": chess,
    "chess-one": chessOne,
    "chest": chest,
    "chicken": chicken,
    "chicken-leg": chickenLeg,
    "chicken-zodiac": chickenZodiac,
    "child-with-pacifier": childWithPacifier,
    "children-cap": childrenCap,
    "children-pyramid": childrenPyramid,
    "chili": chili,
    "chimney": chimney,
    "chinese": chinese,
    "chinese-one": chineseOne,
    "chinese-pavilion": chinesePavilion,
    "chip": chip,
    "chopping-board": choppingBoard,
    "chopsticks-fork": chopsticksFork,
    "christmas-tree": christmasTree,
    "christmas-tree-one": christmasTreeOne,
    "church-one": churchOne,
    "church-two": churchTwo,
    "circle-double-down": circleDoubleDown,
    "circle-double-left": circleDoubleLeft,
    "circle-double-right": circleDoubleRight,
    "circle-double-up": circleDoubleUp,
    "circle-five-line": circleFiveLine,
    "circle-four": circleFour,
    "circle-four-line": circleFourLine,
    "circle-house": circleHouse,
    "circle-left-down": circleLeftDown,
    "circle-left-up": circleLeftUp,
    "circle-right-down": circleRightDown,
    "circle-right-up": circleRightUp,
    "circle-three": circleThree,
    "circle-two-line": circleTwoLine,
    "circles-and-triangles": circlesAndTriangles,
    "circles-seven": circlesSeven,
    "circular-connection": circularConnection,
    "circus": circus,
    "city": city,
    "city-gate": cityGate,
    "city-one": cityOne,
    "clap": clap,
    "classroom": classroom,
    "clear": clear,
    "clear-format": clearFormat,
    "click": click,
    "click-tap": clickTap,
    "click-tap-two": clickTapTwo,
    "click-to-fold": clickToFold,
    "clipboard": clipboard,
    "clock-tower": clockTower,
    "close": close,
    "close-one": closeOne,
    "close-remind": closeRemind,
    "close-small": closeSmall,
    "close-wifi": closeWifi,
    "clothes-briefs": clothesBriefs,
    "clothes-cardigan": clothesCardigan,
    "clothes-crew-neck": clothesCrewNeck,
    "clothes-diapers": clothesDiapers,
    "clothes-gloves": clothesGloves,
    "clothes-gloves-two": clothesGlovesTwo,
    "clothes-hoodie": clothesHoodie,
    "clothes-pants": clothesPants,
    "clothes-pants-short": clothesPantsShort,
    "clothes-pants-sweat": clothesPantsSweat,
    "clothes-short-sleeve": clothesShortSleeve,
    "clothes-skates": clothesSkates,
    "clothes-suit": clothesSuit,
    "clothes-sweater": clothesSweater,
    "clothes-turtleneck": clothesTurtleneck,
    "clothes-windbreaker": clothesWindbreaker,
    "cloud-storage": cloudStorage,
    "cloudy": cloudy,
    "cloudy-night": cloudyNight,
    "clue": clue,
    "coat-hanger": coatHanger,
    "cocktail": cocktail,
    "coconut-tree": coconutTree,
    "code": code,
    "code-brackets": codeBrackets,
    "code-computer": codeComputer,
    "code-download": codeDownload,
    "code-laptop": codeLaptop,
    "code-one": codeOne,
    "coffee-machine": coffeeMachine,
    "cola": cola,
    "collapse-text-input": collapseTextInput,
    "collect-computer": collectComputer,
    "collect-laptop": collectLaptop,
    "collect-picture": collectPicture,
    "collection-files": collectionFiles,
    "collection-records": collectionRecords,
    "color-card": colorCard,
    "color-filter": colorFilter,
    "column": column,
    "comb": comb,
    "come": come,
    "command": command,
    "comment": comment,
    "comment-one": commentOne,
    "comments": comments,
    "commodity": commodity,
    "communication": communication,
    "commuter-bag": commuterBag,
    "compass": compass,
    "compass-one": compassOne,
    "components": components,
    "composition": composition,
    "compression": compression,
    "computer": computer,
    "computer-one": computerOne,
    "concept-sharing": conceptSharing,
    "concern": concern,
    "conditioner": conditioner,
    "cone": cone,
    "cones": cones,
    "config": config,
    "confounded-face": confoundedFace,
    "confused-face": confusedFace,
    "connect": connect,
    "connect-address-one": connectAddressOne,
    "connect-address-two": connectAddressTwo,
    "connection": connection,
    "connection-arrow": connectionArrow,
    "connection-box": connectionBox,
    "connection-point": connectionPoint,
    "connection-point-two": connectionPointTwo,
    "consignment": consignment,
    "consume": consume,
    "contrast": contrast,
    "contrast-view": contrastView,
    "contrast-view-circle": contrastViewCircle,
    "control": control,
    "converging-gateway": convergingGateway,
    "cook": cook,
    "cooking": cooking,
    "cooking-pot": cookingPot,
    "cool": cool,
    "cooperative-handshake": cooperativeHandshake,
    "coordinate-system": coordinateSystem,
    "copy": copy,
    "copy-link": copyLink,
    "copy-one": copyOne,
    "copyright": copyright,
    "corner-down-left": cornerDownLeft,
    "corner-down-right": cornerDownRight,
    "corner-left-down": cornerLeftDown,
    "corner-left-up": cornerLeftUp,
    "corner-right-down": cornerRightDown,
    "corner-right-up": cornerRightUp,
    "corner-up-left": cornerUpLeft,
    "corner-up-right": cornerUpRight,
    "coronavirus": coronavirus,
    "correct": correct,
    "cosmetic-brush": cosmeticBrush,
    "coupon": coupon,
    "court": court,
    "cpu": cpu,
    "crab": crab,
    "creation-date-sort": creationDateSort,
    "creative": creative,
    "credit": credit,
    "crib": crib,
    "croissant": croissant,
    "cross-ring": crossRing,
    "cross-ring-two": crossRingTwo,
    "cross-society": crossSociety,
    "crown": crown,
    "crown-three": crownThree,
    "crown-two": crownTwo,
    "cruise": cruise,
    "crying-baby": cryingBaby,
    "cube": cube,
    "cube-five": cubeFive,
    "cube-four": cubeFour,
    "cube-three": cubeThree,
    "cube-two": cubeTwo,
    "cup": cup,
    "cup-four": cupFour,
    "cup-one": cupOne,
    "curling": curling,
    "currency": currency,
    "curve-adjustment": curveAdjustment,
    "customer": customer,
    "cutting": cutting,
    "cutting-one": cuttingOne,
    "cuvette": cuvette,
    "cycle": cycle,
    "cycle-arrow": cycleArrow,
    "cycle-movement": cycleMovement,
    "cycle-one": cycleOne,
    "cylinder": cylinder,
    "damage-map": damageMap,
    "dark-mode": darkMode,
    "dashboard": dashboard,
    "dashboard-car": dashboardCar,
    "dashboard-one": dashboardOne,
    "dashboard-two": dashboardTwo,
    "data": data,
    "data-all": dataAll,
    "data-arrival": dataArrival,
    "data-display": dataDisplay,
    "data-file": dataFile,
    "data-four": dataFour,
    "data-lock": dataLock,
    "data-null": dataNull,
    "data-one": dataOne,
    "data-screen": dataScreen,
    "data-server": dataServer,
    "data-sheet": dataSheet,
    "data-switching": dataSwitching,
    "data-three": dataThree,
    "data-two": dataTwo,
    "data-user": dataUser,
    "database-alert": databaseAlert,
    "database-code": databaseCode,
    "database-config": databaseConfig,
    "database-download": databaseDownload,
    "database-enter": databaseEnter,
    "database-fail": databaseFail,
    "database-first": databaseFirst,
    "database-forbid": databaseForbid,
    "database-lock": databaseLock,
    "database-network": databaseNetwork,
    "database-network-point": databaseNetworkPoint,
    "database-point": databasePoint,
    "database-position": databasePosition,
    "database-power": databasePower,
    "database-proportion": databaseProportion,
    "database-search": databaseSearch,
    "database-setting": databaseSetting,
    "database-success": databaseSuccess,
    "database-sync": databaseSync,
    "database-time": databaseTime,
    "date-comes-back": dateComesBack,
    "deadline-sort": deadlineSort,
    "death-star": deathStar,
    "deeplink": deeplink,
    "deer": deer,
    "degree-hat": degreeHat,
    "delete": delete,
    "delete-five": deleteFive,
    "delete-four": deleteFour,
    "delete-key": deleteKey,
    "delete-mode": deleteMode,
    "delete-one": deleteOne,
    "delete-themes": deleteThemes,
    "delete-three": deleteThree,
    "delete-two": deleteTwo,
    "delivery": delivery,
    "deposit": deposit,
    "descend": descend,
    "desk-lamp": deskLamp,
    "desk-lamp-one": deskLampOne,
    "detection": detection,
    "devices": devices,
    "diamond": diamond,
    "diamond-necklace": diamondNecklace,
    "diamond-one": diamondOne,
    "diamond-ring": diamondRing,
    "diamond-three": diamondThree,
    "diamond-two": diamondTwo,
    "diamonds": diamonds,
    "dianziqian": dianziqian,
    "diapers-one": diapersOne,
    "difference-set": differenceSet,
    "digital-watches": digitalWatches,
    "direction": direction,
    "direction-adjustment": directionAdjustment,
    "direction-adjustment-three": directionAdjustmentThree,
    "direction-adjustment-two": directionAdjustmentTwo,
    "disabaled-web": disabaledWeb,
    "disabled-computer": disabledComputer,
    "disabled-laptop": disabledLaptop,
    "disabled-picture": disabledPicture,
    "disappointed-face": disappointedFace,
    "discovery-index": discoveryIndex,
    "disk": disk,
    "disk-one": diskOne,
    "disk-two": diskTwo,
    "dislike": dislike,
    "dislike-two": dislikeTwo,
    "display": display,
    "distortion": distortion,
    "distraught-face": distraughtFace,
    "distribute-horizontal-spacing": distributeHorizontalSpacing,
    "distribute-horizontally": distributeHorizontally,
    "distribute-vertical-spacing": distributeVerticalSpacing,
    "distribute-vertically": distributeVertically,
    "dividing-line": dividingLine,
    "dividing-line-one": dividingLineOne,
    "diving": diving,
    "diving-bottle": divingBottle,
    "diving-suit": divingSuit,
    "division": division,
    "dizzy-face": dizzyFace,
    "doc-add": docAdd,
    "doc-detail": docDetail,
    "doc-fail": docFail,
    "doc-search": docSearch,
    "doc-search-two": docSearchTwo,
    "doc-success": docSuccess,
    "document-folder": documentFolder,
    "dog": dog,
    "dog-zodiac": dogZodiac,
    "dollar": dollar,
    "dolphin": dolphin,
    "dome": dome,
    "dome-light": domeLight,
    "done-all": doneAll,
    "dongchedi": dongchedi,
    "door-handle": doorHandle,
    "dot": dot,
    "double-bed": doubleBed,
    "double-down": doubleDown,
    "double-left": doubleLeft,
    "double-right": doubleRight,
    "double-up": doubleUp,
    "doughnut": doughnut,
    "down": down,
    "down-c": downC,
    "down-one": downOne,
    "down-picture": downPicture,
    "down-small": downSmall,
    "down-square": downSquare,
    "down-two": downTwo,
    "download": download,
    "download-computer": downloadComputer,
    "download-four": downloadFour,
    "download-laptop": downloadLaptop,
    "download-one": downloadOne,
    "download-three": downloadThree,
    "download-two": downloadTwo,
    "download-web": downloadWeb,
    "drag": drag,
    "dragon-zodiac": dragonZodiac,
    "dribble": dribble,
    "drink": drink,
    "drone": drone,
    "drone-one": droneOne,
    "drop-down-list": dropDownList,
    "drop-shadow-down": dropShadowDown,
    "drop-shadow-left": dropShadowLeft,
    "drop-shadow-right": dropShadowRight,
    "drop-shadow-up": dropShadowUp,
    "dropbox": dropbox,
    "drumstick": drumstick,
    "dubai": dubai,
    "duck": duck,
    "dumbbel-line": dumbbelLine,
    "dumbbell": dumbbell,
    "dvi": dvi,
    "eagle": eagle,
    "earth": earth,
    "easy": easy,
    "ecg": ecg,
    "edit": edit,
    "edit-movie": editMovie,
    "edit-name": editName,
    "edit-one": editOne,
    "edit-two": editTwo,
    "editing": editing,
    "editor": editor,
    "eeg": eeg,
    "effects": effects,
    "efferent-four": efferentFour,
    "efferent-three": efferentThree,
    "egg": egg,
    "egg-one": eggOne,
    "eggplant": eggplant,
    "eiffel-tower": eiffelTower,
    "eight-key": eightKey,
    "electric-drill": electricDrill,
    "electric-iron": electricIron,
    "electric-wave": electricWave,
    "electrocardiogram": electrocardiogram,
    "electronic-door-lock": electronicDoorLock,
    "electronic-locks-close": electronicLocksClose,
    "electronic-locks-open": electronicLocksOpen,
    "electronic-pen": electronicPen,
    "elephant": elephant,
    "elevator": elevator,
    "email-block": emailBlock,
    "email-delect": emailDelect,
    "email-down": emailDown,
    "email-fail": emailFail,
    "email-lock": emailLock,
    "email-push": emailPush,
    "email-search": emailSearch,
    "email-security": emailSecurity,
    "email-successfully": emailSuccessfully,
    "emotion-happy": emotionHappy,
    "emotion-unhappy": emotionUnhappy,
    "empty": empty,
    "end-time-sort": endTimeSort,
    "endless": endless,
    "endocrine": endocrine,
    "endpoint-displacement": endpointDisplacement,
    "endpoint-flat": endpointFlat,
    "endpoint-round": endpointRound,
    "endpoint-square": endpointSquare,
    "energy-socket": energySocket,
    "engineering-brand": engineeringBrand,
    "engineering-vehicle": engineeringVehicle,
    "english": english,
    "english-mustache": englishMustache,
    "enquire": enquire,
    "enter-key": enterKey,
    "enter-key-one": enterKeyOne,
    "enter-the-keyboard": enterTheKeyboard,
    "entertainment": entertainment,
    "envelope": envelope,
    "envelope-one": envelopeOne,
    "equal-ratio": equalRatio,
    "equalizer": equalizer,
    "erase": erase,
    "error": error,
    "error-computer": errorComputer,
    "error-picture": errorPicture,
    "error-prompt": errorPrompt,
    "escalators": escalators,
    "ethernet-off": ethernetOff,
    "ethernet-on": ethernetOn,
    "every-user": everyUser,
    "excel": excel,
    "excel-one": excelOne,
    "exchange": exchange,
    "exchange-four": exchangeFour,
    "exchange-one": exchangeOne,
    "exchange-three": exchangeThree,
    "exchange-two": exchangeTwo,
    "exclude-selection": excludeSelection,
    "exclusive-gateway": exclusiveGateway,
    "expand-down": expandDown,
    "expand-down-one": expandDownOne,
    "expand-left": expandLeft,
    "expand-left-and-right": expandLeftAndRight,
    "expand-right": expandRight,
    "expand-text-input": expandTextInput,
    "expand-up": expandUp,
    "expenses": expenses,
    "expenses-one": expensesOne,
    "experiment": experiment,
    "experiment-one": experimentOne,
    "export": export,
    "express-delivery": expressDelivery,
    "expressionless-face": expressionlessFace,
    "extend": extend,
    "external-transmission": externalTransmission,
    "eyebrow": eyebrow,
    "eyes": eyes,
    "f-eight-key": fEightKey,
    "f-five-key": fFiveKey,
    "f-four-key": fFourKey,
    "f-n-key": fNKey,
    "f-nine-key": fNineKey,
    "f-one-key": fOneKey,
    "f-seven-key": fSevenKey,
    "f-six-key": fSixKey,
    "f-three-key": fThreeKey,
    "f-two-key": fTwoKey,
    "f-zero-key": fZeroKey,
    "face-powder": facePowder,
    "face-recognition": faceRecognition,
    "face-with-smiling-open-eyes": faceWithSmilingOpenEyes,
    "face-without-mouth": faceWithoutMouth,
    "facebook": facebook,
    "facebook-one": facebookOne,
    "facetime": facetime,
    "faceu": faceu,
    "facial-cleanser": facialCleanser,
    "facial-mask": facialMask,
    "factory-building": factoryBuilding,
    "fail-picture": failPicture,
    "family": family,
    "fan": fan,
    "fanqiexiaoshuo": fanqiexiaoshuo,
    "feelgood": feelgood,
    "feelgood-one": feelgoodOne,
    "feiyu": feiyu,
    "female": female,
    "fence-one": fenceOne,
    "fence-two": fenceTwo,
    "ferris-wheel": ferrisWheel,
    "figma": figma,
    "figma-component": figmaComponent,
    "figma-flatten-selection": figmaFlattenSelection,
    "figma-mask": figmaMask,
    "figma-reset-instance": figmaResetInstance,
    "file-addition": fileAddition,
    "file-addition-one": fileAdditionOne,
    "file-cabinet": fileCabinet,
    "file-code": fileCode,
    "file-code-one": fileCodeOne,
    "file-collection": fileCollection,
    "file-collection-one": fileCollectionOne,
    "file-conversion": fileConversion,
    "file-conversion-one": fileConversionOne,
    "file-date": fileDate,
    "file-date-one": fileDateOne,
    "file-display": fileDisplay,
    "file-display-one": fileDisplayOne,
    "file-doc": fileDoc,
    "file-editing": fileEditing,
    "file-editing-one": fileEditingOne,
    "file-excel": fileExcel,
    "file-failed": fileFailed,
    "file-failed-one": fileFailedOne,
    "file-focus": fileFocus,
    "file-focus-one": fileFocusOne,
    "file-gif": fileGif,
    "file-hash": fileHash,
    "file-hash-one": fileHashOne,
    "file-hiding": fileHiding,
    "file-hiding-one": fileHidingOne,
    "file-jpg": fileJpg,
    "file-lock": fileLock,
    "file-lock-one": fileLockOne,
    "file-music": fileMusic,
    "file-music-one": fileMusicOne,
    "file-pdf": filePdf,
    "file-pdf-one": filePdfOne,
    "file-ppt": filePpt,
    "file-protection": fileProtection,
    "file-protection-one": fileProtectionOne,
    "file-quality": fileQuality,
    "file-quality-one": fileQualityOne,
    "file-question": fileQuestion,
    "file-removal": fileRemoval,
    "file-removal-one": fileRemovalOne,
    "file-search": fileSearch,
    "file-search-one": fileSearchOne,
    "file-search-two": fileSearchTwo,
    "file-settings": fileSettings,
    "file-settings-one": fileSettingsOne,
    "file-staff": fileStaff,
    "file-staff-one": fileStaffOne,
    "file-success": fileSuccess,
    "file-success-one": fileSuccessOne,
    "file-text": fileText,
    "file-text-one": fileTextOne,
    "file-tips": fileTips,
    "file-tips-one": fileTipsOne,
    "file-txt": fileTxt,
    "file-txt-one": fileTxtOne,
    "file-withdrawal": fileWithdrawal,
    "file-withdrawal-one": fileWithdrawalOne,
    "file-word": fileWord,
    "file-zip": fileZip,
    "fill": fill,
    "film": film,
    "filter": filter,
    "filter-one": filterOne,
    "finance": finance,
    "financing": financing,
    "financing-one": financingOne,
    "financing-two": financingTwo,
    "find": find,
    "find-one": findOne,
    "fingernail": fingernail,
    "fingerprint": fingerprint,
    "fingerprint-three": fingerprintThree,
    "fingerprint-two": fingerprintTwo,
    "fire": fire,
    "fire-extinguisher": fireExtinguisher,
    "fire-extinguisher-one": fireExtinguisherOne,
    "fire-two": fireTwo,
    "fireworks": fireworks,
    "first": first,
    "first-aid-kit": firstAidKit,
    "fish": fish,
    "fish-one": fishOne,
    "fishing": fishing,
    "fist": fist,
    "fitness": fitness,
    "five": five,
    "five-ellipses": fiveEllipses,
    "five-five": fiveFive,
    "five-key": fiveKey,
    "five-star-badge": fiveStarBadge,
    "flag": flag,
    "flash-payment": flashPayment,
    "flashlamp": flashlamp,
    "flashlight": flashlight,
    "flask": flask,
    "flight-airflow": flightAirflow,
    "flight-safety": flightSafety,
    "flip-camera": flipCamera,
    "flip-horizontally": flipHorizontally,
    "flip-vertically": flipVertically,
    "flirt": flirt,
    "float": float,
    "floor-tile": floorTile,
    "fm": fm,
    "focus": focus,
    "focus-one": focusOne,
    "fog": fog,
    "fold-up-one": foldUpOne,
    "folder": folder,
    "folder-block": folderBlock,
    "folder-block-one": folderBlockOne,
    "folder-close": folderClose,
    "folder-code": folderCode,
    "folder-code-one": folderCodeOne,
    "folder-conversion": folderConversion,
    "folder-conversion-one": folderConversionOne,
    "folder-download": folderDownload,
    "folder-failed": folderFailed,
    "folder-failed-one": folderFailedOne,
    "folder-focus": folderFocus,
    "folder-focus-one": folderFocusOne,
    "folder-lock": folderLock,
    "folder-lock-one": folderLockOne,
    "folder-minus": folderMinus,
    "folder-music": folderMusic,
    "folder-music-one": folderMusicOne,
    "folder-one": folderOne,
    "folder-open": folderOpen,
    "folder-plus": folderPlus,
    "folder-protection": folderProtection,
    "folder-protection-one": folderProtectionOne,
    "folder-quality": folderQuality,
    "folder-quality-one": folderQualityOne,
    "folder-search": folderSearch,
    "folder-search-one": folderSearchOne,
    "folder-settings": folderSettings,
    "folder-settings-one": folderSettingsOne,
    "folder-success": folderSuccess,
    "folder-success-one": folderSuccessOne,
    "folder-upload": folderUpload,
    "folder-withdrawal": folderWithdrawal,
    "folder-withdrawal-one": folderWithdrawalOne,
    "follow-up-date-sort": followUpDateSort,
    "font-search": fontSearch,
    "font-size": fontSize,
    "font-size-two": fontSizeTwo,
    "foot": foot,
    "football": football,
    "forbid": forbid,
    "fork": fork,
    "fork-spoon": forkSpoon,
    "form": form,
    "form-one": formOne,
    "format": format,
    "format-brush": formatBrush,
    "formula": formula,
    "foundation-makeup": foundationMakeup,
    "four": four,
    "four-arrows": fourArrows,
    "four-four": fourFour,
    "four-key": fourKey,
    "four-leaves": fourLeaves,
    "four-point-connection": fourPointConnection,
    "four-round-point-connection": fourRoundPointConnection,
    "foursquare": foursquare,
    "freeze-column": freezeColumn,
    "freeze-line": freezeLine,
    "freezing-line-column": freezingLineColumn,
    "french-fries": frenchFries,
    "friends-circle": friendsCircle,
    "frigate": frigate,
    "frog": frog,
    "frowning-face-whit-open-mouth": frowningFaceWhitOpenMouth,
    "fruiter": fruiter,
    "full-dress-longuette": fullDressLonguette,
    "full-screen": fullScreen,
    "full-screen-one": fullScreenOne,
    "full-screen-play": fullScreenPlay,
    "full-screen-two": fullScreenTwo,
    "full-selection": fullSelection,
    "fullwidth": fullwidth,
    "funds": funds,
    "future-build-one": futureBuildOne,
    "future-build-three": futureBuildThree,
    "future-build-two": futureBuildTwo,
    "game": game,
    "game-console": gameConsole,
    "game-console-one": gameConsoleOne,
    "game-emoji": gameEmoji,
    "game-handle": gameHandle,
    "game-ps": gamePs,
    "game-three": gameThree,
    "game-two": gameTwo,
    "gamepad": gamepad,
    "garage": garage,
    "garlic": garlic,
    "gas": gas,
    "gastrointestinal": gastrointestinal,
    "gate": gate,
    "gate-machine": gateMachine,
    "gauze": gauze,
    "gavel": gavel,
    "gemini": gemini,
    "general-branch": generalBranch,
    "geometric-flowers": geometricFlowers,
    "germs": germs,
    "ghost": ghost,
    "gift": gift,
    "gift-bag": giftBag,
    "gift-box": giftBox,
    "girl": girl,
    "girl-one": girlOne,
    "girl-two": girlTwo,
    "github": github,
    "github-one": githubOne,
    "gitlab": gitlab,
    "glasses": glasses,
    "glasses-one": glassesOne,
    "glasses-three": glassesThree,
    "globe": globe,
    "glove": glove,
    "go-ahead": goAhead,
    "go-end": goEnd,
    "go-on": goOn,
    "go-start": goStart,
    "goblet": goblet,
    "goblet-cracking": gobletCracking,
    "goblet-full": gobletFull,
    "goblet-one": gobletOne,
    "gold-medal": goldMedal,
    "gold-medal-two": goldMedalTwo,
    "golf-course": golfCourse,
    "gongfu": gongfu,
    "good": good,
    "good-one": goodOne,
    "good-two": goodTwo,
    "google": google,
    "google-ads": googleAds,
    "gopro": gopro,
    "gps": gps,
    "graphic-design": graphicDesign,
    "graphic-design-two": graphicDesignTwo,
    "graphic-stitching": graphicStitching,
    "graphic-stitching-four": graphicStitchingFour,
    "graphic-stitching-three": graphicStitchingThree,
    "great-wall": greatWall,
    "green-house": greenHouse,
    "green-new-energy": greenNewEnergy,
    "grid-four": gridFour,
    "grid-nine": gridNine,
    "grid-sixteen": gridSixteen,
    "grid-three": gridThree,
    "grid-two": gridTwo,
    "grimacing-face": grimacingFace,
    "grinning-face": grinningFace,
    "grinning-face-with-open-mouth": grinningFaceWithOpenMouth,
    "grinning-face-with-squinting-eyes": grinningFaceWithSquintingEyes,
    "grinning-face-with-tightly-closed-eyes": grinningFaceWithTightlyClosedEyes,
    "grinning-face-with-tightly-closed-eyes-open-mouth": grinningFaceWithTightlyClosedEyesOpenMouth,
    "group": group,
    "guide-board": guideBoard,
    "gymnastics": gymnastics,
    "gymnastics-one": gymnasticsOne,
    "h": h,
    "h1": h1,
    "h2": h2,
    "h3": h3,
    "hair-brush": hairBrush,
    "hair-clip": hairClip,
    "hair-dryer": hairDryer,
    "hair-dryer-one": hairDryerOne,
    "halo": halo,
    "hamburger": hamburger,
    "hamburger-button": hamburgerButton,
    "hamburger-one": hamburgerOne,
    "hammer-and-anvil": hammerAndAnvil,
    "hand-cream": handCream,
    "hand-down": handDown,
    "hand-drag": handDrag,
    "hand-left": handLeft,
    "hand-painted-plate": handPaintedPlate,
    "hand-right": handRight,
    "hand-up": handUp,
    "handbag": handbag,
    "handheld": handheld,
    "handle-a": handleA,
    "handle-b": handleB,
    "handle-c": handleC,
    "handle-down": handleDown,
    "handle-left": handleLeft,
    "handle-right": handleRight,
    "handle-round": handleRound,
    "handle-square": handleSquare,
    "handle-triangle": handleTriangle,
    "handle-up": handleUp,
    "handle-x": handleX,
    "handle-y": handleY,
    "handle-z": handleZ,
    "hands": hands,
    "handwashing": handwashing,
    "handwashing-fluid": handwashingFluid,
    "hanfu-chinese-style": hanfuChineseStyle,
    "hanger": hanger,
    "hanger-one": hangerOne,
    "hanger-two": hangerTwo,
    "hard-disk": hardDisk,
    "hard-disk-one": hardDiskOne,
    "harm": harm,
    "hashtag-key": hashtagKey,
    "hat": hat,
    "hdd": hdd,
    "hdmi-cable": hdmiCable,
    "hdmi-connector": hdmiConnector,
    "headphone-sound": headphoneSound,
    "headset": headset,
    "headset-one": headsetOne,
    "headset-two": headsetTwo,
    "headwear": headwear,
    "health": health,
    "health-products": healthProducts,
    "healthy-recognition": healthyRecognition,
    "heart": heart,
    "heart-ballon": heartBallon,
    "heart-rate": heartRate,
    "heartbeat": heartbeat,
    "heater-resistor": heaterResistor,
    "heavy-metal": heavyMetal,
    "heavy-rain": heavyRain,
    "heavy-wind": heavyWind,
    "helmet": helmet,
    "helmet-one": helmetOne,
    "help": help,
    "helpcenter": helpcenter,
    "hexagon-one": hexagonOne,
    "hexagon-strip": hexagonStrip,
    "hexagonal": hexagonal,
    "hi": hi,
    "high-heeled-shoes": highHeeledShoes,
    "high-light": highLight,
    "high-speed-rail": highSpeedRail,
    "hippo": hippo,
    "histogram": histogram,
    "history": history,
    "history-query": historyQuery,
    "hockey": hockey,
    "hold": hold,
    "hold-interface": holdInterface,
    "hold-seeds": holdSeeds,
    "holding-hands": holdingHands,
    "holy-sword": holySword,
    "home": home,
    "home-two": homeTwo,
    "homestay": homestay,
    "honey": honey,
    "honey-one": honeyOne,
    "horizontal-spacing-between-items": horizontalSpacingBetweenItems,
    "horizontal-tidy-up": horizontalTidyUp,
    "horizontally-centered": horizontallyCentered,
    "horse-zodiac": horseZodiac,
    "hospital": hospital,
    "hospital-bed": hospitalBed,
    "hospital-four": hospitalFour,
    "hospital-three": hospitalThree,
    "hospital-two": hospitalTwo,
    "hot-air-balloon": hotAirBalloon,
    "hot-pot": hotPot,
    "hot-pot-one": hotPotOne,
    "hotel": hotel,
    "hotel-do-not-clean": hotelDoNotClean,
    "hotel-please-clean": hotelPleaseClean,
    "hourglass": hourglass,
    "hourglass-full": hourglassFull,
    "hourglass-null": hourglassNull,
    "html-five": htmlFive,
    "hunting-gear": huntingGear,
    "huoshanzhibo": huoshanzhibo,
    "i-mac": iMac,
    "icecream": icecream,
    "icecream-five": icecreamFive,
    "icecream-four": icecreamFour,
    "icecream-one": icecreamOne,
    "icecream-three": icecreamThree,
    "icecream-two": icecreamTwo,
    "id-card": idCard,
    "id-card-h": idCardH,
    "id-card-v": idCardV,
    "image-files": imageFiles,
    "imbalance": imbalance,
    "import-and-export": importAndExport,
    "in-flight": inFlight,
    "inbox": inbox,
    "inbox-download-r": inboxDownloadR,
    "inbox-in": inboxIn,
    "inbox-out": inboxOut,
    "inbox-r": inboxR,
    "inbox-success": inboxSuccess,
    "inbox-success-r": inboxSuccessR,
    "inbox-upload-r": inboxUploadR,
    "inclusive-gateway": inclusiveGateway,
    "income": income,
    "income-one": incomeOne,
    "incoming": incoming,
    "increase": increase,
    "increase-the-scale": increaseTheScale,
    "indent-left": indentLeft,
    "indent-right": indentRight,
    "index-finger": indexFinger,
    "induction-lock": inductionLock,
    "industrial-scales": industrialScales,
    "info": info,
    "infusion": infusion,
    "injection": injection,
    "inline": inline,
    "inner-shadow-bottom-left": innerShadowBottomLeft,
    "inner-shadow-bottom-right": innerShadowBottomRight,
    "inner-shadow-down": innerShadowDown,
    "inner-shadow-left": innerShadowLeft,
    "inner-shadow-right": innerShadowRight,
    "inner-shadow-top-left": innerShadowTopLeft,
    "inner-shadow-top-right": innerShadowTopRight,
    "inner-shadow-up": innerShadowUp,
    "insert-card": insertCard,
    "insert-table": insertTable,
    "inspection": inspection,
    "instagram": instagram,
    "instagram-one": instagramOne,
    "install": install,
    "instruction": instruction,
    "intercom": intercom,
    "intermediate-mode": intermediateMode,
    "internal-data": internalData,
    "internal-expansion": internalExpansion,
    "internal-reduction": internalReduction,
    "internal-transmission": internalTransmission,
    "international": international,
    "intersect-selection": intersectSelection,
    "intersection": intersection,
    "invalid-files": invalidFiles,
    "invert-camera": invertCamera,
    "invert-left": invertLeft,
    "invert-right": invertRight,
    "ios-face-recognition": iosFaceRecognition,
    "ipad": ipad,
    "ipad-one": ipadOne,
    "iphone": iphone,
    "ipo": ipo,
    "iron": iron,
    "iron-disable": ironDisable,
    "iron-three": ironThree,
    "iron-two": ironTwo,
    "iwatch": iwatch,
    "iwatch-one": iwatchOne,
    "iwatch-two": iwatchTwo,
    "jewelry": jewelry,
    "jinritoutiao": jinritoutiao,
    "journey": journey,
    "joystick": joystick,
    "juice": juice,
    "jump": jump,
    "kagi-map": kagiMap,
    "kettle": kettle,
    "kettle-one": kettleOne,
    "key": key,
    "key-one": keyOne,
    "key-two": keyTwo,
    "keyboard": keyboard,
    "keyboard-one": keyboardOne,
    "keyhole": keyhole,
    "keyline": keyline,
    "kitchen-knife": kitchenKnife,
    "knife-fork": knifeFork,
    "koala-bear": koalaBear,
    "kungfu": kungfu,
    "label": label,
    "ladder": ladder,
    "ladder-one": ladderOne,
    "lamp": lamp,
    "land-surveying": landSurveying,
    "landing": landing,
    "landscape": landscape,
    "laptop": laptop,
    "laptop-computer": laptopComputer,
    "laptop-one": laptopOne,
    "lark": lark,
    "lark-one": larkOne,
    "lattice-pattern": latticePattern,
    "layers": layers,
    "layout-five": layoutFive,
    "layout-four": layoutFour,
    "layout-one": layoutOne,
    "layout-three": layoutThree,
    "layout-two": layoutTwo,
    "leaf": leaf,
    "leaves": leaves,
    "leaves-one": leavesOne,
    "leaves-two": leavesTwo,
    "led-diode": ledDiode,
    "left": left,
    "left-alignment": leftAlignment,
    "left-and-right-branch": leftAndRightBranch,
    "left-bar": leftBar,
    "left-branch": leftBranch,
    "left-c": leftC,
    "left-expand": leftExpand,
    "left-one": leftOne,
    "left-small": leftSmall,
    "left-small-down": leftSmallDown,
    "left-small-up": leftSmallUp,
    "left-square": leftSquare,
    "left-two": leftTwo,
    "lemon": lemon,
    "lens-alignment": lensAlignment,
    "leo": leo,
    "level": level,
    "level-adjustment": levelAdjustment,
    "level-eight-title": levelEightTitle,
    "level-five-title": levelFiveTitle,
    "level-four-title": levelFourTitle,
    "level-nine-title": levelNineTitle,
    "level-seven-title": levelSevenTitle,
    "level-six-title": levelSixTitle,
    "libra": libra,
    "lifebuoy": lifebuoy,
    "light": light,
    "light-house": lightHouse,
    "light-member": lightMember,
    "light-rain": lightRain,
    "lightning": lightning,
    "like": like,
    "lincoln": lincoln,
    "link": link,
    "link-break": linkBreak,
    "link-cloud": linkCloud,
    "link-cloud-faild": linkCloudFaild,
    "link-cloud-sucess": linkCloudSucess,
    "link-four": linkFour,
    "link-in": linkIn,
    "link-interrupt": linkInterrupt,
    "link-left": linkLeft,
    "link-one": linkOne,
    "link-out": linkOut,
    "link-right": linkRight,
    "link-three": linkThree,
    "link-two": linkTwo,
    "lip-gloss": lipGloss,
    "lip-tattoo": lipTattoo,
    "lipstick": lipstick,
    "lipstick-one": lipstickOne,
    "liqueur": liqueur,
    "list": list,
    "list-add": listAdd,
    "list-alphabet": listAlphabet,
    "list-bottom": listBottom,
    "list-checkbox": listCheckbox,
    "list-fail": listFail,
    "list-middle": listMiddle,
    "list-numbers": listNumbers,
    "list-one": listOne,
    "list-success": listSuccess,
    "list-top": listTop,
    "list-two": listTwo,
    "list-view": listView,
    "loading": loading,
    "loading-four": loadingFour,
    "loading-one": loadingOne,
    "loading-three": loadingThree,
    "loading-two": loadingTwo,
    "local": local,
    "local-pin": localPin,
    "local-two": localTwo,
    "lock": lock,
    "lock-one": lockOne,
    "locking-computer": lockingComputer,
    "locking-laptop": lockingLaptop,
    "locking-picture": lockingPicture,
    "locking-web": lockingWeb,
    "log": log,
    "login": login,
    "logout": logout,
    "lollipop": lollipop,
    "loop-once": loopOnce,
    "lotion": lotion,
    "lotus": lotus,
    "loudly-crying-face": loudlyCryingFace,
    "loudly-crying-face-whit-open-mouth": loudlyCryingFaceWhitOpenMouth,
    "love-and-help": loveAndHelp,
    "lower-branch": lowerBranch,
    "luggage": luggage,
    "luminous": luminous,
    "lung": lung,
    "mac-finder": macFinder,
    "macadamia-nut": macadamiaNut,
    "magic": magic,
    "magic-hat": magicHat,
    "magic-wand": magicWand,
    "magnet": magnet,
    "mail": mail,
    "mail-download": mailDownload,
    "mail-edit": mailEdit,
    "mail-open": mailOpen,
    "mail-package": mailPackage,
    "mail-review": mailReview,
    "mail-unpacking": mailUnpacking,
    "maill-one": maillOne,
    "makeups": makeups,
    "male": male,
    "mall-bag": mallBag,
    "manual-gear": manualGear,
    "many-to-many": manyToMany,
    "map-distance": mapDistance,
    "map-draw": mapDraw,
    "map-road": mapRoad,
    "map-road-two": mapRoadTwo,
    "map-two": mapTwo,
    "margin": margin,
    "margin-one": marginOne,
    "mark": mark,
    "market": market,
    "market-analysis": marketAnalysis,
    "mascara": mascara,
    "mask": mask,
    "mask-one": maskOne,
    "mask-two": maskTwo,
    "maslow-pyramids": maslowPyramids,
    "massage-chair": massageChair,
    "massage-chair-one": massageChairOne,
    "massage-table": massageTable,
    "master": master,
    "material": material,
    "material-three": materialThree,
    "material-two": materialTwo,
    "maximum": maximum,
    "maya": maya,
    "mayura-gesture": mayuraGesture,
    "me": me,
    "measuring-cup": measuringCup,
    "medal-one": medalOne,
    "mediaeditor": mediaeditor,
    "medical-box": medicalBox,
    "medical-files": medicalFiles,
    "medical-mark": medicalMark,
    "medication-time": medicationTime,
    "medicine-bottle": medicineBottle,
    "medicine-bottle-one": medicineBottleOne,
    "medicine-chest": medicineChest,
    "memory": memory,
    "memory-card": memoryCard,
    "memory-card-one": memoryCardOne,
    "memory-one": memoryOne,
    "men-jacket": menJacket,
    "menu-fold": menuFold,
    "menu-fold-one": menuFoldOne,
    "menu-unfold": menuUnfold,
    "menu-unfold-one": menuUnfoldOne,
    "merge": merge,
    "merge-cells": mergeCells,
    "message": message,
    "message-emoji": messageEmoji,
    "message-failed": messageFailed,
    "message-one": messageOne,
    "message-privacy": messagePrivacy,
    "message-search": messageSearch,
    "message-security": messageSecurity,
    "message-sent": messageSent,
    "message-success": messageSuccess,
    "message-unread": messageUnread,
    "messages": messages,
    "messages-one": messagesOne,
    "micro-sd": microSd,
    "micro-slr-camera": microSlrCamera,
    "microphone": microphone,
    "microphone-one": microphoneOne,
    "microscope": microscope,
    "microscope-one": microscopeOne,
    "microwave-oven": microwaveOven,
    "microwaves": microwaves,
    "middle-finger": middleFinger,
    "milk": milk,
    "milk-one": milkOne,
    "min": min,
    "mind-mapping": mindMapping,
    "mindmap-list": mindmapList,
    "mindmap-map": mindmapMap,
    "mini-sd-card": miniSdCard,
    "minus": minus,
    "minus-the-bottom": minusTheBottom,
    "minus-the-top": minusTheTop,
    "mirror": mirror,
    "mirror-one": mirrorOne,
    "mirror-two": mirrorTwo,
    "misaligned-semicircle": misalignedSemicircle,
    "mitsubishi": mitsubishi,
    "modify": modify,
    "modify-two": modifyTwo,
    "monitor": monitor,
    "monitor-camera": monitorCamera,
    "monitor-off": monitorOff,
    "monitor-one": monitorOne,
    "monitor-two": monitorTwo,
    "monkey": monkey,
    "monkey-zodiac": monkeyZodiac,
    "monument-one": monumentOne,
    "monument-two": monumentTwo,
    "moon": moon,
    "more": more,
    "more-app": moreApp,
    "more-four": moreFour,
    "more-one": moreOne,
    "more-three": moreThree,
    "more-two": moreTwo,
    "mosaic": mosaic,
    "mountain": mountain,
    "mounted": mounted,
    "mouse": mouse,
    "mouse-one": mouseOne,
    "mouse-zodiac": mouseZodiac,
    "mouth": mouth,
    "move": move,
    "move-in": moveIn,
    "move-in-one": moveInOne,
    "move-one": moveOne,
    "movie": movie,
    "movie-board": movieBoard,
    "moving-picture": movingPicture,
    "multi-circular": multiCircular,
    "multi-function-knife": multiFunctionKnife,
    "multi-picture-carousel": multiPictureCarousel,
    "multi-rectangle": multiRectangle,
    "multi-ring": multiRing,
    "multi-triangular": multiTriangular,
    "multi-triangular-four": multiTriangularFour,
    "multi-triangular-three": multiTriangularThree,
    "multi-triangular-two": multiTriangularTwo,
    "multicast": multicast,
    "multilayer-sphere": multilayerSphere,
    "muscle": muscle,
    "museum-one": museumOne,
    "museum-two": museumTwo,
    "music": music,
    "music-cd": musicCd,
    "music-list": musicList,
    "music-menu": musicMenu,
    "music-one": musicOne,
    "music-rhythm": musicRhythm,
    "mute": mute,
    "nail-polish": nailPolish,
    "nail-polish-one": nailPolishOne,
    "nasal": nasal,
    "natural-mode": naturalMode,
    "navigation": navigation,
    "necktie": necktie,
    "needle": needle,
    "negative-dynamics": negativeDynamics,
    "nested-arrows": nestedArrows,
    "nests": nests,
    "network-drive": networkDrive,
    "network-tree": networkTree,
    "neural": neural,
    "neutral-face": neutralFace,
    "new-afferent": newAfferent,
    "new-computer": newComputer,
    "new-dianziqian": newDianziqian,
    "new-efferent": newEfferent,
    "new-lark": newLark,
    "new-picture": newPicture,
    "newlybuild": newlybuild,
    "newspaper-folding": newspaperFolding,
    "next": next,
    "nine-key": nineKey,
    "nine-points-connected": ninePointsConnected,
    "nintendo-switch": nintendoSwitch,
    "nmr": nmr,
    "no-shooting": noShooting,
    "node-flat": nodeFlat,
    "node-round": nodeRound,
    "node-square": nodeSquare,
    "noodles": noodles,
    "notebook": notebook,
    "notebook-and-pen": notebookAndPen,
    "notebook-one": notebookOne,
    "notepad": notepad,
    "notes": notes,
    "nuclear-plant": nuclearPlant,
    "nurse-cap": nurseCap,
    "nut": nut,
    "nutrition": nutrition,
    "oceanengine": oceanengine,
    "octagon": octagon,
    "off-screen": offScreen,
    "off-screen-one": offScreenOne,
    "off-screen-two": offScreenTwo,
    "oil-industry": oilIndustry,
    "okay": okay,
    "one": one,
    "one-key": oneKey,
    "one-one": oneOne,
    "one-third-rotation": oneThirdRotation,
    "one-to-many": oneToMany,
    "one-to-one": oneToOne,
    "onesies": onesies,
    "online-meeting": onlineMeeting,
    "open": open,
    "open-an-account": openAnAccount,
    "open-door": openDoor,
    "open-one": openOne,
    "optimize": optimize,
    "optional": optional,
    "orange": orange,
    "orange-one": orangeOne,
    "orange-station": orangeStation,
    "order": order,
    "ordered-list": orderedList,
    "orthopedic": orthopedic,
    "oscillator": oscillator,
    "other": other,
    "outbound": outbound,
    "outdoor": outdoor,
    "outgoing": outgoing,
    "oval-love": ovalLove,
    "oval-love-two": ovalLoveTwo,
    "oval-one": ovalOne,
    "oven": oven,
    "oven-tray": ovenTray,
    "overall-reduction": overallReduction,
    "owl": owl,
    "pacifier": pacifier,
    "pad": pad,
    "page": page,
    "page-template": pageTemplate,
    "pagoda": pagoda,
    "paint": paint,
    "painted-eggshell": paintedEggshell,
    "painted-screen": paintedScreen,
    "palace": palace,
    "palm": palm,
    "panda": panda,
    "pangle": pangle,
    "panorama-horizontal": panoramaHorizontal,
    "panties": panties,
    "paper-money": paperMoney,
    "paper-money-two": paperMoneyTwo,
    "paper-ship": paperShip,
    "paperclip": paperclip,
    "parabola": parabola,
    "parachute": parachute,
    "paragraph-alphabet": paragraphAlphabet,
    "paragraph-break": paragraphBreak,
    "paragraph-break-two": paragraphBreakTwo,
    "paragraph-cut": paragraphCut,
    "paragraph-rectangle": paragraphRectangle,
    "paragraph-round": paragraphRound,
    "paragraph-triangle": paragraphTriangle,
    "paragraph-unfold": paragraphUnfold,
    "parallel-gateway": parallelGateway,
    "parallelogram": parallelogram,
    "parenting-book": parentingBook,
    "parking": parking,
    "party-balloon": partyBalloon,
    "passport": passport,
    "passport-one": passportOne,
    "pause": pause,
    "pause-one": pauseOne,
    "pay-code": payCode,
    "pay-code-one": payCodeOne,
    "pay-code-two": payCodeTwo,
    "payment-method": paymentMethod,
    "paypal": paypal,
    "peach": peach,
    "pear": pear,
    "pearl-of-the-orient": pearlOfTheOrient,
    "peas": peas,
    "pencil": pencil,
    "pennant": pennant,
    "pentagon-one": pentagonOne,
    "people": people,
    "people-bottom": peopleBottom,
    "people-bottom-card": peopleBottomCard,
    "people-delete": peopleDelete,
    "people-delete-one": peopleDeleteOne,
    "people-download": peopleDownload,
    "people-left": peopleLeft,
    "people-minus": peopleMinus,
    "people-minus-one": peopleMinusOne,
    "people-plus": peoplePlus,
    "people-plus-one": peoplePlusOne,
    "people-right": peopleRight,
    "people-safe": peopleSafe,
    "people-safe-one": peopleSafeOne,
    "people-search": peopleSearch,
    "people-search-one": peopleSearchOne,
    "people-speak": peopleSpeak,
    "people-top": peopleTop,
    "people-top-card": peopleTopCard,
    "people-unknown": peopleUnknown,
    "people-upload": peopleUpload,
    "peoples": peoples,
    "peoples-two": peoplesTwo,
    "percentage": percentage,
    "performance": performance,
    "perfume": perfume,
    "perfumer-bottle": perfumerBottle,
    "period": period,
    "permissions": permissions,
    "personal-collection": personalCollection,
    "personal-privacy": personalPrivacy,
    "perspective": perspective,
    "pesticide": pesticide,
    "petrol": petrol,
    "phone": phone,
    "phone-booth": phoneBooth,
    "phone-call": phoneCall,
    "phone-incoming": phoneIncoming,
    "phone-incoming-one": phoneIncomingOne,
    "phone-missed": phoneMissed,
    "phone-off": phoneOff,
    "phone-one": phoneOne,
    "phone-outgoing": phoneOutgoing,
    "phone-outgoing-one": phoneOutgoingOne,
    "phone-telephone": phoneTelephone,
    "phone-two": phoneTwo,
    "phone-video-call": phoneVideoCall,
    "phonograph": phonograph,
    "photograph": photograph,
    "piano": piano,
    "pic": pic,
    "pic-one": picOne,
    "picture": picture,
    "picture-album": pictureAlbum,
    "picture-one": pictureOne,
    "pie": pie,
    "pie-five": pieFive,
    "pie-four": pieFour,
    "pie-one": pieOne,
    "pie-seven": pieSeven,
    "pie-six": pieSix,
    "pie-three": pieThree,
    "pie-two": pieTwo,
    "pig": pig,
    "pig-zodiac": pigZodiac,
    "pigeon": pigeon,
    "pill": pill,
    "pills": pills,
    "pin": pin,
    "pineapple": pineapple,
    "pinwheel": pinwheel,
    "pisces": pisces,
    "pivot-table": pivotTable,
    "plan": plan,
    "planet": planet,
    "plastic-surgery": plasticSurgery,
    "platte": platte,
    "play": play,
    "play-basketball": playBasketball,
    "play-cycle": playCycle,
    "play-once": playOnce,
    "play-one": playOne,
    "play-two": playTwo,
    "play-volleyball": playVolleyball,
    "play-wrong": playWrong,
    "playback-progress": playbackProgress,
    "plug": plug,
    "plug-one": plugOne,
    "plus": plus,
    "plus-cross": plusCross,
    "point": point,
    "point-out": pointOut,
    "pokeball-one": pokeballOne,
    "poker": poker,
    "popcorn": popcorn,
    "popcorn-one": popcornOne,
    "positive-dynamics": positiveDynamics,
    "pot": pot,
    "potentiometer": potentiometer,
    "pound": pound,
    "pound-sign": poundSign,
    "pouting-face": poutingFace,
    "powder": powder,
    "power": power,
    "power-supply": powerSupply,
    "power-supply-one": powerSupplyOne,
    "powerpoint": powerpoint,
    "ppt": ppt,
    "pregnant-women": pregnantWomen,
    "preschool": preschool,
    "prescription": prescription,
    "press": press,
    "preview-close": previewClose,
    "preview-close-one": previewCloseOne,
    "preview-open": previewOpen,
    "printer": printer,
    "printer-one": printerOne,
    "printer-two": printerTwo,
    "prison": prison,
    "process-line": processLine,
    "projector": projector,
    "projector-one": projectorOne,
    "projector-three": projectorThree,
    "projector-two": projectorTwo,
    "proportional-scaling": proportionalScaling,
    "protect": protect,
    "protection": protection,
    "public-toilet": publicToilet,
    "pull-door": pullDoor,
    "pull-requests": pullRequests,
    "pumpkin": pumpkin,
    "pure-natural": pureNatural,
    "push-door": pushDoor,
    "pushpin": pushpin,
    "puzzle": puzzle,
    "pyramid": pyramid,
    "pyramid-one": pyramidOne,
    "qingniao-clue": qingniaoClue,
    "qiyehao": qiyehao,
    "quadrangular-pyramid": quadrangularPyramid,
    "quadrilateral": quadrilateral,
    "quote": quote,
    "rabbit": rabbit,
    "rabbit-zodiac": rabbitZodiac,
    "radar": radar,
    "radar-chart": radarChart,
    "radar-three": radarThree,
    "radar-two": radarTwo,
    "radiation": radiation,
    "radio": radio,
    "radio-nanny": radioNanny,
    "radio-one": radioOne,
    "radio-two": radioTwo,
    "radish": radish,
    "radish-one": radishOne,
    "railway": railway,
    "ranking": ranking,
    "ranking-list": rankingList,
    "rattle": rattle,
    "rattle-one": rattleOne,
    "razor": razor,
    "read-book": readBook,
    "receive": receive,
    "receiver": receiver,
    "recent-views-sort": recentViewsSort,
    "record": record,
    "record-disc": recordDisc,
    "record-player": recordPlayer,
    "rectangle": rectangle,
    "rectangle-one": rectangleOne,
    "rectangle-small": rectangleSmall,
    "rectangle-tear": rectangleTear,
    "rectangle-x": rectangleX,
    "rectangular-circular-connection": rectangularCircularConnection,
    "rectangular-circular-separation": rectangularCircularSeparation,
    "rectangular-vertebra": rectangularVertebra,
    "recycle-bin": recycleBin,
    "recycling": recycling,
    "recycling-pool": recyclingPool,
    "red-cross": redCross,
    "red-envelope": redEnvelope,
    "red-envelopes": redEnvelopes,
    "redo": redo,
    "reduce": reduce,
    "reduce-decimal-places": reduceDecimalPlaces,
    "reduce-one": reduceOne,
    "reduce-two": reduceTwo,
    "reduce-user": reduceUser,
    "reel": reel,
    "refraction": refraction,
    "refresh": refresh,
    "refresh-one": refreshOne,
    "refrigerator": refrigerator,
    "reject": reject,
    "relational-graph": relationalGraph,
    "relieved-face": relievedFace,
    "reload": reload,
    "remind": remind,
    "remind-disable": remindDisable,
    "remote-control": remoteControl,
    "remote-control-one": remoteControlOne,
    "renal": renal,
    "renault": renault,
    "repair": repair,
    "replay-five": replayFive,
    "replay-music": replayMusic,
    "report": report,
    "repositioning": repositioning,
    "resistor": resistor,
    "respect": respect,
    "resting": resting,
    "retro-bag": retroBag,
    "return": return_,
    "reverse-lens": reverseLens,
    "reverse-lens-one": reverseLensOne,
    "reverse-operation-in": reverseOperationIn,
    "reverse-operation-out": reverseOperationOut,
    "reverse-rotation": reverseRotation,
    "rice": rice,
    "riding": riding,
    "riding-one": ridingOne,
    "right": right,
    "right-angle": rightAngle,
    "right-bar": rightBar,
    "right-branch": rightBranch,
    "right-branch-one": rightBranchOne,
    "right-branch-two": rightBranchTwo,
    "right-c": rightC,
    "right-expand": rightExpand,
    "right-one": rightOne,
    "right-run": rightRun,
    "right-small": rightSmall,
    "right-small-down": rightSmallDown,
    "right-small-up": rightSmallUp,
    "right-square": rightSquare,
    "right-two": rightTwo,
    "right-user": rightUser,
    "ring": ring,
    "ring-one": ringOne,
    "rings": rings,
    "ripple": ripple,
    "road": road,
    "road-cone": roadCone,
    "road-one": roadOne,
    "road-sign": roadSign,
    "road-sign-both": roadSignBoth,
    "robot": robot,
    "robot-one": robotOne,
    "robot-two": robotTwo,
    "rock": rock,
    "rock-gesture": rockGesture,
    "rocket": rocket,
    "rocket-one": rocketOne,
    "rocking-horse": rockingHorse,
    "rollerskates": rollerskates,
    "romper": romper,
    "rope-skipping": ropeSkipping,
    "rope-skipping-one": ropeSkippingOne,
    "rotate": rotate,
    "rotate-one": rotateOne,
    "rotating-add": rotatingAdd,
    "rotating-forward": rotatingForward,
    "rotation": rotation,
    "rotation-horizontal": rotationHorizontal,
    "rotation-one": rotationOne,
    "rotation-vertical": rotationVertical,
    "round": round,
    "round-caliper": roundCaliper,
    "round-distortion": roundDistortion,
    "round-mask": roundMask,
    "round-socket": roundSocket,
    "round-trip": roundTrip,
    "router": router,
    "router-one": routerOne,
    "row-height": rowHeight,
    "rowing": rowing,
    "rs-male": rsMale,
    "rss": rss,
    "rugby": rugby,
    "rugby-one": rugbyOne,
    "rule-two": ruleTwo,
    "ruler": ruler,
    "ruler-one": rulerOne,
    "run-left": runLeft,
    "s-turn-down": sTurnDown,
    "s-turn-left": sTurnLeft,
    "s-turn-right": sTurnRight,
    "s-turn-up": sTurnUp,
    "safe-retrieval": safeRetrieval,
    "sagittarius": sagittarius,
    "sailboat": sailboat,
    "sailboat-one": sailboatOne,
    "sailing": sailing,
    "sales-report": salesReport,
    "sandals": sandals,
    "sandstorm": sandstorm,
    "sandwich": sandwich,
    "sandwich-one": sandwichOne,
    "sapling": sapling,
    "save": save,
    "save-one": saveOne,
    "scale": scale,
    "scale-one": scaleOne,
    "scallion": scallion,
    "scan": scan,
    "scan-code": scanCode,
    "scan-setting": scanSetting,
    "scanning": scanning,
    "scanning-two": scanningTwo,
    "scatter-alignment": scatterAlignment,
    "schedule": schedule,
    "school": school,
    "scissors": scissors,
    "scoreboard": scoreboard,
    "scorpio": scorpio,
    "screen-rotation": screenRotation,
    "screenshot": screenshot,
    "screenshot-one": screenshotOne,
    "screenshot-two": screenshotTwo,
    "screwdriver": screwdriver,
    "sd": sd,
    "sd-card": sdCard,
    "seal": seal,
    "search": search,
    "seat": seat,
    "security": security,
    "security-stall": securityStall,
    "seedling": seedling,
    "selected": selected,
    "selected-focus": selectedFocus,
    "selfie": selfie,
    "send": send,
    "send-backward": sendBackward,
    "send-email": sendEmail,
    "send-one": sendOne,
    "send-to-back": sendToBack,
    "sent-to-back": sentToBack,
    "seo": seo,
    "seo-folder": seoFolder,
    "server": server,
    "set-off": setOff,
    "setting": setting,
    "setting-computer": settingComputer,
    "setting-config": settingConfig,
    "setting-laptop": settingLaptop,
    "setting-one": settingOne,
    "setting-three": settingThree,
    "setting-two": settingTwo,
    "setting-web": settingWeb,
    "seven-key": sevenKey,
    "shade": shade,
    "shake": shake,
    "share": share,
    "share-one": shareOne,
    "share-sys": shareSys,
    "share-three": shareThree,
    "share-two": shareTwo,
    "shaver": shaver,
    "shaver-one": shaverOne,
    "shaving": shaving,
    "sheep-zodiac": sheepZodiac,
    "shield": shield,
    "shield-add": shieldAdd,
    "ship": ship,
    "shop": shop,
    "shopping": shopping,
    "shopping-bag": shoppingBag,
    "shopping-bag-one": shoppingBagOne,
    "shopping-cart": shoppingCart,
    "shopping-cart-add": shoppingCartAdd,
    "shopping-cart-del": shoppingCartDel,
    "shopping-cart-one": shoppingCartOne,
    "shopping-cart-two": shoppingCartTwo,
    "shopping-mall": shoppingMall,
    "short-skirt": shortSkirt,
    "shorts": shorts,
    "shoulder-bag": shoulderBag,
    "shovel": shovel,
    "shovel-one": shovelOne,
    "shower-head": showerHead,
    "shrimp": shrimp,
    "shuffle": shuffle,
    "shuffle-one": shuffleOne,
    "shutter-priority": shutterPriority,
    "sickbed": sickbed,
    "signal": signal,
    "signal-one": signalOne,
    "signal-strength": signalStrength,
    "signal-tower": signalTower,
    "signal-tower-one": signalTowerOne,
    "sim": sim,
    "sim-card": simCard,
    "single-bed": singleBed,
    "sinusoid": sinusoid,
    "sippy-cup": sippyCup,
    "six": six,
    "six-circular-connection": sixCircularConnection,
    "six-key": sixKey,
    "six-points": sixPoints,
    "skate": skate,
    "skates": skates,
    "skating": skating,
    "sketch": sketch,
    "skiing-nordic": skiingNordic,
    "skull": skull,
    "slave": slave,
    "sleaves": sleaves,
    "sleep": sleep,
    "sleep-one": sleepOne,
    "sleep-two": sleepTwo,
    "slide": slide,
    "slide-two": slideTwo,
    "sliding-horizontal": slidingHorizontal,
    "sliding-vertical": slidingVertical,
    "slightly-frowning-face-whit-open-mouth": slightlyFrowningFaceWhitOpenMouth,
    "slightly-smiling-face": slightlySmilingFace,
    "slippers": slippers,
    "slippers-one": slippersOne,
    "sly-face-whit-smile": slyFaceWhitSmile,
    "smart-optimization": smartOptimization,
    "smiling-face": smilingFace,
    "smiling-face-with-squinting-eyes": smilingFaceWithSquintingEyes,
    "snacks": snacks,
    "snake-zodiac": snakeZodiac,
    "snow": snow,
    "snowflake": snowflake,
    "snowman": snowman,
    "soap-bubble": soapBubble,
    "soccer": soccer,
    "soccer-one": soccerOne,
    "socks": socks,
    "sofa": sofa,
    "sofa-two": sofaTwo,
    "softball": softball,
    "solar-energy": solarEnergy,
    "solar-energy-one": solarEnergyOne,
    "solid-state-disk": solidStateDisk,
    "sorcerer-hat": sorcererHat,
    "sort": sort,
    "sort-amount-down": sortAmountDown,
    "sort-amount-up": sortAmountUp,
    "sort-four": sortFour,
    "sort-one": sortOne,
    "sort-three": sortThree,
    "sort-two": sortTwo,
    "sound": sound,
    "sound-one": soundOne,
    "sound-wave": soundWave,
    "source-code": sourceCode,
    "soybean-milk-maker": soybeanMilkMaker,
    "spa-candle": spaCandle,
    "space-colony": spaceColony,
    "spanner": spanner,
    "speaker": speaker,
    "speaker-one": speakerOne,
    "speed": speed,
    "speed-one": speedOne,
    "sperm": sperm,
    "sphere": sphere,
    "spider-man": spiderMan,
    "spikedshoes": spikedshoes,
    "spinning-top": spinningTop,
    "split": split,
    "split-branch": splitBranch,
    "split-cells": splitCells,
    "split-turn-down-left": splitTurnDownLeft,
    "split-turn-down-right": splitTurnDownRight,
    "spoon": spoon,
    "sport": sport,
    "sporting": sporting,
    "square": square,
    "square-small": squareSmall,
    "ssd": ssd,
    "stack-light": stackLight,
    "stamp": stamp,
    "stand-up": standUp,
    "stapler": stapler,
    "star": star,
    "star-one": starOne,
    "start-time-sort": startTimeSort,
    "steering-wheel": steeringWheel,
    "steoller": steoller,
    "stereo-nesting": stereoNesting,
    "stereo-one": stereoOne,
    "stereo-perspective": stereoPerspective,
    "stethoscope": stethoscope,
    "stickers": stickers,
    "stock-market": stockMarket,
    "stopwatch": stopwatch,
    "stopwatch-start": stopwatchStart,
    "storage-card-one": storageCardOne,
    "storage-card-two": storageCardTwo,
    "straight-razor": straightRazor,
    "straw-hat": strawHat,
    "stretching": stretching,
    "stretching-one": stretchingOne,
    "strikethrough": strikethrough,
    "strongbox": strongbox,
    "subtract-selection": subtractSelection,
    "subtract-selection-one": subtractSelectionOne,
    "subway": subway,
    "success": success,
    "success-picture": successPicture,
    "sum": sum,
    "sun": sun,
    "sun-hat": sunHat,
    "sun-one": sunOne,
    "sunbath": sunbath,
    "sunny": sunny,
    "sunrise": sunrise,
    "sunset": sunset,
    "sunshade": sunshade,
    "surprised-face-with-open-big-mouth": surprisedFaceWithOpenBigMouth,
    "surprised-face-with-open-mouth": surprisedFaceWithOpenMouth,
    "surveillance-cameras": surveillanceCameras,
    "surveillance-cameras-one": surveillanceCamerasOne,
    "surveillance-cameras-two": surveillanceCamerasTwo,
    "swallow": swallow,
    "sweater": sweater,
    "swimming-pool": swimmingPool,
    "swimming-ring": swimmingRing,
    "swimsuit": swimsuit,
    "swing": swing,
    "swipe": swipe,
    "switch": switch_,
    "switch-button": switchButton,
    "switch-contrast": switchContrast,
    "switch-nintendo": switchNintendo,
    "switch-one": switchOne,
    "switch-themes": switchThemes,
    "switch-track": switchTrack,
    "switching-done": switchingDone,
    "symbol": symbol,
    "symbol-double-x": symbolDoubleX,
    "symmetry": symmetry,
    "sync": sync,
    "system": system,
    "t-shirt": tShirt,
    "table": table,
    "table-file": tableFile,
    "table-lamp": tableLamp,
    "table-report": tableReport,
    "tabletennis": tabletennis,
    "tag": tag_,
    "tag-one": tagOne,
    "tailoring": tailoring,
    "tailoring-two": tailoringTwo,
    "taj-mahal": tajMahal,
    "take-off": takeOff,
    "take-off-one": takeOffOne,
    "taobao": taobao,
    "tape": tape,
    "tape-measure": tapeMeasure,
    "target": target,
    "target-one": targetOne,
    "target-two": targetTwo,
    "taurus": taurus,
    "taxi": taxi,
    "tea": tea,
    "tea-drink": teaDrink,
    "teapot": teapot,
    "teeth": teeth,
    "telegram": telegram,
    "telescope": telescope,
    "tencent-qq": tencentQq,
    "tennis": tennis,
    "tent": tent,
    "tent-banner": tentBanner,
    "terminal": terminal,
    "termination-file": terminationFile,
    "terrace": terrace,
    "test-tube": testTube,
    "text": text,
    "text-bold": textBold,
    "text-italic": textItalic,
    "text-message": textMessage,
    "text-recognition": textRecognition,
    "text-rotation-down": textRotationDown,
    "text-rotation-left": textRotationLeft,
    "text-rotation-none": textRotationNone,
    "text-rotation-up": textRotationUp,
    "text-style": textStyle,
    "text-style-one": textStyleOne,
    "text-underline": textUnderline,
    "text-wrap-overflow": textWrapOverflow,
    "text-wrap-truncation": textWrapTruncation,
    "textarea": textarea,
    "texture": texture,
    "texture-two": textureTwo,
    "the-single-shoulder-bag": theSingleShoulderBag,
    "theater": theater,
    "theme": theme,
    "thermometer": thermometer,
    "thermometer-one": thermometerOne,
    "thermos-cup": thermosCup,
    "thin": thin,
    "thinking-problem": thinkingProblem,
    "three": three,
    "three-d-glasses": threeDGlasses,
    "three-hexagons": threeHexagons,
    "three-key": threeKey,
    "three-slashes": threeSlashes,
    "three-three": threeThree,
    "three-triangles": threeTriangles,
    "thumbs-down": thumbsDown,
    "thumbs-up": thumbsUp,
    "thunderbolt": thunderbolt,
    "thunderstorm": thunderstorm,
    "thunderstorm-one": thunderstormOne,
    "ticket": ticket,
    "ticket-one": ticketOne,
    "tickets-checked": ticketsChecked,
    "tickets-one": ticketsOne,
    "tickets-two": ticketsTwo,
    "tiger-zodiac": tigerZodiac,
    "tiktok": tiktok,
    "time": time,
    "timed-mail": timedMail,
    "timeline": timeline,
    "timer": timer,
    "tips": tips,
    "tips-one": tipsOne,
    "tire-swing": tireSwing,
    "title-level": titleLevel,
    "to-bottom": toBottom,
    "to-bottom-one": toBottomOne,
    "to-left": toLeft,
    "to-right": toRight,
    "to-top": toTop,
    "to-top-one": toTopOne,
    "toilet": toilet,
    "tomato": tomato,
    "tool": tool,
    "toolkit": toolkit,
    "top-bar": topBar,
    "topbuzz": topbuzz,
    "topic": topic,
    "topic-discussion": topicDiscussion,
    "torch": torch,
    "tour-bus": tourBus,
    "towel": towel,
    "tower": tower,
    "tower-of-babel": towerOfBabel,
    "tower-of-pisa": towerOfPisa,
    "toxins": toxins,
    "trace": trace,
    "trademark": trademark,
    "traditional-chinese-medicine": traditionalChineseMedicine,
    "train": train,
    "transaction": transaction,
    "transaction-order": transactionOrder,
    "transfer": transfer,
    "transfer-data": transferData,
    "transform": transform,
    "translate": translate,
    "translation": translation,
    "transport": transport,
    "transporter": transporter,
    "trapezoid": trapezoid,
    "tray": tray,
    "treadmill": treadmill,
    "treadmill-one": treadmillOne,
    "treadmill-two": treadmillTwo,
    "treasure-chest": treasureChest,
    "tree": tree,
    "tree-diagram": treeDiagram,
    "tree-list": treeList,
    "tree-one": treeOne,
    "tree-two": treeTwo,
    "trend": trend,
    "trend-two": trendTwo,
    "trending-down": trendingDown,
    "trending-up": trendingUp,
    "triangle": triangle,
    "triangle-round-rectangle": triangleRoundRectangle,
    "triangle-ruler": triangleRuler,
    "triangular-pyramid": triangularPyramid,
    "trophy": trophy,
    "trousers-bell-bottoms": trousersBellBottoms,
    "truck": truck,
    "trumpet": trumpet,
    "trunk": trunk,
    "tub": tub,
    "tuchong": tuchong,
    "tumblr": tumblr,
    "turkey": turkey,
    "turn-around": turnAround,
    "turn-off-bluetooth": turnOffBluetooth,
    "turn-on": turnOn,
    "tv": tv,
    "tv-one": tvOne,
    "twitter": twitter,
    "two": two,
    "two-dimensional-code": twoDimensionalCode,
    "two-dimensional-code-one": twoDimensionalCodeOne,
    "two-dimensional-code-two": twoDimensionalCodeTwo,
    "two-ellipses": twoEllipses,
    "two-fingers": twoFingers,
    "two-hands": twoHands,
    "two-key": twoKey,
    "two-semicircles": twoSemicircles,
    "two-triangles": twoTriangles,
    "two-triangles-two": twoTrianglesTwo,
    "two-two": twoTwo,
    "type-drive": typeDrive,
    "u-disk": uDisk,
    "u-turn-down": uTurnDown,
    "u-turn-left": uTurnLeft,
    "u-turn-right": uTurnRight,
    "u-turn-up": uTurnUp,
    "ulikecam": ulikecam,
    "umbrella": umbrella,
    "umbrella-one": umbrellaOne,
    "umbrella-two": umbrellaTwo,
    "undo": undo,
    "ungroup": ungroup,
    "unicast": unicast,
    "union-selection": unionSelection,
    "universal": universal,
    "unlike": unlike,
    "unlink": unlink,
    "unlock": unlock,
    "unlock-one": unlockOne,
    "unordered-list": unorderedList,
    "up": up,
    "up-and-down": upAndDown,
    "up-c": upC,
    "up-one": upOne,
    "up-small": upSmall,
    "up-square": upSquare,
    "up-two": upTwo,
    "update-rotation": updateRotation,
    "upload": upload,
    "upload-computer": uploadComputer,
    "upload-laptop": uploadLaptop,
    "upload-logs": uploadLogs,
    "upload-one": uploadOne,
    "upload-picture": uploadPicture,
    "upload-three": uploadThree,
    "upload-two": uploadTwo,
    "upload-web": uploadWeb,
    "upside-down-face": upsideDownFace,
    "usb": usb,
    "usb-memory-stick": usbMemoryStick,
    "usb-micro-one": usbMicroOne,
    "usb-micro-two": usbMicroTwo,
    "usb-one": usbOne,
    "usb-type-c": usbTypeC,
    "user": user,
    "user-business": userBusiness,
    "user-positioning": userPositioning,
    "user-to-user-transmission": userToUserTransmission,
    "uterus": uterus,
    "vacation": vacation,
    "vacuum-cleaner": vacuumCleaner,
    "vegetable-basket": vegetableBasket,
    "vegetables": vegetables,
    "vertical-spacing-between-items": verticalSpacingBetweenItems,
    "vertical-tidy-up": verticalTidyUp,
    "vertical-timeline": verticalTimeline,
    "vertically-centered": verticallyCentered,
    "vest": vest,
    "vial": vial,
    "vicia-faba": viciaFaba,
    "video": video,
    "video-conference": videoConference,
    "video-file": videoFile,
    "video-one": videoOne,
    "video-two": videoTwo,
    "videocamera": videocamera,
    "videocamera-one": videocameraOne,
    "viencharts": viencharts,
    "view-grid-card": viewGridCard,
    "view-grid-detail": viewGridDetail,
    "view-grid-list": viewGridList,
    "view-list": viewList,
    "viewfinder": viewfinder,
    "vigo": vigo,
    "vip": vip,
    "vip-one": vipOne,
    "virgo": virgo,
    "virtual-reality-glasses": virtualRealityGlasses,
    "voice": voice,
    "voice-input": voiceInput,
    "voice-message": voiceMessage,
    "voice-off": voiceOff,
    "voice-one": voiceOne,
    "voicemail": voicemail,
    "volkswagen": volkswagen,
    "volleyball": volleyball,
    "volume-down": volumeDown,
    "volume-mute": volumeMute,
    "volume-notice": volumeNotice,
    "volume-small": volumeSmall,
    "volume-up": volumeUp,
    "vr-glasses": vrGlasses,
    "waistline": waistline,
    "wallet": wallet,
    "wallet-one": walletOne,
    "wallet-three": walletThree,
    "wallet-two": walletTwo,
    "warehousing": warehousing,
    "washing-machine": washingMachine,
    "washing-machine-one": washingMachineOne,
    "watch": watch,
    "watch-one": watchOne,
    "water": water,
    "water-level": waterLevel,
    "water-no": waterNo,
    "water-rate": waterRate,
    "water-rate-two": waterRateTwo,
    "waterfalls-h": waterfallsH,
    "waterfalls-v": waterfallsV,
    "watermelon": watermelon,
    "watermelon-one": watermelonOne,
    "waterpolo": waterpolo,
    "waterpolo-one": waterpoloOne,
    "waves": waves,
    "waves-left": wavesLeft,
    "waves-right": wavesRight,
    "weary-face": wearyFace,
    "web-page": webPage,
    "webcam": webcam,
    "wechat": wechat,
    "weibo": weibo,
    "weight": weight,
    "weightlifting": weightlifting,
    "weixin-cards-offers": weixinCardsOffers,
    "weixin-favorites": weixinFavorites,
    "weixin-games": weixinGames,
    "weixin-market": weixinMarket,
    "weixin-mini-app": weixinMiniApp,
    "weixin-people-nearby": weixinPeopleNearby,
    "weixin-scan": weixinScan,
    "weixin-search": weixinSearch,
    "weixin-shake": weixinShake,
    "weixin-top-stories": weixinTopStories,
    "whale": whale,
    "wheelchair": wheelchair,
    "whirlwind": whirlwind,
    "whistling": whistling,
    "whole-site-accelerator": wholeSiteAccelerator,
    "wifi": wifi,
    "wind": wind,
    "wind-turbine": windTurbine,
    "windmill": windmill,
    "windmill-one": windmillOne,
    "windmill-two": windmillTwo,
    "windows": windows,
    "wingsuit-flying": wingsuitFlying,
    "winking-face": winkingFace,
    "winking-face-with-open-eyes": winkingFaceWithOpenEyes,
    "woman": woman,
    "women": women,
    "women-coat": womenCoat,
    "woolen-hat": woolenHat,
    "word": word,
    "workbench": workbench,
    "worker": worker,
    "world": world,
    "worried-face": worriedFace,
    "write": write,
    "writing-fluently": writingFluently,
    "wrong-user": wrongUser,
    "xiaodu": xiaodu,
    "xiaodu-home": xiaoduHome,
    "xigua": xigua,
    "xingfuli": xingfuli,
    "xingtu": xingtu,
    "yep": yep,
    "youtobe": youtobe,
    "youtube": youtube,
    "zero-key": zeroKey,
    "zijinyunying": zijinyunying,
    "zip": zip,
    "zoom": zoom,
    "zoom-in": zoomIn,
    "zoom-internal": zoomInternal,
    "zoom-out": zoomOut,
  };
}
