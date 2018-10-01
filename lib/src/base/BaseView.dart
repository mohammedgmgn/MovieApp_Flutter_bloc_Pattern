abstract class BaseView{
  void showLoadingDialog();
  void hideDialog();
  void onError(String error);
  void onSuccess(String msg);
  void showSnack(String msg);
}