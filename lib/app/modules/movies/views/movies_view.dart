import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tools/third/update/toast.dart';
import 'package:get/get.dart';

import '../../../../third/update/update_dialog.dart';
import '../controllers/movies_controller.dart';

class MoviesView extends GetView<MoviesController> {
  MoviesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Dialog "),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, //文本是起始端对齐
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.start, //布局方向，默认MainAxisAlignment.end
                    mainAxisSize: MainAxisSize.min, //主轴大小，默认MainAxisSize.max
                    children: <Widget>[
                      ElevatedButton(
                        child: const Text('默认样式'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Theme.of(context).primaryColor)),
                        // color: Theme.of(context).primaryColor,
                        onPressed: defaultStyle,
                      ),
                      ElevatedButton(
                        child: const Text('自定义样式'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Theme.of(context).primaryColor)),
                        onPressed: customStyle,
                      ),
                    ],
                  ),
                ])));
  }

  UpdateDialog? dialog;

  double progress = 0.0;

  void onUpdate() {
    ToastUtils.success('开始升级...');
    Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      progress = progress + 0.02;
      if (progress > 1.0001) {
        timer.cancel();
        dialog!.dismiss();
        progress = 0;
        ToastUtils.success('升级成功！');
      } else {
        dialog!.update(progress);
      }
    });
  }

  void defaultStyle() {
    if (dialog != null && dialog!.isShowing()) {
      return;
    }
    BuildContext? context = Get.context;
    if (context != null) {
      dialog = UpdateDialog.showUpdate(context,
          title: '是否升级到4.1.4版本？',
          updateContent: '新版本大小:2.0M\n1.xxxxxxx\n2.xxxxxxx\n3.xxxxxxx',
          onUpdate: onUpdate);
    }
  }

  void customStyle() {
    if (dialog != null && dialog!.isShowing()) {
      return;
    }
    BuildContext? context = Get.context;
    if (context != null) {
      dialog = UpdateDialog.showUpdate(context,
          width: 250,
          title: '是否升级到4.1.4版本？',
          updateContent: '新版本大小:2.0M\n1.xxxxxxx\n2.xxxxxxx\n3.xxxxxxx',
          titleTextSize: 14,
          contentTextSize: 12,
          buttonTextSize: 12,
          topImage: Image.asset('assets/images/bg_update_top.png'),
          extraHeight: 5,
          radius: 8,
          themeColor: const Color(0xFFFFAC5D),
          progressBackgroundColor: const Color(0x5AFFAC5D),
          isForce: true,
          updateButtonText: '升级',
          ignoreButtonText: '忽略此版本',
          enableIgnore: true, onIgnore: () {
        dialog?.dismiss();
        // ToastUtils.waring('忽略');
        dialog!.dismiss();
      }, onUpdate: onUpdate);
    }
  }
}
