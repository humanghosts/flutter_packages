import 'package:hg_logger/entity/entities.dart';

import 'icon.dart';

/// 字节跳动IconPark图标 svg类型，官网：https://iconpark.oceanengine.com/official
class IconPark extends SvgIconEnum<SvgIcon> {


  final String fileName;

  IconPark._({required this.fileName}) : super(name: fileName);

  /// 资源文件夹路径
  @override
  String get directory => "assets/icons/svg/iconpark/";

  /// 资源文件路径
  @override
  String get path => "$directory$fileName";

  static IconPark gridSixteen = IconPark._(fileName: "16宫格_grid-sixteen.svg");
  static IconPark dThreeDGlasses = IconPark._(fileName: "3D眼镜_three-d-glasses.svg");
  static IconPark apiApiApp = IconPark._(fileName: "API 应用_api-app.svg");
  static IconPark apiApi = IconPark._(fileName: "API 接口_api.svg");
  static IconPark airplayAirplay = IconPark._(fileName: "AirPlay_airplay.svg");
  static IconPark airpodsAirpods = IconPark._(fileName: "AirPods_airpods.svg");
  static IconPark dviDvi = IconPark._(fileName: "DVI_dvi.svg");
  static IconPark f0FZeroKey = IconPark._(fileName: "F0_f-zero-key.svg");
  static IconPark f1FOneKey = IconPark._(fileName: "F1_f-one-key.svg");
  static IconPark f2FTwoKey = IconPark._(fileName: "F2_f-two-key.svg");
  static IconPark f3FThreeKey = IconPark._(fileName: "F3_f-three-key.svg");
  static IconPark f4FFourKey = IconPark._(fileName: "F4_f-four-key.svg");
  static IconPark f5FFiveKey = IconPark._(fileName: "F5_f-five-key.svg");
  static IconPark f6FSixKey = IconPark._(fileName: "F6_f-six-key.svg");
  static IconPark f7FSevenKey = IconPark._(fileName: "F7_f-seven-key.svg");
  static IconPark f8FEightKey = IconPark._(fileName: "F8_f-eight-key.svg");
  static IconPark f9FNineKey = IconPark._(fileName: "F9_f-nine-key.svg");
  static IconPark figmaFigmaFlattenSelection = IconPark._(fileName: "Figma 选择箭头_figma-flatten-selection.svg");
  static IconPark fnFNKey = IconPark._(fileName: "Fn_f-n-key.svg");
  static IconPark hddHdd = IconPark._(fileName: "HDD_hdd.svg");
  static IconPark hdmiHdmiConnector = IconPark._(fileName: "HDMI接口_hdmi-connector.svg");
  static IconPark hdmiHdmiCable = IconPark._(fileName: "HDMI线_hdmi-cable.svg");
  static IconPark ipadIpad = IconPark._(fileName: "Ipad_ipad.svg");
  static IconPark kChartStock = IconPark._(fileName: "K线图_chart-stock.svg");
  static IconPark qqTencentQq = IconPark._(fileName: "QQ_tencent-qq.svg");
  static IconPark rsRsMale = IconPark._(fileName: "RS_rs-male.svg");
  static IconPark sdSd = IconPark._(fileName: "SD卡_sd.svg");
  static IconPark ssdSsd = IconPark._(fileName: "SSD_ssd.svg");
  static IconPark telegramTelegram = IconPark._(fileName: "Telegram_telegram.svg");
  static IconPark typecUsbTypeC = IconPark._(fileName: "TypeC_usb-type-c.svg");
  static IconPark tTShirt = IconPark._(fileName: "T恤_t-shirt.svg");
  static IconPark u1DiskOne = IconPark._(fileName: "U盘1_disk-one.svg");
  static IconPark u2DiskTwo = IconPark._(fileName: "U盘2_disk-two.svg");
  static IconPark uUDisk = IconPark._(fileName: "U盘_u-disk.svg");
  static IconPark uUsbMemoryStick = IconPark._(fileName: "U盘_usb-memory-stick.svg");
  static IconPark vipVip = IconPark._(fileName: "VIP_vip.svg");
  static IconPark vrVrGlasses = IconPark._(fileName: "VR 眼镜_vr-glasses.svg");
  static IconPark adobeIllustrateAdobeIllustrate = IconPark._(fileName: "adobe-illustrate_adobe-illustrate.svg");
  static IconPark adobeIndesignAdobeIndesign = IconPark._(fileName: "adobe-indesign_adobe-indesign.svg");
  static IconPark adobeLightroomAdobeLightroom = IconPark._(fileName: "adobe-lightroom_adobe-lightroom.svg");
  static IconPark adobePhotoshopAdobePhotoshop = IconPark._(fileName: "adobe-photoshop_adobe-photoshop.svg");
  static IconPark behanceBehance = IconPark._(fileName: "behance_behance.svg");
  static IconPark feelgood1FeelgoodOne = IconPark._(fileName: "feelgood1_feelgood-one.svg");
  static IconPark feelgoodFeelgood = IconPark._(fileName: "feelgood_feelgood.svg");
  static IconPark figmaFigma = IconPark._(fileName: "figma_figma.svg");
  static IconPark foursquareFoursquare = IconPark._(fileName: "foursquare_foursquare.svg");
  static IconPark githubGithub = IconPark._(fileName: "github _github.svg");
  static IconPark githubOneGithubOne = IconPark._(fileName: "github-one_github-one.svg");
  static IconPark gitlabGitlab = IconPark._(fileName: "gitlab_gitlab.svg");
  static IconPark hH = IconPark._(fileName: "h_h.svg");
  static IconPark html5HtmlFive = IconPark._(fileName: "html5_html-five.svg");
  static IconPark instagramInstagramOne = IconPark._(fileName: "instagram_instagram-one.svg");
  static IconPark instagramInstagram = IconPark._(fileName: "instagram_instagram.svg");
  static IconPark ipoIpo = IconPark._(fileName: "ipo_ipo.svg");
  static IconPark kagiKagiMap = IconPark._(fileName: "kagi图_kagi-map.svg");
  static IconPark paypalPaypal = IconPark._(fileName: "paypal_paypal.svg");
  static IconPark pdfFilePdfOne = IconPark._(fileName: "pdf文件_file-pdf-one.svg");
  static IconPark pptFilePpt = IconPark._(fileName: "ppt文件_file-ppt.svg");
  static IconPark sketchSketch = IconPark._(fileName: "sketch_sketch.svg");
  static IconPark topbuzzTopbuzz = IconPark._(fileName: "topbuzz_topbuzz.svg");
  static IconPark tumblrTumblr = IconPark._(fileName: "tumblr_tumblr.svg");
  static IconPark txtFileTxtOne = IconPark._(fileName: "txt文件_file-txt-one.svg");
  static IconPark oneOne = IconPark._(fileName: "一_one-one.svg");
  static IconPark one = IconPark._(fileName: "一_one.svg");
  static IconPark oneToOne = IconPark._(fileName: "一对一_one-to-one.svg");
  static IconPark oneToMany = IconPark._(fileName: "一对多_one-to-many.svg");
  static IconPark levelSevenTitle = IconPark._(fileName: "七级标题_level-seven-title.svg");
  static IconPark threeThree = IconPark._(fileName: "三_three-three.svg");
  static IconPark three = IconPark._(fileName: "三_three.svg");
  static IconPark threeTriangles = IconPark._(fileName: "三个三角_three-triangles.svg");
  static IconPark threeHexagons = IconPark._(fileName: "三个菱形_three-hexagons.svg");
  static IconPark threeSlashes = IconPark._(fileName: "三斜杠_three-slashes.svg");
  static IconPark sandwichOne = IconPark._(fileName: "三明治_sandwich-one.svg");
  static IconPark sandwich = IconPark._(fileName: "三明治_sandwich.svg");
  static IconPark triangularPyramid = IconPark._(fileName: "三棱锥_triangular-pyramid.svg");
  static IconPark mitsubishi = IconPark._(fileName: "三菱_mitsubishi.svg");
  static IconPark triangleRoundRectangle = IconPark._(fileName: "三角圆矩形_triangle-round-rectangle.svg");
  static IconPark triangleRuler = IconPark._(fileName: "三角尺_triangle-ruler.svg");
  static IconPark refraction = IconPark._(fileName: "三角形_refraction.svg");
  static IconPark triangle = IconPark._(fileName: "三角形_triangle.svg");
  static IconPark pennant = IconPark._(fileName: "三角旗_pennant.svg");
  static IconPark flask = IconPark._(fileName: "三角杯_flask.svg");
  static IconPark paragraphTriangle = IconPark._(fileName: "三角段落_paragraph-triangle.svg");
  static IconPark upC = IconPark._(fileName: "上-圆_up-c.svg");
  static IconPark upSmall = IconPark._(fileName: "上-小_up-small.svg");
  static IconPark arrowCircleUp = IconPark._(fileName: "上-箭头_arrow-circle-up.svg");
  static IconPark upOne = IconPark._(fileName: "上1_up-one.svg");
  static IconPark upTwo = IconPark._(fileName: "上1_up-two.svg");
  static IconPark up = IconPark._(fileName: "上_up.svg");
  static IconPark goStart = IconPark._(fileName: "上一曲_go-start.svg");
  static IconPark back = IconPark._(fileName: "上一步_back.svg");
  static IconPark upAndDown = IconPark._(fileName: "上下楼_up-and-down.svg");
  static IconPark uploadOne = IconPark._(fileName: "上传1_upload-one.svg");
  static IconPark uploadTwo = IconPark._(fileName: "上传2_upload-two.svg");
  static IconPark uploadThree = IconPark._(fileName: "上传3_upload-three.svg");
  static IconPark upload = IconPark._(fileName: "上传_upload.svg");
  static IconPark uploadLogs = IconPark._(fileName: "上传日志_upload-logs.svg");
  static IconPark uTurnDown = IconPark._(fileName: "上回转_u-turn-down.svg");
  static IconPark alignTopTwo = IconPark._(fileName: "上对齐2_align-top-two.svg");
  static IconPark bringForward = IconPark._(fileName: "上层_bring-forward.svg");
  static IconPark dropShadowUp = IconPark._(fileName: "上投影_drop-shadow-up.svg");
  static IconPark upSquare = IconPark._(fileName: "上箭头-方_up-square.svg");
  static IconPark bellRing = IconPark._(fileName: "上课铃_bell-ring.svg");
  static IconPark downC = IconPark._(fileName: "下-圆_down-c.svg");
  static IconPark downSmall = IconPark._(fileName: "下-小_down-small.svg");
  static IconPark arrowCircleDown = IconPark._(fileName: "下-箭头_arrow-circle-down.svg");
  static IconPark downOne = IconPark._(fileName: "下1_down-one.svg");
  static IconPark downTwo = IconPark._(fileName: "下1_down-two.svg");
  static IconPark down = IconPark._(fileName: "下_down.svg");
  static IconPark goEnd = IconPark._(fileName: "下一曲_go-end.svg");
  static IconPark next = IconPark._(fileName: "下一步_next.svg");
  static IconPark uTurnUp = IconPark._(fileName: "下回转_u-turn-up.svg");
  static IconPark alignBottomTwo = IconPark._(fileName: "下对齐2_align-bottom-two.svg");
  static IconPark sendBackward = IconPark._(fileName: "下层_send-backward.svg");
  static IconPark dropShadowDown = IconPark._(fileName: "下投影_drop-shadow-down.svg");
  static IconPark dropDownList = IconPark._(fileName: "下拉列表_drop-down-list.svg");
  static IconPark downSquare = IconPark._(fileName: "下箭头-方_down-square.svg");
  static IconPark downloadOne = IconPark._(fileName: "下载1_download-one.svg");
  static IconPark downloadTwo = IconPark._(fileName: "下载2_download-two.svg");
  static IconPark downloadThree = IconPark._(fileName: "下载3_download-three.svg");
  static IconPark downloadFour = IconPark._(fileName: "下载_download-four.svg");
  static IconPark download = IconPark._(fileName: "下载_download.svg");
  static IconPark codeDownload = IconPark._(fileName: "下载代码_code-download.svg");
  static IconPark descend = IconPark._(fileName: "下降_descend.svg");
  static IconPark snow = IconPark._(fileName: "下雪_snow.svg");
  static IconPark dislikeTwo = IconPark._(fileName: "不喜欢_dislike-two.svg");
  static IconPark dislike = IconPark._(fileName: "不喜欢_dislike.svg");
  static IconPark unlike = IconPark._(fileName: "不喜欢_unlike.svg");
  static IconPark emotionUnhappy = IconPark._(fileName: "不开心_emotion-unhappy.svg");
  static IconPark world = IconPark._(fileName: "世界_world.svg");
  static IconPark pearlOfTheOrient = IconPark._(fileName: "东方明珠_pearl-of-the-orient.svg");
  static IconPark twoTrianglesTwo = IconPark._(fileName: "两个三角_two-triangles-two.svg");
  static IconPark twoFingers = IconPark._(fileName: "两个手指_two-fingers.svg");
  static IconPark twoEllipses = IconPark._(fileName: "两个椭圆_two-ellipses.svg");
  static IconPark twoHands = IconPark._(fileName: "两只手_two-hands.svg");
  static IconPark connectionPointTwo = IconPark._(fileName: "两点连接_connection-point-two.svg");
  static IconPark personalPrivacy = IconPark._(fileName: "个人隐私_personal-privacy.svg");
  static IconPark chinesePavilion = IconPark._(fileName: "中国楼阁_chinese-pavilion.svg");
  static IconPark hanfuChineseStyle = IconPark._(fileName: "中式汉服_hanfu-chinese-style.svg");
  static IconPark middleFinger = IconPark._(fileName: "中指_middle-finger.svg");
  static IconPark chineseOne = IconPark._(fileName: "中文1_chinese-one.svg");
  static IconPark chinese = IconPark._(fileName: "中文_chinese.svg");
  static IconPark traditionalChineseMedicine = IconPark._(fileName: "中药_traditional-chinese-medicine.svg");
  static IconPark master = IconPark._(fileName: "主机_master.svg");
  static IconPark theme = IconPark._(fileName: "主题_theme.svg");
  static IconPark hands = IconPark._(fileName: "举手_hands.svg");
  static IconPark report = IconPark._(fileName: "举报_report.svg");
  static IconPark weightlifting = IconPark._(fileName: "举重_weightlifting.svg");
  static IconPark tabletennis = IconPark._(fileName: "乒乓球_tabletennis.svg");
  static IconPark shade = IconPark._(fileName: "乘凉_shade.svg");
  static IconPark gridNine = IconPark._(fileName: "九宫格_grid-nine.svg");
  static IconPark ninePointsConnected = IconPark._(fileName: "九点连接_nine-points-connected.svg");
  static IconPark levelNineTitle = IconPark._(fileName: "九级标题_level-nine-title.svg");
  static IconPark bookmarkOne = IconPark._(fileName: "书签_bookmark-one.svg");
  static IconPark bookmark = IconPark._(fileName: "书签_bookmark.svg");
  static IconPark bookOpen = IconPark._(fileName: "书籍-打开_book-open.svg");
  static IconPark bookOne = IconPark._(fileName: "书籍1_book-one.svg");
  static IconPark book = IconPark._(fileName: "书籍_book.svg");
  static IconPark bookshelf = IconPark._(fileName: "书籍_bookshelf.svg");
  static IconPark lotion = IconPark._(fileName: "乳液_lotion.svg");
  static IconPark twoTwo = IconPark._(fileName: "二_two-two.svg");
  static IconPark two = IconPark._(fileName: "二_two.svg");
  static IconPark twoDimensionalCodeOne = IconPark._(fileName: "二维码_two-dimensional-code-one.svg");
  static IconPark twoDimensionalCodeTwo = IconPark._(fileName: "二维码_two-dimensional-code-two.svg");
  static IconPark twoDimensionalCode = IconPark._(fileName: "二维码_two-dimensional-code.svg");
  static IconPark linkCloudFaild = IconPark._(fileName: "云中断_link-cloud-faild.svg");
  static IconPark networkDrive = IconPark._(fileName: "云办公_network-drive.svg");
  static IconPark cloudStorage = IconPark._(fileName: "云存储_cloud-storage.svg");
  static IconPark linkCloud = IconPark._(fileName: "云运行_link-cloud.svg");
  static IconPark linkCloudSucess = IconPark._(fileName: "云连接_link-cloud-sucess.svg");
  static IconPark fiveFive = IconPark._(fileName: "五_five-five.svg");
  static IconPark five = IconPark._(fileName: "五_five.svg");
  static IconPark fiveEllipses = IconPark._(fileName: "五个椭圆_five-ellipses.svg");
  static IconPark fiveStarBadge = IconPark._(fileName: "五星徽章_five-star-badge.svg");
  static IconPark levelFiveTitle = IconPark._(fileName: "五级标题_level-five-title.svg");
  static IconPark pentagonOne = IconPark._(fileName: "五边形_pentagon-one.svg");
  static IconPark poundSign = IconPark._(fileName: "井号_pound-sign.svg");
  static IconPark pound = IconPark._(fileName: "井号_pound.svg");
  static IconPark fileHashOne = IconPark._(fileName: "井号文件1_file-hash-one.svg");
  static IconPark fileHash = IconPark._(fileName: "井号文件_file-hash.svg");
  static IconPark hashtagKey = IconPark._(fileName: "井号键_hashtag-key.svg");
  static IconPark crossRing = IconPark._(fileName: "交叉环_cross-ring.svg");
  static IconPark transactionOrder = IconPark._(fileName: "交易清单_transaction-order.svg");
  static IconPark delivery = IconPark._(fileName: "交货_delivery.svg");
  static IconPark intersection = IconPark._(fileName: "交集_intersection.svg");
  static IconPark brightness = IconPark._(fileName: "亮度_brightness.svg");
  static IconPark fileStaffOne = IconPark._(fileName: "人事文件1_file-staff-one.svg");
  static IconPark fileStaff = IconPark._(fileName: "人事文件_file-staff.svg");
  static IconPark peopleTopCard = IconPark._(fileName: "人像卡片上_people-top-card.svg");
  static IconPark peopleBottomCard = IconPark._(fileName: "人像卡片下_people-bottom-card.svg");
  static IconPark people = IconPark._(fileName: "人员_people.svg");
  static IconPark peopleTop = IconPark._(fileName: "人员上_people-top.svg");
  static IconPark peopleBottom = IconPark._(fileName: "人员下_people-bottom.svg");
  static IconPark peopleRight = IconPark._(fileName: "人员右_people-right.svg");
  static IconPark peopleUnknown = IconPark._(fileName: "人员屏蔽_people-unknown.svg");
  static IconPark peopleLeft = IconPark._(fileName: "人员左_people-left.svg");
  static IconPark peopleSearchOne = IconPark._(fileName: "人员查找_people-search-one.svg");
  static IconPark peopleSpeak = IconPark._(fileName: "人员说话_people-speak.svg");
  static IconPark turnAround = IconPark._(fileName: "人员调动_turn-around.svg");
  static IconPark peoplesTwo = IconPark._(fileName: "人群_peoples-two.svg");
  static IconPark peoples = IconPark._(fileName: "人群_peoples.svg");
  static IconPark faceRecognition = IconPark._(fileName: "人脸识别_face-recognition.svg");
  static IconPark iosFaceRecognition = IconPark._(fileName: "人脸识别_ios-face-recognition.svg");
  static IconPark peopleSafeOne = IconPark._(fileName: "人身安全1_people-safe-one.svg");
  static IconPark peopleSafe = IconPark._(fileName: "人身安全_people-safe.svg");
  static IconPark jinritoutiao = IconPark._(fileName: "今日头条_jinritoutiao.svg");
  static IconPark huntingGear = IconPark._(fileName: "从动装置_hunting-gear.svg");
  static IconPark payCodeOne = IconPark._(fileName: "付款码_pay-code-one.svg");
  static IconPark code = IconPark._(fileName: "代码_code.svg");
  static IconPark fileCodeOne = IconPark._(fileName: "代码文件1_file-code-one.svg");
  static IconPark fileCode = IconPark._(fileName: "代码文件_file-code.svg");
  static IconPark folderCodeOne = IconPark._(fileName: "代码文件夹1_folder-code-one.svg");
  static IconPark folderCode = IconPark._(fileName: "代码文件夹_folder-code.svg");
  static IconPark dashboardCar = IconPark._(fileName: "仪表盘_dashboard-car.svg");
  static IconPark dashboardOne = IconPark._(fileName: "仪表盘_dashboard-one.svg");
  static IconPark dashboardTwo = IconPark._(fileName: "仪表盘_dashboard-two.svg");
  static IconPark dashboard = IconPark._(fileName: "仪表盘_dashboard.svg");
  static IconPark switchNintendo = IconPark._(fileName: "任天堂游戏_switch-nintendo.svg");
  static IconPark nintendoSwitch = IconPark._(fileName: "任天堂游戏机_nintendo-switch.svg");
  static IconPark qiyehao = IconPark._(fileName: "企业号_qiyehao.svg");
  static IconPark resting = IconPark._(fileName: "休闲_resting.svg");
  static IconPark everyUser = IconPark._(fileName: "众多用户_every-user.svg");
  static IconPark youtube = IconPark._(fileName: "优兔_youtube.svg");
  static IconPark coupon = IconPark._(fileName: "优惠券_coupon.svg");
  static IconPark goodOne = IconPark._(fileName: "优秀_good-one.svg");
  static IconPark fileQualityOne = IconPark._(fileName: "优质文件1_file-quality-one.svg");
  static IconPark fileQuality = IconPark._(fileName: "优质文件_file-quality.svg");
  static IconPark afferentTwo = IconPark._(fileName: "传入_afferent-two.svg");
  static IconPark afferent = IconPark._(fileName: "传入_afferent.svg");
  static IconPark outgoing = IconPark._(fileName: "传出_outgoing.svg");
  static IconPark stretching = IconPark._(fileName: "伸展_stretching.svg");
  static IconPark gymnasticsOne = IconPark._(fileName: "体操1_gymnastics-one.svg");
  static IconPark gymnastics = IconPark._(fileName: "体操2_gymnastics.svg");
  static IconPark weight = IconPark._(fileName: "体重_weight.svg");
  static IconPark blockEight = IconPark._(fileName: "俄罗斯方块_block-eight.svg");
  static IconPark blockFive = IconPark._(fileName: "俄罗斯方块_block-five.svg");
  static IconPark blockFour = IconPark._(fileName: "俄罗斯方块_block-four.svg");
  static IconPark blockNine = IconPark._(fileName: "俄罗斯方块_block-nine.svg");
  static IconPark blockOne = IconPark._(fileName: "俄罗斯方块_block-one.svg");
  static IconPark blockSeven = IconPark._(fileName: "俄罗斯方块_block-seven.svg");
  static IconPark blockSix = IconPark._(fileName: "俄罗斯方块_block-six.svg");
  static IconPark blockTen = IconPark._(fileName: "俄罗斯方块_block-ten.svg");
  static IconPark blockThree = IconPark._(fileName: "俄罗斯方块_block-three.svg");
  static IconPark blockTwo = IconPark._(fileName: "俄罗斯方块_block-two.svg");
  static IconPark bless = IconPark._(fileName: "保佑_bless.svg");
  static IconPark healthProducts = IconPark._(fileName: "保健品_health-products.svg");
  static IconPark save = IconPark._(fileName: "保存_save.svg");
  static IconPark saveOne = IconPark._(fileName: "保存硬盘_save-one.svg");
  static IconPark protect = IconPark._(fileName: "保护_protect.svg");
  static IconPark protection = IconPark._(fileName: "保护_protection.svg");
  static IconPark thermosCup = IconPark._(fileName: "保温杯_thermos-cup.svg");
  static IconPark bottomBarOne = IconPark._(fileName: "保留球_bottom-bar-one.svg");
  static IconPark strongbox = IconPark._(fileName: "保险箱_strongbox.svg");
  static IconPark bowling = IconPark._(fileName: "保龄球_bowling.svg");
  static IconPark signalOne = IconPark._(fileName: "信号_signal-one.svg");
  static IconPark signal = IconPark._(fileName: "信号_signal.svg");
  static IconPark signalTowerOne = IconPark._(fileName: "信号塔_signal-tower-one.svg");
  static IconPark signalTower = IconPark._(fileName: "信号塔_signal-tower.svg");
  static IconPark signalStrength = IconPark._(fileName: "信号强度_signal-strength.svg");
  static IconPark envelopeOne = IconPark._(fileName: "信封1_envelope-one.svg");
  static IconPark envelope = IconPark._(fileName: "信封_envelope.svg");
  static IconPark info = IconPark._(fileName: "信息_info.svg");
  static IconPark message = IconPark._(fileName: "信息_message.svg");
  static IconPark messagePrivacy = IconPark._(fileName: "信息加密_message-privacy.svg");
  static IconPark messageFailed = IconPark._(fileName: "信息失败_message-failed.svg");
  static IconPark messageSecurity = IconPark._(fileName: "信息安全_message-security.svg");
  static IconPark messageSent = IconPark._(fileName: "信息已发送_message-sent.svg");
  static IconPark messageSuccess = IconPark._(fileName: "信息成功_message-success.svg");
  static IconPark messageSearch = IconPark._(fileName: "信息搜索_message-search.svg");
  static IconPark credit = IconPark._(fileName: "信用卡_credit.svg");
  static IconPark modifyTwo = IconPark._(fileName: "修改_modify-two.svg");
  static IconPark modify = IconPark._(fileName: "修改_modify.svg");
  static IconPark parking = IconPark._(fileName: "停车场_parking.svg");
  static IconPark health = IconPark._(fileName: "健康_health.svg");
  static IconPark healthyRecognition = IconPark._(fileName: "健康认知_healthy-recognition.svg");
  static IconPark dumbbell = IconPark._(fileName: "健身_dumbbell.svg");
  static IconPark storageCardOne = IconPark._(fileName: "储存卡1_storage-card-one.svg");
  static IconPark storageCardTwo = IconPark._(fileName: "储存卡2_storage-card-two.svg");
  static IconPark memory = IconPark._(fileName: "储存卡_memory.svg");
  static IconPark simCard = IconPark._(fileName: "储存卡_sim-card.svg");
  static IconPark memoryOne = IconPark._(fileName: "储存器_memory-one.svg");
  static IconPark babyOne = IconPark._(fileName: "儿童1_baby-one.svg");
  static IconPark childrenCap = IconPark._(fileName: "儿童帽_children-cap.svg");
  static IconPark childrenPyramid = IconPark._(fileName: "儿童金字塔_children-pyramid.svg");
  static IconPark chargingTreasure = IconPark._(fileName: "充电宝_charging-treasure.svg");
  static IconPark aperturePriority = IconPark._(fileName: "光圈优先_aperture-priority.svg");
  static IconPark halo = IconPark._(fileName: "光晕_halo.svg");
  static IconPark light = IconPark._(fileName: "光源_light.svg");
  static IconPark cd = IconPark._(fileName: "光盘_cd.svg");
  static IconPark recordDisc = IconPark._(fileName: "光盘_record-disc.svg");
  static IconPark exchangeOne = IconPark._(fileName: "兑换1_exchange-one.svg");
  static IconPark exchangeTwo = IconPark._(fileName: "兑换2_exchange-two.svg");
  static IconPark exchangeThree = IconPark._(fileName: "兑换3_exchange-three.svg");
  static IconPark exchangeFour = IconPark._(fileName: "兑换4_exchange-four.svg");
  static IconPark warehousing = IconPark._(fileName: "入库_warehousing.svg");
  static IconPark fullwidth = IconPark._(fileName: "全宽_fullwidth.svg");
  static IconPark fullScreenOne = IconPark._(fileName: "全局放大1_full-screen-one.svg");
  static IconPark fullScreenTwo = IconPark._(fileName: "全局放大2_full-screen-two.svg");
  static IconPark fullScreen = IconPark._(fileName: "全局放大_full-screen.svg");
  static IconPark offScreenOne = IconPark._(fileName: "全局缩小1_off-screen-one.svg");
  static IconPark offScreenTwo = IconPark._(fileName: "全局缩小2_off-screen-two.svg");
  static IconPark offScreen = IconPark._(fileName: "全局缩小_off-screen.svg");
  static IconPark fullScreenPlay = IconPark._(fileName: "全屏播放_full-screen-play.svg");
  static IconPark panoramaHorizontal = IconPark._(fileName: "全景水平_panorama-horizontal.svg");
  static IconPark globe = IconPark._(fileName: "全球_globe.svg");
  static IconPark universal = IconPark._(fileName: "全球旅游_universal.svg");
  static IconPark generalBranch = IconPark._(fileName: "全科_general-branch.svg");
  static IconPark fullSelection = IconPark._(fileName: "全选_full-selection.svg");
  static IconPark allApplication = IconPark._(fileName: "全部_all-application.svg");
  static IconPark levelEightTitle = IconPark._(fileName: "八级标题_level-eight-title.svg");
  static IconPark octagon = IconPark._(fileName: "八边形_octagon.svg");
  static IconPark busTwo = IconPark._(fileName: "公交车_bus-two.svg");
  static IconPark formula = IconPark._(fileName: "公式_formula.svg");
  static IconPark briefcase = IconPark._(fileName: "公文包_briefcase.svg");
  static IconPark six = IconPark._(fileName: "六_six.svg");
  static IconPark sixPoints = IconPark._(fileName: "六个点_six-points.svg");
  static IconPark levelSixTitle = IconPark._(fileName: "六级标题_level-six-title.svg");
  static IconPark hexagonOne = IconPark._(fileName: "六边形1_hexagon-one.svg");
  static IconPark hexagonStrip = IconPark._(fileName: "六边条_hexagon-strip.svg");
  static IconPark hexagonal = IconPark._(fileName: "六边立体_hexagonal.svg");
  static IconPark concern = IconPark._(fileName: "关注_concern.svg");
  static IconPark chartGraph = IconPark._(fileName: "关系图_chart-graph.svg");
  static IconPark relationalGraph = IconPark._(fileName: "关系链_relational-graph.svg");
  static IconPark association = IconPark._(fileName: "关联_association.svg");
  static IconPark keyline = IconPark._(fileName: "关键线_keyline.svg");
  static IconPark closeSmall = IconPark._(fileName: "关闭-小_close-small.svg");
  static IconPark closeOne = IconPark._(fileName: "关闭_close-one.svg");
  static IconPark close = IconPark._(fileName: "关闭_close.svg");
  static IconPark voiceOff = IconPark._(fileName: "关闭录音_voice-off.svg");
  static IconPark closeRemind = IconPark._(fileName: "关闭提醒_close-remind.svg");
  static IconPark monitorOff = IconPark._(fileName: "关闭摄像_monitor-off.svg");
  static IconPark closeWifi = IconPark._(fileName: "关闭无线网络_close-wifi.svg");
  static IconPark turnOffBluetooth = IconPark._(fileName: "关闭蓝牙_turn-off-bluetooth.svg");
  static IconPark other = IconPark._(fileName: "其他_other.svg");
  static IconPark innerShadowUp = IconPark._(fileName: "内上投影_inner-shadow-up.svg");
  static IconPark innerShadowDown = IconPark._(fileName: "内下投影_inner-shadow-down.svg");
  static IconPark endocrine = IconPark._(fileName: "内分泌_endocrine.svg");
  static IconPark innerShadowTopRight = IconPark._(fileName: "内右上投影_inner-shadow-top-right.svg");
  static IconPark innerShadowBottomRight = IconPark._(fileName: "内右下投影_inner-shadow-bottom-right.svg");
  static IconPark innerShadowRight = IconPark._(fileName: "内右投影_inner-shadow-right.svg");
  static IconPark innerShadowTopLeft = IconPark._(fileName: "内左上投影_inner-shadow-top-left.svg");
  static IconPark innerShadowBottomLeft = IconPark._(fileName: "内左下投影_inner-shadow-bottom-left.svg");
  static IconPark innerShadowLeft = IconPark._(fileName: "内左投影_inner-shadow-left.svg");
  static IconPark clothesBriefs = IconPark._(fileName: "内裤_clothes-briefs.svg");
  static IconPark panties = IconPark._(fileName: "内裤_panties.svg");
  static IconPark internalTransmission = IconPark._(fileName: "内部传输_internal-transmission.svg");
  static IconPark internalExpansion = IconPark._(fileName: "内部扩大_internal-expansion.svg");
  static IconPark internalData = IconPark._(fileName: "内部数据_internal-data.svg");
  static IconPark internalReduction = IconPark._(fileName: "内部缩小_internal-reduction.svg");
  static IconPark write = IconPark._(fileName: "写作_write.svg");
  static IconPark pesticide = IconPark._(fileName: "农药_pesticide.svg");
  static IconPark coronavirus = IconPark._(fileName: "冠状病毒_coronavirus.svg");
  static IconPark curling = IconPark._(fileName: "冰壶_curling.svg");
  static IconPark icecreamFive = IconPark._(fileName: "冰棍4_icecream-five.svg");
  static IconPark icecreamThree = IconPark._(fileName: "冰棍_icecream-three.svg");
  static IconPark icecreamFour = IconPark._(fileName: "冰激凌_icecream-four.svg");
  static IconPark icecreamTwo = IconPark._(fileName: "冰激凌_icecream-two.svg");
  static IconPark icecream = IconPark._(fileName: "冰激凌_icecream.svg");
  static IconPark refrigerator = IconPark._(fileName: "冰箱_refrigerator.svg");
  static IconPark skates = IconPark._(fileName: "冰鞋_skates.svg");
  static IconPark freezeColumn = IconPark._(fileName: "冻结列_freeze-column.svg");
  static IconPark freezeLine = IconPark._(fileName: "冻结行_freeze-line.svg");
  static IconPark freezingLineColumn = IconPark._(fileName: "冻结行列_freezing-line-column.svg");
  static IconPark medicationTime = IconPark._(fileName: "准时吃药_medication-time.svg");
  static IconPark sandals = IconPark._(fileName: "凉鞋_sandals.svg");
  static IconPark minus = IconPark._(fileName: "减_minus.svg");
  static IconPark subtractSelectionOne = IconPark._(fileName: "减去上一层_subtract-selection-one.svg");
  static IconPark subtractSelection = IconPark._(fileName: "减去下一层_subtract-selection.svg");
  static IconPark reduceOne = IconPark._(fileName: "减少_reduce-one.svg");
  static IconPark reduce = IconPark._(fileName: "减少_reduce.svg");
  static IconPark peopleMinusOne = IconPark._(fileName: "减少人群_people-minus-one.svg");
  static IconPark peopleMinus = IconPark._(fileName: "减少人群_people-minus.svg");
  static IconPark reduceDecimalPlaces = IconPark._(fileName: "减少小数位_reduce-decimal-places.svg");
  static IconPark reduceUser = IconPark._(fileName: "减少用户_reduce-user.svg");
  static IconPark geometricFlowers = IconPark._(fileName: "几何花_geometric-flowers.svg");
  static IconPark arcDeTriomphe = IconPark._(fileName: "凯旋门_arc-de-triomphe.svg");
  static IconPark setOff = IconPark._(fileName: "出发_set-off.svg");
  static IconPark outbound = IconPark._(fileName: "出库_outbound.svg");
  static IconPark taxi = IconPark._(fileName: "出租车_taxi.svg");
  static IconPark knifeFork = IconPark._(fileName: "刀子叉子_knife-fork.svg");
  static IconPark blade = IconPark._(fileName: "刀片_blade.svg");
  static IconPark shareTwo = IconPark._(fileName: "分享2_share-two.svg");
  static IconPark shareThree = IconPark._(fileName: "分享3_share-three.svg");
  static IconPark shareOne = IconPark._(fileName: "分享_share-one.svg");
  static IconPark shareSys = IconPark._(fileName: "分享_share-sys.svg");
  static IconPark share = IconPark._(fileName: "分享_share.svg");
  static IconPark fork = IconPark._(fileName: "分叉_fork.svg");
  static IconPark branchOne = IconPark._(fileName: "分支_branch-one.svg");
  static IconPark branchTwo = IconPark._(fileName: "分支_branch-two.svg");
  static IconPark branch = IconPark._(fileName: "分支_branch.svg");
  static IconPark scatterAlignment = IconPark._(fileName: "分散对齐_scatter-alignment.svg");
  static IconPark analysis = IconPark._(fileName: "分析_analysis.svg");
  static IconPark dividingLine = IconPark._(fileName: "分界线_dividing-line.svg");
  static IconPark splitBranch = IconPark._(fileName: "分离_split-branch.svg");
  static IconPark categoryManagement = IconPark._(fileName: "分类管理_category-management.svg");
  static IconPark connectionBox = IconPark._(fileName: "分组_connection-box.svg");
  static IconPark split = IconPark._(fileName: "分裂_split.svg");
  static IconPark appSwitch = IconPark._(fileName: "切换_app-switch.svg");
  static IconPark switchs = IconPark._(fileName: "切换_switch.svg");
  static IconPark switchThemes = IconPark._(fileName: "切换主题_switch-themes.svg");
  static IconPark switchingDone = IconPark._(fileName: "切换完成_switching-done.svg");
  static IconPark switchContrast = IconPark._(fileName: "切换对比_switch-contrast.svg");
  static IconPark switchButton = IconPark._(fileName: "切换按钮_switch-button.svg");
  static IconPark switchTrack = IconPark._(fileName: "切换轨道_switch-track.svg");
  static IconPark choppingBoard = IconPark._(fileName: "切菜板_chopping-board.svg");
  static IconPark rowing = IconPark._(fileName: "划船_rowing.svg");
  static IconPark column = IconPark._(fileName: "列_column.svg");
  static IconPark listTwo = IconPark._(fileName: "列表2_list-two.svg");
  static IconPark listBottom = IconPark._(fileName: "列表_list-bottom.svg");
  static IconPark listMiddle = IconPark._(fileName: "列表_list-middle.svg");
  static IconPark listOne = IconPark._(fileName: "列表_list-one.svg");
  static IconPark listTop = IconPark._(fileName: "列表_list-top.svg");
  static IconPark list = IconPark._(fileName: "列表_list.svg");
  static IconPark viewGridList = IconPark._(fileName: "列表查看模式_view-grid-list.svg");
  static IconPark listView = IconPark._(fileName: "列表视图_list-view.svg");
  static IconPark newlybuild = IconPark._(fileName: "创建_newlybuild.svg");
  static IconPark creative = IconPark._(fileName: "创意_creative.svg");
  static IconPark deleteOne = IconPark._(fileName: "删除_delete-one.svg");
  static IconPark deleteThree = IconPark._(fileName: "删除_delete-three.svg");
  static IconPark deleteTwo = IconPark._(fileName: "删除_delete-two.svg");
  static IconPark delete = IconPark._(fileName: "删除_delete.svg");
  static IconPark deleteThemes = IconPark._(fileName: "删除主题_delete-themes.svg");
  static IconPark deleteMode = IconPark._(fileName: "删除模式_delete-mode.svg");
  static IconPark peopleDeleteOne = IconPark._(fileName: "删除用户_people-delete-one.svg");
  static IconPark peopleDelete = IconPark._(fileName: "删除用户_people-delete.svg");
  static IconPark strikethrough = IconPark._(fileName: "删除线_strikethrough.svg");
  static IconPark shoppingCartDel = IconPark._(fileName: "删除购物车_shopping-cart-del.svg");
  static IconPark deleteKey = IconPark._(fileName: "删除键_delete-key.svg");
  static IconPark confusedFace = IconPark._(fileName: "别嘴_confused-face.svg");
  static IconPark frowningFaceWhitOpenMouth = IconPark._(fileName: "别嘴生气_frowning-face-whit-open-mouth.svg");
  static IconPark shaving = IconPark._(fileName: "刮胡泡_shaving.svg");
  static IconPark wind = IconPark._(fileName: "刮风_wind.svg");
  static IconPark fileDateOne = IconPark._(fileName: "到期文件1_file-date-one.svg");
  static IconPark fileDate = IconPark._(fileName: "到期文件_file-date.svg");
  static IconPark swipe = IconPark._(fileName: "刷卡_swipe.svg");
  static IconPark refreshOne = IconPark._(fileName: "刷新_refresh-one.svg");
  static IconPark refresh = IconPark._(fileName: "刷新_refresh.svg");
  static IconPark ticket = IconPark._(fileName: "券_ticket.svg");
  static IconPark brakePads = IconPark._(fileName: "刹车片_brake-pads.svg");
  static IconPark razor = IconPark._(fileName: "剃刀_razor.svg");
  static IconPark shaverOne = IconPark._(fileName: "剃须刀_shaver-one.svg");
  static IconPark shaver = IconPark._(fileName: "剃须刀_shaver.svg");
  static IconPark scissors = IconPark._(fileName: "剪刀_scissors.svg");
  static IconPark clipboard = IconPark._(fileName: "剪切板_clipboard.svg");
  static IconPark mediaeditor = IconPark._(fileName: "剪映_mediaeditor.svg");
  static IconPark kungfu = IconPark._(fileName: "功夫_kungfu.svg");
  static IconPark plus = IconPark._(fileName: "加_plus.svg");
  static IconPark addSubtract = IconPark._(fileName: "加减_add-subtract.svg");
  static IconPark arithmeticButtons = IconPark._(fileName: "加减乘除_arithmetic-buttons.svg");
  static IconPark adjustment = IconPark._(fileName: "加减调整_adjustment.svg");
  static IconPark addPrint = IconPark._(fileName: "加印_add-print.svg");
  static IconPark plusCross = IconPark._(fileName: "加号_plus-cross.svg");
  static IconPark fileLockOne = IconPark._(fileName: "加密文件1_file-lock-one.svg");
  static IconPark fileLock = IconPark._(fileName: "加密文件_file-lock.svg");
  static IconPark folderLockOne = IconPark._(fileName: "加密文件夹1_folder-lock-one.svg");
  static IconPark folderLock = IconPark._(fileName: "加密文件夹_folder-lock.svg");
  static IconPark heaterResistor = IconPark._(fileName: "加热电阻_heater-resistor.svg");
  static IconPark loadingFour = IconPark._(fileName: "加载4_loading-four.svg");
  static IconPark loadingOne = IconPark._(fileName: "加载_loading-one.svg");
  static IconPark loadingThree = IconPark._(fileName: "加载_loading-three.svg");
  static IconPark loadingTwo = IconPark._(fileName: "加载_loading-two.svg");
  static IconPark loading = IconPark._(fileName: "加载_loading.svg");
  static IconPark flirt = IconPark._(fileName: "勾引_flirt.svg");
  static IconPark inclusiveGateway = IconPark._(fileName: "包容网关_inclusive-gateway.svg");
  static IconPark cosmeticBrush = IconPark._(fileName: "化妆刷_cosmetic-brush.svg");
  static IconPark paint = IconPark._(fileName: "化妆刷_paint.svg");
  static IconPark blockchain = IconPark._(fileName: "区块链_blockchain.svg");
  static IconPark areaMap = IconPark._(fileName: "区域图_area-map.svg");
  static IconPark medicalFiles = IconPark._(fileName: "医疗档案_medical-files.svg");
  static IconPark medicalBox = IconPark._(fileName: "医疗箱_medical-box.svg");
  static IconPark hospitalTwo = IconPark._(fileName: "医院_hospital-two.svg");
  static IconPark hospital = IconPark._(fileName: "医院_hospital.svg");
  static IconPark sortAmountUp = IconPark._(fileName: "升序排序_sort-amount-up.svg");
  static IconPark misalignedSemicircle = IconPark._(fileName: "半圆_misaligned-semicircle.svg");
  static IconPark intermediateMode = IconPark._(fileName: "半自动模式_intermediate-mode.svg");
  static IconPark agreement = IconPark._(fileName: "协议_agreement.svg");
  static IconPark singleBed = IconPark._(fileName: "单人床_single-bed.svg");
  static IconPark unicast = IconPark._(fileName: "单播_unicast.svg");
  static IconPark theSingleShoulderBag = IconPark._(fileName: "单肩包_the-single-shoulder-bag.svg");
  static IconPark radioTwo = IconPark._(fileName: "单选_radio-two.svg");
  static IconPark pumpkin = IconPark._(fileName: "南瓜_pumpkin.svg");
  static IconPark museumOne = IconPark._(fileName: "博物馆_museum-one.svg");
  static IconPark museumTwo = IconPark._(fileName: "博物馆_museum-two.svg");
  static IconPark chartProportion = IconPark._(fileName: "占比图_chart-proportion.svg");
  static IconPark viewGridCard = IconPark._(fileName: "卡片查看模式_view-grid-card.svg");
  static IconPark publicToilet = IconPark._(fileName: "卫生间_public-toilet.svg");
  static IconPark clothesHoodie = IconPark._(fileName: "卫衣_clothes-hoodie.svg");
  static IconPark seal = IconPark._(fileName: "印章_seal.svg");
  static IconPark harm = IconPark._(fileName: "危害_harm.svg");
  static IconPark historyQuery = IconPark._(fileName: "历史搜索_history-query.svg");
  static IconPark history = IconPark._(fileName: "历史记录_history.svg");
  static IconPark compression = IconPark._(fileName: "压缩_compression.svg");
  static IconPark fileZip = IconPark._(fileName: "压缩文件_file-zip.svg");
  static IconPark zip = IconPark._(fileName: "压缩文件_zip.svg");
  static IconPark chefHat = IconPark._(fileName: "厨师帽_chef-hat.svg");
  static IconPark chefHatOne = IconPark._(fileName: "厨师帽子_chef-hat-one.svg");
  static IconPark toRight = IconPark._(fileName: "去右侧_to-right.svg");
  static IconPark toLeft = IconPark._(fileName: "去左侧_to-left.svg");
  static IconPark toBottomOne = IconPark._(fileName: "去底部1_to-bottom-one.svg");
  static IconPark toBottom = IconPark._(fileName: "去底部_to-bottom.svg");
  static IconPark toTopOne = IconPark._(fileName: "去顶部1_to-top-one.svg");
  static IconPark toTop = IconPark._(fileName: "去顶部_to-top.svg");
  static IconPark forkSpoon = IconPark._(fileName: "叉子勺子_fork-spoon.svg");
  static IconPark xSymbolDoubleX = IconPark._(fileName: "双X符号_symbol-double-x.svg");
  static IconPark doubleUp = IconPark._(fileName: "双上_double-up.svg");
  static IconPark doubleDown = IconPark._(fileName: "双下_double-down.svg");
  static IconPark doubleBed = IconPark._(fileName: "双人床_double-bed.svg");
  static IconPark twoSemicircles = IconPark._(fileName: "双半圆_two-semicircles.svg");
  static IconPark cardTwo = IconPark._(fileName: "双卡片_card-two.svg");
  static IconPark doubleRight = IconPark._(fileName: "双右_double-right.svg");
  static IconPark transferData = IconPark._(fileName: "双向数据互传_transfer-data.svg");
  static IconPark doubleLeft = IconPark._(fileName: "双左_double-left.svg");
  static IconPark reverseLensOne = IconPark._(fileName: "反转相机_reverse-lens-one.svg");
  static IconPark invertCamera = IconPark._(fileName: "反转镜头_invert-camera.svg");
  static IconPark luminous = IconPark._(fileName: "发光_luminous.svg");
  static IconPark ledDiode = IconPark._(fileName: "发光二极管_led-diode.svg");
  static IconPark hairClip = IconPark._(fileName: "发夹_hair-clip.svg");
  static IconPark hairBrush = IconPark._(fileName: "发梳_hair-brush.svg");
  static IconPark discoveryIndex = IconPark._(fileName: "发现指数_discovery-index.svg");
  static IconPark afroPick = IconPark._(fileName: "发簪_afro-pick.svg");
  static IconPark sendOne = IconPark._(fileName: "发送1_send-one.svg");
  static IconPark send = IconPark._(fileName: "发送_send.svg");
  static IconPark sendEmail = IconPark._(fileName: "发送邮件_send-email.svg");
  static IconPark viewfinder = IconPark._(fileName: "取景器_viewfinder.svg");
  static IconPark lipstickOne = IconPark._(fileName: "口红1_lipstick-one.svg");
  static IconPark lipstick = IconPark._(fileName: "口红_lipstick.svg");
  static IconPark mask = IconPark._(fileName: "口罩_mask.svg");
  static IconPark cola = IconPark._(fileName: "可乐_cola.svg");
  static IconPark recycling = IconPark._(fileName: "可回收_recycling.svg");
  static IconPark deskLamp = IconPark._(fileName: "台灯_desk-lamp.svg");
  static IconPark tableLamp = IconPark._(fileName: "台灯_table-lamp.svg");
  static IconPark blackEight = IconPark._(fileName: "台球黑八_black-eight.svg");
  static IconPark rightC = IconPark._(fileName: "右-圆_right-c.svg");
  static IconPark rightSmall = IconPark._(fileName: "右-小_right-small.svg");
  static IconPark arrowCircleRight = IconPark._(fileName: "右-箭头_arrow-circle-right.svg");
  static IconPark rightOne = IconPark._(fileName: "右1_right-one.svg");
  static IconPark rightTwo = IconPark._(fileName: "右1_right-two.svg");
  static IconPark right = IconPark._(fileName: "右_right.svg");
  static IconPark rightSmallUp = IconPark._(fileName: "右上-小_right-small-up.svg");
  static IconPark rightSmallDown = IconPark._(fileName: "右下-小_right-small-down.svg");
  static IconPark splitTurnDownRight = IconPark._(fileName: "右下分支_split-turn-down-right.svg");
  static IconPark alignmentRightTop = IconPark._(fileName: "右侧上对齐_alignment-right-top.svg");
  static IconPark alignmentRightBottom = IconPark._(fileName: "右侧下对齐_alignment-right-bottom.svg");
  static IconPark alignmentRightCenter = IconPark._(fileName: "右侧居中对齐_alignment-right-center.svg");
  static IconPark sTurnRight = IconPark._(fileName: "右侧连接_s-turn-right.svg");
  static IconPark uTurnLeft = IconPark._(fileName: "右回转_u-turn-left.svg");
  static IconPark alignRightOne = IconPark._(fileName: "右对齐2_align-right-one.svg");
  static IconPark alignRight = IconPark._(fileName: "右对齐_align-right.svg");
  static IconPark dropShadowRight = IconPark._(fileName: "右投影_drop-shadow-right.svg");
  static IconPark rightBar = IconPark._(fileName: "右栏_right-bar.svg");
  static IconPark rightSquare = IconPark._(fileName: "右箭头-方_right-square.svg");
  static IconPark indentRight = IconPark._(fileName: "右缩进_indent-right.svg");
  static IconPark cornerRightUp = IconPark._(fileName: "右角向上_corner-right-up.svg");
  static IconPark cornerRightDown = IconPark._(fileName: "右角向下_corner-right-down.svg");
  static IconPark rightRun = IconPark._(fileName: "右运行_right-run.svg");
  static IconPark linkRight = IconPark._(fileName: "右连接_link-right.svg");
  static IconPark wavesRight = IconPark._(fileName: "右音波_waves-right.svg");
  static IconPark leaf = IconPark._(fileName: "叶子_leaf.svg");
  static IconPark childWithPacifier = IconPark._(fileName: "吃奶嘴_child-with-pacifier.svg");
  static IconPark cooperativeHandshake = IconPark._(fileName: "合作握手_cooperative-handshake.svg");
  static IconPark merge = IconPark._(fileName: "合并_merge.svg");
  static IconPark sum = IconPark._(fileName: "合并_sum.svg");
  static IconPark mergeCells = IconPark._(fileName: "合并单元格_merge-cells.svg");
  static IconPark unionSelection = IconPark._(fileName: "合并选择_union-selection.svg");
  static IconPark bib = IconPark._(fileName: "吊带裙_bib.svg");
  static IconPark rings = IconPark._(fileName: "吊环_rings.svg");
  static IconPark reverseOperationIn = IconPark._(fileName: "同向运行_reverse-operation-in.svg");
  static IconPark sync = IconPark._(fileName: "同步_sync.svg");
  static IconPark idCard = IconPark._(fileName: "名片_id-card.svg");
  static IconPark cornerUpRight = IconPark._(fileName: "向上右角_corner-up-right.svg");
  static IconPark cornerUpLeft = IconPark._(fileName: "向上左角_corner-up-left.svg");
  static IconPark handUp = IconPark._(fileName: "向上指_hand-up.svg");
  static IconPark foldUpOne = IconPark._(fileName: "向上收起_fold-up-one.svg");
  static IconPark cornerDownRight = IconPark._(fileName: "向下右角_corner-down-right.svg");
  static IconPark cornerDownLeft = IconPark._(fileName: "向下左角_corner-down-left.svg");
  static IconPark handDown = IconPark._(fileName: "向下指_hand-down.svg");
  static IconPark expandDownOne = IconPark._(fileName: "向下收起_expand-down-one.svg");
  static IconPark moveIn = IconPark._(fileName: "向内移动_move-in.svg");
  static IconPark rightExpand = IconPark._(fileName: "向右展开_right-expand.svg");
  static IconPark handRight = IconPark._(fileName: "向右指_hand-right.svg");
  static IconPark linkOut = IconPark._(fileName: "向外连接_link-out.svg");
  static IconPark leftExpand = IconPark._(fileName: "向左展开_left-expand.svg");
  static IconPark handLeft = IconPark._(fileName: "向左指_hand-left.svg");
  static IconPark stethoscope = IconPark._(fileName: "听诊器_stethoscope.svg");
  static IconPark breastPump = IconPark._(fileName: "吸奶器_breast-pump.svg");
  static IconPark vacuumCleaner = IconPark._(fileName: "吸尘器_vacuum-cleaner.svg");
  static IconPark sippyCup = IconPark._(fileName: "吸管杯_sippy-cup.svg");
  static IconPark whistling = IconPark._(fileName: "吹哨_whistling.svg");
  static IconPark hairDryerOne = IconPark._(fileName: "吹风机_hair-dryer-one.svg");
  static IconPark hairDryer = IconPark._(fileName: "吹风机_hair-dryer.svg");
  static IconPark woolenHat = IconPark._(fileName: "呢帽_woolen-hat.svg");
  static IconPark grimacingFace = IconPark._(fileName: "呲牙张嘴_grimacing-face.svg");
  static IconPark command = IconPark._(fileName: "命令键_command.svg");
  static IconPark cup = IconPark._(fileName: "咖啡杯_cup.svg");
  static IconPark babyTaste = IconPark._(fileName: "品尝_baby-taste.svg");
  static IconPark loudlyCryingFace = IconPark._(fileName: "哭_loudly-crying-face.svg");
  static IconPark lipGloss = IconPark._(fileName: "唇彩_lip-gloss.svg");
  static IconPark lipTattoo = IconPark._(fileName: "唇纹身_lip-tattoo.svg");
  static IconPark record = IconPark._(fileName: "唱片集_record.svg");
  static IconPark userBusiness = IconPark._(fileName: "商务用户_user-business.svg");
  static IconPark commodity = IconPark._(fileName: "商品_commodity.svg");
  static IconPark shoppingMall = IconPark._(fileName: "商圈_shopping-mall.svg");
  static IconPark shop = IconPark._(fileName: "商店_shop.svg");
  static IconPark trademark = IconPark._(fileName: "商标符号_trademark.svg");
  static IconPark beer = IconPark._(fileName: "啤酒_beer.svg");
  static IconPark beerMug = IconPark._(fileName: "啤酒杯_beer-mug.svg");
  static IconPark speakerOne = IconPark._(fileName: "喇叭_speaker-one.svg");
  static IconPark trumpet = IconPark._(fileName: "喇叭_trumpet.svg");
  static IconPark trousersBellBottoms = IconPark._(fileName: "喇叭裤_trousers-bell-bottoms.svg");
  static IconPark like = IconPark._(fileName: "喜欢_like.svg");
  static IconPark teaDrink = IconPark._(fileName: "喝茶_tea-drink.svg");
  static IconPark mouth = IconPark._(fileName: "嘴巴_mouth.svg");
  static IconPark fourFour = IconPark._(fileName: "四_four-four.svg");
  static IconPark four = IconPark._(fileName: "四_four.svg");
  static IconPark fourArrows = IconPark._(fileName: "四个箭头_four-arrows.svg");
  static IconPark gridFour = IconPark._(fileName: "四宫格_grid-four.svg");
  static IconPark quadrangularPyramid = IconPark._(fileName: "四棱锥_quadrangular-pyramid.svg");
  static IconPark fourPointConnection = IconPark._(fileName: "四点连接_four-point-connection.svg");
  static IconPark fourRoundPointConnection = IconPark._(fileName: "四点连接_four-round-point-connection.svg");
  static IconPark fourLeaves = IconPark._(fileName: "四片叶子_four-leaves.svg");
  static IconPark levelFourTitle = IconPark._(fileName: "四级标题_level-four-title.svg");
  static IconPark quadrilateral = IconPark._(fileName: "四边形_quadrilateral.svg");
  static IconPark dateComesBack = IconPark._(fileName: "回传数据_date-comes-back.svg");
  static IconPark paperclip = IconPark._(fileName: "回形针_paperclip.svg");
  static IconPark recyclingPool = IconPark._(fileName: "回收池_recycling-pool.svg");
  static IconPark recycleBin = IconPark._(fileName: "回收站_recycle-bin.svg");
  static IconPark enterKeyOne = IconPark._(fileName: "回车键_enter-key-one.svg");
  static IconPark enterKey = IconPark._(fileName: "回车键_enter-key.svg");
  static IconPark slyFaceWhitSmile = IconPark._(fileName: "囧笑_sly-face-whit-smile.svg");
  static IconPark solidStateDisk = IconPark._(fileName: "固态硬盘_solid-state-disk.svg");
  static IconPark international = IconPark._(fileName: "国际化_international.svg");
  static IconPark chessOne = IconPark._(fileName: "国际象棋_chess-one.svg");
  static IconPark layers = IconPark._(fileName: "图层_layers.svg");
  static IconPark rectangularCircularSeparation = IconPark._(fileName: "图形分割_rectangular-circular-separation.svg");
  static IconPark graphicDesignTwo = IconPark._(fileName: "图形组合_graphic-design-two.svg");
  static IconPark graphicDesign = IconPark._(fileName: "图形设计_graphic-design.svg");
  static IconPark rectangularCircularConnection = IconPark._(fileName: "图形连接_rectangular-circular-connection.svg");
  static IconPark picOne = IconPark._(fileName: "图片1_pic-one.svg");
  static IconPark pictureOne = IconPark._(fileName: "图片_picture-one.svg");
  static IconPark picture = IconPark._(fileName: "图片_picture.svg");
  static IconPark imageFiles = IconPark._(fileName: "图片文件_image-files.svg");
  static IconPark tuchong = IconPark._(fileName: "图虫_tuchong.svg");
  static IconPark anguishedFace = IconPark._(fileName: "圆嘴_anguished-face.svg");
  static IconPark circleFiveLine = IconPark._(fileName: "圆圈_circle-five-line.svg");
  static IconPark circleFourLine = IconPark._(fileName: "圆圈_circle-four-line.svg");
  static IconPark circleFour = IconPark._(fileName: "圆圈_circle-four.svg");
  static IconPark circleThree = IconPark._(fileName: "圆圈_circle-three.svg");
  static IconPark circleTwoLine = IconPark._(fileName: "圆圈_circle-two-line.svg");
  static IconPark circlesSeven = IconPark._(fileName: "圆圈_circles-seven.svg");
  static IconPark endpointRound = IconPark._(fileName: "圆头端点_endpoint-round.svg");
  static IconPark nodeRound = IconPark._(fileName: "圆头节点_node-round.svg");
  static IconPark round = IconPark._(fileName: "圆形_round.svg");
  static IconPark roundCaliper = IconPark._(fileName: "圆形卡钳_round-caliper.svg");
  static IconPark circleDoubleUp = IconPark._(fileName: "圆形双上箭头_circle-double-up.svg");
  static IconPark circleDoubleDown = IconPark._(fileName: "圆形双下箭头_circle-double-down.svg");
  static IconPark circleDoubleRight = IconPark._(fileName: "圆形双右箭头_circle-double-right.svg");
  static IconPark circleDoubleLeft = IconPark._(fileName: "圆形双左箭头_circle-double-left.svg");
  static IconPark circleRightUp = IconPark._(fileName: "圆形右上_circle-right-up.svg");
  static IconPark circleRightDown = IconPark._(fileName: "圆形右下_circle-right-down.svg");
  static IconPark circlesAndTriangles = IconPark._(fileName: "圆形和三角_circles-and-triangles.svg");
  static IconPark circleLeftUp = IconPark._(fileName: "圆形左上_circle-left-up.svg");
  static IconPark circleLeftDown = IconPark._(fileName: "圆形左下_circle-left-down.svg");
  static IconPark roundDistortion = IconPark._(fileName: "圆形扭曲_round-distortion.svg");
  static IconPark roundSocket = IconPark._(fileName: "圆形插座_round-socket.svg");
  static IconPark paragraphRound = IconPark._(fileName: "圆形段落_paragraph-round.svg");
  static IconPark graphicStitchingFour = IconPark._(fileName: "圆形组合_graphic-stitching-four.svg");
  static IconPark graphicStitchingThree = IconPark._(fileName: "圆形组合_graphic-stitching-three.svg");
  static IconPark graphicStitching = IconPark._(fileName: "圆形组合_graphic-stitching.svg");
  static IconPark circularConnection = IconPark._(fileName: "圆形连接_circular-connection.svg");
  static IconPark sixCircularConnection = IconPark._(fileName: "圆形连接_six-circular-connection.svg");
  static IconPark roundMask = IconPark._(fileName: "圆形遮罩_round-mask.svg");
  static IconPark cylinder = IconPark._(fileName: "圆柱_cylinder.svg");
  static IconPark ringOne = IconPark._(fileName: "圆环_ring-one.svg");
  static IconPark ring = IconPark._(fileName: "圆环_ring.svg");
  static IconPark sphere = IconPark._(fileName: "圆球_sphere.svg");
  static IconPark radishOne = IconPark._(fileName: "圆萝卜_radish-one.svg");
  static IconPark compass = IconPark._(fileName: "圆规_compass.svg");
  static IconPark cone = IconPark._(fileName: "圆锥_cone.svg");
  static IconPark dome = IconPark._(fileName: "圆顶_dome.svg");
  static IconPark clothesCrewNeck = IconPark._(fileName: "圆领衫_clothes-crew-neck.svg");
  static IconPark circleHouse = IconPark._(fileName: "圈舍_circle-house.svg");
  static IconPark holySword = IconPark._(fileName: "圣剑_holy-sword.svg");
  static IconPark christmasTree = IconPark._(fileName: "圣诞树_christmas-tree.svg");
  static IconPark mapDraw = IconPark._(fileName: "地图_map-draw.svg");
  static IconPark mapRoadTwo = IconPark._(fileName: "地图_map-road-two.svg");
  static IconPark mapTwo = IconPark._(fileName: "地图_map-two.svg");
  static IconPark mapDistance = IconPark._(fileName: "地图距离_map-distance.svg");
  static IconPark mapRoad = IconPark._(fileName: "地图道路_map-road.svg");
  static IconPark earth = IconPark._(fileName: "地球仪_earth.svg");
  static IconPark subway = IconPark._(fileName: "地铁_subway.svg");
  static IconPark equalizer = IconPark._(fileName: "均衡器_equalizer.svg");
  static IconPark bad = IconPark._(fileName: "坏的_bad.svg");
  static IconPark cones = IconPark._(fileName: "坐标系_cones.svg");
  static IconPark coordinateSystem = IconPark._(fileName: "坐标系统_coordinate-system.svg");
  static IconPark inline = IconPark._(fileName: "块公式_inline.svg");
  static IconPark nut = IconPark._(fileName: "坚果_nut.svg");
  static IconPark distributeVertically = IconPark._(fileName: "垂直分布_distribute-vertically.svg");
  static IconPark alignmentVerticalRight = IconPark._(fileName: "垂直右对齐_alignment-vertical-right.svg");
  static IconPark alignVertically = IconPark._(fileName: "垂直对齐_align-vertically.svg");
  static IconPark margin = IconPark._(fileName: "垂直居中_margin.svg");
  static IconPark alignVerticalCenterTwo = IconPark._(fileName: "垂直居中对齐2_align-vertical-center-two.svg");
  static IconPark alignmentVerticalCenter = IconPark._(fileName: "垂直居中对齐_alignment-vertical-center.svg");
  static IconPark verticallyCentered = IconPark._(fileName: "垂直居中对齐_vertically-centered.svg");
  static IconPark alignmentVerticalLeft = IconPark._(fileName: "垂直左对齐_alignment-vertical-left.svg");
  static IconPark slidingVertical = IconPark._(fileName: "垂直拖动_sliding-vertical.svg");
  static IconPark verticalTidyUp = IconPark._(fileName: "垂直整理_vertical-tidy-up.svg");
  static IconPark verticalTimeline = IconPark._(fileName: "垂直时间线_vertical-timeline.svg");
  static IconPark flipVertically = IconPark._(fileName: "垂直翻转_flip-vertically.svg");
  static IconPark verticalSpacingBetweenItems = IconPark._(fileName: "垂直间距_vertical-spacing-between-items.svg");
  static IconPark distributeVerticalSpacing = IconPark._(fileName: "垂直间距分布_distribute-vertical-spacing.svg");
  static IconPark fishing = IconPark._(fileName: "垂钓_fishing.svg");
  static IconPark softball = IconPark._(fileName: "垒球_softball.svg");
  static IconPark eiffelTower = IconPark._(fileName: "埃菲尔铁塔_eiffel-tower.svg");
  static IconPark castle = IconPark._(fileName: "城堡_castle.svg");
  static IconPark cityOne = IconPark._(fileName: "城市_city-one.svg");
  static IconPark city = IconPark._(fileName: "城市_city.svg");
  static IconPark cityGate = IconPark._(fileName: "城门_city-gate.svg");
  static IconPark funds = IconPark._(fileName: "基金_funds.svg");
  static IconPark stackLight = IconPark._(fileName: "堆栈灯_stack-light.svg");
  static IconPark tower = IconPark._(fileName: "塔楼_tower.svg");
  static IconPark fill = IconPark._(fileName: "填充_fill.svg");
  static IconPark addPic = IconPark._(fileName: "增加图片_add-pic.svg");
  static IconPark increaseTheScale = IconPark._(fileName: "增加小数位_increase-the-scale.svg");
  static IconPark addMode = IconPark._(fileName: "增加模式_add-mode.svg");
  static IconPark acoustic = IconPark._(fileName: "声波_acoustic.svg");
  static IconPark volumeNotice = IconPark._(fileName: "声音-大_volume-notice.svg");
  static IconPark volumeSmall = IconPark._(fileName: "声音-小_volume-small.svg");
  static IconPark voiceOne = IconPark._(fileName: "声音_voice-one.svg");
  static IconPark prescription = IconPark._(fileName: "处方_prescription.svg");
  static IconPark copyOne = IconPark._(fileName: "复制_copy-one.svg");
  static IconPark copy = IconPark._(fileName: "复制_copy.svg");
  static IconPark copyLink = IconPark._(fileName: "复制链接_copy-link.svg");
  static IconPark retroBag = IconPark._(fileName: "复古包_retro-bag.svg");
  static IconPark macadamiaNut = IconPark._(fileName: "夏威夷果_macadamia-nut.svg");
  static IconPark externalTransmission = IconPark._(fileName: "外部传输_external-transmission.svg");
  static IconPark multiTriangularFour = IconPark._(fileName: "多三角_multi-triangular-four.svg");
  static IconPark multiTriangularThree = IconPark._(fileName: "多三角_multi-triangular-three.svg");
  static IconPark multiTriangularTwo = IconPark._(fileName: "多三角_multi-triangular-two.svg");
  static IconPark multiTriangular = IconPark._(fileName: "多三角_multi-triangular.svg");
  static IconPark cloudy = IconPark._(fileName: "多云_cloudy.svg");
  static IconPark multiFunctionKnife = IconPark._(fileName: "多功能刀_multi-function-knife.svg");
  static IconPark multiPictureCarousel = IconPark._(fileName: "多图轮播_multi-picture-carousel.svg");
  static IconPark multiCircular = IconPark._(fileName: "多圆形_multi-circular.svg");
  static IconPark multiRing = IconPark._(fileName: "多圆环_multi-ring.svg");
  static IconPark manyToMany = IconPark._(fileName: "多对多_many-to-many.svg");
  static IconPark multilayerSphere = IconPark._(fileName: "多层圆球_multilayer-sphere.svg");
  static IconPark multicast = IconPark._(fileName: "多播_multicast.svg");
  static IconPark multiRectangle = IconPark._(fileName: "多方形_multi-rectangle.svg");
  static IconPark listCheckbox = IconPark._(fileName: "多选列表_list-checkbox.svg");
  static IconPark checkbox = IconPark._(fileName: "多选框_checkbox.svg");
  static IconPark darkMode = IconPark._(fileName: "夜晚模式_dark-mode.svg");
  static IconPark cloudyNight = IconPark._(fileName: "夜间多云_cloudy-night.svg");
  static IconPark xRectangleX = IconPark._(fileName: "大X_rectangle-x.svg");
  static IconPark volkswagen = IconPark._(fileName: "大众_volkswagen.svg");
  static IconPark pin = IconPark._(fileName: "大头钉_pin.svg");
  static IconPark bus = IconPark._(fileName: "大巴_bus.svg");
  static IconPark codeBrackets = IconPark._(fileName: "大括号_code-brackets.svg");
  static IconPark faceWithSmilingOpenEyes = IconPark._(fileName: "大眼笑_face-with-smiling-open-eyes.svg");
  static IconPark mindmapList = IconPark._(fileName: "大纲视图_mindmap-list.svg");
  static IconPark brain = IconPark._(fileName: "大脑_brain.svg");
  static IconPark scallion = IconPark._(fileName: "大葱_scallion.svg");
  static IconPark garlic = IconPark._(fileName: "大蒜_garlic.svg");
  static IconPark shrimp = IconPark._(fileName: "大虾_shrimp.svg");
  static IconPark bigClock = IconPark._(fileName: "大钟表_big-clock.svg");
  static IconPark gate = IconPark._(fileName: "大门_gate.svg");
  static IconPark heavyRain = IconPark._(fileName: "大雨_heavy-rain.svg");
  static IconPark fog = IconPark._(fileName: "大雾_fog.svg");
  static IconPark heavyWind = IconPark._(fileName: "大风_heavy-wind.svg");
  static IconPark balanceTwo = IconPark._(fileName: "天平_balance-two.svg");
  static IconPark spaceColony = IconPark._(fileName: "太空殖民地_space-colony.svg");
  static IconPark sunOne = IconPark._(fileName: "太阳1_sun-one.svg");
  static IconPark sun = IconPark._(fileName: "太阳_sun.svg");
  static IconPark sunHat = IconPark._(fileName: "太阳帽_sun-hat.svg");
  static IconPark solarEnergyOne = IconPark._(fileName: "太阳能_solar-energy-one.svg");
  static IconPark solarEnergy = IconPark._(fileName: "太阳能_solar-energy.svg");
  static IconPark invalidFiles = IconPark._(fileName: "失效文件_invalid-files.svg");
  static IconPark disappointedFace = IconPark._(fileName: "失落_disappointed-face.svg");
  static IconPark imbalance = IconPark._(fileName: "失衡天平_imbalance.svg");
  static IconPark listFail = IconPark._(fileName: "失败列表_list-fail.svg");
  static IconPark folderFailedOne = IconPark._(fileName: "失败文件夹1_folder-failed-one.svg");
  static IconPark folderFailed = IconPark._(fileName: "失败文件夹_folder-failed.svg");
  static IconPark avatar = IconPark._(fileName: "头像_avatar.svg");
  static IconPark helmet = IconPark._(fileName: "头盔_helmet.svg");
  static IconPark headwear = IconPark._(fileName: "头饰_headwear.svg");
  static IconPark benz = IconPark._(fileName: "奔驰_benz.svg");
  static IconPark trophy = IconPark._(fileName: "奖杯_trophy.svg");
  static IconPark woman = IconPark._(fileName: "女人_woman.svg");
  static IconPark womenCoat = IconPark._(fileName: "女大衣_women-coat.svg");
  static IconPark girlOne = IconPark._(fileName: "女孩1_girl-one.svg");
  static IconPark girlTwo = IconPark._(fileName: "女孩2_girl-two.svg");
  static IconPark girl = IconPark._(fileName: "女孩_girl.svg");
  static IconPark female = IconPark._(fileName: "女性_female.svg");
  static IconPark pacifier = IconPark._(fileName: "奶嘴_pacifier.svg");
  static IconPark babyBottle = IconPark._(fileName: "奶瓶_baby-bottle.svg");
  static IconPark bottle = IconPark._(fileName: "奶瓶_bottle.svg");
  static IconPark cheese = IconPark._(fileName: "奶酪_cheese.svg");
  static IconPark good = IconPark._(fileName: "好的_good.svg");
  static IconPark entertainment = IconPark._(fileName: "娱乐_entertainment.svg");
  static IconPark baby = IconPark._(fileName: "婴儿_baby.svg");
  static IconPark uterus = IconPark._(fileName: "子宫_uterus.svg");
  static IconPark bulletMap = IconPark._(fileName: "子弹图_bullet-map.svg");
  static IconPark pregnantWomen = IconPark._(fileName: "孕妇_pregnant-women.svg");
  static IconPark holdSeeds = IconPark._(fileName: "孕育_hold-seeds.svg");
  static IconPark fontSizeTwo = IconPark._(fileName: "字体大小_font-size-two.svg");
  static IconPark fontSearch = IconPark._(fileName: "字体搜索_font-search.svg");
  static IconPark fontSize = IconPark._(fileName: "字号大小_font-size.svg");
  static IconPark alphabeticalSortingTwo = IconPark._(fileName: "字母倒序_alphabetical-sorting-two.svg");
  static IconPark listAlphabet = IconPark._(fileName: "字母列表_list-alphabet.svg");
  static IconPark paragraphAlphabet = IconPark._(fileName: "字母段落_paragraph-alphabet.svg");
  static IconPark alphabeticalSorting = IconPark._(fileName: "字母顺序_alphabetical-sorting.svg");
  static IconPark bydesign = IconPark._(fileName: "字节设计_bydesign.svg");
  static IconPark bytedance = IconPark._(fileName: "字节跳动_bytedance.svg");
  static IconPark bytedanceMiniApp = IconPark._(fileName: "字节跳动小程序_bytedance-mini-app.svg");
  static IconPark sdCard = IconPark._(fileName: "存储卡_sd-card.svg");
  static IconPark deposit = IconPark._(fileName: "存款_deposit.svg");
  static IconPark fileQuestion = IconPark._(fileName: "存疑文件_file-question.svg");
  static IconPark degreeHat = IconPark._(fileName: "学位帽_degree-hat.svg");
  static IconPark preschool = IconPark._(fileName: "学前班_preschool.svg");
  static IconPark bachelorCap = IconPark._(fileName: "学士帽_bachelor-cap.svg");
  static IconPark school = IconPark._(fileName: "学校_school.svg");
  static IconPark cryingBaby = IconPark._(fileName: "孩子哭泣_crying-baby.svg");
  static IconPark security = IconPark._(fileName: "安全_security.svg");
  static IconPark shield = IconPark._(fileName: "安全_shield.svg");
  static IconPark securityStall = IconPark._(fileName: "安全台_security-stall.svg");
  static IconPark shieldAdd = IconPark._(fileName: "安全增加_shield-add.svg");
  static IconPark helmetOne = IconPark._(fileName: "安全帽_helmet-one.svg");
  static IconPark android = IconPark._(fileName: "安卓_android.svg");
  static IconPark enquire = IconPark._(fileName: "安检_enquire.svg");
  static IconPark install = IconPark._(fileName: "安装_install.svg");
  static IconPark doneAll = IconPark._(fileName: "完成全部_done-all.svg");
  static IconPark timedMail = IconPark._(fileName: "定时发送_timed-mail.svg");
  static IconPark appointment = IconPark._(fileName: "定时见面_appointment.svg");
  static IconPark pagoda = IconPark._(fileName: "宝塔_pagoda.svg");
  static IconPark treasureChest = IconPark._(fileName: "宝箱_treasure-chest.svg");
  static IconPark experimentOne = IconPark._(fileName: "实验_experiment-one.svg");
  static IconPark experiment = IconPark._(fileName: "实验_experiment.svg");
  static IconPark audit = IconPark._(fileName: "审核_audit.svg");
  static IconPark palace = IconPark._(fileName: "宫殿_palace.svg");
  static IconPark family = IconPark._(fileName: "家庭_family.svg");
  static IconPark checkCorrect = IconPark._(fileName: "对勾_check-correct.svg");
  static IconPark contrastViewCircle = IconPark._(fileName: "对比_contrast-view-circle.svg");
  static IconPark contrastView = IconPark._(fileName: "对比_contrast-view.svg");
  static IconPark contrast = IconPark._(fileName: "对比度_contrast.svg");
  static IconPark focusOne = IconPark._(fileName: "对焦1_focus-one.svg");
  static IconPark focus = IconPark._(fileName: "对焦_focus.svg");
  static IconPark symmetry = IconPark._(fileName: "对称_symmetry.svg");
  static IconPark intercom = IconPark._(fileName: "对讲机_intercom.svg");
  static IconPark export = IconPark._(fileName: "导出_export.svg");
  static IconPark navigation = IconPark._(fileName: "导航_navigation.svg");
  static IconPark archersBow = IconPark._(fileName: "射箭_archers-bow.svg");
  static IconPark customer = IconPark._(fileName: "小六客服_customer.svg");
  static IconPark xiaodu = IconPark._(fileName: "小度_xiaodu.svg");
  static IconPark xiaoduHome = IconPark._(fileName: "小度在家_xiaodu-home.svg");
  static IconPark squareSmall = IconPark._(fileName: "小方形_square-small.svg");
  static IconPark rectangleSmall = IconPark._(fileName: "小矩形_rectangle-small.svg");
  static IconPark appletClosed = IconPark._(fileName: "小程序关闭_applet-closed.svg");
  static IconPark lightRain = IconPark._(fileName: "小雨_light-rain.svg");
  static IconPark snacks = IconPark._(fileName: "小食_snacks.svg");
  static IconPark rulerOne = IconPark._(fileName: "尺子1_ruler-one.svg");
  static IconPark ruler = IconPark._(fileName: "尺子_ruler.svg");
  static IconPark diapersOne = IconPark._(fileName: "尿不湿_diapers-one.svg");
  static IconPark centerAlignment = IconPark._(fileName: "居中对齐_center-alignment.svg");
  static IconPark screenRotation = IconPark._(fileName: "屏幕旋转_screen-rotation.svg");
  static IconPark expandDown = IconPark._(fileName: "展开_expand-down.svg");
  static IconPark expandLeft = IconPark._(fileName: "展开_expand-left.svg");
  static IconPark expandRight = IconPark._(fileName: "展开_expand-right.svg");
  static IconPark expandUp = IconPark._(fileName: "展开_expand-up.svg");
  static IconPark expandTextInput = IconPark._(fileName: "展开文本域_expand-text-input.svg");
  static IconPark menuUnfoldOne = IconPark._(fileName: "展开菜单1_menu-unfold-one.svg");
  static IconPark menuUnfold = IconPark._(fileName: "展开菜单_menu-unfold.svg");
  static IconPark stereoNesting = IconPark._(fileName: "嵌套图形_stereo-nesting.svg");
  static IconPark nestedArrows = IconPark._(fileName: "嵌套箭头_nested-arrows.svg");
  static IconPark oilIndustry = IconPark._(fileName: "工业油漆_oil-industry.svg");
  static IconPark worker = IconPark._(fileName: "工人_worker.svg");
  static IconPark workbench = IconPark._(fileName: "工作台_workbench.svg");
  static IconPark tool = IconPark._(fileName: "工具_tool.svg");
  static IconPark factoryBuilding = IconPark._(fileName: "工厂_factory-building.svg");
  static IconPark leftC = IconPark._(fileName: "左-圆_left-c.svg");
  static IconPark leftSmall = IconPark._(fileName: "左-小_left-small.svg");
  static IconPark arrowCircleLeft = IconPark._(fileName: "左-箭头_arrow-circle-left.svg");
  static IconPark leftOne = IconPark._(fileName: "左1_left-one.svg");
  static IconPark leftTwo = IconPark._(fileName: "左1_left-two.svg");
  static IconPark left = IconPark._(fileName: "左_left.svg");
  static IconPark leftSmallUp = IconPark._(fileName: "左上-小_left-small-up.svg");
  static IconPark leftSmallDown = IconPark._(fileName: "左下-小_left-small-down.svg");
  static IconPark splitTurnDownLeft = IconPark._(fileName: "左下分支_split-turn-down-left.svg");
  static IconPark alignmentLeftTop = IconPark._(fileName: "左侧上对齐_alignment-left-top.svg");
  static IconPark alignmentLeftBottom = IconPark._(fileName: "左侧下对齐_alignment-left-bottom.svg");
  static IconPark alignmentLeftCenter = IconPark._(fileName: "左侧居中对齐_alignment-left-center.svg");
  static IconPark sTurnLeft = IconPark._(fileName: "左侧连接_s-turn-left.svg");
  static IconPark expandLeftAndRight = IconPark._(fileName: "左右扩大_expand-left-and-right.svg");
  static IconPark uTurnRight = IconPark._(fileName: "左回转_u-turn-right.svg");
  static IconPark alignLeftOne = IconPark._(fileName: "左对齐2_align-left-one.svg");
  static IconPark alignLeft = IconPark._(fileName: "左对齐_align-left.svg");
  static IconPark leftAlignment = IconPark._(fileName: "左对齐_left-alignment.svg");
  static IconPark dropShadowLeft = IconPark._(fileName: "左投影_drop-shadow-left.svg");
  static IconPark leftBar = IconPark._(fileName: "左栏_left-bar.svg");
  static IconPark leftSquare = IconPark._(fileName: "左箭头-方_left-square.svg");
  static IconPark indentLeft = IconPark._(fileName: "左缩进_indent-left.svg");
  static IconPark cornerLeftUp = IconPark._(fileName: "左角向上_corner-left-up.svg");
  static IconPark cornerLeftDown = IconPark._(fileName: "左角向下_corner-left-down.svg");
  static IconPark runLeft = IconPark._(fileName: "左运行_run-left.svg");
  static IconPark linkLeft = IconPark._(fileName: "左链接_link-left.svg");
  static IconPark wavesLeft = IconPark._(fileName: "左音波_waves-left.svg");
  static IconPark cc = IconPark._(fileName: "巨量创意_cc.svg");
  static IconPark oceanengine = IconPark._(fileName: "巨量引擎_oceanengine.svg");
  static IconPark sorcererHat = IconPark._(fileName: "巫师帽_sorcerer-hat.svg");
  static IconPark badOne = IconPark._(fileName: "差劲_bad-one.svg");
  static IconPark differenceSet = IconPark._(fileName: "差异集_difference-set.svg");
  static IconPark local = IconPark._(fileName: "已定位_local.svg");
  static IconPark mailOpen = IconPark._(fileName: "已读邮件_mail-open.svg");
  static IconPark paymentMethod = IconPark._(fileName: "币种兑换_payment-method.svg");
  static IconPark marketAnalysis = IconPark._(fileName: "市场分析_market-analysis.svg");
  static IconPark layoutOne = IconPark._(fileName: "布局1_layout-one.svg");
  static IconPark layoutTwo = IconPark._(fileName: "布局2_layout-two.svg");
  static IconPark layoutThree = IconPark._(fileName: "布局3_layout-three.svg");
  static IconPark layoutFour = IconPark._(fileName: "布局4_layout-four.svg");
  static IconPark layoutFive = IconPark._(fileName: "布局5_layout-five.svg");
  static IconPark sailboat = IconPark._(fileName: "帆船_sailboat.svg");
  static IconPark tent = IconPark._(fileName: "帐篷_tent.svg");
  static IconPark tentBanner = IconPark._(fileName: "帐篷旗帜_tent-banner.svg");
  static IconPark help = IconPark._(fileName: "帮助_help.svg");
  static IconPark helpcenter = IconPark._(fileName: "帮助中心_helpcenter.svg");
  static IconPark hat = IconPark._(fileName: "帽子_hat.svg");
  static IconPark clothesSweater = IconPark._(fileName: "帽衫_clothes-sweater.svg");
  static IconPark average = IconPark._(fileName: "平均值_average.svg");
  static IconPark endpointSquare = IconPark._(fileName: "平头端点_endpoint-square.svg");
  static IconPark nodeSquare = IconPark._(fileName: "平头节点_node-square.svg");
  static IconPark ipadOne = IconPark._(fileName: "平板电脑_ipad-one.svg");
  static IconPark pad = IconPark._(fileName: "平板电脑_pad.svg");
  static IconPark parallelogram = IconPark._(fileName: "平行四边形_parallelogram.svg");
  static IconPark balance = IconPark._(fileName: "平衡_balance.svg");
  static IconPark parallelGateway = IconPark._(fileName: "并行网关_parallel-gateway.svg");
  static IconPark xingfuli = IconPark._(fileName: "幸福里_xingfuli.svg");
  static IconPark powerpoint = IconPark._(fileName: "幻灯片_powerpoint.svg");
  static IconPark ppt = IconPark._(fileName: "幻灯片_ppt.svg");
  static IconPark slideTwo = IconPark._(fileName: "幻灯片_slide-two.svg");
  static IconPark slide = IconPark._(fileName: "幻灯片_slide.svg");
  static IconPark ghost = IconPark._(fileName: "幽灵_ghost.svg");
  static IconPark ad = IconPark._(fileName: "广告_ad.svg");
  static IconPark adProduct = IconPark._(fileName: "广告产品_ad-product.svg");
  static IconPark broadcastOne = IconPark._(fileName: "广播_broadcast-one.svg");
  static IconPark broadcast = IconPark._(fileName: "广播_broadcast.svg");
  static IconPark radioNanny = IconPark._(fileName: "广播保姆_radio-nanny.svg");
  static IconPark bedsideTwo = IconPark._(fileName: "床头柜_bedside-two.svg");
  static IconPark bedside = IconPark._(fileName: "床头柜_bedside.svg");
  static IconPark applicationOne = IconPark._(fileName: "应用_application-one.svg");
  static IconPark applicationTwo = IconPark._(fileName: "应用_application-two.svg");
  static IconPark application = IconPark._(fileName: "应用_application.svg");
  static IconPark babyApp = IconPark._(fileName: "应用_baby-app.svg");
  static IconPark appStore = IconPark._(fileName: "应用商店_app-store.svg");
  static IconPark applicationEffect = IconPark._(fileName: "应用效果_application-effect.svg");
  static IconPark applicationMenu = IconPark._(fileName: "应用菜单_application-menu.svg");
  static IconPark alignBottom = IconPark._(fileName: "底对齐_align-bottom.svg");
  static IconPark bottomBar = IconPark._(fileName: "底栏_bottom-bar.svg");
  static IconPark alignmentBottomCenter = IconPark._(fileName: "底部中心对齐_alignment-bottom-center.svg");
  static IconPark alignmentBottomRight = IconPark._(fileName: "底部右对齐_alignment-bottom-right.svg");
  static IconPark alignmentBottomLeft = IconPark._(fileName: "底部左对齐_alignment-bottom-left.svg");
  static IconPark sTurnDown = IconPark._(fileName: "底部连接_s-turn-down.svg");
  static IconPark chairOne = IconPark._(fileName: "座椅1_chair-one.svg");
  static IconPark chair = IconPark._(fileName: "座椅_chair.svg");
  static IconPark buildingFour = IconPark._(fileName: "建筑_building-four.svg");
  static IconPark buildingOne = IconPark._(fileName: "建筑_building-one.svg");
  static IconPark buildingThree = IconPark._(fileName: "建筑_building-three.svg");
  static IconPark buildingTwo = IconPark._(fileName: "建筑_building-two.svg");
  static IconPark power = IconPark._(fileName: "开关_power.svg");
  static IconPark switchOne = IconPark._(fileName: "开关_switch-one.svg");
  static IconPark emotionHappy = IconPark._(fileName: "开心_emotion-happy.svg");
  static IconPark grinningFace = IconPark._(fileName: "开心_grinning-face.svg");
  static IconPark openAnAccount = IconPark._(fileName: "开户_open-an-account.svg");
  static IconPark clothesCardigan = IconPark._(fileName: "开衫_clothes-cardigan.svg");
  static IconPark openDoor = IconPark._(fileName: "开门_open-door.svg");
  static IconPark abnormal = IconPark._(fileName: "异常_abnormal.svg");
  static IconPark quote = IconPark._(fileName: "引用_quote.svg");
  static IconPark loudlyCryingFaceWhitOpenMouth = IconPark._(fileName: "张嘴哭_loudly-crying-face-whit-open-mouth.svg");
  static IconPark dizzyFace = IconPark._(fileName: "张嘴晕_dizzy-face.svg");
  static IconPark grinningFaceWithOpenMouth = IconPark._(fileName: "张嘴笑_grinning-face-with-open-mouth.svg");
  static IconPark grinningFaceWithTightlyClosedEyesOpenMouth = IconPark._(fileName: "张嘴闭眼笑_grinning-face-with-tightly-closed-eyes-open-mouth.svg");
  static IconPark astonishedFace = IconPark._(fileName: "张大嘴_astonished-face.svg");
  static IconPark spiderMan = IconPark._(fileName: "弹指_spider-man.svg");
  static IconPark voice = IconPark._(fileName: "录音_voice.svg");
  static IconPark formOne = IconPark._(fileName: "形式_form-one.svg");
  static IconPark paintedEggshell = IconPark._(fileName: "彩蛋_painted-eggshell.svg");
  static IconPark editMovie = IconPark._(fileName: "影片剪辑_edit-movie.svg");
  static IconPark movieBoard = IconPark._(fileName: "影视板_movie-board.svg");
  static IconPark theater = IconPark._(fileName: "影院_theater.svg");
  static IconPark roundTrip = IconPark._(fileName: "往返飞_round-trip.svg");
  static IconPark cycleOne = IconPark._(fileName: "循环_cycle-one.svg");
  static IconPark cycle = IconPark._(fileName: "循环_cycle.svg");
  static IconPark loopOnce = IconPark._(fileName: "循环一次_loop-once.svg");
  static IconPark playCycle = IconPark._(fileName: "循环播放_play-cycle.svg");
  static IconPark cycleMovement = IconPark._(fileName: "循环移动_cycle-movement.svg");
  static IconPark cycleArrow = IconPark._(fileName: "循环箭头_cycle-arrow.svg");
  static IconPark wechat = IconPark._(fileName: "微信_wechat.svg");
  static IconPark weixinCardsOffers = IconPark._(fileName: "微信卡包_weixin-cards-offers.svg");
  static IconPark weixinMiniApp = IconPark._(fileName: "微信小程序_weixin-mini-app.svg");
  static IconPark weixinScan = IconPark._(fileName: "微信扫一扫_weixin-scan.svg");
  static IconPark weixinSearch = IconPark._(fileName: "微信搜索_weixin-search.svg");
  static IconPark weixinShake = IconPark._(fileName: "微信摇一摇_weixin-shake.svg");
  static IconPark weixinFavorites = IconPark._(fileName: "微信收藏_weixin-favorites.svg");
  static IconPark weixinGames = IconPark._(fileName: "微信游戏_weixin-games.svg");
  static IconPark weixinMarket = IconPark._(fileName: "微信电商_weixin-market.svg");
  static IconPark weixinTopStories = IconPark._(fileName: "微信看一看_weixin-top-stories.svg");
  static IconPark weixinPeopleNearby = IconPark._(fileName: "微信附近的人_weixin-people-nearby.svg");
  static IconPark microSlrCamera = IconPark._(fileName: "微单_micro-slr-camera.svg");
  static IconPark weibo = IconPark._(fileName: "微博_weibo.svg");
  static IconPark sdMicroSd = IconPark._(fileName: "微型SD_micro-sd.svg");
  static IconPark usb1UsbMicroOne = IconPark._(fileName: "微型USB1_usb-micro-one.svg");
  static IconPark usb2UsbMicroTwo = IconPark._(fileName: "微型USB2_usb-micro-two.svg");
  static IconPark miniSdCard = IconPark._(fileName: "微型存储卡_mini-sd-card.svg");
  static IconPark microwaveOven = IconPark._(fileName: "微波炉_microwave-oven.svg");
  static IconPark microwaves = IconPark._(fileName: "微波炉_microwaves.svg");
  static IconPark slightlySmilingFace = IconPark._(fileName: "微笑_slightly-smiling-face.svg");
  static IconPark windows = IconPark._(fileName: "微软视窗_windows.svg");
  static IconPark badgeTwo = IconPark._(fileName: "徽章_badge-two.svg");
  static IconPark badge = IconPark._(fileName: "徽章提醒_badge.svg");
  static IconPark heartBallon = IconPark._(fileName: "心形气球_heart-ballon.svg");
  static IconPark cardioelectric = IconPark._(fileName: "心电_cardioelectric.svg");
  static IconPark electrocardiogram = IconPark._(fileName: "心电图_electrocardiogram.svg");
  static IconPark heart = IconPark._(fileName: "心脏_heart.svg");
  static IconPark heartbeat = IconPark._(fileName: "心跳_heartbeat.svg");
  static IconPark expressDelivery = IconPark._(fileName: "快递_express-delivery.svg");
  static IconPark shutterPriority = IconPark._(fileName: "快门优先_shutter-priority.svg");
  static IconPark mindmapMap = IconPark._(fileName: "思维导图_mindmap-map.svg");
  static IconPark thinkingProblem = IconPark._(fileName: "思考问题_thinking-problem.svg");
  static IconPark surprisedFaceWithOpenMouth = IconPark._(fileName: "惊讶_surprised-face-with-open-mouth.svg");
  static IconPark surprisedFaceWithOpenBigMouth = IconPark._(fileName: "惊讶张嘴_surprised-face-with-open-big-mouth.svg");
  static IconPark inductionLock = IconPark._(fileName: "感应锁_induction-lock.svg");
  static IconPark poutingFace = IconPark._(fileName: "愤怒_pouting-face.svg");
  static IconPark dongchedi = IconPark._(fileName: "懂车帝_dongchedi.svg");
  static IconPark transaction = IconPark._(fileName: "成交_transaction.svg");
  static IconPark composition = IconPark._(fileName: "成份_composition.svg");
  static IconPark success = IconPark._(fileName: "成功_success.svg");
  static IconPark listSuccess = IconPark._(fileName: "成功列表_list-success.svg");
  static IconPark fileSuccessOne = IconPark._(fileName: "成功文件1_file-success-one.svg");
  static IconPark fileSuccess = IconPark._(fileName: "成功文件_file-success.svg");
  static IconPark folderSuccessOne = IconPark._(fileName: "成功文件夹1_folder-success-one.svg");
  static IconPark folderSuccess = IconPark._(fileName: "成功文件夹_folder-success.svg");
  static IconPark group = IconPark._(fileName: "成组_group.svg");
  static IconPark me = IconPark._(fileName: "我的_me.svg");
  static IconPark screenshotOne = IconPark._(fileName: "截图_screenshot-one.svg");
  static IconPark screenshotTwo = IconPark._(fileName: "截屏_screenshot-two.svg");
  static IconPark screenshot = IconPark._(fileName: "截屏_screenshot.svg");
  static IconPark outdoor = IconPark._(fileName: "户外_outdoor.svg");
  static IconPark fan = IconPark._(fileName: "扇子_fan.svg");
  static IconPark handDrag = IconPark._(fileName: "手动拖动_hand-drag.svg");
  static IconPark manualGear = IconPark._(fileName: "手动挡_manual-gear.svg");
  static IconPark clothesGlovesTwo = IconPark._(fileName: "手套_clothes-gloves-two.svg");
  static IconPark clothesGloves = IconPark._(fileName: "手套_clothes-gloves.svg");
  static IconPark escalators = IconPark._(fileName: "手扶电梯_escalators.svg");
  static IconPark palm = IconPark._(fileName: "手掌_palm.svg");
  static IconPark handbag = IconPark._(fileName: "手提包_handbag.svg");
  static IconPark phone = IconPark._(fileName: "手机_phone.svg");
  static IconPark aHandleA = IconPark._(fileName: "手柄A_handle-a.svg");
  static IconPark bHandleB = IconPark._(fileName: "手柄B_handle-b.svg");
  static IconPark cHandleC = IconPark._(fileName: "手柄C_handle-c.svg");
  static IconPark xHandleX = IconPark._(fileName: "手柄X_handle-x.svg");
  static IconPark yHandleY = IconPark._(fileName: "手柄Y_handle-y.svg");
  static IconPark zHandleZ = IconPark._(fileName: "手柄Z_handle-z.svg");
  static IconPark handleTriangle = IconPark._(fileName: "手柄三角形_handle-triangle.svg");
  static IconPark handleUp = IconPark._(fileName: "手柄上_handle-up.svg");
  static IconPark handleDown = IconPark._(fileName: "手柄下_handle-down.svg");
  static IconPark handleRight = IconPark._(fileName: "手柄右_handle-right.svg");
  static IconPark handleRound = IconPark._(fileName: "手柄圆圈_handle-round.svg");
  static IconPark handleLeft = IconPark._(fileName: "手柄左_handle-left.svg");
  static IconPark handleSquare = IconPark._(fileName: "手柄方形_handle-square.svg");
  static IconPark flashlight = IconPark._(fileName: "手电筒_flashlight.svg");
  static IconPark handPaintedPlate = IconPark._(fileName: "手绘板_hand-painted-plate.svg");
  static IconPark watchOne = IconPark._(fileName: "手表_watch-one.svg");
  static IconPark watch = IconPark._(fileName: "手表_watch.svg");
  static IconPark poker = IconPark._(fileName: "扑克_poker.svg");
  static IconPark printerOne = IconPark._(fileName: "打印机_printer-one.svg");
  static IconPark printerTwo = IconPark._(fileName: "打印机_printer-two.svg");
  static IconPark printer = IconPark._(fileName: "打印机_printer.svg");
  static IconPark openOne = IconPark._(fileName: "打开_open-one.svg");
  static IconPark open = IconPark._(fileName: "打开_open.svg");
  static IconPark turnOn = IconPark._(fileName: "打开_turn-on.svg");
  static IconPark hi = IconPark._(fileName: "打招呼_hi.svg");
  static IconPark playVolleyball = IconPark._(fileName: "打排球_play-volleyball.svg");
  static IconPark playBasketball = IconPark._(fileName: "打篮球_play-basketball.svg");
  static IconPark injection = IconPark._(fileName: "打针_injection.svg");
  static IconPark ovenTray = IconPark._(fileName: "托盘_oven-tray.svg");
  static IconPark tray = IconPark._(fileName: "托盘_tray.svg");
  static IconPark holdInterface = IconPark._(fileName: "托起_hold-interface.svg");
  static IconPark consignment = IconPark._(fileName: "托运_consignment.svg");
  static IconPark scan = IconPark._(fileName: "扫描_scan.svg");
  static IconPark scanningTwo = IconPark._(fileName: "扫描_scanning-two.svg");
  static IconPark scanning = IconPark._(fileName: "扫描_scanning.svg");
  static IconPark scanSetting = IconPark._(fileName: "扫描设置_scan-setting.svg");
  static IconPark scanCode = IconPark._(fileName: "扫码_scan-code.svg");
  static IconPark distortion = IconPark._(fileName: "扭曲_distortion.svg");
  static IconPark hold = IconPark._(fileName: "承接_hold.svg");
  static IconPark castScreen = IconPark._(fileName: "投射屏幕_cast-screen.svg");
  static IconPark projectorTwo = IconPark._(fileName: "投影仪_projector-two.svg");
  static IconPark projector = IconPark._(fileName: "投影仪_projector.svg");
  static IconPark projectorOne = IconPark._(fileName: "投影机_projector-one.svg");
  static IconPark tiktok = IconPark._(fileName: "抖音_tiktok.svg");
  static IconPark huoshanzhibo = IconPark._(fileName: "抖音火山_huoshanzhibo.svg");
  static IconPark chartLine = IconPark._(fileName: "折线图_chart-line.svg");
  static IconPark chartLineArea = IconPark._(fileName: "折线面积图_chart-line-area.svg");
  static IconPark parabola = IconPark._(fileName: "抛物线_parabola.svg");
  static IconPark anchorTwo = IconPark._(fileName: "抛锚_anchor-two.svg");
  static IconPark conditioner = IconPark._(fileName: "护发素_conditioner.svg");
  static IconPark handCream = IconPark._(fileName: "护手霜_hand-cream.svg");
  static IconPark passportOne = IconPark._(fileName: "护照_passport-one.svg");
  static IconPark passport = IconPark._(fileName: "护照_passport.svg");
  static IconPark newspaperFolding = IconPark._(fileName: "报纸折叠_newspaper-folding.svg");
  static IconPark tableReport = IconPark._(fileName: "报表_table-report.svg");
  static IconPark caution = IconPark._(fileName: "报错_caution.svg");
  static IconPark respect = IconPark._(fileName: "抱拳_respect.svg");
  static IconPark confoundedFace = IconPark._(fileName: "抿嘴闭眼_confounded-face.svg");
  static IconPark worriedFace = IconPark._(fileName: "担心_worried-face.svg");
  static IconPark splitCells = IconPark._(fileName: "拆分单元格_split-cells.svg");
  static IconPark pullDoor = IconPark._(fileName: "拉门_pull-door.svg");
  static IconPark aCane = IconPark._(fileName: "拐杖_a-cane.svg");
  static IconPark extend = IconPark._(fileName: "拓展_extend.svg");
  static IconPark drag = IconPark._(fileName: "拖拽_drag.svg");
  static IconPark slippersOne = IconPark._(fileName: "拖鞋_slippers-one.svg");
  static IconPark slippers = IconPark._(fileName: "拖鞋_slippers.svg");
  static IconPark come = IconPark._(fileName: "招引_come.svg");
  static IconPark swing = IconPark._(fileName: "招手_swing.svg");
  static IconPark bye = IconPark._(fileName: "拜拜_bye.svg");
  static IconPark rattleOne = IconPark._(fileName: "拨浪鼓1_rattle-one.svg");
  static IconPark rattle = IconPark._(fileName: "拨浪鼓_rattle.svg");
  static IconPark boxingOne = IconPark._(fileName: "拳击1_boxing-one.svg");
  static IconPark boxing = IconPark._(fileName: "拳击_boxing.svg");
  static IconPark fist = IconPark._(fileName: "拳头_fist.svg");
  static IconPark puzzle = IconPark._(fileName: "拼图_puzzle.svg");
  static IconPark instruction = IconPark._(fileName: "指令_instruction.svg");
  static IconPark pointOut = IconPark._(fileName: "指出_point-out.svg");
  static IconPark compassOne = IconPark._(fileName: "指南针_compass-one.svg");
  static IconPark point = IconPark._(fileName: "指向_point.svg");
  static IconPark fingernail = IconPark._(fileName: "指甲_fingernail.svg");
  static IconPark nailPolishOne = IconPark._(fileName: "指甲油1_nail-polish-one.svg");
  static IconPark nailPolish = IconPark._(fileName: "指甲油_nail-polish.svg");
  static IconPark guideBoard = IconPark._(fileName: "指示牌_guide-board.svg");
  static IconPark fingerprintThree = IconPark._(fileName: "指纹_fingerprint-three.svg");
  static IconPark fingerprintTwo = IconPark._(fileName: "指纹_fingerprint-two.svg");
  static IconPark fingerprint = IconPark._(fileName: "指纹_fingerprint.svg");
  static IconPark changeDateSort = IconPark._(fileName: "按修改日期排序_change-date-sort.svg");
  static IconPark creationDateSort = IconPark._(fileName: "按创建日期排序_creation-date-sort.svg");
  static IconPark startTimeSort = IconPark._(fileName: "按开始时间排序_start-time-sort.svg");
  static IconPark deadlineSort = IconPark._(fileName: "按截止日期排序_deadline-sort.svg");
  static IconPark massageChairOne = IconPark._(fileName: "按摩椅1_massage-chair-one.svg");
  static IconPark massageChair = IconPark._(fileName: "按摩椅_massage-chair.svg");
  static IconPark massageTable = IconPark._(fileName: "按摩椅_massage-table.svg");
  static IconPark recentViewsSort = IconPark._(fileName: "按最近浏览量排序_recent-views-sort.svg");
  static IconPark endTimeSort = IconPark._(fileName: "按结束时间排序_end-time-sort.svg");
  static IconPark followUpDateSort = IconPark._(fileName: "按跟进日期排序_follow-up-date-sort.svg");
  static IconPark oneKey = IconPark._(fileName: "按键一_one-key.svg");
  static IconPark sevenKey = IconPark._(fileName: "按键七_seven-key.svg");
  static IconPark threeKey = IconPark._(fileName: "按键三_three-key.svg");
  static IconPark nineKey = IconPark._(fileName: "按键九_nine-key.svg");
  static IconPark twoKey = IconPark._(fileName: "按键二_two-key.svg");
  static IconPark fiveKey = IconPark._(fileName: "按键五_five-key.svg");
  static IconPark eightKey = IconPark._(fileName: "按键八_eight-key.svg");
  static IconPark sixKey = IconPark._(fileName: "按键六_six-key.svg");
  static IconPark fourKey = IconPark._(fileName: "按键四_four-key.svg");
  static IconPark zeroKey = IconPark._(fileName: "按键零_zero-key.svg");
  static IconPark handheld = IconPark._(fileName: "掌机_handheld.svg");
  static IconPark exclusiveGateway = IconPark._(fileName: "排他网关_exclusive-gateway.svg");
  static IconPark sortOne = IconPark._(fileName: "排序1_sort-one.svg");
  static IconPark sortTwo = IconPark._(fileName: "排序2_sort-two.svg");
  static IconPark sortThree = IconPark._(fileName: "排序3_sort-three.svg");
  static IconPark sortFour = IconPark._(fileName: "排序_sort-four.svg");
  static IconPark sort = IconPark._(fileName: "排序_sort.svg");
  static IconPark volleyball = IconPark._(fileName: "排球_volleyball.svg");
  static IconPark rankingList = IconPark._(fileName: "排行榜_ranking-list.svg");
  static IconPark ranking = IconPark._(fileName: "排行榜_ranking.svg");
  static IconPark excludeSelection = IconPark._(fileName: "排除选择_exclude-selection.svg");
  static IconPark linkIn = IconPark._(fileName: "接入链接_link-in.svg");
  static IconPark acceptEmail = IconPark._(fileName: "接受邮件_accept-email.svg");
  static IconPark receiver = IconPark._(fileName: "接收器_receiver.svg");
  static IconPark receive = IconPark._(fileName: "接收库_receive.svg");
  static IconPark control = IconPark._(fileName: "控制器_control.svg");
  static IconPark twitter = IconPark._(fileName: "推特_twitter.svg");
  static IconPark pullRequests = IconPark._(fileName: "推送请求_pull-requests.svg");
  static IconPark pushDoor = IconPark._(fileName: "推门_push-door.svg");
  static IconPark tipsOne = IconPark._(fileName: "提示_tips-one.svg");
  static IconPark tips = IconPark._(fileName: "提示_tips.svg");
  static IconPark remind = IconPark._(fileName: "提醒_remind.svg");
  static IconPark checkIn = IconPark._(fileName: "插入_check-in.svg");
  static IconPark insertTable = IconPark._(fileName: "插入表_insert-table.svg");
  static IconPark insertCard = IconPark._(fileName: "插卡_insert-card.svg");
  static IconPark powerSupplyOne = IconPark._(fileName: "插头1_power-supply-one.svg");
  static IconPark powerSupply = IconPark._(fileName: "插头2_power-supply.svg");
  static IconPark boltOne = IconPark._(fileName: "插头_bolt-one.svg");
  static IconPark plug = IconPark._(fileName: "插头_plug.svg");
  static IconPark plugOne = IconPark._(fileName: "插电头_plug-one.svg");
  static IconPark findOne = IconPark._(fileName: "搜查_find-one.svg");
  static IconPark search = IconPark._(fileName: "搜索_search.svg");
  static IconPark seo = IconPark._(fileName: "搜索引擎_seo.svg");
  static IconPark folderSearchOne = IconPark._(fileName: "搜索文件夹1_folder-search-one.svg");
  static IconPark folderSearch = IconPark._(fileName: "搜索文件夹_folder-search.svg");
  static IconPark peopleSearch = IconPark._(fileName: "搜索用户_people-search.svg");
  static IconPark powder = IconPark._(fileName: "搽粉_powder.svg");
  static IconPark monitor = IconPark._(fileName: "摄像_monitor.svg");
  static IconPark cameraFive = IconPark._(fileName: "摄像头_camera-five.svg");
  static IconPark cameraOne = IconPark._(fileName: "摄像头_camera-one.svg");
  static IconPark videocamera = IconPark._(fileName: "摄像机1_videocamera.svg");
  static IconPark videocameraOne = IconPark._(fileName: "摄像机2_videocamera-one.svg");
  static IconPark rockGesture = IconPark._(fileName: "摇滚手势_rock-gesture.svg");
  static IconPark rock = IconPark._(fileName: "摇滚指_rock.svg");
  static IconPark babyMobile = IconPark._(fileName: "摇玩_baby-mobile.svg");
  static IconPark crib = IconPark._(fileName: "摇篮_crib.svg");
  static IconPark rockingHorse = IconPark._(fileName: "摇马_rocking-horse.svg");
  static IconPark booth = IconPark._(fileName: "摊位_booth.svg");
  static IconPark ferrisWheel = IconPark._(fileName: "摩天轮_ferris-wheel.svg");
  static IconPark undo = IconPark._(fileName: "撤销_undo.svg");
  static IconPark replayFive = IconPark._(fileName: "播放5次_replay-five.svg");
  static IconPark playOne = IconPark._(fileName: "播放_play-one.svg");
  static IconPark play = IconPark._(fileName: "播放_play.svg");
  static IconPark playOnce = IconPark._(fileName: "播放一次_play-once.svg");
  static IconPark playWrong = IconPark._(fileName: "播放出错_play-wrong.svg");
  static IconPark playTwo = IconPark._(fileName: "播放器_play-two.svg");
  static IconPark recordPlayer = IconPark._(fileName: "播放器_record-player.svg");
  static IconPark playbackProgress = IconPark._(fileName: "播放进度_playback-progress.svg");
  static IconPark erase = IconPark._(fileName: "擦除_erase.svg");
  static IconPark alipay = IconPark._(fileName: "支付宝_alipay.svg");
  static IconPark payCodeTwo = IconPark._(fileName: "支付码_pay-code-two.svg");
  static IconPark payCode = IconPark._(fileName: "支付码_pay-code.svg");
  static IconPark expensesOne = IconPark._(fileName: "支出_expenses-one.svg");
  static IconPark inboxOut = IconPark._(fileName: "收件上载_inbox-out.svg");
  static IconPark inboxIn = IconPark._(fileName: "收件下载_inbox-in.svg");
  static IconPark inboxSuccess = IconPark._(fileName: "收件成功_inbox-success.svg");
  static IconPark inboxR = IconPark._(fileName: "收件箱_inbox-r.svg");
  static IconPark inbox = IconPark._(fileName: "收件箱_inbox.svg");
  static IconPark inboxUploadR = IconPark._(fileName: "收件箱上传_inbox-upload-r.svg");
  static IconPark inboxDownloadR = IconPark._(fileName: "收件箱下载_inbox-download-r.svg");
  static IconPark inboxSuccessR = IconPark._(fileName: "收件箱成功_inbox-success-r.svg");
  static IconPark incomeOne = IconPark._(fileName: "收入_income-one.svg");
  static IconPark reduceTwo = IconPark._(fileName: "收缩_reduce-two.svg");
  static IconPark personalCollection = IconPark._(fileName: "收藏好友_personal-collection.svg");
  static IconPark fileCollectionOne = IconPark._(fileName: "收藏文件1_file-collection-one.svg");
  static IconPark collectionFiles = IconPark._(fileName: "收藏文件_collection-files.svg");
  static IconPark fileCollection = IconPark._(fileName: "收藏文件_file-collection.svg");
  static IconPark folderFocusOne = IconPark._(fileName: "收藏文件夹1_folder-focus-one.svg");
  static IconPark folderFocus = IconPark._(fileName: "收藏文件夹_folder-focus.svg");
  static IconPark collectionRecords = IconPark._(fileName: "收藏音乐_collection-records.svg");
  static IconPark collapseTextInput = IconPark._(fileName: "收起文本域_collapse-text-input.svg");
  static IconPark menuFoldOne = IconPark._(fileName: "收起菜单1_menu-fold-one.svg");
  static IconPark menuFold = IconPark._(fileName: "收起菜单_menu-fold.svg");
  static IconPark microphoneOne = IconPark._(fileName: "收音器_microphone-one.svg");
  static IconPark broadcastRadio = IconPark._(fileName: "收音机_broadcast-radio.svg");
  static IconPark radioOne = IconPark._(fileName: "收音机_radio-one.svg");
  static IconPark radio = IconPark._(fileName: "收音机_radio.svg");
  static IconPark zoomIn = IconPark._(fileName: "放大_zoom-in.svg");
  static IconPark zoom = IconPark._(fileName: "放大_zoom.svg");
  static IconPark projectorThree = IconPark._(fileName: "放映机_projector-three.svg");
  static IconPark damageMap = IconPark._(fileName: "故障图_damage-map.svg");
  static IconPark lifebuoy = IconPark._(fileName: "救生圈_lifebuoy.svg");
  static IconPark churchOne = IconPark._(fileName: "教堂_church-one.svg");
  static IconPark churchTwo = IconPark._(fileName: "教堂_church-two.svg");
  static IconPark chartScatter = IconPark._(fileName: "散点图_chart-scatter.svg");
  static IconPark listNumbers = IconPark._(fileName: "数字列表_list-numbers.svg");
  static IconPark dataAll = IconPark._(fileName: "数据_data-all.svg");
  static IconPark dataFour = IconPark._(fileName: "数据_data-four.svg");
  static IconPark dataOne = IconPark._(fileName: "数据_data-one.svg");
  static IconPark dataThree = IconPark._(fileName: "数据_data-three.svg");
  static IconPark dataTwo = IconPark._(fileName: "数据_data-two.svg");
  static IconPark dataSwitching = IconPark._(fileName: "数据切换_data-switching.svg");
  static IconPark dataArrival = IconPark._(fileName: "数据到达_data-arrival.svg");
  static IconPark chartPieOne = IconPark._(fileName: "数据图_chart-pie-one.svg");
  static IconPark data = IconPark._(fileName: "数据库_data.svg");
  static IconPark databaseDownload = IconPark._(fileName: "数据库下载_database-download.svg");
  static IconPark databaseCode = IconPark._(fileName: "数据库代码_database-code.svg");
  static IconPark databaseProportion = IconPark._(fileName: "数据库占比_database-proportion.svg");
  static IconPark databaseSync = IconPark._(fileName: "数据库同步_database-sync.svg");
  static IconPark databasePosition = IconPark._(fileName: "数据库定位_database-position.svg");
  static IconPark databaseSuccess = IconPark._(fileName: "数据库成功_database-success.svg");
  static IconPark databaseSearch = IconPark._(fileName: "数据库搜索_database-search.svg");
  static IconPark databaseTime = IconPark._(fileName: "数据库时间_database-time.svg");
  static IconPark databasePower = IconPark._(fileName: "数据库电源_database-power.svg");
  static IconPark databaseForbid = IconPark._(fileName: "数据库禁止_database-forbid.svg");
  static IconPark databaseFirst = IconPark._(fileName: "数据库第一_database-first.svg");
  static IconPark databaseNetwork = IconPark._(fileName: "数据库网络_database-network.svg");
  static IconPark databaseNetworkPoint = IconPark._(fileName: "数据库网络节点_database-network-point.svg");
  static IconPark databasePoint = IconPark._(fileName: "数据库节点_database-point.svg");
  static IconPark databaseAlert = IconPark._(fileName: "数据库警示_database-alert.svg");
  static IconPark databaseSetting = IconPark._(fileName: "数据库设置_database-setting.svg");
  static IconPark databaseEnter = IconPark._(fileName: "数据库进入_database-enter.svg");
  static IconPark databaseConfig = IconPark._(fileName: "数据库配置_database-config.svg");
  static IconPark databaseLock = IconPark._(fileName: "数据库锁定_database-lock.svg");
  static IconPark databaseFail = IconPark._(fileName: "数据库错误_database-fail.svg");
  static IconPark usbOne = IconPark._(fileName: "数据接口_usb-one.svg");
  static IconPark usb = IconPark._(fileName: "数据接口_usb.svg");
  static IconPark dataFile = IconPark._(fileName: "数据文件_data-file.svg");
  static IconPark dataDisplay = IconPark._(fileName: "数据显示_data-display.svg");
  static IconPark dataServer = IconPark._(fileName: "数据服务器_data-server.svg");
  static IconPark dataUser = IconPark._(fileName: "数据用户_data-user.svg");
  static IconPark dataScreen = IconPark._(fileName: "数据看板_data-screen.svg");
  static IconPark dataNull = IconPark._(fileName: "数据空_data-null.svg");
  static IconPark excel = IconPark._(fileName: "数据统计工具_excel.svg");
  static IconPark dataSheet = IconPark._(fileName: "数据表_data-sheet.svg");
  static IconPark pivotTable = IconPark._(fileName: "数据透视表_pivot-table.svg");
  static IconPark dataLock = IconPark._(fileName: "数据锁定_data-lock.svg");
  static IconPark overallReduction = IconPark._(fileName: "整体缩小_overall-reduction.svg");
  static IconPark plasticSurgery = IconPark._(fileName: "整形科_plastic-surgery.svg");
  static IconPark excelFileExcel = IconPark._(fileName: "文件-excel_file-excel.svg");
  static IconPark gifFileGif = IconPark._(fileName: "文件-gif_file-gif.svg");
  static IconPark jpgFileJpg = IconPark._(fileName: "文件-jpg_file-jpg.svg");
  static IconPark pdfFilePdf = IconPark._(fileName: "文件-pdf_file-pdf.svg");
  static IconPark txtFileTxt = IconPark._(fileName: "文件-txt_file-txt.svg");
  static IconPark wordFileWord = IconPark._(fileName: "文件-word_file-word.svg");
  static IconPark fileProtectionOne = IconPark._(fileName: "文件保护1_file-protection-one.svg");
  static IconPark fileProtection = IconPark._(fileName: "文件保护_file-protection.svg");
  static IconPark fileFailedOne = IconPark._(fileName: "文件失败1_file-failed-one.svg");
  static IconPark fileFailed = IconPark._(fileName: "文件失败_file-failed.svg");
  static IconPark folderUpload = IconPark._(fileName: "文件夹-上传_folder-upload.svg");
  static IconPark folderDownload = IconPark._(fileName: "文件夹-下载_folder-download.svg");
  static IconPark folderClose = IconPark._(fileName: "文件夹-关_folder-close.svg");
  static IconPark folderMinus = IconPark._(fileName: "文件夹-删除_folder-minus.svg");
  static IconPark folderOpen = IconPark._(fileName: "文件夹-开_folder-open.svg");
  static IconPark folderPlus = IconPark._(fileName: "文件夹-添加_folder-plus.svg");
  static IconPark folder = IconPark._(fileName: "文件夹_folder.svg");
  static IconPark seoFolder = IconPark._(fileName: "文件夹_seo-folder.svg");
  static IconPark folderProtectionOne = IconPark._(fileName: "文件夹保护1_folder-protection-one.svg");
  static IconPark folderProtection = IconPark._(fileName: "文件夹保护_folder-protection.svg");
  static IconPark folderSettingsOne = IconPark._(fileName: "文件夹设置1_folder-settings-one.svg");
  static IconPark folderSettings = IconPark._(fileName: "文件夹设置_folder-settings.svg");
  static IconPark fileSearchTwo = IconPark._(fileName: "文件搜索1_file-search-two.svg");
  static IconPark fileSearchOne = IconPark._(fileName: "文件搜索_file-search-one.svg");
  static IconPark fileWithdrawalOne = IconPark._(fileName: "文件撤销1_file-withdrawal-one.svg");
  static IconPark fileWithdrawal = IconPark._(fileName: "文件撤销_file-withdrawal.svg");
  static IconPark fileCabinet = IconPark._(fileName: "文件柜_file-cabinet.svg");
  static IconPark fileSearch = IconPark._(fileName: "文件查找_file-search.svg");
  static IconPark fileAdditionOne = IconPark._(fileName: "文件添加1_file-addition-one.svg");
  static IconPark fileAddition = IconPark._(fileName: "文件添加_file-addition.svg");
  static IconPark fileSettingsOne = IconPark._(fileName: "文件设置1_file-settings-one.svg");
  static IconPark fileSettings = IconPark._(fileName: "文件设置_file-settings.svg");
  static IconPark addTextTwo = IconPark._(fileName: "文字_add-text-two.svg");
  static IconPark text = IconPark._(fileName: "文字_text.svg");
  static IconPark textUnderline = IconPark._(fileName: "文字下划线_text-underline.svg");
  static IconPark alignTextBothOne = IconPark._(fileName: "文字两边对齐1_align-text-both-one.svg");
  static IconPark alignTextBoth = IconPark._(fileName: "文字两边对齐_align-text-both.svg");
  static IconPark alignTextMiddleOne = IconPark._(fileName: "文字中间对齐1_align-text-middle-one.svg");
  static IconPark alignTextMiddle = IconPark._(fileName: "文字中间对齐_align-text-middle.svg");
  static IconPark textBold = IconPark._(fileName: "文字加粗_text-bold.svg");
  static IconPark alignRightTwo = IconPark._(fileName: "文字右对齐_align-right-two.svg");
  static IconPark textarea = IconPark._(fileName: "文字域_textarea.svg");
  static IconPark addText = IconPark._(fileName: "文字大小_add-text.svg");
  static IconPark alignTextCenterOne = IconPark._(fileName: "文字居中1_align-text-center-one.svg");
  static IconPark alignTextCenter = IconPark._(fileName: "文字居中_align-text-center.svg");
  static IconPark alignTextRightOne = IconPark._(fileName: "文字居右1_align-text-right-one.svg");
  static IconPark alignTextRight = IconPark._(fileName: "文字居右_align-text-right.svg");
  static IconPark alignTextLeftOne = IconPark._(fileName: "文字居左1_align-text-left-one.svg");
  static IconPark alignTextLeft = IconPark._(fileName: "文字居左_align-text-left.svg");
  static IconPark alignLeftTwo = IconPark._(fileName: "文字左对齐_align-left-two.svg");
  static IconPark alignTextBottomOne = IconPark._(fileName: "文字底对齐1_align-text-bottom-one.svg");
  static IconPark alignTextBottom = IconPark._(fileName: "文字底对齐_align-text-bottom.svg");
  static IconPark textItalic = IconPark._(fileName: "文字斜体_text-italic.svg");
  static IconPark textMessage = IconPark._(fileName: "文字讯息_text-message.svg");
  static IconPark textRecognition = IconPark._(fileName: "文字识别_text-recognition.svg");
  static IconPark alignTextTopOne = IconPark._(fileName: "文字顶对齐1_align-text-top-one.svg");
  static IconPark alignTextTop = IconPark._(fileName: "文字顶对齐_align-text-top.svg");
  static IconPark textWrapTruncation = IconPark._(fileName: "文本换行-截断_text-wrap-truncation.svg");
  static IconPark textWrapOverflow = IconPark._(fileName: "文本换行-溢出_text-wrap-overflow.svg");
  static IconPark fileTextOne = IconPark._(fileName: "文本文件1_file-text-one.svg");
  static IconPark fileText = IconPark._(fileName: "文本文件_file-text.svg");
  static IconPark textRotationUp = IconPark._(fileName: "文本旋转-上_text-rotation-up.svg");
  static IconPark textRotationDown = IconPark._(fileName: "文本旋转-下_text-rotation-down.svg");
  static IconPark textRotationLeft = IconPark._(fileName: "文本旋转-左_text-rotation-left.svg");
  static IconPark textRotationNone = IconPark._(fileName: "文本旋转-无_text-rotation-none.svg");
  static IconPark textStyleOne = IconPark._(fileName: "文本样式_text-style-one.svg");
  static IconPark textStyle = IconPark._(fileName: "文本样式_text-style.svg");
  static IconPark fileDoc = IconPark._(fileName: "文档_file-doc.svg");
  static IconPark word = IconPark._(fileName: "文档_word.svg");
  static IconPark docFail = IconPark._(fileName: "文档失败_doc-fail.svg");
  static IconPark docSuccess = IconPark._(fileName: "文档成功_doc-success.svg");
  static IconPark docSearchTwo = IconPark._(fileName: "文档搜索_doc-search-two.svg");
  static IconPark docSearch = IconPark._(fileName: "文档搜索_doc-search.svg");
  static IconPark documentFolder = IconPark._(fileName: "文档架子_document-folder.svg");
  static IconPark docAdd = IconPark._(fileName: "文档添加_doc-add.svg");
  static IconPark docDetail = IconPark._(fileName: "文档详情_doc-detail.svg");
  static IconPark linkBreak = IconPark._(fileName: "断开连接_link-break.svg");
  static IconPark direction = IconPark._(fileName: "方向_direction.svg");
  static IconPark roadSignBoth = IconPark._(fileName: "方向标识_road-sign-both.svg");
  static IconPark roadSign = IconPark._(fileName: "方向标识_road-sign.svg");
  static IconPark directionAdjustmentThree = IconPark._(fileName: "方向校准_direction-adjustment-three.svg");
  static IconPark directionAdjustmentTwo = IconPark._(fileName: "方向校准_direction-adjustment-two.svg");
  static IconPark directionAdjustment = IconPark._(fileName: "方向校准_direction-adjustment.svg");
  static IconPark steeringWheel = IconPark._(fileName: "方向盘_steering-wheel.svg");
  static IconPark arrowKeys = IconPark._(fileName: "方向键_arrow-keys.svg");
  static IconPark endpointFlat = IconPark._(fileName: "方头端点_endpoint-flat.svg");
  static IconPark nodeFlat = IconPark._(fileName: "方头节点_node-flat.svg");
  static IconPark square = IconPark._(fileName: "方形_square.svg");
  static IconPark tourBus = IconPark._(fileName: "旅游巴士_tour-bus.svg");
  static IconPark journey = IconPark._(fileName: "旅行_journey.svg");
  static IconPark photograph = IconPark._(fileName: "旅行照_photograph.svg");
  static IconPark oneThirdRotation = IconPark._(fileName: "旋转_one-third-rotation.svg");
  static IconPark rotateOne = IconPark._(fileName: "旋转_rotate-one.svg");
  static IconPark rotate = IconPark._(fileName: "旋转_rotate.svg");
  static IconPark rotation = IconPark._(fileName: "旋转_rotation.svg");
  static IconPark rotatingAdd = IconPark._(fileName: "旋转添加_rotating-add.svg");
  static IconPark whirlwind = IconPark._(fileName: "旋风_whirlwind.svg");
  static IconPark flag = IconPark._(fileName: "旗子_flag.svg");
  static IconPark droneOne = IconPark._(fileName: "无人机_drone-one.svg");
  static IconPark drone = IconPark._(fileName: "无人机_drone.svg");
  static IconPark faceWithoutMouth = IconPark._(fileName: "无嘴脸_face-without-mouth.svg");
  static IconPark unorderedList = IconPark._(fileName: "无序列表_unordered-list.svg");
  static IconPark remindDisable = IconPark._(fileName: "无效提醒_remind-disable.svg");
  static IconPark endless = IconPark._(fileName: "无穷尽_endless.svg");
  static IconPark wifi = IconPark._(fileName: "无线网络_wifi.svg");
  static IconPark expressionlessFace = IconPark._(fileName: "无语脸_expressionless-face.svg");
  static IconPark sunbath = IconPark._(fileName: "日光浴_sunbath.svg");
  static IconPark sunrise = IconPark._(fileName: "日出_sunrise.svg");
  static IconPark calendarDot = IconPark._(fileName: "日历_calendar-dot.svg");
  static IconPark calendarThirtyTwo = IconPark._(fileName: "日历_calendar-thirty-two.svg");
  static IconPark calendarThirty = IconPark._(fileName: "日历_calendar-thirty.svg");
  static IconPark calendarThree = IconPark._(fileName: "日历_calendar-three.svg");
  static IconPark calendar = IconPark._(fileName: "日历_calendar.svg");
  static IconPark log = IconPark._(fileName: "日志_log.svg");
  static IconPark schedule = IconPark._(fileName: "日程表_schedule.svg");
  static IconPark time = IconPark._(fileName: "时间_time.svg");
  static IconPark timeline = IconPark._(fileName: "时间线_timeline.svg");
  static IconPark market = IconPark._(fileName: "易拍_market.svg");
  static IconPark asterisk = IconPark._(fileName: "星号_asterisk.svg");
  static IconPark asteriskKey = IconPark._(fileName: "星号键_asterisk-key.svg");
  static IconPark xingtu = IconPark._(fileName: "星图_xingtu.svg");
  static IconPark starOne = IconPark._(fileName: "星星_star-one.svg");
  static IconPark star = IconPark._(fileName: "星星_star.svg");
  static IconPark twoTriangles = IconPark._(fileName: "星星_two-triangles.svg");
  static IconPark planet = IconPark._(fileName: "星球_planet.svg");
  static IconPark microscopeOne = IconPark._(fileName: "显微镜_microscope-one.svg");
  static IconPark microscope = IconPark._(fileName: "显微镜_microscope.svg");
  static IconPark monitorOne = IconPark._(fileName: "显示器_monitor-one.svg");
  static IconPark display = IconPark._(fileName: "显示屏_display.svg");
  static IconPark fileDisplayOne = IconPark._(fileName: "显示文件1_file-display-one.svg");
  static IconPark fileDisplay = IconPark._(fileName: "显示文件_file-display.svg");
  static IconPark sunny = IconPark._(fileName: "晴天_sunny.svg");
  static IconPark latticePattern = IconPark._(fileName: "晶格图案_lattice-pattern.svg");
  static IconPark smartOptimization = IconPark._(fileName: "智能优化_smart-optimization.svg");
  static IconPark iwatchOne = IconPark._(fileName: "智能手表_iwatch-one.svg");
  static IconPark iwatch = IconPark._(fileName: "智能手表_iwatch.svg");
  static IconPark cameraThree = IconPark._(fileName: "智能摄像头_camera-three.svg");
  static IconPark electronicDoorLock = IconPark._(fileName: "智能门锁_electronic-door-lock.svg");
  static IconPark hanger = IconPark._(fileName: "晾衣架_hanger.svg");
  static IconPark pauseOne = IconPark._(fileName: "暂停_pause-one.svg");
  static IconPark pause = IconPark._(fileName: "暂停_pause.svg");
  static IconPark hockey = IconPark._(fileName: "曲棍球_hockey.svg");
  static IconPark curveAdjustment = IconPark._(fileName: "曲线调整_curve-adjustment.svg");
  static IconPark moreOne = IconPark._(fileName: "更多1_more-one.svg");
  static IconPark moreTwo = IconPark._(fileName: "更多2_more-two.svg");
  static IconPark moreThree = IconPark._(fileName: "更多3_more-three.svg");
  static IconPark moreApp = IconPark._(fileName: "更多_more-app.svg");
  static IconPark moreFour = IconPark._(fileName: "更多_more-four.svg");
  static IconPark more = IconPark._(fileName: "更多_more.svg");
  static IconPark change = IconPark._(fileName: "更改_change.svg");
  static IconPark updateRotation = IconPark._(fileName: "更新_update-rotation.svg");
  static IconPark bringToFront = IconPark._(fileName: "最上层_bring-to-front.svg");
  static IconPark sentToBack = IconPark._(fileName: "最下层_sent-to-back.svg");
  static IconPark maximum = IconPark._(fileName: "最大值_maximum.svg");
  static IconPark min = IconPark._(fileName: "最小值_min.svg");
  static IconPark moon = IconPark._(fileName: "月亮_moon.svg");
  static IconPark orderedList = IconPark._(fileName: "有序列表_ordered-list.svg");
  static IconPark friendsCircle = IconPark._(fileName: "朋友圈_friends-circle.svg");
  static IconPark server = IconPark._(fileName: "服务器_server.svg");
  static IconPark telescope = IconPark._(fileName: "望远镜_telescope.svg");
  static IconPark futureBuildOne = IconPark._(fileName: "未来大厦_future-build-one.svg");
  static IconPark futureBuildThree = IconPark._(fileName: "未来建筑_future-build-three.svg");
  static IconPark futureBuildTwo = IconPark._(fileName: "未来魔都_future-build-two.svg");
  static IconPark messageUnread = IconPark._(fileName: "未读消息_message-unread.svg");
  static IconPark localPin = IconPark._(fileName: "本地_local-pin.svg");
  static IconPark localTwo = IconPark._(fileName: "本地_local-two.svg");
  static IconPark robotOne = IconPark._(fileName: "机器人1_robot-one.svg");
  static IconPark robotTwo = IconPark._(fileName: "机器人2_robot-two.svg");
  static IconPark robot = IconPark._(fileName: "机器人2_robot.svg");
  static IconPark permissions = IconPark._(fileName: "权限_permissions.svg");
  static IconPark materialThree = IconPark._(fileName: "材料3_material-three.svg");
  static IconPark materialTwo = IconPark._(fileName: "材质_material-two.svg");
  static IconPark chartHistogramOne = IconPark._(fileName: "条形图_chart-histogram-one.svg");
  static IconPark chartHistogramTwo = IconPark._(fileName: "条形图_chart-histogram-two.svg");
  static IconPark chartHistogram = IconPark._(fileName: "条形图_chart-histogram.svg");
  static IconPark barCode = IconPark._(fileName: "条形码_bar-code.svg");
  static IconPark cupOne = IconPark._(fileName: "杯子_cup-one.svg");
  static IconPark lincoln = IconPark._(fileName: "林肯_lincoln.svg");
  static IconPark juice = IconPark._(fileName: "果饮_juice.svg");
  static IconPark targetTwo = IconPark._(fileName: "枪靶_target-two.svg");
  static IconPark lemon = IconPark._(fileName: "柠檬_lemon.svg");
  static IconPark orangeOne = IconPark._(fileName: "柠檬片_orange-one.svg");
  static IconPark find = IconPark._(fileName: "查找_find.svg");
  static IconPark fenceTwo = IconPark._(fileName: "栅栏_fence-two.svg");
  static IconPark label = IconPark._(fileName: "标签_label.svg");
  static IconPark tagOne = IconPark._(fileName: "标签_tag-one.svg");
  static IconPark tag = IconPark._(fileName: "标签_tag.svg");
  static IconPark mark = IconPark._(fileName: "标记_mark.svg");
  static IconPark h2 = IconPark._(fileName: "标题1_h2.svg");
  static IconPark h3 = IconPark._(fileName: "标题2_h3.svg");
  static IconPark h1 = IconPark._(fileName: "标题_h1.svg");
  static IconPark titleLevel = IconPark._(fileName: "标题级别_title-level.svg");
  static IconPark fenceOne = IconPark._(fileName: "栏栅_fence-one.svg");
  static IconPark tree = IconPark._(fileName: "树_tree.svg");
  static IconPark leaves = IconPark._(fileName: "树叶_leaves.svg");
  static IconPark sleaves = IconPark._(fileName: "树叶_sleaves.svg");
  static IconPark treeDiagram = IconPark._(fileName: "树状图_tree-diagram.svg");
  static IconPark treeList = IconPark._(fileName: "树结构_tree-list.svg");
  static IconPark sapling = IconPark._(fileName: "树苗_sapling.svg");
  static IconPark checkSmall = IconPark._(fileName: "校验-小_check-small.svg");
  static IconPark checkOne = IconPark._(fileName: "校验_check-one.svg");
  static IconPark check = IconPark._(fileName: "校验_check.svg");
  static IconPark nuclearPlant = IconPark._(fileName: "核电厂_nuclear-plant.svg");
  static IconPark nmr = IconPark._(fileName: "核磁共振_nmr.svg");
  static IconPark format = IconPark._(fileName: "格式_format.svg");
  static IconPark formatBrush = IconPark._(fileName: "格式刷_format-brush.svg");
  static IconPark peach = IconPark._(fileName: "桃子_peach.svg");
  static IconPark brdigeThree = IconPark._(fileName: "桥_brdige-three.svg");
  static IconPark bridgeOne = IconPark._(fileName: "桥_bridge-one.svg");
  static IconPark bridgeTwo = IconPark._(fileName: "桥_bridge-two.svg");
  static IconPark pear = IconPark._(fileName: "梨子_pear.svg");
  static IconPark ladder = IconPark._(fileName: "梯子_ladder.svg");
  static IconPark trapezoid = IconPark._(fileName: "梯形_trapezoid.svg");
  static IconPark comb = IconPark._(fileName: "梳子_comb.svg");
  static IconPark inspection = IconPark._(fileName: "检查_inspection.svg");
  static IconPark checklist = IconPark._(fileName: "检查列表_checklist.svg");
  static IconPark detection = IconPark._(fileName: "检测_detection.svg");
  static IconPark gateMachine = IconPark._(fileName: "检票机_gate-machine.svg");
  static IconPark checkerboard = IconPark._(fileName: "棋盘_checkerboard.svg");
  static IconPark lollipop = IconPark._(fileName: "棒棒糖_lollipop.svg");
  static IconPark baseball = IconPark._(fileName: "棒球_baseball.svg");
  static IconPark baseballCap = IconPark._(fileName: "棒球帽_baseball-cap.svg");
  static IconPark ovalOne = IconPark._(fileName: "椭圆形_oval-one.svg");
  static IconPark ovalLoveTwo = IconPark._(fileName: "椭圆爱心_oval-love-two.svg");
  static IconPark ovalLove = IconPark._(fileName: "椭圆爱心_oval-love.svg");
  static IconPark coconutTree = IconPark._(fileName: "椰子树_coconut-tree.svg");
  static IconPark soybeanMilkMaker = IconPark._(fileName: "榨汁机_soybean-milk-maker.svg");
  static IconPark blocksAndArrows = IconPark._(fileName: "模块箭头_blocks-and-arrows.svg");
  static IconPark rotationHorizontal = IconPark._(fileName: "横向旋转_rotation-horizontal.svg");
  static IconPark cherry = IconPark._(fileName: "樱桃_cherry.svg");
  static IconPark rugbyOne = IconPark._(fileName: "橄榄球1_rugby-one.svg");
  static IconPark rugby = IconPark._(fileName: "橄榄球_rugby.svg");
  static IconPark orange = IconPark._(fileName: "橙子_orange.svg");
  static IconPark orangeStation = IconPark._(fileName: "橙子建站_orange-station.svg");
  static IconPark ceMarking = IconPark._(fileName: "欧洲市场_ce-marking.svg");
  static IconPark rotatingForward = IconPark._(fileName: "正向旋转_rotating-forward.svg");
  static IconPark neutralFace = IconPark._(fileName: "正常标签_neutral-face.svg");
  static IconPark sinusoid = IconPark._(fileName: "正弦曲线_sinusoid.svg");
  static IconPark rightUser = IconPark._(fileName: "正确用户_right-user.svg");
  static IconPark correct = IconPark._(fileName: "正确的_correct.svg");
  static IconPark deathStar = IconPark._(fileName: "死亡之星_death-star.svg");
  static IconPark paragraphCut = IconPark._(fileName: "段落截断_paragraph-cut.svg");
  static IconPark paragraphBreakTwo = IconPark._(fileName: "段落折行_paragraph-break-two.svg");
  static IconPark paragraphBreak = IconPark._(fileName: "段落折行_paragraph-break.svg");
  static IconPark paragraphUnfold = IconPark._(fileName: "段落溢出_paragraph-unfold.svg");
  static IconPark toxins = IconPark._(fileName: "毒素_toxins.svg");
  static IconPark proportionalScaling = IconPark._(fileName: "比例缩放_proportional-scaling.svg");
  static IconPark scoreboard = IconPark._(fileName: "比分牌_scoreboard.svg");
  static IconPark bitcoin = IconPark._(fileName: "比特币_bitcoin.svg");
  static IconPark towerOfPisa = IconPark._(fileName: "比萨斜塔_tower-of-pisa.svg");
  static IconPark towel = IconPark._(fileName: "毛巾_towel.svg");
  static IconPark sweater = IconPark._(fileName: "毛衣_sweater.svg");
  static IconPark homestay = IconPark._(fileName: "民宿_homestay.svg");
  static IconPark bubbleChart = IconPark._(fileName: "气泡图_bubble-chart.svg");
  static IconPark partyBalloon = IconPark._(fileName: "气球_party-balloon.svg");
  static IconPark waterLevel = IconPark._(fileName: "水位线_water-level.svg");
  static IconPark kettleOne = IconPark._(fileName: "水壶_kettle-one.svg");
  static IconPark alignmentHorizontalTop = IconPark._(fileName: "水平上对齐_alignment-horizontal-top.svg");
  static IconPark alignmentHorizontalBottom = IconPark._(fileName: "水平下对齐_alignment-horizontal-bottom.svg");
  static IconPark distributeHorizontally = IconPark._(fileName: "水平分布_distribute-horizontally.svg");
  static IconPark alignHorizontally = IconPark._(fileName: "水平对齐_align-horizontally.svg");
  static IconPark marginOne = IconPark._(fileName: "水平居中_margin-one.svg");
  static IconPark alignHorizontalCenterTwo = IconPark._(fileName: "水平居中对齐2_align-horizontal-center-two.svg");
  static IconPark alignmentHorizontalCenter = IconPark._(fileName: "水平居中对齐_alignment-horizontal-center.svg");
  static IconPark horizontallyCentered = IconPark._(fileName: "水平居中对齐_horizontally-centered.svg");
  static IconPark slidingHorizontal = IconPark._(fileName: "水平拖动_sliding-horizontal.svg");
  static IconPark horizontalTidyUp = IconPark._(fileName: "水平整理_horizontal-tidy-up.svg");
  static IconPark levelAdjustment = IconPark._(fileName: "水平校准_level-adjustment.svg");
  static IconPark flipHorizontally = IconPark._(fileName: "水平翻转_flip-horizontally.svg");
  static IconPark horizontalSpacingBetweenItems = IconPark._(fileName: "水平间距_horizontal-spacing-between-items.svg");
  static IconPark distributeHorizontalSpacing = IconPark._(fileName: "水平间距分布_distribute-horizontal-spacing.svg");
  static IconPark cannedFruit = IconPark._(fileName: "水果罐头_canned-fruit.svg");
  static IconPark waterpoloOne = IconPark._(fileName: "水球1_waterpolo-one.svg");
  static IconPark waterpolo = IconPark._(fileName: "水球_waterpolo.svg");
  static IconPark waterRateTwo = IconPark._(fileName: "水电费_water-rate-two.svg");
  static IconPark waterNo = IconPark._(fileName: "水缺乏_water-no.svg");
  static IconPark waterRate = IconPark._(fileName: "水费_water-rate.svg");
  static IconPark water = IconPark._(fileName: "水资源_water.svg");
  static IconPark convergingGateway = IconPark._(fileName: "汇聚网关_converging-gateway.svg");
  static IconPark hamburgerOne = IconPark._(fileName: "汉堡_hamburger-one.svg");
  static IconPark hamburger = IconPark._(fileName: "汉堡_hamburger.svg");
  static IconPark hamburgerButton = IconPark._(fileName: "汉堡图标_hamburger-button.svg");
  static IconPark petrol = IconPark._(fileName: "汽油_petrol.svg");
  static IconPark car = IconPark._(fileName: "汽车_car.svg");
  static IconPark gps = IconPark._(fileName: "汽车导航_gps.svg");
  static IconPark carBattery = IconPark._(fileName: "汽车电瓶_car-battery.svg");
  static IconPark sofaTwo = IconPark._(fileName: "沙发_sofa-two.svg");
  static IconPark sofa = IconPark._(fileName: "沙发_sofa.svg");
  static IconPark sandstorm = IconPark._(fileName: "沙尘暴_sandstorm.svg");
  static IconPark hourglass = IconPark._(fileName: "沙漏_hourglass.svg");
  static IconPark hourglassFull = IconPark._(fileName: "沙漏满_hourglass-full.svg");
  static IconPark hourglassNull = IconPark._(fileName: "沙漏空_hourglass-null.svg");
  static IconPark communication = IconPark._(fileName: "沟通_communication.svg");
  static IconPark wearyFace = IconPark._(fileName: "沮丧_weary-face.svg");
  static IconPark youtobe = IconPark._(fileName: "油管_youtobe.svg");
  static IconPark bill = IconPark._(fileName: "法案_bill.svg");
  static IconPark soapBubble = IconPark._(fileName: "泡泡_soap-bubble.svg");
  static IconPark ripple = IconPark._(fileName: "波纹_ripple.svg");
  static IconPark attention = IconPark._(fileName: "注意_attention.svg");
  static IconPark tajMahal = IconPark._(fileName: "泰姬陵_taj-mahal.svg");
  static IconPark swimsuit = IconPark._(fileName: "泳装_swimsuit.svg");
  static IconPark handwashing = IconPark._(fileName: "洗手_handwashing.svg");
  static IconPark handwashingFluid = IconPark._(fileName: "洗手液_handwashing-fluid.svg");
  static IconPark shuffleOne = IconPark._(fileName: "洗牌_shuffle-one.svg");
  static IconPark shuffle = IconPark._(fileName: "洗牌_shuffle.svg");
  static IconPark washingMachineOne = IconPark._(fileName: "洗衣机1_washing-machine-one.svg");
  static IconPark washingMachine = IconPark._(fileName: "洗衣机_washing-machine.svg");
  static IconPark facialCleanser = IconPark._(fileName: "洗面奶_facial-cleanser.svg");
  static IconPark activitySource = IconPark._(fileName: "活动源_activity-source.svg");
  static IconPark assemblyLine = IconPark._(fileName: "流水线_assembly-line.svg");
  static IconPark chromeBrowserChrome = IconPark._(fileName: "浏览器-chrome_browser-chrome.svg");
  static IconPark safariBrowserSafari = IconPark._(fileName: "浏览器-safari_browser-safari.svg");
  static IconPark browser = IconPark._(fileName: "浏览器_browser.svg");
  static IconPark beachUmbrella = IconPark._(fileName: "海滩雨伞_beach-umbrella.svg");
  static IconPark messageOne = IconPark._(fileName: "消息_message-one.svg");
  static IconPark negativeDynamics = IconPark._(fileName: "消极动态_negative-dynamics.svg");
  static IconPark consume = IconPark._(fileName: "消费_consume.svg");
  static IconPark increase = IconPark._(fileName: "涨幅_increase.svg");
  static IconPark showerHead = IconPark._(fileName: "淋浴喷头_shower-head.svg");
  static IconPark taobao = IconPark._(fileName: "淘宝_taobao.svg");
  static IconPark addFour = IconPark._(fileName: "添加_add-four.svg");
  static IconPark addOne = IconPark._(fileName: "添加_add-one.svg");
  static IconPark addThree = IconPark._(fileName: "添加_add-three.svg");
  static IconPark add = IconPark._(fileName: "添加_add.svg");
  static IconPark peoplePlusOne = IconPark._(fileName: "添加人群_people-plus-one.svg");
  static IconPark peoplePlus = IconPark._(fileName: "添加人群_people-plus.svg");
  static IconPark listAdd = IconPark._(fileName: "添加列表_list-add.svg");
  static IconPark addItem = IconPark._(fileName: "添加同级条目_add-item.svg");
  static IconPark addSubset = IconPark._(fileName: "添加子条目_add-subset.svg");
  static IconPark addUser = IconPark._(fileName: "添加用户_add-user.svg");
  static IconPark shoppingCartAdd = IconPark._(fileName: "添加购物车_shopping-cart-add.svg");
  static IconPark addMusic = IconPark._(fileName: "添加音乐_add-music.svg");
  static IconPark clear = IconPark._(fileName: "清除_clear.svg");
  static IconPark clearFormat = IconPark._(fileName: "清除格式_clear-format.svg");
  static IconPark greenHouse = IconPark._(fileName: "温室房_green-house.svg");
  static IconPark thermometer = IconPark._(fileName: "温度计_thermometer.svg");
  static IconPark gameTwo = IconPark._(fileName: "游戏_game-two.svg");
  static IconPark game = IconPark._(fileName: "游戏_game.svg");
  static IconPark gameHandle = IconPark._(fileName: "游戏手柄_game-handle.svg");
  static IconPark gameThree = IconPark._(fileName: "游戏手柄_game-three.svg");
  static IconPark joystick = IconPark._(fileName: "游戏摇杆_joystick.svg");
  static IconPark gameConsole = IconPark._(fileName: "游戏机_game-console.svg");
  static IconPark gamePs = IconPark._(fileName: "游戏机_game-ps.svg");
  static IconPark gameEmoji = IconPark._(fileName: "游戏表情_game-emoji.svg");
  static IconPark swimmingRing = IconPark._(fileName: "游泳圈_swimming-ring.svg");
  static IconPark swimmingPool = IconPark._(fileName: "游泳池_swimming-pool.svg");
  static IconPark rollerskates = IconPark._(fileName: "溜冰鞋_rollerskates.svg");
  static IconPark skating = IconPark._(fileName: "溜冰鞋_skating.svg");
  static IconPark tireSwing = IconPark._(fileName: "溜溜球_tire-swing.svg");
  static IconPark clothesSkates = IconPark._(fileName: "滑冰鞋_clothes-skates.svg");
  static IconPark skate = IconPark._(fileName: "滑板_skate.svg");
  static IconPark skiingNordic = IconPark._(fileName: "滑雪_skiing-nordic.svg");
  static IconPark float = IconPark._(fileName: "漂浮圈_float.svg");
  static IconPark performance = IconPark._(fileName: "演出_performance.svg");
  static IconPark diving = IconPark._(fileName: "潜水_diving.svg");
  static IconPark divingBottle = IconPark._(fileName: "潜水瓶_diving-bottle.svg");
  static IconPark divingSuit = IconPark._(fileName: "潜水装_diving-suit.svg");
  static IconPark faceu = IconPark._(fileName: "激萌_faceu.svg");
  static IconPark waterfallsH = IconPark._(fileName: "瀑布流横向_waterfalls-h.svg");
  static IconPark waterfallsV = IconPark._(fileName: "瀑布流纵向_waterfalls-v.svg");
  static IconPark fireTwo = IconPark._(fileName: "火堆_fire-two.svg");
  static IconPark vigo = IconPark._(fileName: "火山小视频_vigo.svg");
  static IconPark torch = IconPark._(fileName: "火炬_torch.svg");
  static IconPark fire = IconPark._(fileName: "火热_fire.svg");
  static IconPark rocketOne = IconPark._(fileName: "火箭_rocket-one.svg");
  static IconPark rocket = IconPark._(fileName: "火箭_rocket.svg");
  static IconPark chafingDishOne = IconPark._(fileName: "火锅_chafing-dish-one.svg");
  static IconPark hotPotOne = IconPark._(fileName: "火锅_hot-pot-one.svg");
  static IconPark hotPot = IconPark._(fileName: "火锅_hot-pot.svg");
  static IconPark turkey = IconPark._(fileName: "火鸡_turkey.svg");
  static IconPark fireExtinguisherOne = IconPark._(fileName: "灭火器_fire-extinguisher-one.svg");
  static IconPark fireExtinguisher = IconPark._(fileName: "灭火器_fire-extinguisher.svg");
  static IconPark lightHouse = IconPark._(fileName: "灯塔_light-house.svg");
  static IconPark frenchFries = IconPark._(fileName: "炸薯条_french-fries.svg");
  static IconPark dot = IconPark._(fileName: "点_dot.svg");
  static IconPark clickTapTwo = IconPark._(fileName: "点击_click-tap-two.svg");
  static IconPark clickTap = IconPark._(fileName: "点击_click-tap.svg");
  static IconPark click = IconPark._(fileName: "点击_click.svg");
  static IconPark press = IconPark._(fileName: "点击_press.svg");
  static IconPark clickToFold = IconPark._(fileName: "点击缩起_click-to-fold.svg");
  static IconPark chimney = IconPark._(fileName: "烟筒_chimney.svg");
  static IconPark barbecue = IconPark._(fileName: "烧烤_barbecue.svg");
  static IconPark hotAirBalloon = IconPark._(fileName: "热气球_hot-air-balloon.svg");
  static IconPark kettle = IconPark._(fileName: "热水壶_kettle.svg");
  static IconPark cooking = IconPark._(fileName: "烹饪_cooking.svg");
  static IconPark egg = IconPark._(fileName: "煎鸡蛋_egg.svg");
  static IconPark pic = IconPark._(fileName: "照片_pic.svg");
  static IconPark cookingPot = IconPark._(fileName: "煮锅_cooking-pot.svg");
  static IconPark cook = IconPark._(fileName: "煮饭_cook.svg");
  static IconPark ironThree = IconPark._(fileName: "熨斗_iron-three.svg");
  static IconPark ironTwo = IconPark._(fileName: "熨斗_iron-two.svg");
  static IconPark iron = IconPark._(fileName: "熨斗_iron.svg");
  static IconPark ironDisable = IconPark._(fileName: "熨斗坏了_iron-disable.svg");
  static IconPark swallow = IconPark._(fileName: "燕子_swallow.svg");
  static IconPark nests = IconPark._(fileName: "燕窝_nests.svg");
  static IconPark popcornOne = IconPark._(fileName: "爆米花_popcorn-one.svg");
  static IconPark popcorn = IconPark._(fileName: "爆米花_popcorn.svg");
  static IconPark copyright = IconPark._(fileName: "版权符号_copyright.svg");
  static IconPark teeth = IconPark._(fileName: "牙齿_teeth.svg");
  static IconPark milkOne = IconPark._(fileName: "牛奶_milk-one.svg");
  static IconPark milk = IconPark._(fileName: "牛奶_milk.svg");
  static IconPark avocadoOne = IconPark._(fileName: "牛油果_avocado-one.svg");
  static IconPark avocado = IconPark._(fileName: "牛油果_avocado.svg");
  static IconPark croissant = IconPark._(fileName: "牛角面包_croissant.svg");
  static IconPark holdingHands = IconPark._(fileName: "牵手_holding-hands.svg");
  static IconPark effects = IconPark._(fileName: "特效_effects.svg");
  static IconPark maya = IconPark._(fileName: "玛雅_maya.svg");
  static IconPark chartRing = IconPark._(fileName: "环形图_chart-ring.svg");
  static IconPark barberBrush = IconPark._(fileName: "理发刷_barber-brush.svg");
  static IconPark barberClippers = IconPark._(fileName: "理发剪_barber-clippers.svg");
  static IconPark conceptSharing = IconPark._(fileName: "理念共享_concept-sharing.svg");
  static IconPark financingOne = IconPark._(fileName: "理财_financing-one.svg");
  static IconPark financing = IconPark._(fileName: "理财_financing.svg");
  static IconPark bottleTwo = IconPark._(fileName: "瓶子_bottle-two.svg");
  static IconPark bottleThree = IconPark._(fileName: "瓶装_bottle-three.svg");
  static IconPark doughnut = IconPark._(fileName: "甜甜圈_doughnut.svg");
  static IconPark birthdayCake = IconPark._(fileName: "生日蛋糕_birthday-cake.svg");
  static IconPark angryFace = IconPark._(fileName: "生气_angry-face.svg");
  static IconPark user = IconPark._(fileName: "用户_user.svg");
  static IconPark peopleUpload = IconPark._(fileName: "用户上传_people-upload.svg");
  static IconPark peopleDownload = IconPark._(fileName: "用户下载_people-download.svg");
  static IconPark userToUserTransmission = IconPark._(fileName: "用户互传_user-to-user-transmission.svg");
  static IconPark userPositioning = IconPark._(fileName: "用户定位_user-positioning.svg");
  static IconPark potentiometer = IconPark._(fileName: "电位器_potentiometer.svg");
  static IconPark fm = IconPark._(fileName: "电台_fm.svg");
  static IconPark balanceOne = IconPark._(fileName: "电子秤_balance-one.svg");
  static IconPark industrialScales = IconPark._(fileName: "电子秤_industrial-scales.svg");
  static IconPark dianziqian = IconPark._(fileName: "电子签_dianziqian.svg");
  static IconPark digitalWatches = IconPark._(fileName: "电子表_digital-watches.svg");
  static IconPark electronicLocksClose = IconPark._(fileName: "电子锁关_electronic-locks-close.svg");
  static IconPark electronicLocksOpen = IconPark._(fileName: "电子锁开_electronic-locks-open.svg");
  static IconPark movie = IconPark._(fileName: "电影_movie.svg");
  static IconPark phoneOutgoingOne = IconPark._(fileName: "电拨拨出_phone-outgoing-one.svg");
  static IconPark phoneOutgoing = IconPark._(fileName: "电拨拨出_phone-outgoing.svg");
  static IconPark elevator = IconPark._(fileName: "电梯_elevator.svg");
  static IconPark batteryWorkingOne = IconPark._(fileName: "电池_battery-working-one.svg");
  static IconPark batteryCharge = IconPark._(fileName: "电池充电_battery-charge.svg");
  static IconPark batteryEmpty = IconPark._(fileName: "电池没电_battery-empty.svg");
  static IconPark batteryFull = IconPark._(fileName: "电池满电_battery-full.svg");
  static IconPark batteryWorking = IconPark._(fileName: "电池运行_battery-working.svg");
  static IconPark electricWave = IconPark._(fileName: "电波_electric-wave.svg");
  static IconPark waves = IconPark._(fileName: "电波_waves.svg");
  static IconPark oven = IconPark._(fileName: "电烤箱_oven.svg");
  static IconPark electricIron = IconPark._(fileName: "电熨斗_electric-iron.svg");
  static IconPark computer = IconPark._(fileName: "电脑_computer.svg");
  static IconPark tvOne = IconPark._(fileName: "电视_tv-one.svg");
  static IconPark tv = IconPark._(fileName: "电视_tv.svg");
  static IconPark phoneTwo = IconPark._(fileName: "电话2_phone-two.svg");
  static IconPark phoneOne = IconPark._(fileName: "电话_phone-one.svg");
  static IconPark phoneTelephone = IconPark._(fileName: "电话_phone-telephone.svg");
  static IconPark phoneBooth = IconPark._(fileName: "电话亭_phone-booth.svg");
  static IconPark phoneOff = IconPark._(fileName: "电话关闭_phone-off.svg");
  static IconPark sim = IconPark._(fileName: "电话卡_sim.svg");
  static IconPark phoneCall = IconPark._(fileName: "电话呼叫_phone-call.svg");
  static IconPark phoneIncomingOne = IconPark._(fileName: "电话拨入_phone-incoming-one.svg");
  static IconPark phoneIncoming = IconPark._(fileName: "电话拨入_phone-incoming.svg");
  static IconPark phoneMissed = IconPark._(fileName: "电话错过_phone-missed.svg");
  static IconPark resistor = IconPark._(fileName: "电阻器_resistor.svg");
  static IconPark boyStroller = IconPark._(fileName: "男儿童车_boy-stroller.svg");
  static IconPark menJacket = IconPark._(fileName: "男士外套_men-jacket.svg");
  static IconPark boyOne = IconPark._(fileName: "男孩1_boy-one.svg");
  static IconPark boyTwo = IconPark._(fileName: "男孩2_boy-two.svg");
  static IconPark boy = IconPark._(fileName: "男孩_boy.svg");
  static IconPark male = IconPark._(fileName: "男性_male.svg");
  static IconPark phonograph = IconPark._(fileName: "留声机_phonograph.svg");
  static IconPark tomato = IconPark._(fileName: "番茄_tomato.svg");
  static IconPark fanqiexiaoshuo = IconPark._(fileName: "番茄小说_fanqiexiaoshuo.svg");
  static IconPark germs = IconPark._(fileName: "病菌_germs.svg");
  static IconPark thin = IconPark._(fileName: "瘦身_thin.svg");
  static IconPark percentage = IconPark._(fileName: "百分号_percentage.svg");
  static IconPark crownTwo = IconPark._(fileName: "皇冠_crown-two.svg");
  static IconPark crown = IconPark._(fileName: "皇冠_crown.svg");
  static IconPark crownThree = IconPark._(fileName: "皇冠帽_crown-three.svg");
  static IconPark cameraFour = IconPark._(fileName: "监控录像_camera-four.svg");
  static IconPark monitorCamera = IconPark._(fileName: "监控摄像头_monitor-camera.svg");
  static IconPark surveillanceCamerasOne = IconPark._(fileName: "监控摄像头_surveillance-cameras-one.svg");
  static IconPark surveillanceCamerasTwo = IconPark._(fileName: "监控摄像头_surveillance-cameras-two.svg");
  static IconPark surveillanceCameras = IconPark._(fileName: "监控摄像头_surveillance-cameras.svg");
  static IconPark prison = IconPark._(fileName: "监狱_prison.svg");
  static IconPark box = IconPark._(fileName: "盒子_box.svg");
  static IconPark straightRazor = IconPark._(fileName: "直剃刀_straight-razor.svg");
  static IconPark histogram = IconPark._(fileName: "直方图_histogram.svg");
  static IconPark rightAngle = IconPark._(fileName: "直角形_right-angle.svg");
  static IconPark intersectSelection = IconPark._(fileName: "相交选择_intersect-selection.svg");
  static IconPark cameraTwo = IconPark._(fileName: "相机_camera-two.svg");
  static IconPark camera = IconPark._(fileName: "相机_camera.svg");
  static IconPark adjacentItem = IconPark._(fileName: "相邻条目_adjacent-item.svg");
  static IconPark winkingFaceWithOpenEyes = IconPark._(fileName: "眨一个眼睛_winking-face-with-open-eyes.svg");
  static IconPark winkingFace = IconPark._(fileName: "眨眼睛_winking-face.svg");
  static IconPark eyebrow = IconPark._(fileName: "眼眉_eyebrow.svg");
  static IconPark eyes = IconPark._(fileName: "眼睛_eyes.svg");
  static IconPark glassesOne = IconPark._(fileName: "眼镜_glasses-one.svg");
  static IconPark glasses = IconPark._(fileName: "眼镜_glasses.svg");
  static IconPark sleep = IconPark._(fileName: "睡眠_sleep.svg");
  static IconPark sleepOne = IconPark._(fileName: "睡觉_sleep-one.svg");
  static IconPark mascara = IconPark._(fileName: "睫毛膏_mascara.svg");
  static IconPark aiming = IconPark._(fileName: "瞄准_aiming.svg");
  static IconPark rectangleOne = IconPark._(fileName: "矩形1_rectangle-one.svg");
  static IconPark rectangle = IconPark._(fileName: "矩形_rectangle.svg");
  static IconPark rectangleTear = IconPark._(fileName: "矩形撕裂_rectangle-tear.svg");
  static IconPark rectangularVertebra = IconPark._(fileName: "矩形椎体_rectangular-vertebra.svg");
  static IconPark paragraphRectangle = IconPark._(fileName: "矩形段落_paragraph-rectangle.svg");
  static IconPark messagesOne = IconPark._(fileName: "短信1_messages-one.svg");
  static IconPark messages = IconPark._(fileName: "短信_messages.svg");
  static IconPark shortSkirt = IconPark._(fileName: "短裙_short-skirt.svg");
  static IconPark clothesPantsShort = IconPark._(fileName: "短裤_clothes-pants-short.svg");
  static IconPark clothesShortSleeve = IconPark._(fileName: "短裤_clothes-short-sleeve.svg");
  static IconPark shorts = IconPark._(fileName: "短裤_shorts.svg");
  static IconPark hardDisk = IconPark._(fileName: "硬盘_hard-disk.svg");
  static IconPark bowlOne = IconPark._(fileName: "碗_bowl-one.svg");
  static IconPark tape = IconPark._(fileName: "磁带_tape.svg");
  static IconPark typeDrive = IconPark._(fileName: "磁带_type-drive.svg");
  static IconPark disk = IconPark._(fileName: "磁盘_disk.svg");
  static IconPark magnet = IconPark._(fileName: "磁铁_magnet.svg");
  static IconPark fullDressLonguette = IconPark._(fileName: "礼服长裙_full-dress-longuette.svg");
  static IconPark gift = IconPark._(fileName: "礼物_gift.svg");
  static IconPark giftBox = IconPark._(fileName: "礼物盒_gift-box.svg");
  static IconPark fireworks = IconPark._(fileName: "礼花_fireworks.svg");
  static IconPark neural = IconPark._(fileName: "神经_neural.svg");
  static IconPark ticketOne = IconPark._(fileName: "票_ticket-one.svg");
  static IconPark ticketsChecked = IconPark._(fileName: "票务检查_tickets-checked.svg");
  static IconPark forbid = IconPark._(fileName: "禁止_forbid.svg");
  static IconPark noShooting = IconPark._(fileName: "禁止拍照_no-shooting.svg");
  static IconPark folderBlockOne = IconPark._(fileName: "禁用文件夹1_folder-block-one.svg");
  static IconPark folderBlock = IconPark._(fileName: "禁用文件夹_folder-block.svg");
  static IconPark stopwatch = IconPark._(fileName: "秒表_stopwatch.svg");
  static IconPark positiveDynamics = IconPark._(fileName: "积极动态_positive-dynamics.svg");
  static IconPark bringToFrontOne = IconPark._(fileName: "移到前面_bring-to-front-one.svg");
  static IconPark sendToBack = IconPark._(fileName: "移到后面_send-to-back.svg");
  static IconPark minusTheBottom = IconPark._(fileName: "移到底部_minus-the-bottom.svg");
  static IconPark minusTheTop = IconPark._(fileName: "移到顶部_minus-the-top.svg");
  static IconPark moveInOne = IconPark._(fileName: "移动_move-in-one.svg");
  static IconPark moveOne = IconPark._(fileName: "移动_move-one.svg");
  static IconPark move = IconPark._(fileName: "移动_move.svg");
  static IconPark gameConsoleOne = IconPark._(fileName: "移动游戏机_game-console-one.svg");
  static IconPark hardDiskOne = IconPark._(fileName: "移动硬盘_hard-disk-one.svg");
  static IconPark fileRemovalOne = IconPark._(fileName: "移除文件1_file-removal-one.svg");
  static IconPark fileRemoval = IconPark._(fileName: "移除文件_file-removal.svg");
  static IconPark bug = IconPark._(fileName: "程序问题_bug.svg");
  static IconPark empty = IconPark._(fileName: "空手_empty.svg");
  static IconPark airConditioning = IconPark._(fileName: "空调_air-conditioning.svg");
  static IconPark pangle = IconPark._(fileName: "穿山甲_pangle.svg");
  static IconPark stereoOne = IconPark._(fileName: "立体声_stereo-one.svg");
  static IconPark stereoPerspective = IconPark._(fileName: "立体透视_stereo-perspective.svg");
  static IconPark wholeSiteAccelerator = IconPark._(fileName: "站点加速_whole-site-accelerator.svg");
  static IconPark arena = IconPark._(fileName: "竞技场_arena.svg");
  static IconPark steoller = IconPark._(fileName: "童车_steoller.svg");
  static IconPark endpointDisplacement = IconPark._(fileName: "端点位移_endpoint-displacement.svg");
  static IconPark grinningFaceWithSquintingEyes = IconPark._(fileName: "笑眯眼_grinning-face-with-squinting-eyes.svg");
  static IconPark relievedFace = IconPark._(fileName: "笑眯眼_relieved-face.svg");
  static IconPark smilingFaceWithSquintingEyes = IconPark._(fileName: "笑眯眼_smiling-face-with-squinting-eyes.svg");
  static IconPark smilingFace = IconPark._(fileName: "笑脸_smiling-face.svg");
  static IconPark notes = IconPark._(fileName: "笔记_notes.svg");
  static IconPark laptop = IconPark._(fileName: "笔记本_laptop.svg");
  static IconPark notebookOne = IconPark._(fileName: "笔记本_notebook-one.svg");
  static IconPark notebook = IconPark._(fileName: "笔记本_notebook.svg");
  static IconPark notebookAndPen = IconPark._(fileName: "笔记本和笔_notebook-and-pen.svg");
  static IconPark laptopComputer = IconPark._(fileName: "笔记本电脑_laptop-computer.svg");
  static IconPark symbol = IconPark._(fileName: "符号_symbol.svg");
  static IconPark first = IconPark._(fileName: "第一_first.svg");
  static IconPark equalRatio = IconPark._(fileName: "等比_equal-ratio.svg");
  static IconPark scale = IconPark._(fileName: "等比缩放_scale.svg");
  static IconPark filterOne = IconPark._(fileName: "筛选1_filter-one.svg");
  static IconPark filter = IconPark._(fileName: "筛选_filter.svg");
  static IconPark chopsticksFork = IconPark._(fileName: "筷子叉子_chopsticks-fork.svg");
  static IconPark easy = IconPark._(fileName: "简单_easy.svg");
  static IconPark dropbox = IconPark._(fileName: "管理箱_dropbox.svg");
  static IconPark arrowUp = IconPark._(fileName: "箭头上_arrow-up.svg");
  static IconPark arrowDown = IconPark._(fileName: "箭头下_arrow-down.svg");
  static IconPark arrowRight = IconPark._(fileName: "箭头右_arrow-right.svg");
  static IconPark arrowRightUp = IconPark._(fileName: "箭头右上_arrow-right-up.svg");
  static IconPark arrowRightDown = IconPark._(fileName: "箭头右下_arrow-right-down.svg");
  static IconPark arrowLeft = IconPark._(fileName: "箭头左_arrow-left.svg");
  static IconPark arrowLeftUp = IconPark._(fileName: "箭头左上_arrow-left-up.svg");
  static IconPark arrowLeftDown = IconPark._(fileName: "箭头左下_arrow-left-down.svg");
  static IconPark basketball = IconPark._(fileName: "篮球_basketball.svg");
  static IconPark court = IconPark._(fileName: "篮球场_court.svg");
  static IconPark basketballClothes = IconPark._(fileName: "篮球服_basketball-clothes.svg");
  static IconPark basketballOne = IconPark._(fileName: "篮球架1_basketball-one.svg");
  static IconPark basketballStand = IconPark._(fileName: "篮球架_basketball-stand.svg");
  static IconPark rice = IconPark._(fileName: "米饭_rice.svg");
  static IconPark foundationMakeup = IconPark._(fileName: "粉底液_foundation-makeup.svg");
  static IconPark sperm = IconPark._(fileName: "精子_sperm.svg");
  static IconPark pokeballOne = IconPark._(fileName: "精灵球1_pokeball-one.svg");
  static IconPark baokemeng = IconPark._(fileName: "精灵球_baokemeng.svg");
  static IconPark candy = IconPark._(fileName: "糖果_candy.svg");
  static IconPark system = IconPark._(fileName: "系统_system.svg");
  static IconPark material = IconPark._(fileName: "素材_material.svg");
  static IconPark redEnvelope = IconPark._(fileName: "红包_red-envelope.svg");
  static IconPark redEnvelopes = IconPark._(fileName: "红包_red-envelopes.svg");
  static IconPark redCross = IconPark._(fileName: "红十字_red-cross.svg");
  static IconPark level = IconPark._(fileName: "级别_level.svg");
  static IconPark monumentOne = IconPark._(fileName: "纪念碑_monument-one.svg");
  static IconPark monumentTwo = IconPark._(fileName: "纪念碑_monument-two.svg");
  static IconPark pureNatural = IconPark._(fileName: "纯天然_pure-natural.svg");
  static IconPark rotationVertical = IconPark._(fileName: "纵向旋转_rotation-vertical.svg");
  static IconPark clothesDiapers = IconPark._(fileName: "纸尿裤_clothes-diapers.svg");
  static IconPark paperShip = IconPark._(fileName: "纸船_paper-ship.svg");
  static IconPark textureTwo = IconPark._(fileName: "纹理_texture-two.svg");
  static IconPark texture = IconPark._(fileName: "纹理_texture.svg");
  static IconPark processLine = IconPark._(fileName: "纹路_process-line.svg");
  static IconPark onlineMeeting = IconPark._(fileName: "线上办公室_online-meeting.svg");
  static IconPark clue = IconPark._(fileName: "线索_clue.svg");
  static IconPark reel = IconPark._(fileName: "线轮_reel.svg");
  static IconPark components = IconPark._(fileName: "组件_components.svg");
  static IconPark figmaComponent = IconPark._(fileName: "组件_figma-component.svg");
  static IconPark cell = IconPark._(fileName: "细胞_cell.svg");
  static IconPark terminationFile = IconPark._(fileName: "终止文件_termination-file.svg");
  static IconPark terminal = IconPark._(fileName: "终端_terminal.svg");
  static IconPark period = IconPark._(fileName: "经期_period.svg");
  static IconPark paintedScreen = IconPark._(fileName: "绘制屏_painted-screen.svg");
  static IconPark goOn = IconPark._(fileName: "继续_go-on.svg");
  static IconPark viencharts = IconPark._(fileName: "维恩图_viencharts.svg");
  static IconPark greenNewEnergy = IconPark._(fileName: "绿色新能源_green-new-energy.svg");
  static IconPark cableCar = IconPark._(fileName: "缆车_cable-car.svg");
  static IconPark editOne = IconPark._(fileName: "编辑1_edit-one.svg");
  static IconPark editTwo = IconPark._(fileName: "编辑2_edit-two.svg");
  static IconPark edit = IconPark._(fileName: "编辑_edit.svg");
  static IconPark editor = IconPark._(fileName: "编辑_editor.svg");
  static IconPark repair = IconPark._(fileName: "编辑_repair.svg");
  static IconPark editName = IconPark._(fileName: "编辑姓名_edit-name.svg");
  static IconPark writingFluently = IconPark._(fileName: "编辑撰写_writing-fluently.svg");
  static IconPark fileEditingOne = IconPark._(fileName: "编辑文件1_file-editing-one.svg");
  static IconPark fileEditing = IconPark._(fileName: "编辑文件_file-editing.svg");
  static IconPark zoomOut = IconPark._(fileName: "缩小_zoom-out.svg");
  static IconPark zoomInternal = IconPark._(fileName: "缩放_zoom-internal.svg");
  static IconPark ethernetOff = IconPark._(fileName: "网口关_ethernet-off.svg");
  static IconPark ethernetOn = IconPark._(fileName: "网口开_ethernet-on.svg");
  static IconPark gridTwo = IconPark._(fileName: "网格2_grid-two.svg");
  static IconPark gridThree = IconPark._(fileName: "网格3_grid-three.svg");
  static IconPark tennis = IconPark._(fileName: "网球_tennis.svg");
  static IconPark webcam = IconPark._(fileName: "网络摄像头_webcam.svg");
  static IconPark networkTree = IconPark._(fileName: "网络节点_network-tree.svg");
  static IconPark dollar = IconPark._(fileName: "美元_dollar.svg");
  static IconPark optimize = IconPark._(fileName: "美化_optimize.svg");
  static IconPark makeups = IconPark._(fileName: "美容_makeups.svg");
  static IconPark beautyInstrument = IconPark._(fileName: "美容仪_beauty-instrument.svg");
  static IconPark beauty = IconPark._(fileName: "美颜_beauty.svg");
  static IconPark badminton = IconPark._(fileName: "羽毛球_badminton.svg");
  static IconPark translate = IconPark._(fileName: "翻译_translate.svg");
  static IconPark translation = IconPark._(fileName: "翻译_translation.svg");
  static IconPark upsideDownFace = IconPark._(fileName: "翻转笑脸_upside-down-face.svg");
  static IconPark flipCamera = IconPark._(fileName: "翻转镜头_flip-camera.svg");
  static IconPark wingsuitFlying = IconPark._(fileName: "翼装飞行_wingsuit-flying.svg");
  static IconPark headsetOne = IconPark._(fileName: "耳机_headset-one.svg");
  static IconPark headsetTwo = IconPark._(fileName: "耳机_headset-two.svg");
  static IconPark headset = IconPark._(fileName: "耳机_headset.svg");
  static IconPark headphoneSound = IconPark._(fileName: "耳机声音_headphone-sound.svg");
  static IconPark muscle = IconPark._(fileName: "肌肉_muscle.svg");
  static IconPark gastrointestinal = IconPark._(fileName: "肠胃_gastrointestinal.svg");
  static IconPark stockMarket = IconPark._(fileName: "股市_stock-market.svg");
  static IconPark parentingBook = IconPark._(fileName: "育儿书_parenting-book.svg");
  static IconPark lung = IconPark._(fileName: "肺_lung.svg");
  static IconPark renal = IconPark._(fileName: "肾_renal.svg");
  static IconPark backpack = IconPark._(fileName: "背包_backpack.svg");
  static IconPark babySling = IconPark._(fileName: "背带_baby-sling.svg");
  static IconPark vest = IconPark._(fileName: "背心_vest.svg");
  static IconPark backgroundColor = IconPark._(fileName: "背景颜色_background-color.svg");
  static IconPark yep = IconPark._(fileName: "胜利_yep.svg");
  static IconPark englishMustache = IconPark._(fileName: "胡子_english-mustache.svg");
  static IconPark carrot = IconPark._(fileName: "胡萝卜_carrot.svg");
  static IconPark glove = IconPark._(fileName: "胶手套_glove.svg");
  static IconPark chest = IconPark._(fileName: "胸部_chest.svg");
  static IconPark energySocket = IconPark._(fileName: "能源插座_energy-socket.svg");
  static IconPark mindMapping = IconPark._(fileName: "脑图_mind-mapping.svg");
  static IconPark babyFeet = IconPark._(fileName: "脚掌_baby-feet.svg");
  static IconPark facebookOne = IconPark._(fileName: "脸书_facebook-one.svg");
  static IconPark facebook = IconPark._(fileName: "脸书_facebook.svg");
  static IconPark facePowder = IconPark._(fileName: "脸粉_face-powder.svg");
  static IconPark belt = IconPark._(fileName: "腰带_belt.svg");
  static IconPark abdominal = IconPark._(fileName: "腹部_abdominal.svg");
  static IconPark autoLineWidth = IconPark._(fileName: "自动列宽_auto-line-width.svg");
  static IconPark autoWidthOne = IconPark._(fileName: "自动宽度1_auto-width-one.svg");
  static IconPark autoWidth = IconPark._(fileName: "自动宽度_auto-width.svg");
  static IconPark autoLineHeight = IconPark._(fileName: "自动行高_auto-line-height.svg");
  static IconPark autoHeightOne = IconPark._(fileName: "自动高度1_auto-height-one.svg");
  static IconPark autoFocus = IconPark._(fileName: "自定对焦_auto-focus.svg");
  static IconPark selfie = IconPark._(fileName: "自拍杆_selfie.svg");
  static IconPark naturalMode = IconPark._(fileName: "自然模式_natural-mode.svg");
  static IconPark bike = IconPark._(fileName: "自行车_bike.svg");
  static IconPark optional = IconPark._(fileName: "自选_optional.svg");
  static IconPark cruise = IconPark._(fileName: "航海_cruise.svg");
  static IconPark aviation = IconPark._(fileName: "航空_aviation.svg");
  static IconPark sailing = IconPark._(fileName: "航行_sailing.svg");
  static IconPark ship = IconPark._(fileName: "船_ship.svg");
  static IconPark colorCard = IconPark._(fileName: "色卡_color-card.svg");
  static IconPark lamp = IconPark._(fileName: "节能灯_lamp.svg");
  static IconPark chip = IconPark._(fileName: "芯片_chip.svg");
  static IconPark cpu = IconPark._(fileName: "芯片_cpu.svg");
  static IconPark english = IconPark._(fileName: "英文_english.svg");
  static IconPark appleOne = IconPark._(fileName: "苹果_apple-one.svg");
  static IconPark apple = IconPark._(fileName: "苹果_apple.svg");
  static IconPark iphone = IconPark._(fileName: "苹果手机_iphone.svg");
  static IconPark iwatchTwo = IconPark._(fileName: "苹果智能手表_iwatch-two.svg");
  static IconPark imacIMac = IconPark._(fileName: "苹果电脑iMac_i-mac.svg");
  static IconPark eggplant = IconPark._(fileName: "茄子_eggplant.svg");
  static IconPark tea = IconPark._(fileName: "茶_tea.svg");
  static IconPark teapot = IconPark._(fileName: "茶壶_teapot.svg");
  static IconPark cupFour = IconPark._(fileName: "茶杯4_cup-four.svg");
  static IconPark strawHat = IconPark._(fileName: "草帽_straw-hat.svg");
  static IconPark pills = IconPark._(fileName: "药丸_pills.svg");
  static IconPark medicineBottle = IconPark._(fileName: "药罐_medicine-bottle.svg");
  static IconPark kitchenKnife = IconPark._(fileName: "菜刀_kitchen-knife.svg");
  static IconPark vegetableBasket = IconPark._(fileName: "菜篮子_vegetable-basket.svg");
  static IconPark pineapple = IconPark._(fileName: "菠萝_pineapple.svg");
  static IconPark diamondOne = IconPark._(fileName: "菱形1_diamond-one.svg");
  static IconPark diamondTwo = IconPark._(fileName: "菱形2_diamond-two.svg");
  static IconPark diamondThree = IconPark._(fileName: "菱形3_diamond-three.svg");
  static IconPark radish = IconPark._(fileName: "萝卜_radish.svg");
  static IconPark nutrition = IconPark._(fileName: "营养_nutrition.svg");
  static IconPark bluetooth = IconPark._(fileName: "蓝牙_bluetooth.svg");
  static IconPark virtualRealityGlasses = IconPark._(fileName: "虚拟现实眼镜_virtual-reality-glasses.svg");
  static IconPark viciaFaba = IconPark._(fileName: "蚕豆_vicia-faba.svg");
  static IconPark cakeFive = IconPark._(fileName: "蛋糕_cake-five.svg");
  static IconPark cakeFour = IconPark._(fileName: "蛋糕_cake-four.svg");
  static IconPark cakeOne = IconPark._(fileName: "蛋糕_cake-one.svg");
  static IconPark cakeThree = IconPark._(fileName: "蛋糕_cake-three.svg");
  static IconPark cakeTwo = IconPark._(fileName: "蛋糕_cake-two.svg");
  static IconPark cake = IconPark._(fileName: "蛋糕_cake.svg");
  static IconPark honeyOne = IconPark._(fileName: "蜂蜜_honey-one.svg");
  static IconPark honey = IconPark._(fileName: "蜂蜜_honey.svg");
  static IconPark spaCandle = IconPark._(fileName: "蜡烛沐浴_spa-candle.svg");
  static IconPark crab = IconPark._(fileName: "螃蟹_crab.svg");
  static IconPark financingTwo = IconPark._(fileName: "融资2_financing-two.svg");
  static IconPark block = IconPark._(fileName: "行内公式_block.svg");
  static IconPark baggageDelay = IconPark._(fileName: "行李延误_baggage-delay.svg");
  static IconPark luggage = IconPark._(fileName: "行李箱_luggage.svg");
  static IconPark trunk = IconPark._(fileName: "行李箱_trunk.svg");
  static IconPark rowHeight = IconPark._(fileName: "行高度_row-height.svg");
  static IconPark coatHanger = IconPark._(fileName: "衣架_coat-hanger.svg");
  static IconPark hangerOne = IconPark._(fileName: "衣架_hanger-one.svg");
  static IconPark hangerTwo = IconPark._(fileName: "衣架_hanger-two.svg");
  static IconPark messageEmoji = IconPark._(fileName: "表情信息_message-emoji.svg");
  static IconPark excelOne = IconPark._(fileName: "表格_excel-one.svg");
  static IconPark form = IconPark._(fileName: "表格_form.svg");
  static IconPark tableFile = IconPark._(fileName: "表格_table-file.svg");
  static IconPark table = IconPark._(fileName: "表格_table.svg");
  static IconPark socks = IconPark._(fileName: "袜子_socks.svg");
  static IconPark cuttingOne = IconPark._(fileName: "裁切_cutting-one.svg");
  static IconPark cutting = IconPark._(fileName: "裁切_cutting.svg");
  static IconPark tailoring = IconPark._(fileName: "裁剪_tailoring.svg");
  static IconPark tailoringTwo = IconPark._(fileName: "裁剪放大_tailoring-two.svg");
  static IconPark babyPants = IconPark._(fileName: "裤子_baby-pants.svg");
  static IconPark clothesPants = IconPark._(fileName: "裤子_clothes-pants.svg");
  static IconPark chess = IconPark._(fileName: "西洋棋_chess.svg");
  static IconPark watermelonOne = IconPark._(fileName: "西瓜_watermelon-one.svg");
  static IconPark watermelon = IconPark._(fileName: "西瓜_watermelon.svg");
  static IconPark xigua = IconPark._(fileName: "西瓜视频_xigua.svg");
  static IconPark clothesSuit = IconPark._(fileName: "西装_clothes-suit.svg");
  static IconPark landSurveying = IconPark._(fileName: "观测仪_land-surveying.svg");
  static IconPark videoOne = IconPark._(fileName: "视频_video-one.svg");
  static IconPark videoTwo = IconPark._(fileName: "视频_video-two.svg");
  static IconPark video = IconPark._(fileName: "视频_video.svg");
  static IconPark videoFile = IconPark._(fileName: "视频文件_video-file.svg");
  static IconPark facetime = IconPark._(fileName: "视频电话_facetime.svg");
  static IconPark phoneVideoCall = IconPark._(fileName: "视频电话_phone-video-call.svg");
  static IconPark rotationOne = IconPark._(fileName: "角度_rotation-one.svg");
  static IconPark ungroup = IconPark._(fileName: "解组_ungroup.svg");
  static IconPark unlock = IconPark._(fileName: "解锁_unlock.svg");
  static IconPark figmaResetInstance = IconPark._(fileName: "解除组件_figma-reset-instance.svg");
  static IconPark electronicPen = IconPark._(fileName: "触电笔_electronic-pen.svg");
  static IconPark alarm = IconPark._(fileName: "警报_alarm.svg");
  static IconPark fileTipsOne = IconPark._(fileName: "警示文件1_file-tips-one.svg");
  static IconPark fileTips = IconPark._(fileName: "警示文件_file-tips.svg");
  static IconPark plan = IconPark._(fileName: "计划_plan.svg");
  static IconPark stopwatchStart = IconPark._(fileName: "计时器_stopwatch-start.svg");
  static IconPark timer = IconPark._(fileName: "计时器_timer.svg");
  static IconPark arithmeticOne = IconPark._(fileName: "计算_arithmetic-one.svg");
  static IconPark arithmetic = IconPark._(fileName: "计算_arithmetic.svg");
  static IconPark calculatorOne = IconPark._(fileName: "计算器_calculator-one.svg");
  static IconPark calculator = IconPark._(fileName: "计算器_calculator.svg");
  static IconPark computerOne = IconPark._(fileName: "计算机_computer-one.svg");
  static IconPark measuringCup = IconPark._(fileName: "计量杯_measuring-cup.svg");
  static IconPark stapler = IconPark._(fileName: "订书机_stapler.svg");
  static IconPark order = IconPark._(fileName: "订单_order.svg");
  static IconPark rss = IconPark._(fileName: "订阅_rss.svg");
  static IconPark okay = IconPark._(fileName: "认可_okay.svg");
  static IconPark notepad = IconPark._(fileName: "记事本_notepad.svg");
  static IconPark memoryCard = IconPark._(fileName: "记忆卡_memory-card.svg");
  static IconPark devices = IconPark._(fileName: "设备_devices.svg");
  static IconPark settingOne = IconPark._(fileName: "设置_setting-one.svg");
  static IconPark settingThree = IconPark._(fileName: "设置_setting-three.svg");
  static IconPark settingTwo = IconPark._(fileName: "设置_setting-two.svg");
  static IconPark setting = IconPark._(fileName: "设置_setting.svg");
  static IconPark settingConfig = IconPark._(fileName: "设置配置_setting-config.svg");
  static IconPark macFinder = IconPark._(fileName: "访达_mac-finder.svg");
  static IconPark certificate = IconPark._(fileName: "证书_certificate.svg");
  static IconPark commentOne = IconPark._(fileName: "评论_comment-one.svg");
  static IconPark comment = IconPark._(fileName: "评论_comment.svg");
  static IconPark comments = IconPark._(fileName: "评论_comments.svg");
  static IconPark cuvette = IconPark._(fileName: "试管_cuvette.svg");
  static IconPark testTube = IconPark._(fileName: "试管_test-tube.svg");
  static IconPark vial = IconPark._(fileName: "试管_vial.svg");
  static IconPark topic = IconPark._(fileName: "话题_topic.svg");
  static IconPark topicDiscussion = IconPark._(fileName: "话题讨论_topic-discussion.svg");
  static IconPark viewList = IconPark._(fileName: "详情列表_view-list.svg");
  static IconPark viewGridDetail = IconPark._(fileName: "详情查看模式_view-grid-detail.svg");
  static IconPark voiceMessage = IconPark._(fileName: "语音信息_voice-message.svg");
  static IconPark voicemail = IconPark._(fileName: "语音信息_voicemail.svg");
  static IconPark voiceInput = IconPark._(fileName: "语音文字_voice-input.svg");
  static IconPark hotelDoNotClean = IconPark._(fileName: "请勿打扫_hotel-do-not-clean.svg");
  static IconPark hotelPleaseClean = IconPark._(fileName: "请打扫_hotel-please-clean.svg");
  static IconPark classroom = IconPark._(fileName: "课堂_classroom.svg");
  static IconPark platte = IconPark._(fileName: "调色盘_platte.svg");
  static IconPark google = IconPark._(fileName: "谷歌_google.svg");
  static IconPark googleAds = IconPark._(fileName: "谷歌广告_google-ads.svg");
  static IconPark peas = IconPark._(fileName: "豌豆角_peas.svg");
  static IconPark bezierCurve = IconPark._(fileName: "贝塞尔曲线_bezier-curve.svg");
  static IconPark exchange = IconPark._(fileName: "货币兑换_exchange.svg");
  static IconPark currency = IconPark._(fileName: "货币流通_currency.svg");
  static IconPark truck = IconPark._(fileName: "货车_truck.svg");
  static IconPark buy = IconPark._(fileName: "购买_buy.svg");
  static IconPark mallBag = IconPark._(fileName: "购物袋_mall-bag.svg");
  static IconPark shoppingBag = IconPark._(fileName: "购物袋_shopping-bag.svg");
  static IconPark shoppingCartOne = IconPark._(fileName: "购物车1_shopping-cart-one.svg");
  static IconPark shoppingCart = IconPark._(fileName: "购物车_shopping-cart.svg");
  static IconPark shopping = IconPark._(fileName: "购物车_shopping.svg");
  static IconPark stickers = IconPark._(fileName: "贴纸_stickers.svg");
  static IconPark zijinyunying = IconPark._(fileName: "资金运营平台_zijinyunying.svg");
  static IconPark goodTwo = IconPark._(fileName: "赞_good-two.svg");
  static IconPark thumbsUp = IconPark._(fileName: "赞_thumbs-up.svg");
  static IconPark trendTwo = IconPark._(fileName: "趋势_trend-two.svg");
  static IconPark trend = IconPark._(fileName: "趋势_trend.svg");
  static IconPark trendingUp = IconPark._(fileName: "趋势上升_trending-up.svg");
  static IconPark trendingDown = IconPark._(fileName: "趋势下降_trending-down.svg");
  static IconPark soccerOne = IconPark._(fileName: "足球1_soccer-one.svg");
  static IconPark football = IconPark._(fileName: "足球_football.svg");
  static IconPark soccer = IconPark._(fileName: "足球_soccer.svg");
  static IconPark treadmillOne = IconPark._(fileName: "跑步机1_treadmill-one.svg");
  static IconPark treadmill = IconPark._(fileName: "跑步机_treadmill.svg");
  static IconPark routerOne = IconPark._(fileName: "路由器_router-one.svg");
  static IconPark router = IconPark._(fileName: "路由器_router.svg");
  static IconPark roadCone = IconPark._(fileName: "路锥_road-cone.svg");
  static IconPark ropeSkippingOne = IconPark._(fileName: "跳绳_rope-skipping-one.svg");
  static IconPark ropeSkipping = IconPark._(fileName: "跳绳_rope-skipping.svg");
  static IconPark badTwo = IconPark._(fileName: "踩_bad-two.svg");
  static IconPark thumbsDown = IconPark._(fileName: "踩_thumbs-down.svg");
  static IconPark idCardH = IconPark._(fileName: "身份证_id-card-h.svg");
  static IconPark idCardV = IconPark._(fileName: "身份证_id-card-v.svg");
  static IconPark garage = IconPark._(fileName: "车库_garage.svg");
  static IconPark babyCarSeat = IconPark._(fileName: "车载座_baby-car-seat.svg");
  static IconPark income = IconPark._(fileName: "转入_income.svg");
  static IconPark expenses = IconPark._(fileName: "转出_expenses.svg");
  static IconPark transform = IconPark._(fileName: "转变_transform.svg");
  static IconPark fileConversionOne = IconPark._(fileName: "转换文件1_file-conversion-one.svg");
  static IconPark fileConversion = IconPark._(fileName: "转换文件_file-conversion.svg");
  static IconPark folderConversionOne = IconPark._(fileName: "转换文件夹1_folder-conversion-one.svg");
  static IconPark folderConversion = IconPark._(fileName: "转换文件夹_folder-conversion.svg");
  static IconPark transfer = IconPark._(fileName: "转机_transfer.svg");
  static IconPark carousel = IconPark._(fileName: "轮播_carousel.svg");
  static IconPark carouselVideo = IconPark._(fileName: "轮播视频_carousel-video.svg");
  static IconPark wheelchair = IconPark._(fileName: "轮椅_wheelchair.svg");
  static IconPark lightMember = IconPark._(fileName: "轻会员_light-member.svg");
  static IconPark slightlyFrowningFaceWhitOpenMouth = IconPark._(fileName: "轻微沮丧_slightly-frowning-face-whit-open-mouth.svg");
  static IconPark ulikecam = IconPark._(fileName: "轻颜相机_ulikecam.svg");
  static IconPark boosterCarSeat = IconPark._(fileName: "辅助座椅_booster-car-seat.svg");
  static IconPark radiation = IconPark._(fileName: "辐射_radiation.svg");
  static IconPark incoming = IconPark._(fileName: "输入_incoming.svg");
  static IconPark enterTheKeyboard = IconPark._(fileName: "输入键盘_enter-the-keyboard.svg");
  static IconPark chili = IconPark._(fileName: "辣椒_chili.svg");
  static IconPark sport = IconPark._(fileName: "运动_sport.svg");
  static IconPark gopro = IconPark._(fileName: "运动相机_gopro.svg");
  static IconPark clothesPantsSweat = IconPark._(fileName: "运动裤_clothes-pants-sweat.svg");
  static IconPark transport = IconPark._(fileName: "运送车_transport.svg");
  static IconPark returns = IconPark._(fileName: "返回_return.svg");
  static IconPark login = IconPark._(fileName: "进入_login.svg");
  static IconPark importAndExport = IconPark._(fileName: "进出口_import-and-export.svg");
  static IconPark pieOne = IconPark._(fileName: "进度1_pie-one.svg");
  static IconPark pieTwo = IconPark._(fileName: "进度2_pie-two.svg");
  static IconPark pieThree = IconPark._(fileName: "进度3_pie-three.svg");
  static IconPark pieFour = IconPark._(fileName: "进度4_pie-four.svg");
  static IconPark pieFive = IconPark._(fileName: "进度5_pie-five.svg");
  static IconPark pieSix = IconPark._(fileName: "进度6_pie-six.svg");
  static IconPark pieSeven = IconPark._(fileName: "进度7_pie-seven.svg");
  static IconPark pie = IconPark._(fileName: "进度_pie.svg");
  static IconPark onesies = IconPark._(fileName: "连体衣_onesies.svg");
  static IconPark romper = IconPark._(fileName: "连体衣_romper.svg");
  static IconPark connection = IconPark._(fileName: "连接_connection.svg");
  static IconPark connectAddressOne = IconPark._(fileName: "连接地址1_connect-address-one.svg");
  static IconPark connectAddressTwo = IconPark._(fileName: "连接地址2_connect-address-two.svg");
  static IconPark connectionPoint = IconPark._(fileName: "连接点_connection-point.svg");
  static IconPark connectionArrow = IconPark._(fileName: "连接箭头_connection-arrow.svg");
  static IconPark dubai = IconPark._(fileName: "迪拜大厦_dubai.svg");
  static IconPark dribble = IconPark._(fileName: "追波_dribble.svg");
  static IconPark trace = IconPark._(fileName: "追踪_trace.svg");
  static IconPark logout = IconPark._(fileName: "退出_logout.svg");
  static IconPark folderWithdrawalOne = IconPark._(fileName: "退出文件夹1_folder-withdrawal-one.svg");
  static IconPark folderWithdrawal = IconPark._(fileName: "退出文件夹_folder-withdrawal.svg");
  static IconPark transporter = IconPark._(fileName: "送货车_transporter.svg");
  static IconPark reverseRotation = IconPark._(fileName: "逆向旋转_reverse-rotation.svg");
  static IconPark reverseOperationOut = IconPark._(fileName: "逆向运行_reverse-operation-out.svg");
  static IconPark selected = IconPark._(fileName: "选中_selected.svg");
  static IconPark selectedFocus = IconPark._(fileName: "选中焦点_selected-focus.svg");
  static IconPark perspective = IconPark._(fileName: "透视_perspective.svg");
  static IconPark commuterBag = IconPark._(fileName: "通勤包_commuter-bag.svg");
  static IconPark addressBook = IconPark._(fileName: "通讯录_address-book.svg");
  static IconPark speedOne = IconPark._(fileName: "速度_speed-one.svg");
  static IconPark speed = IconPark._(fileName: "速度_speed.svg");
  static IconPark road = IconPark._(fileName: "道路_road.svg");
  static IconPark remoteControlOne = IconPark._(fileName: "遥控器_remote-control-one.svg");
  static IconPark remoteControl = IconPark._(fileName: "遥控器_remote-control.svg");
  static IconPark figmaMask = IconPark._(fileName: "遮罩_figma-mask.svg");
  static IconPark maskTwo = IconPark._(fileName: "遮罩_mask-two.svg");
  static IconPark sunshade = IconPark._(fileName: "遮阳篷_sunshade.svg");
  static IconPark maillOne = IconPark._(fileName: "邮件1_maill-one.svg");
  static IconPark mail = IconPark._(fileName: "邮件_mail.svg");
  static IconPark emailDown = IconPark._(fileName: "邮件下载_email-down.svg");
  static IconPark mailDownload = IconPark._(fileName: "邮件下载_mail-download.svg");
  static IconPark emailDelect = IconPark._(fileName: "邮件删除_email-delect.svg");
  static IconPark mailPackage = IconPark._(fileName: "邮件包_mail-package.svg");
  static IconPark emailFail = IconPark._(fileName: "邮件发送失败_email-fail.svg");
  static IconPark emailSuccessfully = IconPark._(fileName: "邮件发送成功_email-successfully.svg");
  static IconPark emailSecurity = IconPark._(fileName: "邮件安全_email-security.svg");
  static IconPark emailBlock = IconPark._(fileName: "邮件屏蔽_email-block.svg");
  static IconPark mailUnpacking = IconPark._(fileName: "邮件打开_mail-unpacking.svg");
  static IconPark emailPush = IconPark._(fileName: "邮件推送_email-push.svg");
  static IconPark emailSearch = IconPark._(fileName: "邮件搜索_email-search.svg");
  static IconPark mailReview = IconPark._(fileName: "邮件查阅_mail-review.svg");
  static IconPark atSign = IconPark._(fileName: "邮件符号_at-sign.svg");
  static IconPark mailEdit = IconPark._(fileName: "邮件编辑_mail-edit.svg");
  static IconPark emailLock = IconPark._(fileName: "邮件锁定_email-lock.svg");
  static IconPark stamp = IconPark._(fileName: "邮票_stamp.svg");
  static IconPark config = IconPark._(fileName: "配置_config.svg");
  static IconPark hotel = IconPark._(fileName: "酒店_hotel.svg");
  static IconPark bottleOne = IconPark._(fileName: "酒瓶_bottle-one.svg");
  static IconPark cool = IconPark._(fileName: "酷的_cool.svg");
  static IconPark redo = IconPark._(fileName: "重新_redo.svg");
  static IconPark repositioning = IconPark._(fileName: "重新定位_repositioning.svg");
  static IconPark replayMusic = IconPark._(fileName: "重新播放_replay-music.svg");
  static IconPark fileFocusOne = IconPark._(fileName: "重点文件1_file-focus-one.svg");
  static IconPark fileFocus = IconPark._(fileName: "重点文件_file-focus.svg");
  static IconPark reload = IconPark._(fileName: "重装_reload.svg");
  static IconPark heavyMetal = IconPark._(fileName: "重金属_heavy-metal.svg");
  static IconPark camp = IconPark._(fileName: "野营_camp.svg");
  static IconPark pyramidOne = IconPark._(fileName: "金字塔_pyramid-one.svg");
  static IconPark pyramid = IconPark._(fileName: "金字塔_pyramid.svg");
  static IconPark goldMedalTwo = IconPark._(fileName: "金牌_gold-medal-two.svg");
  static IconPark goldMedal = IconPark._(fileName: "金牌_gold-medal.svg");
  static IconPark finance = IconPark._(fileName: "金融_finance.svg");
  static IconPark spikedshoes = IconPark._(fileName: "钉鞋_spikedshoes.svg");
  static IconPark paperMoneyTwo = IconPark._(fileName: "钞票_paper-money-two.svg");
  static IconPark paperMoney = IconPark._(fileName: "钞票_paper-money.svg");
  static IconPark clockTower = IconPark._(fileName: "钟楼_clock-tower.svg");
  static IconPark piano = IconPark._(fileName: "钢琴_piano.svg");
  static IconPark key = IconPark._(fileName: "钥匙_key.svg");
  static IconPark keyhole = IconPark._(fileName: "钥匙孔_keyhole.svg");
  static IconPark walletOne = IconPark._(fileName: "钱包_wallet-one.svg");
  static IconPark walletTwo = IconPark._(fileName: "钱包_wallet-two.svg");
  static IconPark wallet = IconPark._(fileName: "钱包_wallet.svg");
  static IconPark diamondRing = IconPark._(fileName: "钻戒_diamond-ring.svg");
  static IconPark diamond = IconPark._(fileName: "钻石_diamond.svg");
  static IconPark diamonds = IconPark._(fileName: "钻石_diamonds.svg");
  static IconPark diamondNecklace = IconPark._(fileName: "钻石项链_diamond-necklace.svg");
  static IconPark spoon = IconPark._(fileName: "铁勺_spoon.svg");
  static IconPark railway = IconPark._(fileName: "铁路_railway.svg");
  static IconPark shovel = IconPark._(fileName: "铁铲_shovel.svg");
  static IconPark pot = IconPark._(fileName: "铁锅_pot.svg");
  static IconPark hammerAndAnvil = IconPark._(fileName: "铁锤_hammer-and-anvil.svg");
  static IconPark shovelOne = IconPark._(fileName: "铲子_shovel-one.svg");
  static IconPark bank = IconPark._(fileName: "银行_bank.svg");
  static IconPark bankCardOne = IconPark._(fileName: "银行卡_bank-card-one.svg");
  static IconPark bankCardTwo = IconPark._(fileName: "银行卡_bank-card-two.svg");
  static IconPark bankCard = IconPark._(fileName: "银行卡_bank-card.svg");
  static IconPark bankTransfer = IconPark._(fileName: "银行转账_bank-transfer.svg");
  static IconPark linkFour = IconPark._(fileName: "链接4_link-four.svg");
  static IconPark connect = IconPark._(fileName: "链接_connect.svg");
  static IconPark deeplink = IconPark._(fileName: "链接_deeplink.svg");
  static IconPark linkOne = IconPark._(fileName: "链接_link-one.svg");
  static IconPark linkThree = IconPark._(fileName: "链接_link-three.svg");
  static IconPark linkTwo = IconPark._(fileName: "链接_link-two.svg");
  static IconPark link = IconPark._(fileName: "链接_link.svg");
  static IconPark linkInterrupt = IconPark._(fileName: "链接中断_link-interrupt.svg");
  static IconPark unlink = IconPark._(fileName: "链接断开_unlink.svg");
  static IconPark salesReport = IconPark._(fileName: "销售_sales-report.svg");
  static IconPark lock = IconPark._(fileName: "锁定_lock.svg");
  static IconPark bigX = IconPark._(fileName: "错误_big-x.svg");
  static IconPark error = IconPark._(fileName: "错误_error.svg");
  static IconPark errorPrompt = IconPark._(fileName: "错误提示_error-prompt.svg");
  static IconPark wrongUser = IconPark._(fileName: "错误用户_wrong-user.svg");
  static IconPark anchorSqure = IconPark._(fileName: "锚方_anchor-squre.svg");
  static IconPark anchorOne = IconPark._(fileName: "锚点_anchor-one.svg");
  static IconPark anchor = IconPark._(fileName: "锚点_anchor.svg");
  static IconPark anchorRound = IconPark._(fileName: "锚轮_anchor-round.svg");
  static IconPark keyboardOne = IconPark._(fileName: "键盘_keyboard-one.svg");
  static IconPark keyboard = IconPark._(fileName: "键盘_keyboard.svg");
  static IconPark reverseLens = IconPark._(fileName: "镜头反转_reverse-lens.svg");
  static IconPark lensAlignment = IconPark._(fileName: "镜头对准_lens-alignment.svg");
  static IconPark mirrorTwo = IconPark._(fileName: "镜子2_mirror-two.svg");
  static IconPark mirrorOne = IconPark._(fileName: "镜子_mirror-one.svg");
  static IconPark mirror = IconPark._(fileName: "镜子_mirror.svg");
  static IconPark greatWall = IconPark._(fileName: "长城_great-wall.svg");
  static IconPark doorHandle = IconPark._(fileName: "门把手_door-handle.svg");
  static IconPark ticketsOne = IconPark._(fileName: "门票_tickets-one.svg");
  static IconPark ticketsTwo = IconPark._(fileName: "门票_tickets-two.svg");
  static IconPark flashPayment = IconPark._(fileName: "闪付_flash-payment.svg");
  static IconPark flashlamp = IconPark._(fileName: "闪光模式_flashlamp.svg");
  static IconPark lightning = IconPark._(fileName: "闪电_lightning.svg");
  static IconPark distraughtFace = IconPark._(fileName: "闭眼生气_distraught-face.svg");
  static IconPark grinningFaceWithTightlyClosedEyes = IconPark._(fileName: "闭眼笑_grinning-face-with-tightly-closed-eyes.svg");
  static IconPark alarmClock = IconPark._(fileName: "闹钟_alarm-clock.svg");
  static IconPark antiCorrosion = IconPark._(fileName: "防腐_anti-corrosion.svg");
  static IconPark spinningTop = IconPark._(fileName: "陀螺_spinning-top.svg");
  static IconPark slave = IconPark._(fileName: "附件_slave.svg");
  static IconPark sortAmountDown = IconPark._(fileName: "降序排序_sort-amount-down.svg");
  static IconPark parachute = IconPark._(fileName: "降落伞_parachute.svg");
  static IconPark division = IconPark._(fileName: "除号_division.svg");
  static IconPark fileHidingOne = IconPark._(fileName: "隐藏文件1_file-hiding-one.svg");
  static IconPark fileHiding = IconPark._(fileName: "隐藏文件_file-hiding.svg");
  static IconPark umbrellaOne = IconPark._(fileName: "雨伞_umbrella-one.svg");
  static IconPark umbrellaTwo = IconPark._(fileName: "雨伞_umbrella-two.svg");
  static IconPark umbrella = IconPark._(fileName: "雨伞_umbrella.svg");
  static IconPark icecreamOne = IconPark._(fileName: "雪糕_icecream-one.svg");
  static IconPark snowflake = IconPark._(fileName: "雪花_snowflake.svg");
  static IconPark renault = IconPark._(fileName: "雷诺_renault.svg");
  static IconPark radarTwo = IconPark._(fileName: "雷达_radar-two.svg");
  static IconPark radar = IconPark._(fileName: "雷达_radar.svg");
  static IconPark radarChart = IconPark._(fileName: "雷达图_radar-chart.svg");
  static IconPark thunderstormOne = IconPark._(fileName: "雷雨_thunderstorm-one.svg");
  static IconPark thunderstorm = IconPark._(fileName: "雷雨_thunderstorm.svg");
  static IconPark shake = IconPark._(fileName: "震动_shake.svg");
  static IconPark oscillator = IconPark._(fileName: "震荡器_oscillator.svg");
  static IconPark thunderbolt = IconPark._(fileName: "霹雳接口_thunderbolt.svg");
  static IconPark vegetables = IconPark._(fileName: "青菜_vegetables.svg");
  static IconPark qingniaoClue = IconPark._(fileName: "青鸟线索通_qingniao-clue.svg");
  static IconPark mute = IconPark._(fileName: "静音_mute.svg");
  static IconPark volumeMute = IconPark._(fileName: "静音_volume-mute.svg");
  static IconPark maskOne = IconPark._(fileName: "面具_mask-one.svg");
  static IconPark breadOne = IconPark._(fileName: "面包_bread-one.svg");
  static IconPark bread = IconPark._(fileName: "面包_bread.svg");
  static IconPark breadMachine = IconPark._(fileName: "面包机_bread-machine.svg");
  static IconPark bowl = IconPark._(fileName: "面条_bowl.svg");
  static IconPark noodles = IconPark._(fileName: "面条_noodles.svg");
  static IconPark boots = IconPark._(fileName: "靴子_boots.svg");
  static IconPark target = IconPark._(fileName: "靶子_target.svg");
  static IconPark targetOne = IconPark._(fileName: "靶标_target-one.svg");
  static IconPark musicOne = IconPark._(fileName: "音乐_music-one.svg");
  static IconPark music = IconPark._(fileName: "音乐_music.svg");
  static IconPark cdMusicCd = IconPark._(fileName: "音乐cd_music-cd.svg");
  static IconPark musicRhythm = IconPark._(fileName: "音乐律动_music-rhythm.svg");
  static IconPark fileMusicOne = IconPark._(fileName: "音乐文件1_file-music-one.svg");
  static IconPark fileMusic = IconPark._(fileName: "音乐文件_file-music.svg");
  static IconPark folderMusicOne = IconPark._(fileName: "音乐文件夹1_folder-music-one.svg");
  static IconPark folderMusic = IconPark._(fileName: "音乐文件夹_folder-music.svg");
  static IconPark musicList = IconPark._(fileName: "音乐菜单_music-list.svg");
  static IconPark musicMenu = IconPark._(fileName: "音乐菜单_music-menu.svg");
  static IconPark soundOne = IconPark._(fileName: "音响_sound-one.svg");
  static IconPark sound = IconPark._(fileName: "音响_sound.svg");
  static IconPark speaker = IconPark._(fileName: "音响_speaker.svg");
  static IconPark soundWave = IconPark._(fileName: "音波_sound-wave.svg");
  static IconPark monitorTwo = IconPark._(fileName: "音波控制_monitor-two.svg");
  static IconPark volumeDown = IconPark._(fileName: "音量减小_volume-down.svg");
  static IconPark volumeUp = IconPark._(fileName: "音量增大_volume-up.svg");
  static IconPark audioFile = IconPark._(fileName: "音频文件_audio-file.svg");
  static IconPark page = IconPark._(fileName: "页面_page.svg");
  static IconPark pageTemplate = IconPark._(fileName: "页面模版_page-template.svg");
  static IconPark alignTop = IconPark._(fileName: "顶对齐_align-top.svg");
  static IconPark topBar = IconPark._(fileName: "顶栏_top-bar.svg");
  static IconPark domeLight = IconPark._(fileName: "顶灯_dome-light.svg");
  static IconPark alignmentTopRight = IconPark._(fileName: "顶部右对齐_alignment-top-right.svg");
  static IconPark alignmentTopCenter = IconPark._(fileName: "顶部居中对齐_alignment-top-center.svg");
  static IconPark alignmentTopLeft = IconPark._(fileName: "顶部左对齐_alignment-top-left.svg");
  static IconPark sTurnUp = IconPark._(fileName: "顶部连接_s-turn-up.svg");
  static IconPark previewCloseOne = IconPark._(fileName: "预览-关闭_preview-close-one.svg");
  static IconPark previewClose = IconPark._(fileName: "预览-关闭_preview-close.svg");
  static IconPark previewOpen = IconPark._(fileName: "预览-打开_preview-open.svg");
  static IconPark necktie = IconPark._(fileName: "领带_necktie.svg");
  static IconPark bow = IconPark._(fileName: "领结_bow.svg");
  static IconPark colorFilter = IconPark._(fileName: "颜色滤镜_color-filter.svg");
  static IconPark windTurbine = IconPark._(fileName: "风力发电机_wind-turbine.svg");
  static IconPark landscape = IconPark._(fileName: "风景区_landscape.svg");
  static IconPark towerOfBabel = IconPark._(fileName: "风笛塔_tower-of-babel.svg");
  static IconPark clothesWindbreaker = IconPark._(fileName: "风衣_clothes-windbreaker.svg");
  static IconPark pinwheel = IconPark._(fileName: "风车_pinwheel.svg");
  static IconPark windmillOne = IconPark._(fileName: "风车_windmill-one.svg");
  static IconPark windmillTwo = IconPark._(fileName: "风车_windmill-two.svg");
  static IconPark windmill = IconPark._(fileName: "风车_windmill.svg");
  static IconPark larkOne = IconPark._(fileName: "飞书1_lark-one.svg");
  static IconPark lark = IconPark._(fileName: "飞书_lark.svg");
  static IconPark acceleration = IconPark._(fileName: "飞机加速_acceleration.svg");
  static IconPark airplaneWindowOne = IconPark._(fileName: "飞机窗口_airplane-window-one.svg");
  static IconPark airplaneWindow = IconPark._(fileName: "飞机窗口_airplane-window.svg");
  static IconPark takeOff = IconPark._(fileName: "飞机起飞_take-off.svg");
  static IconPark flightSafety = IconPark._(fileName: "飞行安全_flight-safety.svg");
  static IconPark inFlight = IconPark._(fileName: "飞行巡航_in-flight.svg");
  static IconPark flightAirflow = IconPark._(fileName: "飞行气流_flight-airflow.svg");
  static IconPark crmFeiyu = IconPark._(fileName: "飞鱼CRM_feiyu.svg");
  static IconPark indexFinger = IconPark._(fileName: "食指_index-finger.svg");
  static IconPark babyMeal = IconPark._(fileName: "餐具_baby-meal.svg");
  static IconPark drink = IconPark._(fileName: "饮料_drink.svg");
  static IconPark chartPie = IconPark._(fileName: "饼图_chart-pie.svg");
  static IconPark homeTwo = IconPark._(fileName: "首页_home-two.svg");
  static IconPark home = IconPark._(fileName: "首页_home.svg");
  static IconPark jewelry = IconPark._(fileName: "首饰_jewelry.svg");
  static IconPark perfume = IconPark._(fileName: "香水_perfume.svg");
  static IconPark perfumerBottle = IconPark._(fileName: "香水瓶_perfumer-bottle.svg");
  static IconPark banana = IconPark._(fileName: "香蕉_banana.svg");
  static IconPark mayuraGesture = IconPark._(fileName: "马尤拉手势_mayura-gesture.svg");
  static IconPark circus = IconPark._(fileName: "马戏团_circus.svg");
  static IconPark maslowPyramids = IconPark._(fileName: "马斯洛金字塔_maslow-pyramids.svg");
  static IconPark toilet = IconPark._(fileName: "马桶_toilet.svg");
  static IconPark mosaic = IconPark._(fileName: "马赛克_mosaic.svg");
  static IconPark reject = IconPark._(fileName: "驳回_reject.svg");
  static IconPark ridingOne = IconPark._(fileName: "骑术_riding-one.svg");
  static IconPark riding = IconPark._(fileName: "骑自行车_riding.svg");
  static IconPark bone = IconPark._(fileName: "骨头_bone.svg");
  static IconPark orthopedic = IconPark._(fileName: "骨科_orthopedic.svg");
  static IconPark skull = IconPark._(fileName: "骷髅_skull.svg");
  static IconPark highLight = IconPark._(fileName: "高亮_high-light.svg");
  static IconPark golfCourse = IconPark._(fileName: "高尔夫球场_golf-course.svg");
  static IconPark gobletOne = IconPark._(fileName: "高脚杯_goblet-one.svg");
  static IconPark goblet = IconPark._(fileName: "高脚杯_goblet.svg");
  static IconPark gobletFull = IconPark._(fileName: "高脚杯满了_goblet-full.svg");
  static IconPark gobletCracking = IconPark._(fileName: "高脚杯裂开_goblet-cracking.svg");
  static IconPark folderQualityOne = IconPark._(fileName: "高质量文件夹1_folder-quality-one.svg");
  static IconPark folderQuality = IconPark._(fileName: "高质量文件夹_folder-quality.svg");
  static IconPark highHeeledShoes = IconPark._(fileName: "高跟鞋_high-heeled-shoes.svg");
  static IconPark clothesTurtleneck = IconPark._(fileName: "高领毛衣_clothes-turtleneck.svg");
  static IconPark cubeFive = IconPark._(fileName: "魔方_cube-five.svg");
  static IconPark cubeFour = IconPark._(fileName: "魔方_cube-four.svg");
  static IconPark cubeThree = IconPark._(fileName: "魔方_cube-three.svg");
  static IconPark cubeTwo = IconPark._(fileName: "魔方_cube-two.svg");
  static IconPark cube = IconPark._(fileName: "魔方_cube.svg");
  static IconPark magicHat = IconPark._(fileName: "魔术帽_magic-hat.svg");
  static IconPark crossRingTwo = IconPark._(fileName: "魔比斯环_cross-ring-two.svg");
  static IconPark magicWand = IconPark._(fileName: "魔法棒_magic-wand.svg");
  static IconPark magic = IconPark._(fileName: "魔法棒_magic.svg");
  static IconPark fish = IconPark._(fileName: "鱼_fish.svg");
  static IconPark cocktail = IconPark._(fileName: "鸡尾酒_cocktail.svg");
  static IconPark liqueur = IconPark._(fileName: "鸡尾酒_liqueur.svg");
  static IconPark chicken = IconPark._(fileName: "鸡肉_chicken.svg");
  static IconPark chickenLeg = IconPark._(fileName: "鸡腿_chicken-leg.svg");
  static IconPark drumstick = IconPark._(fileName: "鸡腿_drumstick.svg");
  static IconPark eggOne = IconPark._(fileName: "鸡蛋_egg-one.svg");
  static IconPark chafingDish = IconPark._(fileName: "鸳鸯锅_chafing-dish.svg");
  static IconPark microphone = IconPark._(fileName: "麦克风_microphone.svg");
  static IconPark clap = IconPark._(fileName: "鼓掌_clap.svg");
  static IconPark mouseOne = IconPark._(fileName: "鼠标_mouse-one.svg");
  static IconPark mouse = IconPark._(fileName: "鼠标_mouse.svg");
  static IconPark nasal = IconPark._(fileName: "鼻腔_nasal.svg");

  /// icon的map集合，用于遍历或者查找
  static Map<String, IconPark> iconMap = {
    "16宫格_grid-sixteen.svg": gridSixteen,
    "3D眼镜_three-d-glasses.svg": dThreeDGlasses,
    "API 应用_api-app.svg": apiApiApp,
    "API 接口_api.svg": apiApi,
    "AirPlay_airplay.svg": airplayAirplay,
    "AirPods_airpods.svg": airpodsAirpods,
    "DVI_dvi.svg": dviDvi,
    "F0_f-zero-key.svg": f0FZeroKey,
    "F1_f-one-key.svg": f1FOneKey,
    "F2_f-two-key.svg": f2FTwoKey,
    "F3_f-three-key.svg": f3FThreeKey,
    "F4_f-four-key.svg": f4FFourKey,
    "F5_f-five-key.svg": f5FFiveKey,
    "F6_f-six-key.svg": f6FSixKey,
    "F7_f-seven-key.svg": f7FSevenKey,
    "F8_f-eight-key.svg": f8FEightKey,
    "F9_f-nine-key.svg": f9FNineKey,
    "Figma 选择箭头_figma-flatten-selection.svg": figmaFigmaFlattenSelection,
    "Fn_f-n-key.svg": fnFNKey,
    "HDD_hdd.svg": hddHdd,
    "HDMI接口_hdmi-connector.svg": hdmiHdmiConnector,
    "HDMI线_hdmi-cable.svg": hdmiHdmiCable,
    "Ipad_ipad.svg": ipadIpad,
    "K线图_chart-stock.svg": kChartStock,
    "QQ_tencent-qq.svg": qqTencentQq,
    "RS_rs-male.svg": rsRsMale,
    "SD卡_sd.svg": sdSd,
    "SSD_ssd.svg": ssdSsd,
    "Telegram_telegram.svg": telegramTelegram,
    "TypeC_usb-type-c.svg": typecUsbTypeC,
    "T恤_t-shirt.svg": tTShirt,
    "U盘1_disk-one.svg": u1DiskOne,
    "U盘2_disk-two.svg": u2DiskTwo,
    "U盘_u-disk.svg": uUDisk,
    "U盘_usb-memory-stick.svg": uUsbMemoryStick,
    "VIP_vip.svg": vipVip,
    "VR 眼镜_vr-glasses.svg": vrVrGlasses,
    "adobe-illustrate_adobe-illustrate.svg": adobeIllustrateAdobeIllustrate,
    "adobe-indesign_adobe-indesign.svg": adobeIndesignAdobeIndesign,
    "adobe-lightroom_adobe-lightroom.svg": adobeLightroomAdobeLightroom,
    "adobe-photoshop_adobe-photoshop.svg": adobePhotoshopAdobePhotoshop,
    "behance_behance.svg": behanceBehance,
    "feelgood1_feelgood-one.svg": feelgood1FeelgoodOne,
    "feelgood_feelgood.svg": feelgoodFeelgood,
    "figma_figma.svg": figmaFigma,
    "foursquare_foursquare.svg": foursquareFoursquare,
    "github _github.svg": githubGithub,
    "github-one_github-one.svg": githubOneGithubOne,
    "gitlab_gitlab.svg": gitlabGitlab,
    "h_h.svg": hH,
    "html5_html-five.svg": html5HtmlFive,
    "instagram_instagram-one.svg": instagramInstagramOne,
    "instagram_instagram.svg": instagramInstagram,
    "ipo_ipo.svg": ipoIpo,
    "kagi图_kagi-map.svg": kagiKagiMap,
    "paypal_paypal.svg": paypalPaypal,
    "pdf文件_file-pdf-one.svg": pdfFilePdfOne,
    "ppt文件_file-ppt.svg": pptFilePpt,
    "sketch_sketch.svg": sketchSketch,
    "topbuzz_topbuzz.svg": topbuzzTopbuzz,
    "tumblr_tumblr.svg": tumblrTumblr,
    "txt文件_file-txt-one.svg": txtFileTxtOne,
    "一_one-one.svg": oneOne,
    "一_one.svg": one,
    "一对一_one-to-one.svg": oneToOne,
    "一对多_one-to-many.svg": oneToMany,
    "七级标题_level-seven-title.svg": levelSevenTitle,
    "三_three-three.svg": threeThree,
    "三_three.svg": three,
    "三个三角_three-triangles.svg": threeTriangles,
    "三个菱形_three-hexagons.svg": threeHexagons,
    "三斜杠_three-slashes.svg": threeSlashes,
    "三明治_sandwich-one.svg": sandwichOne,
    "三明治_sandwich.svg": sandwich,
    "三棱锥_triangular-pyramid.svg": triangularPyramid,
    "三菱_mitsubishi.svg": mitsubishi,
    "三角圆矩形_triangle-round-rectangle.svg": triangleRoundRectangle,
    "三角尺_triangle-ruler.svg": triangleRuler,
    "三角形_refraction.svg": refraction,
    "三角形_triangle.svg": triangle,
    "三角旗_pennant.svg": pennant,
    "三角杯_flask.svg": flask,
    "三角段落_paragraph-triangle.svg": paragraphTriangle,
    "上-圆_up-c.svg": upC,
    "上-小_up-small.svg": upSmall,
    "上-箭头_arrow-circle-up.svg": arrowCircleUp,
    "上1_up-one.svg": upOne,
    "上1_up-two.svg": upTwo,
    "上_up.svg": up,
    "上一曲_go-start.svg": goStart,
    "上一步_back.svg": back,
    "上下楼_up-and-down.svg": upAndDown,
    "上传1_upload-one.svg": uploadOne,
    "上传2_upload-two.svg": uploadTwo,
    "上传3_upload-three.svg": uploadThree,
    "上传_upload.svg": upload,
    "上传日志_upload-logs.svg": uploadLogs,
    "上回转_u-turn-down.svg": uTurnDown,
    "上对齐2_align-top-two.svg": alignTopTwo,
    "上层_bring-forward.svg": bringForward,
    "上投影_drop-shadow-up.svg": dropShadowUp,
    "上箭头-方_up-square.svg": upSquare,
    "上课铃_bell-ring.svg": bellRing,
    "下-圆_down-c.svg": downC,
    "下-小_down-small.svg": downSmall,
    "下-箭头_arrow-circle-down.svg": arrowCircleDown,
    "下1_down-one.svg": downOne,
    "下1_down-two.svg": downTwo,
    "下_down.svg": down,
    "下一曲_go-end.svg": goEnd,
    "下一步_next.svg": next,
    "下回转_u-turn-up.svg": uTurnUp,
    "下对齐2_align-bottom-two.svg": alignBottomTwo,
    "下层_send-backward.svg": sendBackward,
    "下投影_drop-shadow-down.svg": dropShadowDown,
    "下拉列表_drop-down-list.svg": dropDownList,
    "下箭头-方_down-square.svg": downSquare,
    "下载1_download-one.svg": downloadOne,
    "下载2_download-two.svg": downloadTwo,
    "下载3_download-three.svg": downloadThree,
    "下载_download-four.svg": downloadFour,
    "下载_download.svg": download,
    "下载代码_code-download.svg": codeDownload,
    "下降_descend.svg": descend,
    "下雪_snow.svg": snow,
    "不喜欢_dislike-two.svg": dislikeTwo,
    "不喜欢_dislike.svg": dislike,
    "不喜欢_unlike.svg": unlike,
    "不开心_emotion-unhappy.svg": emotionUnhappy,
    "世界_world.svg": world,
    "东方明珠_pearl-of-the-orient.svg": pearlOfTheOrient,
    "两个三角_two-triangles-two.svg": twoTrianglesTwo,
    "两个手指_two-fingers.svg": twoFingers,
    "两个椭圆_two-ellipses.svg": twoEllipses,
    "两只手_two-hands.svg": twoHands,
    "两点连接_connection-point-two.svg": connectionPointTwo,
    "个人隐私_personal-privacy.svg": personalPrivacy,
    "中国楼阁_chinese-pavilion.svg": chinesePavilion,
    "中式汉服_hanfu-chinese-style.svg": hanfuChineseStyle,
    "中指_middle-finger.svg": middleFinger,
    "中文1_chinese-one.svg": chineseOne,
    "中文_chinese.svg": chinese,
    "中药_traditional-chinese-medicine.svg": traditionalChineseMedicine,
    "主机_master.svg": master,
    "主题_theme.svg": theme,
    "举手_hands.svg": hands,
    "举报_report.svg": report,
    "举重_weightlifting.svg": weightlifting,
    "乒乓球_tabletennis.svg": tabletennis,
    "乘凉_shade.svg": shade,
    "九宫格_grid-nine.svg": gridNine,
    "九点连接_nine-points-connected.svg": ninePointsConnected,
    "九级标题_level-nine-title.svg": levelNineTitle,
    "书签_bookmark-one.svg": bookmarkOne,
    "书签_bookmark.svg": bookmark,
    "书籍-打开_book-open.svg": bookOpen,
    "书籍1_book-one.svg": bookOne,
    "书籍_book.svg": book,
    "书籍_bookshelf.svg": bookshelf,
    "乳液_lotion.svg": lotion,
    "二_two-two.svg": twoTwo,
    "二_two.svg": two,
    "二维码_two-dimensional-code-one.svg": twoDimensionalCodeOne,
    "二维码_two-dimensional-code-two.svg": twoDimensionalCodeTwo,
    "二维码_two-dimensional-code.svg": twoDimensionalCode,
    "云中断_link-cloud-faild.svg": linkCloudFaild,
    "云办公_network-drive.svg": networkDrive,
    "云存储_cloud-storage.svg": cloudStorage,
    "云运行_link-cloud.svg": linkCloud,
    "云连接_link-cloud-sucess.svg": linkCloudSucess,
    "五_five-five.svg": fiveFive,
    "五_five.svg": five,
    "五个椭圆_five-ellipses.svg": fiveEllipses,
    "五星徽章_five-star-badge.svg": fiveStarBadge,
    "五级标题_level-five-title.svg": levelFiveTitle,
    "五边形_pentagon-one.svg": pentagonOne,
    "井号_pound-sign.svg": poundSign,
    "井号_pound.svg": pound,
    "井号文件1_file-hash-one.svg": fileHashOne,
    "井号文件_file-hash.svg": fileHash,
    "井号键_hashtag-key.svg": hashtagKey,
    "交叉环_cross-ring.svg": crossRing,
    "交易清单_transaction-order.svg": transactionOrder,
    "交货_delivery.svg": delivery,
    "交集_intersection.svg": intersection,
    "亮度_brightness.svg": brightness,
    "人事文件1_file-staff-one.svg": fileStaffOne,
    "人事文件_file-staff.svg": fileStaff,
    "人像卡片上_people-top-card.svg": peopleTopCard,
    "人像卡片下_people-bottom-card.svg": peopleBottomCard,
    "人员_people.svg": people,
    "人员上_people-top.svg": peopleTop,
    "人员下_people-bottom.svg": peopleBottom,
    "人员右_people-right.svg": peopleRight,
    "人员屏蔽_people-unknown.svg": peopleUnknown,
    "人员左_people-left.svg": peopleLeft,
    "人员查找_people-search-one.svg": peopleSearchOne,
    "人员说话_people-speak.svg": peopleSpeak,
    "人员调动_turn-around.svg": turnAround,
    "人群_peoples-two.svg": peoplesTwo,
    "人群_peoples.svg": peoples,
    "人脸识别_face-recognition.svg": faceRecognition,
    "人脸识别_ios-face-recognition.svg": iosFaceRecognition,
    "人身安全1_people-safe-one.svg": peopleSafeOne,
    "人身安全_people-safe.svg": peopleSafe,
    "今日头条_jinritoutiao.svg": jinritoutiao,
    "从动装置_hunting-gear.svg": huntingGear,
    "付款码_pay-code-one.svg": payCodeOne,
    "代码_code.svg": code,
    "代码文件1_file-code-one.svg": fileCodeOne,
    "代码文件_file-code.svg": fileCode,
    "代码文件夹1_folder-code-one.svg": folderCodeOne,
    "代码文件夹_folder-code.svg": folderCode,
    "仪表盘_dashboard-car.svg": dashboardCar,
    "仪表盘_dashboard-one.svg": dashboardOne,
    "仪表盘_dashboard-two.svg": dashboardTwo,
    "仪表盘_dashboard.svg": dashboard,
    "任天堂游戏_switch-nintendo.svg": switchNintendo,
    "任天堂游戏机_nintendo-switch.svg": nintendoSwitch,
    "企业号_qiyehao.svg": qiyehao,
    "休闲_resting.svg": resting,
    "众多用户_every-user.svg": everyUser,
    "优兔_youtube.svg": youtube,
    "优惠券_coupon.svg": coupon,
    "优秀_good-one.svg": goodOne,
    "优质文件1_file-quality-one.svg": fileQualityOne,
    "优质文件_file-quality.svg": fileQuality,
    "传入_afferent-two.svg": afferentTwo,
    "传入_afferent.svg": afferent,
    "传出_outgoing.svg": outgoing,
    "伸展_stretching.svg": stretching,
    "体操1_gymnastics-one.svg": gymnasticsOne,
    "体操2_gymnastics.svg": gymnastics,
    "体重_weight.svg": weight,
    "俄罗斯方块_block-eight.svg": blockEight,
    "俄罗斯方块_block-five.svg": blockFive,
    "俄罗斯方块_block-four.svg": blockFour,
    "俄罗斯方块_block-nine.svg": blockNine,
    "俄罗斯方块_block-one.svg": blockOne,
    "俄罗斯方块_block-seven.svg": blockSeven,
    "俄罗斯方块_block-six.svg": blockSix,
    "俄罗斯方块_block-ten.svg": blockTen,
    "俄罗斯方块_block-three.svg": blockThree,
    "俄罗斯方块_block-two.svg": blockTwo,
    "保佑_bless.svg": bless,
    "保健品_health-products.svg": healthProducts,
    "保存_save.svg": save,
    "保存硬盘_save-one.svg": saveOne,
    "保护_protect.svg": protect,
    "保护_protection.svg": protection,
    "保温杯_thermos-cup.svg": thermosCup,
    "保留球_bottom-bar-one.svg": bottomBarOne,
    "保险箱_strongbox.svg": strongbox,
    "保龄球_bowling.svg": bowling,
    "信号_signal-one.svg": signalOne,
    "信号_signal.svg": signal,
    "信号塔_signal-tower-one.svg": signalTowerOne,
    "信号塔_signal-tower.svg": signalTower,
    "信号强度_signal-strength.svg": signalStrength,
    "信封1_envelope-one.svg": envelopeOne,
    "信封_envelope.svg": envelope,
    "信息_info.svg": info,
    "信息_message.svg": message,
    "信息加密_message-privacy.svg": messagePrivacy,
    "信息失败_message-failed.svg": messageFailed,
    "信息安全_message-security.svg": messageSecurity,
    "信息已发送_message-sent.svg": messageSent,
    "信息成功_message-success.svg": messageSuccess,
    "信息搜索_message-search.svg": messageSearch,
    "信用卡_credit.svg": credit,
    "修改_modify-two.svg": modifyTwo,
    "修改_modify.svg": modify,
    "停车场_parking.svg": parking,
    "健康_health.svg": health,
    "健康认知_healthy-recognition.svg": healthyRecognition,
    "健身_dumbbell.svg": dumbbell,
    "储存卡1_storage-card-one.svg": storageCardOne,
    "储存卡2_storage-card-two.svg": storageCardTwo,
    "储存卡_memory.svg": memory,
    "储存卡_sim-card.svg": simCard,
    "储存器_memory-one.svg": memoryOne,
    "儿童1_baby-one.svg": babyOne,
    "儿童帽_children-cap.svg": childrenCap,
    "儿童金字塔_children-pyramid.svg": childrenPyramid,
    "充电宝_charging-treasure.svg": chargingTreasure,
    "光圈优先_aperture-priority.svg": aperturePriority,
    "光晕_halo.svg": halo,
    "光源_light.svg": light,
    "光盘_cd.svg": cd,
    "光盘_record-disc.svg": recordDisc,
    "兑换1_exchange-one.svg": exchangeOne,
    "兑换2_exchange-two.svg": exchangeTwo,
    "兑换3_exchange-three.svg": exchangeThree,
    "兑换4_exchange-four.svg": exchangeFour,
    "入库_warehousing.svg": warehousing,
    "全宽_fullwidth.svg": fullwidth,
    "全局放大1_full-screen-one.svg": fullScreenOne,
    "全局放大2_full-screen-two.svg": fullScreenTwo,
    "全局放大_full-screen.svg": fullScreen,
    "全局缩小1_off-screen-one.svg": offScreenOne,
    "全局缩小2_off-screen-two.svg": offScreenTwo,
    "全局缩小_off-screen.svg": offScreen,
    "全屏播放_full-screen-play.svg": fullScreenPlay,
    "全景水平_panorama-horizontal.svg": panoramaHorizontal,
    "全球_globe.svg": globe,
    "全球旅游_universal.svg": universal,
    "全科_general-branch.svg": generalBranch,
    "全选_full-selection.svg": fullSelection,
    "全部_all-application.svg": allApplication,
    "八级标题_level-eight-title.svg": levelEightTitle,
    "八边形_octagon.svg": octagon,
    "公交车_bus-two.svg": busTwo,
    "公式_formula.svg": formula,
    "公文包_briefcase.svg": briefcase,
    "六_six.svg": six,
    "六个点_six-points.svg": sixPoints,
    "六级标题_level-six-title.svg": levelSixTitle,
    "六边形1_hexagon-one.svg": hexagonOne,
    "六边条_hexagon-strip.svg": hexagonStrip,
    "六边立体_hexagonal.svg": hexagonal,
    "关注_concern.svg": concern,
    "关系图_chart-graph.svg": chartGraph,
    "关系链_relational-graph.svg": relationalGraph,
    "关联_association.svg": association,
    "关键线_keyline.svg": keyline,
    "关闭-小_close-small.svg": closeSmall,
    "关闭_close-one.svg": closeOne,
    "关闭_close.svg": close,
    "关闭录音_voice-off.svg": voiceOff,
    "关闭提醒_close-remind.svg": closeRemind,
    "关闭摄像_monitor-off.svg": monitorOff,
    "关闭无线网络_close-wifi.svg": closeWifi,
    "关闭蓝牙_turn-off-bluetooth.svg": turnOffBluetooth,
    "其他_other.svg": other,
    "内上投影_inner-shadow-up.svg": innerShadowUp,
    "内下投影_inner-shadow-down.svg": innerShadowDown,
    "内分泌_endocrine.svg": endocrine,
    "内右上投影_inner-shadow-top-right.svg": innerShadowTopRight,
    "内右下投影_inner-shadow-bottom-right.svg": innerShadowBottomRight,
    "内右投影_inner-shadow-right.svg": innerShadowRight,
    "内左上投影_inner-shadow-top-left.svg": innerShadowTopLeft,
    "内左下投影_inner-shadow-bottom-left.svg": innerShadowBottomLeft,
    "内左投影_inner-shadow-left.svg": innerShadowLeft,
    "内裤_clothes-briefs.svg": clothesBriefs,
    "内裤_panties.svg": panties,
    "内部传输_internal-transmission.svg": internalTransmission,
    "内部扩大_internal-expansion.svg": internalExpansion,
    "内部数据_internal-data.svg": internalData,
    "内部缩小_internal-reduction.svg": internalReduction,
    "写作_write.svg": write,
    "农药_pesticide.svg": pesticide,
    "冠状病毒_coronavirus.svg": coronavirus,
    "冰壶_curling.svg": curling,
    "冰棍4_icecream-five.svg": icecreamFive,
    "冰棍_icecream-three.svg": icecreamThree,
    "冰激凌_icecream-four.svg": icecreamFour,
    "冰激凌_icecream-two.svg": icecreamTwo,
    "冰激凌_icecream.svg": icecream,
    "冰箱_refrigerator.svg": refrigerator,
    "冰鞋_skates.svg": skates,
    "冻结列_freeze-column.svg": freezeColumn,
    "冻结行_freeze-line.svg": freezeLine,
    "冻结行列_freezing-line-column.svg": freezingLineColumn,
    "准时吃药_medication-time.svg": medicationTime,
    "凉鞋_sandals.svg": sandals,
    "减_minus.svg": minus,
    "减去上一层_subtract-selection-one.svg": subtractSelectionOne,
    "减去下一层_subtract-selection.svg": subtractSelection,
    "减少_reduce-one.svg": reduceOne,
    "减少_reduce.svg": reduce,
    "减少人群_people-minus-one.svg": peopleMinusOne,
    "减少人群_people-minus.svg": peopleMinus,
    "减少小数位_reduce-decimal-places.svg": reduceDecimalPlaces,
    "减少用户_reduce-user.svg": reduceUser,
    "几何花_geometric-flowers.svg": geometricFlowers,
    "凯旋门_arc-de-triomphe.svg": arcDeTriomphe,
    "出发_set-off.svg": setOff,
    "出库_outbound.svg": outbound,
    "出租车_taxi.svg": taxi,
    "刀子叉子_knife-fork.svg": knifeFork,
    "刀片_blade.svg": blade,
    "分享2_share-two.svg": shareTwo,
    "分享3_share-three.svg": shareThree,
    "分享_share-one.svg": shareOne,
    "分享_share-sys.svg": shareSys,
    "分享_share.svg": share,
    "分叉_fork.svg": fork,
    "分支_branch-one.svg": branchOne,
    "分支_branch-two.svg": branchTwo,
    "分支_branch.svg": branch,
    "分散对齐_scatter-alignment.svg": scatterAlignment,
    "分析_analysis.svg": analysis,
    "分界线_dividing-line.svg": dividingLine,
    "分离_split-branch.svg": splitBranch,
    "分类管理_category-management.svg": categoryManagement,
    "分组_connection-box.svg": connectionBox,
    "分裂_split.svg": split,
    "切换_app-switch.svg": appSwitch,
    "切换_switch.svg": switchs,
    "切换主题_switch-themes.svg": switchThemes,
    "切换完成_switching-done.svg": switchingDone,
    "切换对比_switch-contrast.svg": switchContrast,
    "切换按钮_switch-button.svg": switchButton,
    "切换轨道_switch-track.svg": switchTrack,
    "切菜板_chopping-board.svg": choppingBoard,
    "划船_rowing.svg": rowing,
    "列_column.svg": column,
    "列表2_list-two.svg": listTwo,
    "列表_list-bottom.svg": listBottom,
    "列表_list-middle.svg": listMiddle,
    "列表_list-one.svg": listOne,
    "列表_list-top.svg": listTop,
    "列表_list.svg": list,
    "列表查看模式_view-grid-list.svg": viewGridList,
    "列表视图_list-view.svg": listView,
    "创建_newlybuild.svg": newlybuild,
    "创意_creative.svg": creative,
    "删除_delete-one.svg": deleteOne,
    "删除_delete-three.svg": deleteThree,
    "删除_delete-two.svg": deleteTwo,
    "删除_delete.svg": delete,
    "删除主题_delete-themes.svg": deleteThemes,
    "删除模式_delete-mode.svg": deleteMode,
    "删除用户_people-delete-one.svg": peopleDeleteOne,
    "删除用户_people-delete.svg": peopleDelete,
    "删除线_strikethrough.svg": strikethrough,
    "删除购物车_shopping-cart-del.svg": shoppingCartDel,
    "删除键_delete-key.svg": deleteKey,
    "别嘴_confused-face.svg": confusedFace,
    "别嘴生气_frowning-face-whit-open-mouth.svg": frowningFaceWhitOpenMouth,
    "刮胡泡_shaving.svg": shaving,
    "刮风_wind.svg": wind,
    "到期文件1_file-date-one.svg": fileDateOne,
    "到期文件_file-date.svg": fileDate,
    "刷卡_swipe.svg": swipe,
    "刷新_refresh-one.svg": refreshOne,
    "刷新_refresh.svg": refresh,
    "券_ticket.svg": ticket,
    "刹车片_brake-pads.svg": brakePads,
    "剃刀_razor.svg": razor,
    "剃须刀_shaver-one.svg": shaverOne,
    "剃须刀_shaver.svg": shaver,
    "剪刀_scissors.svg": scissors,
    "剪切板_clipboard.svg": clipboard,
    "剪映_mediaeditor.svg": mediaeditor,
    "功夫_kungfu.svg": kungfu,
    "加_plus.svg": plus,
    "加减_add-subtract.svg": addSubtract,
    "加减乘除_arithmetic-buttons.svg": arithmeticButtons,
    "加减调整_adjustment.svg": adjustment,
    "加印_add-print.svg": addPrint,
    "加号_plus-cross.svg": plusCross,
    "加密文件1_file-lock-one.svg": fileLockOne,
    "加密文件_file-lock.svg": fileLock,
    "加密文件夹1_folder-lock-one.svg": folderLockOne,
    "加密文件夹_folder-lock.svg": folderLock,
    "加热电阻_heater-resistor.svg": heaterResistor,
    "加载4_loading-four.svg": loadingFour,
    "加载_loading-one.svg": loadingOne,
    "加载_loading-three.svg": loadingThree,
    "加载_loading-two.svg": loadingTwo,
    "加载_loading.svg": loading,
    "勾引_flirt.svg": flirt,
    "包容网关_inclusive-gateway.svg": inclusiveGateway,
    "化妆刷_cosmetic-brush.svg": cosmeticBrush,
    "化妆刷_paint.svg": paint,
    "区块链_blockchain.svg": blockchain,
    "区域图_area-map.svg": areaMap,
    "医疗档案_medical-files.svg": medicalFiles,
    "医疗箱_medical-box.svg": medicalBox,
    "医院_hospital-two.svg": hospitalTwo,
    "医院_hospital.svg": hospital,
    "升序排序_sort-amount-up.svg": sortAmountUp,
    "半圆_misaligned-semicircle.svg": misalignedSemicircle,
    "半自动模式_intermediate-mode.svg": intermediateMode,
    "协议_agreement.svg": agreement,
    "单人床_single-bed.svg": singleBed,
    "单播_unicast.svg": unicast,
    "单肩包_the-single-shoulder-bag.svg": theSingleShoulderBag,
    "单选_radio-two.svg": radioTwo,
    "南瓜_pumpkin.svg": pumpkin,
    "博物馆_museum-one.svg": museumOne,
    "博物馆_museum-two.svg": museumTwo,
    "占比图_chart-proportion.svg": chartProportion,
    "卡片查看模式_view-grid-card.svg": viewGridCard,
    "卫生间_public-toilet.svg": publicToilet,
    "卫衣_clothes-hoodie.svg": clothesHoodie,
    "印章_seal.svg": seal,
    "危害_harm.svg": harm,
    "历史搜索_history-query.svg": historyQuery,
    "历史记录_history.svg": history,
    "压缩_compression.svg": compression,
    "压缩文件_file-zip.svg": fileZip,
    "压缩文件_zip.svg": zip,
    "厨师帽_chef-hat.svg": chefHat,
    "厨师帽子_chef-hat-one.svg": chefHatOne,
    "去右侧_to-right.svg": toRight,
    "去左侧_to-left.svg": toLeft,
    "去底部1_to-bottom-one.svg": toBottomOne,
    "去底部_to-bottom.svg": toBottom,
    "去顶部1_to-top-one.svg": toTopOne,
    "去顶部_to-top.svg": toTop,
    "叉子勺子_fork-spoon.svg": forkSpoon,
    "双X符号_symbol-double-x.svg": xSymbolDoubleX,
    "双上_double-up.svg": doubleUp,
    "双下_double-down.svg": doubleDown,
    "双人床_double-bed.svg": doubleBed,
    "双半圆_two-semicircles.svg": twoSemicircles,
    "双卡片_card-two.svg": cardTwo,
    "双右_double-right.svg": doubleRight,
    "双向数据互传_transfer-data.svg": transferData,
    "双左_double-left.svg": doubleLeft,
    "反转相机_reverse-lens-one.svg": reverseLensOne,
    "反转镜头_invert-camera.svg": invertCamera,
    "发光_luminous.svg": luminous,
    "发光二极管_led-diode.svg": ledDiode,
    "发夹_hair-clip.svg": hairClip,
    "发梳_hair-brush.svg": hairBrush,
    "发现指数_discovery-index.svg": discoveryIndex,
    "发簪_afro-pick.svg": afroPick,
    "发送1_send-one.svg": sendOne,
    "发送_send.svg": send,
    "发送邮件_send-email.svg": sendEmail,
    "取景器_viewfinder.svg": viewfinder,
    "口红1_lipstick-one.svg": lipstickOne,
    "口红_lipstick.svg": lipstick,
    "口罩_mask.svg": mask,
    "可乐_cola.svg": cola,
    "可回收_recycling.svg": recycling,
    "台灯_desk-lamp.svg": deskLamp,
    "台灯_table-lamp.svg": tableLamp,
    "台球黑八_black-eight.svg": blackEight,
    "右-圆_right-c.svg": rightC,
    "右-小_right-small.svg": rightSmall,
    "右-箭头_arrow-circle-right.svg": arrowCircleRight,
    "右1_right-one.svg": rightOne,
    "右1_right-two.svg": rightTwo,
    "右_right.svg": right,
    "右上-小_right-small-up.svg": rightSmallUp,
    "右下-小_right-small-down.svg": rightSmallDown,
    "右下分支_split-turn-down-right.svg": splitTurnDownRight,
    "右侧上对齐_alignment-right-top.svg": alignmentRightTop,
    "右侧下对齐_alignment-right-bottom.svg": alignmentRightBottom,
    "右侧居中对齐_alignment-right-center.svg": alignmentRightCenter,
    "右侧连接_s-turn-right.svg": sTurnRight,
    "右回转_u-turn-left.svg": uTurnLeft,
    "右对齐2_align-right-one.svg": alignRightOne,
    "右对齐_align-right.svg": alignRight,
    "右投影_drop-shadow-right.svg": dropShadowRight,
    "右栏_right-bar.svg": rightBar,
    "右箭头-方_right-square.svg": rightSquare,
    "右缩进_indent-right.svg": indentRight,
    "右角向上_corner-right-up.svg": cornerRightUp,
    "右角向下_corner-right-down.svg": cornerRightDown,
    "右运行_right-run.svg": rightRun,
    "右连接_link-right.svg": linkRight,
    "右音波_waves-right.svg": wavesRight,
    "叶子_leaf.svg": leaf,
    "吃奶嘴_child-with-pacifier.svg": childWithPacifier,
    "合作握手_cooperative-handshake.svg": cooperativeHandshake,
    "合并_merge.svg": merge,
    "合并_sum.svg": sum,
    "合并单元格_merge-cells.svg": mergeCells,
    "合并选择_union-selection.svg": unionSelection,
    "吊带裙_bib.svg": bib,
    "吊环_rings.svg": rings,
    "同向运行_reverse-operation-in.svg": reverseOperationIn,
    "同步_sync.svg": sync,
    "名片_id-card.svg": idCard,
    "向上右角_corner-up-right.svg": cornerUpRight,
    "向上左角_corner-up-left.svg": cornerUpLeft,
    "向上指_hand-up.svg": handUp,
    "向上收起_fold-up-one.svg": foldUpOne,
    "向下右角_corner-down-right.svg": cornerDownRight,
    "向下左角_corner-down-left.svg": cornerDownLeft,
    "向下指_hand-down.svg": handDown,
    "向下收起_expand-down-one.svg": expandDownOne,
    "向内移动_move-in.svg": moveIn,
    "向右展开_right-expand.svg": rightExpand,
    "向右指_hand-right.svg": handRight,
    "向外连接_link-out.svg": linkOut,
    "向左展开_left-expand.svg": leftExpand,
    "向左指_hand-left.svg": handLeft,
    "听诊器_stethoscope.svg": stethoscope,
    "吸奶器_breast-pump.svg": breastPump,
    "吸尘器_vacuum-cleaner.svg": vacuumCleaner,
    "吸管杯_sippy-cup.svg": sippyCup,
    "吹哨_whistling.svg": whistling,
    "吹风机_hair-dryer-one.svg": hairDryerOne,
    "吹风机_hair-dryer.svg": hairDryer,
    "呢帽_woolen-hat.svg": woolenHat,
    "呲牙张嘴_grimacing-face.svg": grimacingFace,
    "命令键_command.svg": command,
    "咖啡杯_cup.svg": cup,
    "品尝_baby-taste.svg": babyTaste,
    "哭_loudly-crying-face.svg": loudlyCryingFace,
    "唇彩_lip-gloss.svg": lipGloss,
    "唇纹身_lip-tattoo.svg": lipTattoo,
    "唱片集_record.svg": record,
    "商务用户_user-business.svg": userBusiness,
    "商品_commodity.svg": commodity,
    "商圈_shopping-mall.svg": shoppingMall,
    "商店_shop.svg": shop,
    "商标符号_trademark.svg": trademark,
    "啤酒_beer.svg": beer,
    "啤酒杯_beer-mug.svg": beerMug,
    "喇叭_speaker-one.svg": speakerOne,
    "喇叭_trumpet.svg": trumpet,
    "喇叭裤_trousers-bell-bottoms.svg": trousersBellBottoms,
    "喜欢_like.svg": like,
    "喝茶_tea-drink.svg": teaDrink,
    "嘴巴_mouth.svg": mouth,
    "四_four-four.svg": fourFour,
    "四_four.svg": four,
    "四个箭头_four-arrows.svg": fourArrows,
    "四宫格_grid-four.svg": gridFour,
    "四棱锥_quadrangular-pyramid.svg": quadrangularPyramid,
    "四点连接_four-point-connection.svg": fourPointConnection,
    "四点连接_four-round-point-connection.svg": fourRoundPointConnection,
    "四片叶子_four-leaves.svg": fourLeaves,
    "四级标题_level-four-title.svg": levelFourTitle,
    "四边形_quadrilateral.svg": quadrilateral,
    "回传数据_date-comes-back.svg": dateComesBack,
    "回形针_paperclip.svg": paperclip,
    "回收池_recycling-pool.svg": recyclingPool,
    "回收站_recycle-bin.svg": recycleBin,
    "回车键_enter-key-one.svg": enterKeyOne,
    "回车键_enter-key.svg": enterKey,
    "囧笑_sly-face-whit-smile.svg": slyFaceWhitSmile,
    "固态硬盘_solid-state-disk.svg": solidStateDisk,
    "国际化_international.svg": international,
    "国际象棋_chess-one.svg": chessOne,
    "图层_layers.svg": layers,
    "图形分割_rectangular-circular-separation.svg": rectangularCircularSeparation,
    "图形组合_graphic-design-two.svg": graphicDesignTwo,
    "图形设计_graphic-design.svg": graphicDesign,
    "图形连接_rectangular-circular-connection.svg": rectangularCircularConnection,
    "图片1_pic-one.svg": picOne,
    "图片_picture-one.svg": pictureOne,
    "图片_picture.svg": picture,
    "图片文件_image-files.svg": imageFiles,
    "图虫_tuchong.svg": tuchong,
    "圆嘴_anguished-face.svg": anguishedFace,
    "圆圈_circle-five-line.svg": circleFiveLine,
    "圆圈_circle-four-line.svg": circleFourLine,
    "圆圈_circle-four.svg": circleFour,
    "圆圈_circle-three.svg": circleThree,
    "圆圈_circle-two-line.svg": circleTwoLine,
    "圆圈_circles-seven.svg": circlesSeven,
    "圆头端点_endpoint-round.svg": endpointRound,
    "圆头节点_node-round.svg": nodeRound,
    "圆形_round.svg": round,
    "圆形卡钳_round-caliper.svg": roundCaliper,
    "圆形双上箭头_circle-double-up.svg": circleDoubleUp,
    "圆形双下箭头_circle-double-down.svg": circleDoubleDown,
    "圆形双右箭头_circle-double-right.svg": circleDoubleRight,
    "圆形双左箭头_circle-double-left.svg": circleDoubleLeft,
    "圆形右上_circle-right-up.svg": circleRightUp,
    "圆形右下_circle-right-down.svg": circleRightDown,
    "圆形和三角_circles-and-triangles.svg": circlesAndTriangles,
    "圆形左上_circle-left-up.svg": circleLeftUp,
    "圆形左下_circle-left-down.svg": circleLeftDown,
    "圆形扭曲_round-distortion.svg": roundDistortion,
    "圆形插座_round-socket.svg": roundSocket,
    "圆形段落_paragraph-round.svg": paragraphRound,
    "圆形组合_graphic-stitching-four.svg": graphicStitchingFour,
    "圆形组合_graphic-stitching-three.svg": graphicStitchingThree,
    "圆形组合_graphic-stitching.svg": graphicStitching,
    "圆形连接_circular-connection.svg": circularConnection,
    "圆形连接_six-circular-connection.svg": sixCircularConnection,
    "圆形遮罩_round-mask.svg": roundMask,
    "圆柱_cylinder.svg": cylinder,
    "圆环_ring-one.svg": ringOne,
    "圆环_ring.svg": ring,
    "圆球_sphere.svg": sphere,
    "圆萝卜_radish-one.svg": radishOne,
    "圆规_compass.svg": compass,
    "圆锥_cone.svg": cone,
    "圆顶_dome.svg": dome,
    "圆领衫_clothes-crew-neck.svg": clothesCrewNeck,
    "圈舍_circle-house.svg": circleHouse,
    "圣剑_holy-sword.svg": holySword,
    "圣诞树_christmas-tree.svg": christmasTree,
    "地图_map-draw.svg": mapDraw,
    "地图_map-road-two.svg": mapRoadTwo,
    "地图_map-two.svg": mapTwo,
    "地图距离_map-distance.svg": mapDistance,
    "地图道路_map-road.svg": mapRoad,
    "地球仪_earth.svg": earth,
    "地铁_subway.svg": subway,
    "均衡器_equalizer.svg": equalizer,
    "坏的_bad.svg": bad,
    "坐标系_cones.svg": cones,
    "坐标系统_coordinate-system.svg": coordinateSystem,
    "块公式_inline.svg": inline,
    "坚果_nut.svg": nut,
    "垂直分布_distribute-vertically.svg": distributeVertically,
    "垂直右对齐_alignment-vertical-right.svg": alignmentVerticalRight,
    "垂直对齐_align-vertically.svg": alignVertically,
    "垂直居中_margin.svg": margin,
    "垂直居中对齐2_align-vertical-center-two.svg": alignVerticalCenterTwo,
    "垂直居中对齐_alignment-vertical-center.svg": alignmentVerticalCenter,
    "垂直居中对齐_vertically-centered.svg": verticallyCentered,
    "垂直左对齐_alignment-vertical-left.svg": alignmentVerticalLeft,
    "垂直拖动_sliding-vertical.svg": slidingVertical,
    "垂直整理_vertical-tidy-up.svg": verticalTidyUp,
    "垂直时间线_vertical-timeline.svg": verticalTimeline,
    "垂直翻转_flip-vertically.svg": flipVertically,
    "垂直间距_vertical-spacing-between-items.svg": verticalSpacingBetweenItems,
    "垂直间距分布_distribute-vertical-spacing.svg": distributeVerticalSpacing,
    "垂钓_fishing.svg": fishing,
    "垒球_softball.svg": softball,
    "埃菲尔铁塔_eiffel-tower.svg": eiffelTower,
    "城堡_castle.svg": castle,
    "城市_city-one.svg": cityOne,
    "城市_city.svg": city,
    "城门_city-gate.svg": cityGate,
    "基金_funds.svg": funds,
    "堆栈灯_stack-light.svg": stackLight,
    "塔楼_tower.svg": tower,
    "填充_fill.svg": fill,
    "增加图片_add-pic.svg": addPic,
    "增加小数位_increase-the-scale.svg": increaseTheScale,
    "增加模式_add-mode.svg": addMode,
    "声波_acoustic.svg": acoustic,
    "声音-大_volume-notice.svg": volumeNotice,
    "声音-小_volume-small.svg": volumeSmall,
    "声音_voice-one.svg": voiceOne,
    "处方_prescription.svg": prescription,
    "复制_copy-one.svg": copyOne,
    "复制_copy.svg": copy,
    "复制链接_copy-link.svg": copyLink,
    "复古包_retro-bag.svg": retroBag,
    "夏威夷果_macadamia-nut.svg": macadamiaNut,
    "外部传输_external-transmission.svg": externalTransmission,
    "多三角_multi-triangular-four.svg": multiTriangularFour,
    "多三角_multi-triangular-three.svg": multiTriangularThree,
    "多三角_multi-triangular-two.svg": multiTriangularTwo,
    "多三角_multi-triangular.svg": multiTriangular,
    "多云_cloudy.svg": cloudy,
    "多功能刀_multi-function-knife.svg": multiFunctionKnife,
    "多图轮播_multi-picture-carousel.svg": multiPictureCarousel,
    "多圆形_multi-circular.svg": multiCircular,
    "多圆环_multi-ring.svg": multiRing,
    "多对多_many-to-many.svg": manyToMany,
    "多层圆球_multilayer-sphere.svg": multilayerSphere,
    "多播_multicast.svg": multicast,
    "多方形_multi-rectangle.svg": multiRectangle,
    "多选列表_list-checkbox.svg": listCheckbox,
    "多选框_checkbox.svg": checkbox,
    "夜晚模式_dark-mode.svg": darkMode,
    "夜间多云_cloudy-night.svg": cloudyNight,
    "大X_rectangle-x.svg": xRectangleX,
    "大众_volkswagen.svg": volkswagen,
    "大头钉_pin.svg": pin,
    "大巴_bus.svg": bus,
    "大括号_code-brackets.svg": codeBrackets,
    "大眼笑_face-with-smiling-open-eyes.svg": faceWithSmilingOpenEyes,
    "大纲视图_mindmap-list.svg": mindmapList,
    "大脑_brain.svg": brain,
    "大葱_scallion.svg": scallion,
    "大蒜_garlic.svg": garlic,
    "大虾_shrimp.svg": shrimp,
    "大钟表_big-clock.svg": bigClock,
    "大门_gate.svg": gate,
    "大雨_heavy-rain.svg": heavyRain,
    "大雾_fog.svg": fog,
    "大风_heavy-wind.svg": heavyWind,
    "天平_balance-two.svg": balanceTwo,
    "太空殖民地_space-colony.svg": spaceColony,
    "太阳1_sun-one.svg": sunOne,
    "太阳_sun.svg": sun,
    "太阳帽_sun-hat.svg": sunHat,
    "太阳能_solar-energy-one.svg": solarEnergyOne,
    "太阳能_solar-energy.svg": solarEnergy,
    "失效文件_invalid-files.svg": invalidFiles,
    "失落_disappointed-face.svg": disappointedFace,
    "失衡天平_imbalance.svg": imbalance,
    "失败列表_list-fail.svg": listFail,
    "失败文件夹1_folder-failed-one.svg": folderFailedOne,
    "失败文件夹_folder-failed.svg": folderFailed,
    "头像_avatar.svg": avatar,
    "头盔_helmet.svg": helmet,
    "头饰_headwear.svg": headwear,
    "奔驰_benz.svg": benz,
    "奖杯_trophy.svg": trophy,
    "女人_woman.svg": woman,
    "女大衣_women-coat.svg": womenCoat,
    "女孩1_girl-one.svg": girlOne,
    "女孩2_girl-two.svg": girlTwo,
    "女孩_girl.svg": girl,
    "女性_female.svg": female,
    "奶嘴_pacifier.svg": pacifier,
    "奶瓶_baby-bottle.svg": babyBottle,
    "奶瓶_bottle.svg": bottle,
    "奶酪_cheese.svg": cheese,
    "好的_good.svg": good,
    "娱乐_entertainment.svg": entertainment,
    "婴儿_baby.svg": baby,
    "子宫_uterus.svg": uterus,
    "子弹图_bullet-map.svg": bulletMap,
    "孕妇_pregnant-women.svg": pregnantWomen,
    "孕育_hold-seeds.svg": holdSeeds,
    "字体大小_font-size-two.svg": fontSizeTwo,
    "字体搜索_font-search.svg": fontSearch,
    "字号大小_font-size.svg": fontSize,
    "字母倒序_alphabetical-sorting-two.svg": alphabeticalSortingTwo,
    "字母列表_list-alphabet.svg": listAlphabet,
    "字母段落_paragraph-alphabet.svg": paragraphAlphabet,
    "字母顺序_alphabetical-sorting.svg": alphabeticalSorting,
    "字节设计_bydesign.svg": bydesign,
    "字节跳动_bytedance.svg": bytedance,
    "字节跳动小程序_bytedance-mini-app.svg": bytedanceMiniApp,
    "存储卡_sd-card.svg": sdCard,
    "存款_deposit.svg": deposit,
    "存疑文件_file-question.svg": fileQuestion,
    "学位帽_degree-hat.svg": degreeHat,
    "学前班_preschool.svg": preschool,
    "学士帽_bachelor-cap.svg": bachelorCap,
    "学校_school.svg": school,
    "孩子哭泣_crying-baby.svg": cryingBaby,
    "安全_security.svg": security,
    "安全_shield.svg": shield,
    "安全台_security-stall.svg": securityStall,
    "安全增加_shield-add.svg": shieldAdd,
    "安全帽_helmet-one.svg": helmetOne,
    "安卓_android.svg": android,
    "安检_enquire.svg": enquire,
    "安装_install.svg": install,
    "完成全部_done-all.svg": doneAll,
    "定时发送_timed-mail.svg": timedMail,
    "定时见面_appointment.svg": appointment,
    "宝塔_pagoda.svg": pagoda,
    "宝箱_treasure-chest.svg": treasureChest,
    "实验_experiment-one.svg": experimentOne,
    "实验_experiment.svg": experiment,
    "审核_audit.svg": audit,
    "宫殿_palace.svg": palace,
    "家庭_family.svg": family,
    "对勾_check-correct.svg": checkCorrect,
    "对比_contrast-view-circle.svg": contrastViewCircle,
    "对比_contrast-view.svg": contrastView,
    "对比度_contrast.svg": contrast,
    "对焦1_focus-one.svg": focusOne,
    "对焦_focus.svg": focus,
    "对称_symmetry.svg": symmetry,
    "对讲机_intercom.svg": intercom,
    "导出_export.svg": export,
    "导航_navigation.svg": navigation,
    "射箭_archers-bow.svg": archersBow,
    "小六客服_customer.svg": customer,
    "小度_xiaodu.svg": xiaodu,
    "小度在家_xiaodu-home.svg": xiaoduHome,
    "小方形_square-small.svg": squareSmall,
    "小矩形_rectangle-small.svg": rectangleSmall,
    "小程序关闭_applet-closed.svg": appletClosed,
    "小雨_light-rain.svg": lightRain,
    "小食_snacks.svg": snacks,
    "尺子1_ruler-one.svg": rulerOne,
    "尺子_ruler.svg": ruler,
    "尿不湿_diapers-one.svg": diapersOne,
    "居中对齐_center-alignment.svg": centerAlignment,
    "屏幕旋转_screen-rotation.svg": screenRotation,
    "展开_expand-down.svg": expandDown,
    "展开_expand-left.svg": expandLeft,
    "展开_expand-right.svg": expandRight,
    "展开_expand-up.svg": expandUp,
    "展开文本域_expand-text-input.svg": expandTextInput,
    "展开菜单1_menu-unfold-one.svg": menuUnfoldOne,
    "展开菜单_menu-unfold.svg": menuUnfold,
    "嵌套图形_stereo-nesting.svg": stereoNesting,
    "嵌套箭头_nested-arrows.svg": nestedArrows,
    "工业油漆_oil-industry.svg": oilIndustry,
    "工人_worker.svg": worker,
    "工作台_workbench.svg": workbench,
    "工具_tool.svg": tool,
    "工厂_factory-building.svg": factoryBuilding,
    "左-圆_left-c.svg": leftC,
    "左-小_left-small.svg": leftSmall,
    "左-箭头_arrow-circle-left.svg": arrowCircleLeft,
    "左1_left-one.svg": leftOne,
    "左1_left-two.svg": leftTwo,
    "左_left.svg": left,
    "左上-小_left-small-up.svg": leftSmallUp,
    "左下-小_left-small-down.svg": leftSmallDown,
    "左下分支_split-turn-down-left.svg": splitTurnDownLeft,
    "左侧上对齐_alignment-left-top.svg": alignmentLeftTop,
    "左侧下对齐_alignment-left-bottom.svg": alignmentLeftBottom,
    "左侧居中对齐_alignment-left-center.svg": alignmentLeftCenter,
    "左侧连接_s-turn-left.svg": sTurnLeft,
    "左右扩大_expand-left-and-right.svg": expandLeftAndRight,
    "左回转_u-turn-right.svg": uTurnRight,
    "左对齐2_align-left-one.svg": alignLeftOne,
    "左对齐_align-left.svg": alignLeft,
    "左对齐_left-alignment.svg": leftAlignment,
    "左投影_drop-shadow-left.svg": dropShadowLeft,
    "左栏_left-bar.svg": leftBar,
    "左箭头-方_left-square.svg": leftSquare,
    "左缩进_indent-left.svg": indentLeft,
    "左角向上_corner-left-up.svg": cornerLeftUp,
    "左角向下_corner-left-down.svg": cornerLeftDown,
    "左运行_run-left.svg": runLeft,
    "左链接_link-left.svg": linkLeft,
    "左音波_waves-left.svg": wavesLeft,
    "巨量创意_cc.svg": cc,
    "巨量引擎_oceanengine.svg": oceanengine,
    "巫师帽_sorcerer-hat.svg": sorcererHat,
    "差劲_bad-one.svg": badOne,
    "差异集_difference-set.svg": differenceSet,
    "已定位_local.svg": local,
    "已读邮件_mail-open.svg": mailOpen,
    "币种兑换_payment-method.svg": paymentMethod,
    "市场分析_market-analysis.svg": marketAnalysis,
    "布局1_layout-one.svg": layoutOne,
    "布局2_layout-two.svg": layoutTwo,
    "布局3_layout-three.svg": layoutThree,
    "布局4_layout-four.svg": layoutFour,
    "布局5_layout-five.svg": layoutFive,
    "帆船_sailboat.svg": sailboat,
    "帐篷_tent.svg": tent,
    "帐篷旗帜_tent-banner.svg": tentBanner,
    "帮助_help.svg": help,
    "帮助中心_helpcenter.svg": helpcenter,
    "帽子_hat.svg": hat,
    "帽衫_clothes-sweater.svg": clothesSweater,
    "平均值_average.svg": average,
    "平头端点_endpoint-square.svg": endpointSquare,
    "平头节点_node-square.svg": nodeSquare,
    "平板电脑_ipad-one.svg": ipadOne,
    "平板电脑_pad.svg": pad,
    "平行四边形_parallelogram.svg": parallelogram,
    "平衡_balance.svg": balance,
    "并行网关_parallel-gateway.svg": parallelGateway,
    "幸福里_xingfuli.svg": xingfuli,
    "幻灯片_powerpoint.svg": powerpoint,
    "幻灯片_ppt.svg": ppt,
    "幻灯片_slide-two.svg": slideTwo,
    "幻灯片_slide.svg": slide,
    "幽灵_ghost.svg": ghost,
    "广告_ad.svg": ad,
    "广告产品_ad-product.svg": adProduct,
    "广播_broadcast-one.svg": broadcastOne,
    "广播_broadcast.svg": broadcast,
    "广播保姆_radio-nanny.svg": radioNanny,
    "床头柜_bedside-two.svg": bedsideTwo,
    "床头柜_bedside.svg": bedside,
    "应用_application-one.svg": applicationOne,
    "应用_application-two.svg": applicationTwo,
    "应用_application.svg": application,
    "应用_baby-app.svg": babyApp,
    "应用商店_app-store.svg": appStore,
    "应用效果_application-effect.svg": applicationEffect,
    "应用菜单_application-menu.svg": applicationMenu,
    "底对齐_align-bottom.svg": alignBottom,
    "底栏_bottom-bar.svg": bottomBar,
    "底部中心对齐_alignment-bottom-center.svg": alignmentBottomCenter,
    "底部右对齐_alignment-bottom-right.svg": alignmentBottomRight,
    "底部左对齐_alignment-bottom-left.svg": alignmentBottomLeft,
    "底部连接_s-turn-down.svg": sTurnDown,
    "座椅1_chair-one.svg": chairOne,
    "座椅_chair.svg": chair,
    "建筑_building-four.svg": buildingFour,
    "建筑_building-one.svg": buildingOne,
    "建筑_building-three.svg": buildingThree,
    "建筑_building-two.svg": buildingTwo,
    "开关_power.svg": power,
    "开关_switch-one.svg": switchOne,
    "开心_emotion-happy.svg": emotionHappy,
    "开心_grinning-face.svg": grinningFace,
    "开户_open-an-account.svg": openAnAccount,
    "开衫_clothes-cardigan.svg": clothesCardigan,
    "开门_open-door.svg": openDoor,
    "异常_abnormal.svg": abnormal,
    "引用_quote.svg": quote,
    "张嘴哭_loudly-crying-face-whit-open-mouth.svg": loudlyCryingFaceWhitOpenMouth,
    "张嘴晕_dizzy-face.svg": dizzyFace,
    "张嘴笑_grinning-face-with-open-mouth.svg": grinningFaceWithOpenMouth,
    "张嘴闭眼笑_grinning-face-with-tightly-closed-eyes-open-mouth.svg": grinningFaceWithTightlyClosedEyesOpenMouth,
    "张大嘴_astonished-face.svg": astonishedFace,
    "弹指_spider-man.svg": spiderMan,
    "录音_voice.svg": voice,
    "形式_form-one.svg": formOne,
    "彩蛋_painted-eggshell.svg": paintedEggshell,
    "影片剪辑_edit-movie.svg": editMovie,
    "影视板_movie-board.svg": movieBoard,
    "影院_theater.svg": theater,
    "往返飞_round-trip.svg": roundTrip,
    "循环_cycle-one.svg": cycleOne,
    "循环_cycle.svg": cycle,
    "循环一次_loop-once.svg": loopOnce,
    "循环播放_play-cycle.svg": playCycle,
    "循环移动_cycle-movement.svg": cycleMovement,
    "循环箭头_cycle-arrow.svg": cycleArrow,
    "微信_wechat.svg": wechat,
    "微信卡包_weixin-cards-offers.svg": weixinCardsOffers,
    "微信小程序_weixin-mini-app.svg": weixinMiniApp,
    "微信扫一扫_weixin-scan.svg": weixinScan,
    "微信搜索_weixin-search.svg": weixinSearch,
    "微信摇一摇_weixin-shake.svg": weixinShake,
    "微信收藏_weixin-favorites.svg": weixinFavorites,
    "微信游戏_weixin-games.svg": weixinGames,
    "微信电商_weixin-market.svg": weixinMarket,
    "微信看一看_weixin-top-stories.svg": weixinTopStories,
    "微信附近的人_weixin-people-nearby.svg": weixinPeopleNearby,
    "微单_micro-slr-camera.svg": microSlrCamera,
    "微博_weibo.svg": weibo,
    "微型SD_micro-sd.svg": sdMicroSd,
    "微型USB1_usb-micro-one.svg": usb1UsbMicroOne,
    "微型USB2_usb-micro-two.svg": usb2UsbMicroTwo,
    "微型存储卡_mini-sd-card.svg": miniSdCard,
    "微波炉_microwave-oven.svg": microwaveOven,
    "微波炉_microwaves.svg": microwaves,
    "微笑_slightly-smiling-face.svg": slightlySmilingFace,
    "微软视窗_windows.svg": windows,
    "徽章_badge-two.svg": badgeTwo,
    "徽章提醒_badge.svg": badge,
    "心形气球_heart-ballon.svg": heartBallon,
    "心电_cardioelectric.svg": cardioelectric,
    "心电图_electrocardiogram.svg": electrocardiogram,
    "心脏_heart.svg": heart,
    "心跳_heartbeat.svg": heartbeat,
    "快递_express-delivery.svg": expressDelivery,
    "快门优先_shutter-priority.svg": shutterPriority,
    "思维导图_mindmap-map.svg": mindmapMap,
    "思考问题_thinking-problem.svg": thinkingProblem,
    "惊讶_surprised-face-with-open-mouth.svg": surprisedFaceWithOpenMouth,
    "惊讶张嘴_surprised-face-with-open-big-mouth.svg": surprisedFaceWithOpenBigMouth,
    "感应锁_induction-lock.svg": inductionLock,
    "愤怒_pouting-face.svg": poutingFace,
    "懂车帝_dongchedi.svg": dongchedi,
    "成交_transaction.svg": transaction,
    "成份_composition.svg": composition,
    "成功_success.svg": success,
    "成功列表_list-success.svg": listSuccess,
    "成功文件1_file-success-one.svg": fileSuccessOne,
    "成功文件_file-success.svg": fileSuccess,
    "成功文件夹1_folder-success-one.svg": folderSuccessOne,
    "成功文件夹_folder-success.svg": folderSuccess,
    "成组_group.svg": group,
    "我的_me.svg": me,
    "截图_screenshot-one.svg": screenshotOne,
    "截屏_screenshot-two.svg": screenshotTwo,
    "截屏_screenshot.svg": screenshot,
    "户外_outdoor.svg": outdoor,
    "扇子_fan.svg": fan,
    "手动拖动_hand-drag.svg": handDrag,
    "手动挡_manual-gear.svg": manualGear,
    "手套_clothes-gloves-two.svg": clothesGlovesTwo,
    "手套_clothes-gloves.svg": clothesGloves,
    "手扶电梯_escalators.svg": escalators,
    "手掌_palm.svg": palm,
    "手提包_handbag.svg": handbag,
    "手机_phone.svg": phone,
    "手柄A_handle-a.svg": aHandleA,
    "手柄B_handle-b.svg": bHandleB,
    "手柄C_handle-c.svg": cHandleC,
    "手柄X_handle-x.svg": xHandleX,
    "手柄Y_handle-y.svg": yHandleY,
    "手柄Z_handle-z.svg": zHandleZ,
    "手柄三角形_handle-triangle.svg": handleTriangle,
    "手柄上_handle-up.svg": handleUp,
    "手柄下_handle-down.svg": handleDown,
    "手柄右_handle-right.svg": handleRight,
    "手柄圆圈_handle-round.svg": handleRound,
    "手柄左_handle-left.svg": handleLeft,
    "手柄方形_handle-square.svg": handleSquare,
    "手电筒_flashlight.svg": flashlight,
    "手绘板_hand-painted-plate.svg": handPaintedPlate,
    "手表_watch-one.svg": watchOne,
    "手表_watch.svg": watch,
    "扑克_poker.svg": poker,
    "打印机_printer-one.svg": printerOne,
    "打印机_printer-two.svg": printerTwo,
    "打印机_printer.svg": printer,
    "打开_open-one.svg": openOne,
    "打开_open.svg": open,
    "打开_turn-on.svg": turnOn,
    "打招呼_hi.svg": hi,
    "打排球_play-volleyball.svg": playVolleyball,
    "打篮球_play-basketball.svg": playBasketball,
    "打针_injection.svg": injection,
    "托盘_oven-tray.svg": ovenTray,
    "托盘_tray.svg": tray,
    "托起_hold-interface.svg": holdInterface,
    "托运_consignment.svg": consignment,
    "扫描_scan.svg": scan,
    "扫描_scanning-two.svg": scanningTwo,
    "扫描_scanning.svg": scanning,
    "扫描设置_scan-setting.svg": scanSetting,
    "扫码_scan-code.svg": scanCode,
    "扭曲_distortion.svg": distortion,
    "承接_hold.svg": hold,
    "投射屏幕_cast-screen.svg": castScreen,
    "投影仪_projector-two.svg": projectorTwo,
    "投影仪_projector.svg": projector,
    "投影机_projector-one.svg": projectorOne,
    "抖音_tiktok.svg": tiktok,
    "抖音火山_huoshanzhibo.svg": huoshanzhibo,
    "折线图_chart-line.svg": chartLine,
    "折线面积图_chart-line-area.svg": chartLineArea,
    "抛物线_parabola.svg": parabola,
    "抛锚_anchor-two.svg": anchorTwo,
    "护发素_conditioner.svg": conditioner,
    "护手霜_hand-cream.svg": handCream,
    "护照_passport-one.svg": passportOne,
    "护照_passport.svg": passport,
    "报纸折叠_newspaper-folding.svg": newspaperFolding,
    "报表_table-report.svg": tableReport,
    "报错_caution.svg": caution,
    "抱拳_respect.svg": respect,
    "抿嘴闭眼_confounded-face.svg": confoundedFace,
    "担心_worried-face.svg": worriedFace,
    "拆分单元格_split-cells.svg": splitCells,
    "拉门_pull-door.svg": pullDoor,
    "拐杖_a-cane.svg": aCane,
    "拓展_extend.svg": extend,
    "拖拽_drag.svg": drag,
    "拖鞋_slippers-one.svg": slippersOne,
    "拖鞋_slippers.svg": slippers,
    "招引_come.svg": come,
    "招手_swing.svg": swing,
    "拜拜_bye.svg": bye,
    "拨浪鼓1_rattle-one.svg": rattleOne,
    "拨浪鼓_rattle.svg": rattle,
    "拳击1_boxing-one.svg": boxingOne,
    "拳击_boxing.svg": boxing,
    "拳头_fist.svg": fist,
    "拼图_puzzle.svg": puzzle,
    "指令_instruction.svg": instruction,
    "指出_point-out.svg": pointOut,
    "指南针_compass-one.svg": compassOne,
    "指向_point.svg": point,
    "指甲_fingernail.svg": fingernail,
    "指甲油1_nail-polish-one.svg": nailPolishOne,
    "指甲油_nail-polish.svg": nailPolish,
    "指示牌_guide-board.svg": guideBoard,
    "指纹_fingerprint-three.svg": fingerprintThree,
    "指纹_fingerprint-two.svg": fingerprintTwo,
    "指纹_fingerprint.svg": fingerprint,
    "按修改日期排序_change-date-sort.svg": changeDateSort,
    "按创建日期排序_creation-date-sort.svg": creationDateSort,
    "按开始时间排序_start-time-sort.svg": startTimeSort,
    "按截止日期排序_deadline-sort.svg": deadlineSort,
    "按摩椅1_massage-chair-one.svg": massageChairOne,
    "按摩椅_massage-chair.svg": massageChair,
    "按摩椅_massage-table.svg": massageTable,
    "按最近浏览量排序_recent-views-sort.svg": recentViewsSort,
    "按结束时间排序_end-time-sort.svg": endTimeSort,
    "按跟进日期排序_follow-up-date-sort.svg": followUpDateSort,
    "按键一_one-key.svg": oneKey,
    "按键七_seven-key.svg": sevenKey,
    "按键三_three-key.svg": threeKey,
    "按键九_nine-key.svg": nineKey,
    "按键二_two-key.svg": twoKey,
    "按键五_five-key.svg": fiveKey,
    "按键八_eight-key.svg": eightKey,
    "按键六_six-key.svg": sixKey,
    "按键四_four-key.svg": fourKey,
    "按键零_zero-key.svg": zeroKey,
    "掌机_handheld.svg": handheld,
    "排他网关_exclusive-gateway.svg": exclusiveGateway,
    "排序1_sort-one.svg": sortOne,
    "排序2_sort-two.svg": sortTwo,
    "排序3_sort-three.svg": sortThree,
    "排序_sort-four.svg": sortFour,
    "排序_sort.svg": sort,
    "排球_volleyball.svg": volleyball,
    "排行榜_ranking-list.svg": rankingList,
    "排行榜_ranking.svg": ranking,
    "排除选择_exclude-selection.svg": excludeSelection,
    "接入链接_link-in.svg": linkIn,
    "接受邮件_accept-email.svg": acceptEmail,
    "接收器_receiver.svg": receiver,
    "接收库_receive.svg": receive,
    "控制器_control.svg": control,
    "推特_twitter.svg": twitter,
    "推送请求_pull-requests.svg": pullRequests,
    "推门_push-door.svg": pushDoor,
    "提示_tips-one.svg": tipsOne,
    "提示_tips.svg": tips,
    "提醒_remind.svg": remind,
    "插入_check-in.svg": checkIn,
    "插入表_insert-table.svg": insertTable,
    "插卡_insert-card.svg": insertCard,
    "插头1_power-supply-one.svg": powerSupplyOne,
    "插头2_power-supply.svg": powerSupply,
    "插头_bolt-one.svg": boltOne,
    "插头_plug.svg": plug,
    "插电头_plug-one.svg": plugOne,
    "搜查_find-one.svg": findOne,
    "搜索_search.svg": search,
    "搜索引擎_seo.svg": seo,
    "搜索文件夹1_folder-search-one.svg": folderSearchOne,
    "搜索文件夹_folder-search.svg": folderSearch,
    "搜索用户_people-search.svg": peopleSearch,
    "搽粉_powder.svg": powder,
    "摄像_monitor.svg": monitor,
    "摄像头_camera-five.svg": cameraFive,
    "摄像头_camera-one.svg": cameraOne,
    "摄像机1_videocamera.svg": videocamera,
    "摄像机2_videocamera-one.svg": videocameraOne,
    "摇滚手势_rock-gesture.svg": rockGesture,
    "摇滚指_rock.svg": rock,
    "摇玩_baby-mobile.svg": babyMobile,
    "摇篮_crib.svg": crib,
    "摇马_rocking-horse.svg": rockingHorse,
    "摊位_booth.svg": booth,
    "摩天轮_ferris-wheel.svg": ferrisWheel,
    "撤销_undo.svg": undo,
    "播放5次_replay-five.svg": replayFive,
    "播放_play-one.svg": playOne,
    "播放_play.svg": play,
    "播放一次_play-once.svg": playOnce,
    "播放出错_play-wrong.svg": playWrong,
    "播放器_play-two.svg": playTwo,
    "播放器_record-player.svg": recordPlayer,
    "播放进度_playback-progress.svg": playbackProgress,
    "擦除_erase.svg": erase,
    "支付宝_alipay.svg": alipay,
    "支付码_pay-code-two.svg": payCodeTwo,
    "支付码_pay-code.svg": payCode,
    "支出_expenses-one.svg": expensesOne,
    "收件上载_inbox-out.svg": inboxOut,
    "收件下载_inbox-in.svg": inboxIn,
    "收件成功_inbox-success.svg": inboxSuccess,
    "收件箱_inbox-r.svg": inboxR,
    "收件箱_inbox.svg": inbox,
    "收件箱上传_inbox-upload-r.svg": inboxUploadR,
    "收件箱下载_inbox-download-r.svg": inboxDownloadR,
    "收件箱成功_inbox-success-r.svg": inboxSuccessR,
    "收入_income-one.svg": incomeOne,
    "收缩_reduce-two.svg": reduceTwo,
    "收藏好友_personal-collection.svg": personalCollection,
    "收藏文件1_file-collection-one.svg": fileCollectionOne,
    "收藏文件_collection-files.svg": collectionFiles,
    "收藏文件_file-collection.svg": fileCollection,
    "收藏文件夹1_folder-focus-one.svg": folderFocusOne,
    "收藏文件夹_folder-focus.svg": folderFocus,
    "收藏音乐_collection-records.svg": collectionRecords,
    "收起文本域_collapse-text-input.svg": collapseTextInput,
    "收起菜单1_menu-fold-one.svg": menuFoldOne,
    "收起菜单_menu-fold.svg": menuFold,
    "收音器_microphone-one.svg": microphoneOne,
    "收音机_broadcast-radio.svg": broadcastRadio,
    "收音机_radio-one.svg": radioOne,
    "收音机_radio.svg": radio,
    "放大_zoom-in.svg": zoomIn,
    "放大_zoom.svg": zoom,
    "放映机_projector-three.svg": projectorThree,
    "故障图_damage-map.svg": damageMap,
    "救生圈_lifebuoy.svg": lifebuoy,
    "教堂_church-one.svg": churchOne,
    "教堂_church-two.svg": churchTwo,
    "散点图_chart-scatter.svg": chartScatter,
    "数字列表_list-numbers.svg": listNumbers,
    "数据_data-all.svg": dataAll,
    "数据_data-four.svg": dataFour,
    "数据_data-one.svg": dataOne,
    "数据_data-three.svg": dataThree,
    "数据_data-two.svg": dataTwo,
    "数据切换_data-switching.svg": dataSwitching,
    "数据到达_data-arrival.svg": dataArrival,
    "数据图_chart-pie-one.svg": chartPieOne,
    "数据库_data.svg": data,
    "数据库下载_database-download.svg": databaseDownload,
    "数据库代码_database-code.svg": databaseCode,
    "数据库占比_database-proportion.svg": databaseProportion,
    "数据库同步_database-sync.svg": databaseSync,
    "数据库定位_database-position.svg": databasePosition,
    "数据库成功_database-success.svg": databaseSuccess,
    "数据库搜索_database-search.svg": databaseSearch,
    "数据库时间_database-time.svg": databaseTime,
    "数据库电源_database-power.svg": databasePower,
    "数据库禁止_database-forbid.svg": databaseForbid,
    "数据库第一_database-first.svg": databaseFirst,
    "数据库网络_database-network.svg": databaseNetwork,
    "数据库网络节点_database-network-point.svg": databaseNetworkPoint,
    "数据库节点_database-point.svg": databasePoint,
    "数据库警示_database-alert.svg": databaseAlert,
    "数据库设置_database-setting.svg": databaseSetting,
    "数据库进入_database-enter.svg": databaseEnter,
    "数据库配置_database-config.svg": databaseConfig,
    "数据库锁定_database-lock.svg": databaseLock,
    "数据库错误_database-fail.svg": databaseFail,
    "数据接口_usb-one.svg": usbOne,
    "数据接口_usb.svg": usb,
    "数据文件_data-file.svg": dataFile,
    "数据显示_data-display.svg": dataDisplay,
    "数据服务器_data-server.svg": dataServer,
    "数据用户_data-user.svg": dataUser,
    "数据看板_data-screen.svg": dataScreen,
    "数据空_data-null.svg": dataNull,
    "数据统计工具_excel.svg": excel,
    "数据表_data-sheet.svg": dataSheet,
    "数据透视表_pivot-table.svg": pivotTable,
    "数据锁定_data-lock.svg": dataLock,
    "整体缩小_overall-reduction.svg": overallReduction,
    "整形科_plastic-surgery.svg": plasticSurgery,
    "文件-excel_file-excel.svg": excelFileExcel,
    "文件-gif_file-gif.svg": gifFileGif,
    "文件-jpg_file-jpg.svg": jpgFileJpg,
    "文件-pdf_file-pdf.svg": pdfFilePdf,
    "文件-txt_file-txt.svg": txtFileTxt,
    "文件-word_file-word.svg": wordFileWord,
    "文件保护1_file-protection-one.svg": fileProtectionOne,
    "文件保护_file-protection.svg": fileProtection,
    "文件失败1_file-failed-one.svg": fileFailedOne,
    "文件失败_file-failed.svg": fileFailed,
    "文件夹-上传_folder-upload.svg": folderUpload,
    "文件夹-下载_folder-download.svg": folderDownload,
    "文件夹-关_folder-close.svg": folderClose,
    "文件夹-删除_folder-minus.svg": folderMinus,
    "文件夹-开_folder-open.svg": folderOpen,
    "文件夹-添加_folder-plus.svg": folderPlus,
    "文件夹_folder.svg": folder,
    "文件夹_seo-folder.svg": seoFolder,
    "文件夹保护1_folder-protection-one.svg": folderProtectionOne,
    "文件夹保护_folder-protection.svg": folderProtection,
    "文件夹设置1_folder-settings-one.svg": folderSettingsOne,
    "文件夹设置_folder-settings.svg": folderSettings,
    "文件搜索1_file-search-two.svg": fileSearchTwo,
    "文件搜索_file-search-one.svg": fileSearchOne,
    "文件撤销1_file-withdrawal-one.svg": fileWithdrawalOne,
    "文件撤销_file-withdrawal.svg": fileWithdrawal,
    "文件柜_file-cabinet.svg": fileCabinet,
    "文件查找_file-search.svg": fileSearch,
    "文件添加1_file-addition-one.svg": fileAdditionOne,
    "文件添加_file-addition.svg": fileAddition,
    "文件设置1_file-settings-one.svg": fileSettingsOne,
    "文件设置_file-settings.svg": fileSettings,
    "文字_add-text-two.svg": addTextTwo,
    "文字_text.svg": text,
    "文字下划线_text-underline.svg": textUnderline,
    "文字两边对齐1_align-text-both-one.svg": alignTextBothOne,
    "文字两边对齐_align-text-both.svg": alignTextBoth,
    "文字中间对齐1_align-text-middle-one.svg": alignTextMiddleOne,
    "文字中间对齐_align-text-middle.svg": alignTextMiddle,
    "文字加粗_text-bold.svg": textBold,
    "文字右对齐_align-right-two.svg": alignRightTwo,
    "文字域_textarea.svg": textarea,
    "文字大小_add-text.svg": addText,
    "文字居中1_align-text-center-one.svg": alignTextCenterOne,
    "文字居中_align-text-center.svg": alignTextCenter,
    "文字居右1_align-text-right-one.svg": alignTextRightOne,
    "文字居右_align-text-right.svg": alignTextRight,
    "文字居左1_align-text-left-one.svg": alignTextLeftOne,
    "文字居左_align-text-left.svg": alignTextLeft,
    "文字左对齐_align-left-two.svg": alignLeftTwo,
    "文字底对齐1_align-text-bottom-one.svg": alignTextBottomOne,
    "文字底对齐_align-text-bottom.svg": alignTextBottom,
    "文字斜体_text-italic.svg": textItalic,
    "文字讯息_text-message.svg": textMessage,
    "文字识别_text-recognition.svg": textRecognition,
    "文字顶对齐1_align-text-top-one.svg": alignTextTopOne,
    "文字顶对齐_align-text-top.svg": alignTextTop,
    "文本换行-截断_text-wrap-truncation.svg": textWrapTruncation,
    "文本换行-溢出_text-wrap-overflow.svg": textWrapOverflow,
    "文本文件1_file-text-one.svg": fileTextOne,
    "文本文件_file-text.svg": fileText,
    "文本旋转-上_text-rotation-up.svg": textRotationUp,
    "文本旋转-下_text-rotation-down.svg": textRotationDown,
    "文本旋转-左_text-rotation-left.svg": textRotationLeft,
    "文本旋转-无_text-rotation-none.svg": textRotationNone,
    "文本样式_text-style-one.svg": textStyleOne,
    "文本样式_text-style.svg": textStyle,
    "文档_file-doc.svg": fileDoc,
    "文档_word.svg": word,
    "文档失败_doc-fail.svg": docFail,
    "文档成功_doc-success.svg": docSuccess,
    "文档搜索_doc-search-two.svg": docSearchTwo,
    "文档搜索_doc-search.svg": docSearch,
    "文档架子_document-folder.svg": documentFolder,
    "文档添加_doc-add.svg": docAdd,
    "文档详情_doc-detail.svg": docDetail,
    "断开连接_link-break.svg": linkBreak,
    "方向_direction.svg": direction,
    "方向标识_road-sign-both.svg": roadSignBoth,
    "方向标识_road-sign.svg": roadSign,
    "方向校准_direction-adjustment-three.svg": directionAdjustmentThree,
    "方向校准_direction-adjustment-two.svg": directionAdjustmentTwo,
    "方向校准_direction-adjustment.svg": directionAdjustment,
    "方向盘_steering-wheel.svg": steeringWheel,
    "方向键_arrow-keys.svg": arrowKeys,
    "方头端点_endpoint-flat.svg": endpointFlat,
    "方头节点_node-flat.svg": nodeFlat,
    "方形_square.svg": square,
    "旅游巴士_tour-bus.svg": tourBus,
    "旅行_journey.svg": journey,
    "旅行照_photograph.svg": photograph,
    "旋转_one-third-rotation.svg": oneThirdRotation,
    "旋转_rotate-one.svg": rotateOne,
    "旋转_rotate.svg": rotate,
    "旋转_rotation.svg": rotation,
    "旋转添加_rotating-add.svg": rotatingAdd,
    "旋风_whirlwind.svg": whirlwind,
    "旗子_flag.svg": flag,
    "无人机_drone-one.svg": droneOne,
    "无人机_drone.svg": drone,
    "无嘴脸_face-without-mouth.svg": faceWithoutMouth,
    "无序列表_unordered-list.svg": unorderedList,
    "无效提醒_remind-disable.svg": remindDisable,
    "无穷尽_endless.svg": endless,
    "无线网络_wifi.svg": wifi,
    "无语脸_expressionless-face.svg": expressionlessFace,
    "日光浴_sunbath.svg": sunbath,
    "日出_sunrise.svg": sunrise,
    "日历_calendar-dot.svg": calendarDot,
    "日历_calendar-thirty-two.svg": calendarThirtyTwo,
    "日历_calendar-thirty.svg": calendarThirty,
    "日历_calendar-three.svg": calendarThree,
    "日历_calendar.svg": calendar,
    "日志_log.svg": log,
    "日程表_schedule.svg": schedule,
    "时间_time.svg": time,
    "时间线_timeline.svg": timeline,
    "易拍_market.svg": market,
    "星号_asterisk.svg": asterisk,
    "星号键_asterisk-key.svg": asteriskKey,
    "星图_xingtu.svg": xingtu,
    "星星_star-one.svg": starOne,
    "星星_star.svg": star,
    "星星_two-triangles.svg": twoTriangles,
    "星球_planet.svg": planet,
    "显微镜_microscope-one.svg": microscopeOne,
    "显微镜_microscope.svg": microscope,
    "显示器_monitor-one.svg": monitorOne,
    "显示屏_display.svg": display,
    "显示文件1_file-display-one.svg": fileDisplayOne,
    "显示文件_file-display.svg": fileDisplay,
    "晴天_sunny.svg": sunny,
    "晶格图案_lattice-pattern.svg": latticePattern,
    "智能优化_smart-optimization.svg": smartOptimization,
    "智能手表_iwatch-one.svg": iwatchOne,
    "智能手表_iwatch.svg": iwatch,
    "智能摄像头_camera-three.svg": cameraThree,
    "智能门锁_electronic-door-lock.svg": electronicDoorLock,
    "晾衣架_hanger.svg": hanger,
    "暂停_pause-one.svg": pauseOne,
    "暂停_pause.svg": pause,
    "曲棍球_hockey.svg": hockey,
    "曲线调整_curve-adjustment.svg": curveAdjustment,
    "更多1_more-one.svg": moreOne,
    "更多2_more-two.svg": moreTwo,
    "更多3_more-three.svg": moreThree,
    "更多_more-app.svg": moreApp,
    "更多_more-four.svg": moreFour,
    "更多_more.svg": more,
    "更改_change.svg": change,
    "更新_update-rotation.svg": updateRotation,
    "最上层_bring-to-front.svg": bringToFront,
    "最下层_sent-to-back.svg": sentToBack,
    "最大值_maximum.svg": maximum,
    "最小值_min.svg": min,
    "月亮_moon.svg": moon,
    "有序列表_ordered-list.svg": orderedList,
    "朋友圈_friends-circle.svg": friendsCircle,
    "服务器_server.svg": server,
    "望远镜_telescope.svg": telescope,
    "未来大厦_future-build-one.svg": futureBuildOne,
    "未来建筑_future-build-three.svg": futureBuildThree,
    "未来魔都_future-build-two.svg": futureBuildTwo,
    "未读消息_message-unread.svg": messageUnread,
    "本地_local-pin.svg": localPin,
    "本地_local-two.svg": localTwo,
    "机器人1_robot-one.svg": robotOne,
    "机器人2_robot-two.svg": robotTwo,
    "机器人2_robot.svg": robot,
    "权限_permissions.svg": permissions,
    "材料3_material-three.svg": materialThree,
    "材质_material-two.svg": materialTwo,
    "条形图_chart-histogram-one.svg": chartHistogramOne,
    "条形图_chart-histogram-two.svg": chartHistogramTwo,
    "条形图_chart-histogram.svg": chartHistogram,
    "条形码_bar-code.svg": barCode,
    "杯子_cup-one.svg": cupOne,
    "林肯_lincoln.svg": lincoln,
    "果饮_juice.svg": juice,
    "枪靶_target-two.svg": targetTwo,
    "柠檬_lemon.svg": lemon,
    "柠檬片_orange-one.svg": orangeOne,
    "查找_find.svg": find,
    "栅栏_fence-two.svg": fenceTwo,
    "标签_label.svg": label,
    "标签_tag-one.svg": tagOne,
    "标签_tag.svg": tag,
    "标记_mark.svg": mark,
    "标题1_h2.svg": h2,
    "标题2_h3.svg": h3,
    "标题_h1.svg": h1,
    "标题级别_title-level.svg": titleLevel,
    "栏栅_fence-one.svg": fenceOne,
    "树_tree.svg": tree,
    "树叶_leaves.svg": leaves,
    "树叶_sleaves.svg": sleaves,
    "树状图_tree-diagram.svg": treeDiagram,
    "树结构_tree-list.svg": treeList,
    "树苗_sapling.svg": sapling,
    "校验-小_check-small.svg": checkSmall,
    "校验_check-one.svg": checkOne,
    "校验_check.svg": check,
    "核电厂_nuclear-plant.svg": nuclearPlant,
    "核磁共振_nmr.svg": nmr,
    "格式_format.svg": format,
    "格式刷_format-brush.svg": formatBrush,
    "桃子_peach.svg": peach,
    "桥_brdige-three.svg": brdigeThree,
    "桥_bridge-one.svg": bridgeOne,
    "桥_bridge-two.svg": bridgeTwo,
    "梨子_pear.svg": pear,
    "梯子_ladder.svg": ladder,
    "梯形_trapezoid.svg": trapezoid,
    "梳子_comb.svg": comb,
    "检查_inspection.svg": inspection,
    "检查列表_checklist.svg": checklist,
    "检测_detection.svg": detection,
    "检票机_gate-machine.svg": gateMachine,
    "棋盘_checkerboard.svg": checkerboard,
    "棒棒糖_lollipop.svg": lollipop,
    "棒球_baseball.svg": baseball,
    "棒球帽_baseball-cap.svg": baseballCap,
    "椭圆形_oval-one.svg": ovalOne,
    "椭圆爱心_oval-love-two.svg": ovalLoveTwo,
    "椭圆爱心_oval-love.svg": ovalLove,
    "椰子树_coconut-tree.svg": coconutTree,
    "榨汁机_soybean-milk-maker.svg": soybeanMilkMaker,
    "模块箭头_blocks-and-arrows.svg": blocksAndArrows,
    "横向旋转_rotation-horizontal.svg": rotationHorizontal,
    "樱桃_cherry.svg": cherry,
    "橄榄球1_rugby-one.svg": rugbyOne,
    "橄榄球_rugby.svg": rugby,
    "橙子_orange.svg": orange,
    "橙子建站_orange-station.svg": orangeStation,
    "欧洲市场_ce-marking.svg": ceMarking,
    "正向旋转_rotating-forward.svg": rotatingForward,
    "正常标签_neutral-face.svg": neutralFace,
    "正弦曲线_sinusoid.svg": sinusoid,
    "正确用户_right-user.svg": rightUser,
    "正确的_correct.svg": correct,
    "死亡之星_death-star.svg": deathStar,
    "段落截断_paragraph-cut.svg": paragraphCut,
    "段落折行_paragraph-break-two.svg": paragraphBreakTwo,
    "段落折行_paragraph-break.svg": paragraphBreak,
    "段落溢出_paragraph-unfold.svg": paragraphUnfold,
    "毒素_toxins.svg": toxins,
    "比例缩放_proportional-scaling.svg": proportionalScaling,
    "比分牌_scoreboard.svg": scoreboard,
    "比特币_bitcoin.svg": bitcoin,
    "比萨斜塔_tower-of-pisa.svg": towerOfPisa,
    "毛巾_towel.svg": towel,
    "毛衣_sweater.svg": sweater,
    "民宿_homestay.svg": homestay,
    "气泡图_bubble-chart.svg": bubbleChart,
    "气球_party-balloon.svg": partyBalloon,
    "水位线_water-level.svg": waterLevel,
    "水壶_kettle-one.svg": kettleOne,
    "水平上对齐_alignment-horizontal-top.svg": alignmentHorizontalTop,
    "水平下对齐_alignment-horizontal-bottom.svg": alignmentHorizontalBottom,
    "水平分布_distribute-horizontally.svg": distributeHorizontally,
    "水平对齐_align-horizontally.svg": alignHorizontally,
    "水平居中_margin-one.svg": marginOne,
    "水平居中对齐2_align-horizontal-center-two.svg": alignHorizontalCenterTwo,
    "水平居中对齐_alignment-horizontal-center.svg": alignmentHorizontalCenter,
    "水平居中对齐_horizontally-centered.svg": horizontallyCentered,
    "水平拖动_sliding-horizontal.svg": slidingHorizontal,
    "水平整理_horizontal-tidy-up.svg": horizontalTidyUp,
    "水平校准_level-adjustment.svg": levelAdjustment,
    "水平翻转_flip-horizontally.svg": flipHorizontally,
    "水平间距_horizontal-spacing-between-items.svg": horizontalSpacingBetweenItems,
    "水平间距分布_distribute-horizontal-spacing.svg": distributeHorizontalSpacing,
    "水果罐头_canned-fruit.svg": cannedFruit,
    "水球1_waterpolo-one.svg": waterpoloOne,
    "水球_waterpolo.svg": waterpolo,
    "水电费_water-rate-two.svg": waterRateTwo,
    "水缺乏_water-no.svg": waterNo,
    "水费_water-rate.svg": waterRate,
    "水资源_water.svg": water,
    "汇聚网关_converging-gateway.svg": convergingGateway,
    "汉堡_hamburger-one.svg": hamburgerOne,
    "汉堡_hamburger.svg": hamburger,
    "汉堡图标_hamburger-button.svg": hamburgerButton,
    "汽油_petrol.svg": petrol,
    "汽车_car.svg": car,
    "汽车导航_gps.svg": gps,
    "汽车电瓶_car-battery.svg": carBattery,
    "沙发_sofa-two.svg": sofaTwo,
    "沙发_sofa.svg": sofa,
    "沙尘暴_sandstorm.svg": sandstorm,
    "沙漏_hourglass.svg": hourglass,
    "沙漏满_hourglass-full.svg": hourglassFull,
    "沙漏空_hourglass-null.svg": hourglassNull,
    "沟通_communication.svg": communication,
    "沮丧_weary-face.svg": wearyFace,
    "油管_youtobe.svg": youtobe,
    "法案_bill.svg": bill,
    "泡泡_soap-bubble.svg": soapBubble,
    "波纹_ripple.svg": ripple,
    "注意_attention.svg": attention,
    "泰姬陵_taj-mahal.svg": tajMahal,
    "泳装_swimsuit.svg": swimsuit,
    "洗手_handwashing.svg": handwashing,
    "洗手液_handwashing-fluid.svg": handwashingFluid,
    "洗牌_shuffle-one.svg": shuffleOne,
    "洗牌_shuffle.svg": shuffle,
    "洗衣机1_washing-machine-one.svg": washingMachineOne,
    "洗衣机_washing-machine.svg": washingMachine,
    "洗面奶_facial-cleanser.svg": facialCleanser,
    "活动源_activity-source.svg": activitySource,
    "流水线_assembly-line.svg": assemblyLine,
    "浏览器-chrome_browser-chrome.svg": chromeBrowserChrome,
    "浏览器-safari_browser-safari.svg": safariBrowserSafari,
    "浏览器_browser.svg": browser,
    "海滩雨伞_beach-umbrella.svg": beachUmbrella,
    "消息_message-one.svg": messageOne,
    "消极动态_negative-dynamics.svg": negativeDynamics,
    "消费_consume.svg": consume,
    "涨幅_increase.svg": increase,
    "淋浴喷头_shower-head.svg": showerHead,
    "淘宝_taobao.svg": taobao,
    "添加_add-four.svg": addFour,
    "添加_add-one.svg": addOne,
    "添加_add-three.svg": addThree,
    "添加_add.svg": add,
    "添加人群_people-plus-one.svg": peoplePlusOne,
    "添加人群_people-plus.svg": peoplePlus,
    "添加列表_list-add.svg": listAdd,
    "添加同级条目_add-item.svg": addItem,
    "添加子条目_add-subset.svg": addSubset,
    "添加用户_add-user.svg": addUser,
    "添加购物车_shopping-cart-add.svg": shoppingCartAdd,
    "添加音乐_add-music.svg": addMusic,
    "清除_clear.svg": clear,
    "清除格式_clear-format.svg": clearFormat,
    "温室房_green-house.svg": greenHouse,
    "温度计_thermometer.svg": thermometer,
    "游戏_game-two.svg": gameTwo,
    "游戏_game.svg": game,
    "游戏手柄_game-handle.svg": gameHandle,
    "游戏手柄_game-three.svg": gameThree,
    "游戏摇杆_joystick.svg": joystick,
    "游戏机_game-console.svg": gameConsole,
    "游戏机_game-ps.svg": gamePs,
    "游戏表情_game-emoji.svg": gameEmoji,
    "游泳圈_swimming-ring.svg": swimmingRing,
    "游泳池_swimming-pool.svg": swimmingPool,
    "溜冰鞋_rollerskates.svg": rollerskates,
    "溜冰鞋_skating.svg": skating,
    "溜溜球_tire-swing.svg": tireSwing,
    "滑冰鞋_clothes-skates.svg": clothesSkates,
    "滑板_skate.svg": skate,
    "滑雪_skiing-nordic.svg": skiingNordic,
    "漂浮圈_float.svg": float,
    "演出_performance.svg": performance,
    "潜水_diving.svg": diving,
    "潜水瓶_diving-bottle.svg": divingBottle,
    "潜水装_diving-suit.svg": divingSuit,
    "激萌_faceu.svg": faceu,
    "瀑布流横向_waterfalls-h.svg": waterfallsH,
    "瀑布流纵向_waterfalls-v.svg": waterfallsV,
    "火堆_fire-two.svg": fireTwo,
    "火山小视频_vigo.svg": vigo,
    "火炬_torch.svg": torch,
    "火热_fire.svg": fire,
    "火箭_rocket-one.svg": rocketOne,
    "火箭_rocket.svg": rocket,
    "火锅_chafing-dish-one.svg": chafingDishOne,
    "火锅_hot-pot-one.svg": hotPotOne,
    "火锅_hot-pot.svg": hotPot,
    "火鸡_turkey.svg": turkey,
    "灭火器_fire-extinguisher-one.svg": fireExtinguisherOne,
    "灭火器_fire-extinguisher.svg": fireExtinguisher,
    "灯塔_light-house.svg": lightHouse,
    "炸薯条_french-fries.svg": frenchFries,
    "点_dot.svg": dot,
    "点击_click-tap-two.svg": clickTapTwo,
    "点击_click-tap.svg": clickTap,
    "点击_click.svg": click,
    "点击_press.svg": press,
    "点击缩起_click-to-fold.svg": clickToFold,
    "烟筒_chimney.svg": chimney,
    "烧烤_barbecue.svg": barbecue,
    "热气球_hot-air-balloon.svg": hotAirBalloon,
    "热水壶_kettle.svg": kettle,
    "烹饪_cooking.svg": cooking,
    "煎鸡蛋_egg.svg": egg,
    "照片_pic.svg": pic,
    "煮锅_cooking-pot.svg": cookingPot,
    "煮饭_cook.svg": cook,
    "熨斗_iron-three.svg": ironThree,
    "熨斗_iron-two.svg": ironTwo,
    "熨斗_iron.svg": iron,
    "熨斗坏了_iron-disable.svg": ironDisable,
    "燕子_swallow.svg": swallow,
    "燕窝_nests.svg": nests,
    "爆米花_popcorn-one.svg": popcornOne,
    "爆米花_popcorn.svg": popcorn,
    "版权符号_copyright.svg": copyright,
    "牙齿_teeth.svg": teeth,
    "牛奶_milk-one.svg": milkOne,
    "牛奶_milk.svg": milk,
    "牛油果_avocado-one.svg": avocadoOne,
    "牛油果_avocado.svg": avocado,
    "牛角面包_croissant.svg": croissant,
    "牵手_holding-hands.svg": holdingHands,
    "特效_effects.svg": effects,
    "玛雅_maya.svg": maya,
    "环形图_chart-ring.svg": chartRing,
    "理发刷_barber-brush.svg": barberBrush,
    "理发剪_barber-clippers.svg": barberClippers,
    "理念共享_concept-sharing.svg": conceptSharing,
    "理财_financing-one.svg": financingOne,
    "理财_financing.svg": financing,
    "瓶子_bottle-two.svg": bottleTwo,
    "瓶装_bottle-three.svg": bottleThree,
    "甜甜圈_doughnut.svg": doughnut,
    "生日蛋糕_birthday-cake.svg": birthdayCake,
    "生气_angry-face.svg": angryFace,
    "用户_user.svg": user,
    "用户上传_people-upload.svg": peopleUpload,
    "用户下载_people-download.svg": peopleDownload,
    "用户互传_user-to-user-transmission.svg": userToUserTransmission,
    "用户定位_user-positioning.svg": userPositioning,
    "电位器_potentiometer.svg": potentiometer,
    "电台_fm.svg": fm,
    "电子秤_balance-one.svg": balanceOne,
    "电子秤_industrial-scales.svg": industrialScales,
    "电子签_dianziqian.svg": dianziqian,
    "电子表_digital-watches.svg": digitalWatches,
    "电子锁关_electronic-locks-close.svg": electronicLocksClose,
    "电子锁开_electronic-locks-open.svg": electronicLocksOpen,
    "电影_movie.svg": movie,
    "电拨拨出_phone-outgoing-one.svg": phoneOutgoingOne,
    "电拨拨出_phone-outgoing.svg": phoneOutgoing,
    "电梯_elevator.svg": elevator,
    "电池_battery-working-one.svg": batteryWorkingOne,
    "电池充电_battery-charge.svg": batteryCharge,
    "电池没电_battery-empty.svg": batteryEmpty,
    "电池满电_battery-full.svg": batteryFull,
    "电池运行_battery-working.svg": batteryWorking,
    "电波_electric-wave.svg": electricWave,
    "电波_waves.svg": waves,
    "电烤箱_oven.svg": oven,
    "电熨斗_electric-iron.svg": electricIron,
    "电脑_computer.svg": computer,
    "电视_tv-one.svg": tvOne,
    "电视_tv.svg": tv,
    "电话2_phone-two.svg": phoneTwo,
    "电话_phone-one.svg": phoneOne,
    "电话_phone-telephone.svg": phoneTelephone,
    "电话亭_phone-booth.svg": phoneBooth,
    "电话关闭_phone-off.svg": phoneOff,
    "电话卡_sim.svg": sim,
    "电话呼叫_phone-call.svg": phoneCall,
    "电话拨入_phone-incoming-one.svg": phoneIncomingOne,
    "电话拨入_phone-incoming.svg": phoneIncoming,
    "电话错过_phone-missed.svg": phoneMissed,
    "电阻器_resistor.svg": resistor,
    "男儿童车_boy-stroller.svg": boyStroller,
    "男士外套_men-jacket.svg": menJacket,
    "男孩1_boy-one.svg": boyOne,
    "男孩2_boy-two.svg": boyTwo,
    "男孩_boy.svg": boy,
    "男性_male.svg": male,
    "留声机_phonograph.svg": phonograph,
    "番茄_tomato.svg": tomato,
    "番茄小说_fanqiexiaoshuo.svg": fanqiexiaoshuo,
    "病菌_germs.svg": germs,
    "瘦身_thin.svg": thin,
    "百分号_percentage.svg": percentage,
    "皇冠_crown-two.svg": crownTwo,
    "皇冠_crown.svg": crown,
    "皇冠帽_crown-three.svg": crownThree,
    "监控录像_camera-four.svg": cameraFour,
    "监控摄像头_monitor-camera.svg": monitorCamera,
    "监控摄像头_surveillance-cameras-one.svg": surveillanceCamerasOne,
    "监控摄像头_surveillance-cameras-two.svg": surveillanceCamerasTwo,
    "监控摄像头_surveillance-cameras.svg": surveillanceCameras,
    "监狱_prison.svg": prison,
    "盒子_box.svg": box,
    "直剃刀_straight-razor.svg": straightRazor,
    "直方图_histogram.svg": histogram,
    "直角形_right-angle.svg": rightAngle,
    "相交选择_intersect-selection.svg": intersectSelection,
    "相机_camera-two.svg": cameraTwo,
    "相机_camera.svg": camera,
    "相邻条目_adjacent-item.svg": adjacentItem,
    "眨一个眼睛_winking-face-with-open-eyes.svg": winkingFaceWithOpenEyes,
    "眨眼睛_winking-face.svg": winkingFace,
    "眼眉_eyebrow.svg": eyebrow,
    "眼睛_eyes.svg": eyes,
    "眼镜_glasses-one.svg": glassesOne,
    "眼镜_glasses.svg": glasses,
    "睡眠_sleep.svg": sleep,
    "睡觉_sleep-one.svg": sleepOne,
    "睫毛膏_mascara.svg": mascara,
    "瞄准_aiming.svg": aiming,
    "矩形1_rectangle-one.svg": rectangleOne,
    "矩形_rectangle.svg": rectangle,
    "矩形撕裂_rectangle-tear.svg": rectangleTear,
    "矩形椎体_rectangular-vertebra.svg": rectangularVertebra,
    "矩形段落_paragraph-rectangle.svg": paragraphRectangle,
    "短信1_messages-one.svg": messagesOne,
    "短信_messages.svg": messages,
    "短裙_short-skirt.svg": shortSkirt,
    "短裤_clothes-pants-short.svg": clothesPantsShort,
    "短裤_clothes-short-sleeve.svg": clothesShortSleeve,
    "短裤_shorts.svg": shorts,
    "硬盘_hard-disk.svg": hardDisk,
    "碗_bowl-one.svg": bowlOne,
    "磁带_tape.svg": tape,
    "磁带_type-drive.svg": typeDrive,
    "磁盘_disk.svg": disk,
    "磁铁_magnet.svg": magnet,
    "礼服长裙_full-dress-longuette.svg": fullDressLonguette,
    "礼物_gift.svg": gift,
    "礼物盒_gift-box.svg": giftBox,
    "礼花_fireworks.svg": fireworks,
    "神经_neural.svg": neural,
    "票_ticket-one.svg": ticketOne,
    "票务检查_tickets-checked.svg": ticketsChecked,
    "禁止_forbid.svg": forbid,
    "禁止拍照_no-shooting.svg": noShooting,
    "禁用文件夹1_folder-block-one.svg": folderBlockOne,
    "禁用文件夹_folder-block.svg": folderBlock,
    "秒表_stopwatch.svg": stopwatch,
    "积极动态_positive-dynamics.svg": positiveDynamics,
    "移到前面_bring-to-front-one.svg": bringToFrontOne,
    "移到后面_send-to-back.svg": sendToBack,
    "移到底部_minus-the-bottom.svg": minusTheBottom,
    "移到顶部_minus-the-top.svg": minusTheTop,
    "移动_move-in-one.svg": moveInOne,
    "移动_move-one.svg": moveOne,
    "移动_move.svg": move,
    "移动游戏机_game-console-one.svg": gameConsoleOne,
    "移动硬盘_hard-disk-one.svg": hardDiskOne,
    "移除文件1_file-removal-one.svg": fileRemovalOne,
    "移除文件_file-removal.svg": fileRemoval,
    "程序问题_bug.svg": bug,
    "空手_empty.svg": empty,
    "空调_air-conditioning.svg": airConditioning,
    "穿山甲_pangle.svg": pangle,
    "立体声_stereo-one.svg": stereoOne,
    "立体透视_stereo-perspective.svg": stereoPerspective,
    "站点加速_whole-site-accelerator.svg": wholeSiteAccelerator,
    "竞技场_arena.svg": arena,
    "童车_steoller.svg": steoller,
    "端点位移_endpoint-displacement.svg": endpointDisplacement,
    "笑眯眼_grinning-face-with-squinting-eyes.svg": grinningFaceWithSquintingEyes,
    "笑眯眼_relieved-face.svg": relievedFace,
    "笑眯眼_smiling-face-with-squinting-eyes.svg": smilingFaceWithSquintingEyes,
    "笑脸_smiling-face.svg": smilingFace,
    "笔记_notes.svg": notes,
    "笔记本_laptop.svg": laptop,
    "笔记本_notebook-one.svg": notebookOne,
    "笔记本_notebook.svg": notebook,
    "笔记本和笔_notebook-and-pen.svg": notebookAndPen,
    "笔记本电脑_laptop-computer.svg": laptopComputer,
    "符号_symbol.svg": symbol,
    "第一_first.svg": first,
    "等比_equal-ratio.svg": equalRatio,
    "等比缩放_scale.svg": scale,
    "筛选1_filter-one.svg": filterOne,
    "筛选_filter.svg": filter,
    "筷子叉子_chopsticks-fork.svg": chopsticksFork,
    "简单_easy.svg": easy,
    "管理箱_dropbox.svg": dropbox,
    "箭头上_arrow-up.svg": arrowUp,
    "箭头下_arrow-down.svg": arrowDown,
    "箭头右_arrow-right.svg": arrowRight,
    "箭头右上_arrow-right-up.svg": arrowRightUp,
    "箭头右下_arrow-right-down.svg": arrowRightDown,
    "箭头左_arrow-left.svg": arrowLeft,
    "箭头左上_arrow-left-up.svg": arrowLeftUp,
    "箭头左下_arrow-left-down.svg": arrowLeftDown,
    "篮球_basketball.svg": basketball,
    "篮球场_court.svg": court,
    "篮球服_basketball-clothes.svg": basketballClothes,
    "篮球架1_basketball-one.svg": basketballOne,
    "篮球架_basketball-stand.svg": basketballStand,
    "米饭_rice.svg": rice,
    "粉底液_foundation-makeup.svg": foundationMakeup,
    "精子_sperm.svg": sperm,
    "精灵球1_pokeball-one.svg": pokeballOne,
    "精灵球_baokemeng.svg": baokemeng,
    "糖果_candy.svg": candy,
    "系统_system.svg": system,
    "素材_material.svg": material,
    "红包_red-envelope.svg": redEnvelope,
    "红包_red-envelopes.svg": redEnvelopes,
    "红十字_red-cross.svg": redCross,
    "级别_level.svg": level,
    "纪念碑_monument-one.svg": monumentOne,
    "纪念碑_monument-two.svg": monumentTwo,
    "纯天然_pure-natural.svg": pureNatural,
    "纵向旋转_rotation-vertical.svg": rotationVertical,
    "纸尿裤_clothes-diapers.svg": clothesDiapers,
    "纸船_paper-ship.svg": paperShip,
    "纹理_texture-two.svg": textureTwo,
    "纹理_texture.svg": texture,
    "纹路_process-line.svg": processLine,
    "线上办公室_online-meeting.svg": onlineMeeting,
    "线索_clue.svg": clue,
    "线轮_reel.svg": reel,
    "组件_components.svg": components,
    "组件_figma-component.svg": figmaComponent,
    "细胞_cell.svg": cell,
    "终止文件_termination-file.svg": terminationFile,
    "终端_terminal.svg": terminal,
    "经期_period.svg": period,
    "绘制屏_painted-screen.svg": paintedScreen,
    "继续_go-on.svg": goOn,
    "维恩图_viencharts.svg": viencharts,
    "绿色新能源_green-new-energy.svg": greenNewEnergy,
    "缆车_cable-car.svg": cableCar,
    "编辑1_edit-one.svg": editOne,
    "编辑2_edit-two.svg": editTwo,
    "编辑_edit.svg": edit,
    "编辑_editor.svg": editor,
    "编辑_repair.svg": repair,
    "编辑姓名_edit-name.svg": editName,
    "编辑撰写_writing-fluently.svg": writingFluently,
    "编辑文件1_file-editing-one.svg": fileEditingOne,
    "编辑文件_file-editing.svg": fileEditing,
    "缩小_zoom-out.svg": zoomOut,
    "缩放_zoom-internal.svg": zoomInternal,
    "网口关_ethernet-off.svg": ethernetOff,
    "网口开_ethernet-on.svg": ethernetOn,
    "网格2_grid-two.svg": gridTwo,
    "网格3_grid-three.svg": gridThree,
    "网球_tennis.svg": tennis,
    "网络摄像头_webcam.svg": webcam,
    "网络节点_network-tree.svg": networkTree,
    "美元_dollar.svg": dollar,
    "美化_optimize.svg": optimize,
    "美容_makeups.svg": makeups,
    "美容仪_beauty-instrument.svg": beautyInstrument,
    "美颜_beauty.svg": beauty,
    "羽毛球_badminton.svg": badminton,
    "翻译_translate.svg": translate,
    "翻译_translation.svg": translation,
    "翻转笑脸_upside-down-face.svg": upsideDownFace,
    "翻转镜头_flip-camera.svg": flipCamera,
    "翼装飞行_wingsuit-flying.svg": wingsuitFlying,
    "耳机_headset-one.svg": headsetOne,
    "耳机_headset-two.svg": headsetTwo,
    "耳机_headset.svg": headset,
    "耳机声音_headphone-sound.svg": headphoneSound,
    "肌肉_muscle.svg": muscle,
    "肠胃_gastrointestinal.svg": gastrointestinal,
    "股市_stock-market.svg": stockMarket,
    "育儿书_parenting-book.svg": parentingBook,
    "肺_lung.svg": lung,
    "肾_renal.svg": renal,
    "背包_backpack.svg": backpack,
    "背带_baby-sling.svg": babySling,
    "背心_vest.svg": vest,
    "背景颜色_background-color.svg": backgroundColor,
    "胜利_yep.svg": yep,
    "胡子_english-mustache.svg": englishMustache,
    "胡萝卜_carrot.svg": carrot,
    "胶手套_glove.svg": glove,
    "胸部_chest.svg": chest,
    "能源插座_energy-socket.svg": energySocket,
    "脑图_mind-mapping.svg": mindMapping,
    "脚掌_baby-feet.svg": babyFeet,
    "脸书_facebook-one.svg": facebookOne,
    "脸书_facebook.svg": facebook,
    "脸粉_face-powder.svg": facePowder,
    "腰带_belt.svg": belt,
    "腹部_abdominal.svg": abdominal,
    "自动列宽_auto-line-width.svg": autoLineWidth,
    "自动宽度1_auto-width-one.svg": autoWidthOne,
    "自动宽度_auto-width.svg": autoWidth,
    "自动行高_auto-line-height.svg": autoLineHeight,
    "自动高度1_auto-height-one.svg": autoHeightOne,
    "自定对焦_auto-focus.svg": autoFocus,
    "自拍杆_selfie.svg": selfie,
    "自然模式_natural-mode.svg": naturalMode,
    "自行车_bike.svg": bike,
    "自选_optional.svg": optional,
    "航海_cruise.svg": cruise,
    "航空_aviation.svg": aviation,
    "航行_sailing.svg": sailing,
    "船_ship.svg": ship,
    "色卡_color-card.svg": colorCard,
    "节能灯_lamp.svg": lamp,
    "芯片_chip.svg": chip,
    "芯片_cpu.svg": cpu,
    "英文_english.svg": english,
    "苹果_apple-one.svg": appleOne,
    "苹果_apple.svg": apple,
    "苹果手机_iphone.svg": iphone,
    "苹果智能手表_iwatch-two.svg": iwatchTwo,
    "苹果电脑iMac_i-mac.svg": imacIMac,
    "茄子_eggplant.svg": eggplant,
    "茶_tea.svg": tea,
    "茶壶_teapot.svg": teapot,
    "茶杯4_cup-four.svg": cupFour,
    "草帽_straw-hat.svg": strawHat,
    "药丸_pills.svg": pills,
    "药罐_medicine-bottle.svg": medicineBottle,
    "菜刀_kitchen-knife.svg": kitchenKnife,
    "菜篮子_vegetable-basket.svg": vegetableBasket,
    "菠萝_pineapple.svg": pineapple,
    "菱形1_diamond-one.svg": diamondOne,
    "菱形2_diamond-two.svg": diamondTwo,
    "菱形3_diamond-three.svg": diamondThree,
    "萝卜_radish.svg": radish,
    "营养_nutrition.svg": nutrition,
    "蓝牙_bluetooth.svg": bluetooth,
    "虚拟现实眼镜_virtual-reality-glasses.svg": virtualRealityGlasses,
    "蚕豆_vicia-faba.svg": viciaFaba,
    "蛋糕_cake-five.svg": cakeFive,
    "蛋糕_cake-four.svg": cakeFour,
    "蛋糕_cake-one.svg": cakeOne,
    "蛋糕_cake-three.svg": cakeThree,
    "蛋糕_cake-two.svg": cakeTwo,
    "蛋糕_cake.svg": cake,
    "蜂蜜_honey-one.svg": honeyOne,
    "蜂蜜_honey.svg": honey,
    "蜡烛沐浴_spa-candle.svg": spaCandle,
    "螃蟹_crab.svg": crab,
    "融资2_financing-two.svg": financingTwo,
    "行内公式_block.svg": block,
    "行李延误_baggage-delay.svg": baggageDelay,
    "行李箱_luggage.svg": luggage,
    "行李箱_trunk.svg": trunk,
    "行高度_row-height.svg": rowHeight,
    "衣架_coat-hanger.svg": coatHanger,
    "衣架_hanger-one.svg": hangerOne,
    "衣架_hanger-two.svg": hangerTwo,
    "表情信息_message-emoji.svg": messageEmoji,
    "表格_excel-one.svg": excelOne,
    "表格_form.svg": form,
    "表格_table-file.svg": tableFile,
    "表格_table.svg": table,
    "袜子_socks.svg": socks,
    "裁切_cutting-one.svg": cuttingOne,
    "裁切_cutting.svg": cutting,
    "裁剪_tailoring.svg": tailoring,
    "裁剪放大_tailoring-two.svg": tailoringTwo,
    "裤子_baby-pants.svg": babyPants,
    "裤子_clothes-pants.svg": clothesPants,
    "西洋棋_chess.svg": chess,
    "西瓜_watermelon-one.svg": watermelonOne,
    "西瓜_watermelon.svg": watermelon,
    "西瓜视频_xigua.svg": xigua,
    "西装_clothes-suit.svg": clothesSuit,
    "观测仪_land-surveying.svg": landSurveying,
    "视频_video-one.svg": videoOne,
    "视频_video-two.svg": videoTwo,
    "视频_video.svg": video,
    "视频文件_video-file.svg": videoFile,
    "视频电话_facetime.svg": facetime,
    "视频电话_phone-video-call.svg": phoneVideoCall,
    "角度_rotation-one.svg": rotationOne,
    "解组_ungroup.svg": ungroup,
    "解锁_unlock.svg": unlock,
    "解除组件_figma-reset-instance.svg": figmaResetInstance,
    "触电笔_electronic-pen.svg": electronicPen,
    "警报_alarm.svg": alarm,
    "警示文件1_file-tips-one.svg": fileTipsOne,
    "警示文件_file-tips.svg": fileTips,
    "计划_plan.svg": plan,
    "计时器_stopwatch-start.svg": stopwatchStart,
    "计时器_timer.svg": timer,
    "计算_arithmetic-one.svg": arithmeticOne,
    "计算_arithmetic.svg": arithmetic,
    "计算器_calculator-one.svg": calculatorOne,
    "计算器_calculator.svg": calculator,
    "计算机_computer-one.svg": computerOne,
    "计量杯_measuring-cup.svg": measuringCup,
    "订书机_stapler.svg": stapler,
    "订单_order.svg": order,
    "订阅_rss.svg": rss,
    "认可_okay.svg": okay,
    "记事本_notepad.svg": notepad,
    "记忆卡_memory-card.svg": memoryCard,
    "设备_devices.svg": devices,
    "设置_setting-one.svg": settingOne,
    "设置_setting-three.svg": settingThree,
    "设置_setting-two.svg": settingTwo,
    "设置_setting.svg": setting,
    "设置配置_setting-config.svg": settingConfig,
    "访达_mac-finder.svg": macFinder,
    "证书_certificate.svg": certificate,
    "评论_comment-one.svg": commentOne,
    "评论_comment.svg": comment,
    "评论_comments.svg": comments,
    "试管_cuvette.svg": cuvette,
    "试管_test-tube.svg": testTube,
    "试管_vial.svg": vial,
    "话题_topic.svg": topic,
    "话题讨论_topic-discussion.svg": topicDiscussion,
    "详情列表_view-list.svg": viewList,
    "详情查看模式_view-grid-detail.svg": viewGridDetail,
    "语音信息_voice-message.svg": voiceMessage,
    "语音信息_voicemail.svg": voicemail,
    "语音文字_voice-input.svg": voiceInput,
    "请勿打扫_hotel-do-not-clean.svg": hotelDoNotClean,
    "请打扫_hotel-please-clean.svg": hotelPleaseClean,
    "课堂_classroom.svg": classroom,
    "调色盘_platte.svg": platte,
    "谷歌_google.svg": google,
    "谷歌广告_google-ads.svg": googleAds,
    "豌豆角_peas.svg": peas,
    "贝塞尔曲线_bezier-curve.svg": bezierCurve,
    "货币兑换_exchange.svg": exchange,
    "货币流通_currency.svg": currency,
    "货车_truck.svg": truck,
    "购买_buy.svg": buy,
    "购物袋_mall-bag.svg": mallBag,
    "购物袋_shopping-bag.svg": shoppingBag,
    "购物车1_shopping-cart-one.svg": shoppingCartOne,
    "购物车_shopping-cart.svg": shoppingCart,
    "购物车_shopping.svg": shopping,
    "贴纸_stickers.svg": stickers,
    "资金运营平台_zijinyunying.svg": zijinyunying,
    "赞_good-two.svg": goodTwo,
    "赞_thumbs-up.svg": thumbsUp,
    "趋势_trend-two.svg": trendTwo,
    "趋势_trend.svg": trend,
    "趋势上升_trending-up.svg": trendingUp,
    "趋势下降_trending-down.svg": trendingDown,
    "足球1_soccer-one.svg": soccerOne,
    "足球_football.svg": football,
    "足球_soccer.svg": soccer,
    "跑步机1_treadmill-one.svg": treadmillOne,
    "跑步机_treadmill.svg": treadmill,
    "路由器_router-one.svg": routerOne,
    "路由器_router.svg": router,
    "路锥_road-cone.svg": roadCone,
    "跳绳_rope-skipping-one.svg": ropeSkippingOne,
    "跳绳_rope-skipping.svg": ropeSkipping,
    "踩_bad-two.svg": badTwo,
    "踩_thumbs-down.svg": thumbsDown,
    "身份证_id-card-h.svg": idCardH,
    "身份证_id-card-v.svg": idCardV,
    "车库_garage.svg": garage,
    "车载座_baby-car-seat.svg": babyCarSeat,
    "转入_income.svg": income,
    "转出_expenses.svg": expenses,
    "转变_transform.svg": transform,
    "转换文件1_file-conversion-one.svg": fileConversionOne,
    "转换文件_file-conversion.svg": fileConversion,
    "转换文件夹1_folder-conversion-one.svg": folderConversionOne,
    "转换文件夹_folder-conversion.svg": folderConversion,
    "转机_transfer.svg": transfer,
    "轮播_carousel.svg": carousel,
    "轮播视频_carousel-video.svg": carouselVideo,
    "轮椅_wheelchair.svg": wheelchair,
    "轻会员_light-member.svg": lightMember,
    "轻微沮丧_slightly-frowning-face-whit-open-mouth.svg": slightlyFrowningFaceWhitOpenMouth,
    "轻颜相机_ulikecam.svg": ulikecam,
    "辅助座椅_booster-car-seat.svg": boosterCarSeat,
    "辐射_radiation.svg": radiation,
    "输入_incoming.svg": incoming,
    "输入键盘_enter-the-keyboard.svg": enterTheKeyboard,
    "辣椒_chili.svg": chili,
    "运动_sport.svg": sport,
    "运动相机_gopro.svg": gopro,
    "运动裤_clothes-pants-sweat.svg": clothesPantsSweat,
    "运送车_transport.svg": transport,
    "返回_return.svg": returns,
    "进入_login.svg": login,
    "进出口_import-and-export.svg": importAndExport,
    "进度1_pie-one.svg": pieOne,
    "进度2_pie-two.svg": pieTwo,
    "进度3_pie-three.svg": pieThree,
    "进度4_pie-four.svg": pieFour,
    "进度5_pie-five.svg": pieFive,
    "进度6_pie-six.svg": pieSix,
    "进度7_pie-seven.svg": pieSeven,
    "进度_pie.svg": pie,
    "连体衣_onesies.svg": onesies,
    "连体衣_romper.svg": romper,
    "连接_connection.svg": connection,
    "连接地址1_connect-address-one.svg": connectAddressOne,
    "连接地址2_connect-address-two.svg": connectAddressTwo,
    "连接点_connection-point.svg": connectionPoint,
    "连接箭头_connection-arrow.svg": connectionArrow,
    "迪拜大厦_dubai.svg": dubai,
    "追波_dribble.svg": dribble,
    "追踪_trace.svg": trace,
    "退出_logout.svg": logout,
    "退出文件夹1_folder-withdrawal-one.svg": folderWithdrawalOne,
    "退出文件夹_folder-withdrawal.svg": folderWithdrawal,
    "送货车_transporter.svg": transporter,
    "逆向旋转_reverse-rotation.svg": reverseRotation,
    "逆向运行_reverse-operation-out.svg": reverseOperationOut,
    "选中_selected.svg": selected,
    "选中焦点_selected-focus.svg": selectedFocus,
    "透视_perspective.svg": perspective,
    "通勤包_commuter-bag.svg": commuterBag,
    "通讯录_address-book.svg": addressBook,
    "速度_speed-one.svg": speedOne,
    "速度_speed.svg": speed,
    "道路_road.svg": road,
    "遥控器_remote-control-one.svg": remoteControlOne,
    "遥控器_remote-control.svg": remoteControl,
    "遮罩_figma-mask.svg": figmaMask,
    "遮罩_mask-two.svg": maskTwo,
    "遮阳篷_sunshade.svg": sunshade,
    "邮件1_maill-one.svg": maillOne,
    "邮件_mail.svg": mail,
    "邮件下载_email-down.svg": emailDown,
    "邮件下载_mail-download.svg": mailDownload,
    "邮件删除_email-delect.svg": emailDelect,
    "邮件包_mail-package.svg": mailPackage,
    "邮件发送失败_email-fail.svg": emailFail,
    "邮件发送成功_email-successfully.svg": emailSuccessfully,
    "邮件安全_email-security.svg": emailSecurity,
    "邮件屏蔽_email-block.svg": emailBlock,
    "邮件打开_mail-unpacking.svg": mailUnpacking,
    "邮件推送_email-push.svg": emailPush,
    "邮件搜索_email-search.svg": emailSearch,
    "邮件查阅_mail-review.svg": mailReview,
    "邮件符号_at-sign.svg": atSign,
    "邮件编辑_mail-edit.svg": mailEdit,
    "邮件锁定_email-lock.svg": emailLock,
    "邮票_stamp.svg": stamp,
    "配置_config.svg": config,
    "酒店_hotel.svg": hotel,
    "酒瓶_bottle-one.svg": bottleOne,
    "酷的_cool.svg": cool,
    "重新_redo.svg": redo,
    "重新定位_repositioning.svg": repositioning,
    "重新播放_replay-music.svg": replayMusic,
    "重点文件1_file-focus-one.svg": fileFocusOne,
    "重点文件_file-focus.svg": fileFocus,
    "重装_reload.svg": reload,
    "重金属_heavy-metal.svg": heavyMetal,
    "野营_camp.svg": camp,
    "金字塔_pyramid-one.svg": pyramidOne,
    "金字塔_pyramid.svg": pyramid,
    "金牌_gold-medal-two.svg": goldMedalTwo,
    "金牌_gold-medal.svg": goldMedal,
    "金融_finance.svg": finance,
    "钉鞋_spikedshoes.svg": spikedshoes,
    "钞票_paper-money-two.svg": paperMoneyTwo,
    "钞票_paper-money.svg": paperMoney,
    "钟楼_clock-tower.svg": clockTower,
    "钢琴_piano.svg": piano,
    "钥匙_key.svg": key,
    "钥匙孔_keyhole.svg": keyhole,
    "钱包_wallet-one.svg": walletOne,
    "钱包_wallet-two.svg": walletTwo,
    "钱包_wallet.svg": wallet,
    "钻戒_diamond-ring.svg": diamondRing,
    "钻石_diamond.svg": diamond,
    "钻石_diamonds.svg": diamonds,
    "钻石项链_diamond-necklace.svg": diamondNecklace,
    "铁勺_spoon.svg": spoon,
    "铁路_railway.svg": railway,
    "铁铲_shovel.svg": shovel,
    "铁锅_pot.svg": pot,
    "铁锤_hammer-and-anvil.svg": hammerAndAnvil,
    "铲子_shovel-one.svg": shovelOne,
    "银行_bank.svg": bank,
    "银行卡_bank-card-one.svg": bankCardOne,
    "银行卡_bank-card-two.svg": bankCardTwo,
    "银行卡_bank-card.svg": bankCard,
    "银行转账_bank-transfer.svg": bankTransfer,
    "链接4_link-four.svg": linkFour,
    "链接_connect.svg": connect,
    "链接_deeplink.svg": deeplink,
    "链接_link-one.svg": linkOne,
    "链接_link-three.svg": linkThree,
    "链接_link-two.svg": linkTwo,
    "链接_link.svg": link,
    "链接中断_link-interrupt.svg": linkInterrupt,
    "链接断开_unlink.svg": unlink,
    "销售_sales-report.svg": salesReport,
    "锁定_lock.svg": lock,
    "错误_big-x.svg": bigX,
    "错误_error.svg": error,
    "错误提示_error-prompt.svg": errorPrompt,
    "错误用户_wrong-user.svg": wrongUser,
    "锚方_anchor-squre.svg": anchorSqure,
    "锚点_anchor-one.svg": anchorOne,
    "锚点_anchor.svg": anchor,
    "锚轮_anchor-round.svg": anchorRound,
    "键盘_keyboard-one.svg": keyboardOne,
    "键盘_keyboard.svg": keyboard,
    "镜头反转_reverse-lens.svg": reverseLens,
    "镜头对准_lens-alignment.svg": lensAlignment,
    "镜子2_mirror-two.svg": mirrorTwo,
    "镜子_mirror-one.svg": mirrorOne,
    "镜子_mirror.svg": mirror,
    "长城_great-wall.svg": greatWall,
    "门把手_door-handle.svg": doorHandle,
    "门票_tickets-one.svg": ticketsOne,
    "门票_tickets-two.svg": ticketsTwo,
    "闪付_flash-payment.svg": flashPayment,
    "闪光模式_flashlamp.svg": flashlamp,
    "闪电_lightning.svg": lightning,
    "闭眼生气_distraught-face.svg": distraughtFace,
    "闭眼笑_grinning-face-with-tightly-closed-eyes.svg": grinningFaceWithTightlyClosedEyes,
    "闹钟_alarm-clock.svg": alarmClock,
    "防腐_anti-corrosion.svg": antiCorrosion,
    "陀螺_spinning-top.svg": spinningTop,
    "附件_slave.svg": slave,
    "降序排序_sort-amount-down.svg": sortAmountDown,
    "降落伞_parachute.svg": parachute,
    "除号_division.svg": division,
    "隐藏文件1_file-hiding-one.svg": fileHidingOne,
    "隐藏文件_file-hiding.svg": fileHiding,
    "雨伞_umbrella-one.svg": umbrellaOne,
    "雨伞_umbrella-two.svg": umbrellaTwo,
    "雨伞_umbrella.svg": umbrella,
    "雪糕_icecream-one.svg": icecreamOne,
    "雪花_snowflake.svg": snowflake,
    "雷诺_renault.svg": renault,
    "雷达_radar-two.svg": radarTwo,
    "雷达_radar.svg": radar,
    "雷达图_radar-chart.svg": radarChart,
    "雷雨_thunderstorm-one.svg": thunderstormOne,
    "雷雨_thunderstorm.svg": thunderstorm,
    "震动_shake.svg": shake,
    "震荡器_oscillator.svg": oscillator,
    "霹雳接口_thunderbolt.svg": thunderbolt,
    "青菜_vegetables.svg": vegetables,
    "青鸟线索通_qingniao-clue.svg": qingniaoClue,
    "静音_mute.svg": mute,
    "静音_volume-mute.svg": volumeMute,
    "面具_mask-one.svg": maskOne,
    "面包_bread-one.svg": breadOne,
    "面包_bread.svg": bread,
    "面包机_bread-machine.svg": breadMachine,
    "面条_bowl.svg": bowl,
    "面条_noodles.svg": noodles,
    "靴子_boots.svg": boots,
    "靶子_target.svg": target,
    "靶标_target-one.svg": targetOne,
    "音乐_music-one.svg": musicOne,
    "音乐_music.svg": music,
    "音乐cd_music-cd.svg": cdMusicCd,
    "音乐律动_music-rhythm.svg": musicRhythm,
    "音乐文件1_file-music-one.svg": fileMusicOne,
    "音乐文件_file-music.svg": fileMusic,
    "音乐文件夹1_folder-music-one.svg": folderMusicOne,
    "音乐文件夹_folder-music.svg": folderMusic,
    "音乐菜单_music-list.svg": musicList,
    "音乐菜单_music-menu.svg": musicMenu,
    "音响_sound-one.svg": soundOne,
    "音响_sound.svg": sound,
    "音响_speaker.svg": speaker,
    "音波_sound-wave.svg": soundWave,
    "音波控制_monitor-two.svg": monitorTwo,
    "音量减小_volume-down.svg": volumeDown,
    "音量增大_volume-up.svg": volumeUp,
    "音频文件_audio-file.svg": audioFile,
    "页面_page.svg": page,
    "页面模版_page-template.svg": pageTemplate,
    "顶对齐_align-top.svg": alignTop,
    "顶栏_top-bar.svg": topBar,
    "顶灯_dome-light.svg": domeLight,
    "顶部右对齐_alignment-top-right.svg": alignmentTopRight,
    "顶部居中对齐_alignment-top-center.svg": alignmentTopCenter,
    "顶部左对齐_alignment-top-left.svg": alignmentTopLeft,
    "顶部连接_s-turn-up.svg": sTurnUp,
    "预览-关闭_preview-close-one.svg": previewCloseOne,
    "预览-关闭_preview-close.svg": previewClose,
    "预览-打开_preview-open.svg": previewOpen,
    "领带_necktie.svg": necktie,
    "领结_bow.svg": bow,
    "颜色滤镜_color-filter.svg": colorFilter,
    "风力发电机_wind-turbine.svg": windTurbine,
    "风景区_landscape.svg": landscape,
    "风笛塔_tower-of-babel.svg": towerOfBabel,
    "风衣_clothes-windbreaker.svg": clothesWindbreaker,
    "风车_pinwheel.svg": pinwheel,
    "风车_windmill-one.svg": windmillOne,
    "风车_windmill-two.svg": windmillTwo,
    "风车_windmill.svg": windmill,
    "飞书1_lark-one.svg": larkOne,
    "飞书_lark.svg": lark,
    "飞机加速_acceleration.svg": acceleration,
    "飞机窗口_airplane-window-one.svg": airplaneWindowOne,
    "飞机窗口_airplane-window.svg": airplaneWindow,
    "飞机起飞_take-off.svg": takeOff,
    "飞行安全_flight-safety.svg": flightSafety,
    "飞行巡航_in-flight.svg": inFlight,
    "飞行气流_flight-airflow.svg": flightAirflow,
    "飞鱼CRM_feiyu.svg": crmFeiyu,
    "食指_index-finger.svg": indexFinger,
    "餐具_baby-meal.svg": babyMeal,
    "饮料_drink.svg": drink,
    "饼图_chart-pie.svg": chartPie,
    "首页_home-two.svg": homeTwo,
    "首页_home.svg": home,
    "首饰_jewelry.svg": jewelry,
    "香水_perfume.svg": perfume,
    "香水瓶_perfumer-bottle.svg": perfumerBottle,
    "香蕉_banana.svg": banana,
    "马尤拉手势_mayura-gesture.svg": mayuraGesture,
    "马戏团_circus.svg": circus,
    "马斯洛金字塔_maslow-pyramids.svg": maslowPyramids,
    "马桶_toilet.svg": toilet,
    "马赛克_mosaic.svg": mosaic,
    "驳回_reject.svg": reject,
    "骑术_riding-one.svg": ridingOne,
    "骑自行车_riding.svg": riding,
    "骨头_bone.svg": bone,
    "骨科_orthopedic.svg": orthopedic,
    "骷髅_skull.svg": skull,
    "高亮_high-light.svg": highLight,
    "高尔夫球场_golf-course.svg": golfCourse,
    "高脚杯_goblet-one.svg": gobletOne,
    "高脚杯_goblet.svg": goblet,
    "高脚杯满了_goblet-full.svg": gobletFull,
    "高脚杯裂开_goblet-cracking.svg": gobletCracking,
    "高质量文件夹1_folder-quality-one.svg": folderQualityOne,
    "高质量文件夹_folder-quality.svg": folderQuality,
    "高跟鞋_high-heeled-shoes.svg": highHeeledShoes,
    "高领毛衣_clothes-turtleneck.svg": clothesTurtleneck,
    "魔方_cube-five.svg": cubeFive,
    "魔方_cube-four.svg": cubeFour,
    "魔方_cube-three.svg": cubeThree,
    "魔方_cube-two.svg": cubeTwo,
    "魔方_cube.svg": cube,
    "魔术帽_magic-hat.svg": magicHat,
    "魔比斯环_cross-ring-two.svg": crossRingTwo,
    "魔法棒_magic-wand.svg": magicWand,
    "魔法棒_magic.svg": magic,
    "鱼_fish.svg": fish,
    "鸡尾酒_cocktail.svg": cocktail,
    "鸡尾酒_liqueur.svg": liqueur,
    "鸡肉_chicken.svg": chicken,
    "鸡腿_chicken-leg.svg": chickenLeg,
    "鸡腿_drumstick.svg": drumstick,
    "鸡蛋_egg-one.svg": eggOne,
    "鸳鸯锅_chafing-dish.svg": chafingDish,
    "麦克风_microphone.svg": microphone,
    "鼓掌_clap.svg": clap,
    "鼠标_mouse-one.svg": mouseOne,
    "鼠标_mouse.svg": mouse,
    "鼻腔_nasal.svg": nasal,
  };
}
