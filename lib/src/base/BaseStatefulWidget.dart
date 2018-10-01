import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_flutter_bloc_pattern/src/base/BaseView.dart';
import 'package:movie_flutter_bloc_pattern/src/ui/customWidget/LoadingDialog.dart';

abstract class BaseStatefulWidget extends StatefulWidget {}

abstract class BaseStatefulWidgetState<T extends BaseStatefulWidget>
    extends State<T> implements BaseView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LoadingDialog loadingDialog;

  @override
  Future showLoadingDialog() async {
    if (!loadingDialog.isShowing()) {
      loadingDialog = LoadingDialog();
      await showDialog(
          context: context,
          builder: (context) => loadingDialog,
          barrierDismissible: true);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onSuccess(String msg) {
    hideDialog();
  }

  buildAppBar();

  buildBody();

  GlobalKey<ScaffoldState> getGlobalKey() {
    return _scaffoldKey;
  }

  @override
  void hideDialog() {
    if (loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  @override
  void onError(String error) {
    hideDialog();
  }

  @override
  void showSnack(String msg) {
    try {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      print(e.toString());
    }
  }
}
