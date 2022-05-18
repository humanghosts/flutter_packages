import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/component/export.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

import '../settings.dart';

/// 逻辑
class AboutLogic extends SettingsItemLogic {
  /// 打开链接
  void launchUrl(String? url) async {
    if (null == url) return;
    final result = await canLaunch(url);
    if (result) await launch(url);
  }

  /// 获取平台代码，用于生成文档地址
  String get platformCode => Platform.operatingSystem;

  /// 获取版本代码，用于生成文档地址
  String get versionCode {
    if (Platform.isIOS) return AppConfig.platformVersionConfig.ios;
    return "";
  }

  /// 平台版本代码 用于生成文档地址
  String get platformVersionCode => "${platformCode}_$versionCode";
}

/// 页面
class About extends SettingsItem<AboutLogic> {
  About({
    required String key,
    required SettingsItemArgs args,
  }) : super(key: key, args: args, newLogic: AboutLogic());

  @override
  String get title => "关于";

  @override
  Widget buildSettings() {
    List<Widget> children = [
      buildDoc(),
      buildAppReview(),
      buildVersionLog(),
      buildFeedback(),
      buildUserAdvice(),
      buildTodo(),
      buildOpenSource(),
      buildPrivacyPolicy(),
    ];
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              clipBehavior: Clip.none,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                // mainAxisExtent: 120,
                crossAxisSpacing: 16,
                mainAxisSpacing: 12,
                // childAspectRatio: 0.618,
              ),
              padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.5, top: 12),
              itemBuilder: (context, index) {
                return children[index];
              },
              itemCount: children.length,
            ),
          ),
          HgNeumorphicText("当前版本:${logic.platformVersionCode}", color: themeData.disabledColor),
        ],
      ),
    );
  }

  /// 文档主页
  Widget buildDoc() {
    return buildTile(
      iconData: Icons.file_present_outlined,
      iconColor: Colors.blue,
      text: "文档主页",
      onTap: () {
        logic.launchUrl("https://www.yuque.com/humanghosts/events");
      },
    );
  }

  /// 评分反馈
  Widget buildAppReview() {
    return buildTile(
      iconData: Icons.reviews_outlined,
      iconColor: Colors.yellow,
      text: "评分反馈",
      onTap: () async {
        InAppReview inAppReview = InAppReview.instance;
        bool isAvailable = await inAppReview.isAvailable();
        if (isAvailable) {
          inAppReview.openStoreListing(appStoreId: '1594151375');
        }
      },
    );
  }

  /// 开发计划
  Widget buildTodo() {
    return buildTile(
      iconData: Icons.code,
      iconColor: Colors.cyan,
      text: "开发计划",
      onTap: () {
        logic.launchUrl("https://www.yuque.com/humanghosts/events/plan");
      },
    );
  }

  /// 问题反馈
  Widget buildFeedback() {
    return buildTile(
      iconData: Icons.feedback,
      iconColor: Colors.red,
      text: "问题反馈",
      onTap: () {
        logic.launchUrl("https://www.yuque.com/humanghosts/events/feedback_${logic.platformVersionCode}");
      },
    );
  }

  /// 开发工具，开源资源文档，
  /// 包括图标、音频、三方包、框架等
  Widget buildOpenSource() {
    return buildTile(
      iconData: Icons.cases_outlined,
      iconColor: Colors.green,
      text: "开源工具",
      onTap: () {
        logic.launchUrl("https://www.yuque.com/humanghosts/events/open_source");
      },
    );
  }

  /// 版本更新
  Widget buildVersionLog() {
    return buildTile(
      iconData: Icons.checklist_outlined,
      text: "版本更新",
      onTap: () {
        logic.launchUrl("https://www.yuque.com/humanghosts/events/version_${logic.platformVersionCode}");
      },
    );
  }

  /// 功能建议
  Widget buildUserAdvice() {
    return buildTile(
      iconData: Icons.comment,
      iconColor: Colors.orange,
      text: "功能建议",
      onTap: () {
        logic.launchUrl("https://www.yuque.com/humanghosts/events/suggest_${logic.platformVersionCode}");
      },
    );
  }

  /// 隐私政策
  Widget buildPrivacyPolicy() {
    return buildTile(
      iconData: Icons.privacy_tip_outlined,
      iconColor: Colors.red,
      text: "隐私政策",
      onTap: () {
        logic.launchUrl("https://www.yuque.com/humanghosts/events/privacy_policy_${AppConfig.privacyPolicyVersionConfig.version}");
      },
    );
  }

  /// 构建表格项
  Widget buildTile({
    required IconData iconData,
    required String text,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HgNeumorphicIcon(iconData, color: iconColor ?? themeData.iconTheme.color, size: 50),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
          HgNeumorphicText(text, color: themeData.defaultTextColor),
        ],
      ),
      onPressed: onTap,
    );
  }
}
