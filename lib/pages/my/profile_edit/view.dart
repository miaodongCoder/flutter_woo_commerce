import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import 'index.dart';

class ProfileEditPage extends GetView<ProfileEditController> {
  const ProfileEditPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return SingleChildScrollView(
      child: <Widget>[
        // 头像:
        _buildAvatar(),
        // 表单:
        Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: <Widget>[
            // profile表单:
            _buildProfileForm(),
            // password表单:
            _buildPasswordForm(),
          ].toColumn(),
        ).paddingBottom(AppSpace.card),
        // 保存按钮:
        ButtonWidget.primary(LocaleKeys.commonBottomSave.tr).paddingHorizontal(AppSpace.page),
      ].toColumn().paddingTop(45.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileEditController>(
      init: ProfileEditController(),
      id: "profile_edit",
      builder: (_) {
        return Scaffold(
          appBar: mainAppBarWidget(titleString: LocaleKeys.profileEditTitle.tr),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }

  // 头像
  Widget _buildAvatar() {
    return ListTileWidget(
      title: TextWidget.body1(LocaleKeys.profileEditMyPhoto.tr),
      trailing: [
        ImageWidget.url(
          // UserService.to.profile.avatarUrl,
          "https://ducafecat-pub.oss-cn-qingdao.aliyuncs.com/avatar/00258VC3ly1gty0r05zh2j60ut0u0tce02.jpg",
          width: 50.w,
          height: 50.w,
          fit: BoxFit.cover,
          radius: 25.w,
        ),
      ],
      padding: EdgeInsets.all(AppSpace.card),
    ).card().height(90.h).paddingAll(AppSpace.card);
  }

  //  profile 表单
  Widget _buildProfileForm() {
    return const Text("profile 表单");
  }

  //  password 表单
  Widget _buildPasswordForm() {
    return const Text("password 表单");
  }
}
