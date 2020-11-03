class Labels {
  static const cases = 'الحالات المعلن عنها';
  static const deaths = 'الوفيات';
  static const recovered = 'المتعافين';
  static const diagnosis = 'إفحص حالتك الآن';
  static const backPrevRes = "العودة إلى السؤال السابق";
  static const backPrevPage = "العودة";
  static const confirm = "تأكيد";
  static const cancel = "إلغاء";
  static const chooseNumber = "المرجو تحديد رقم";
  static const enterData = "المرجو إدخال البيانات";
  static const home = "الصفحة الرئيسية";
  static const more_info = "توضيح أكثر";
  static const cpom = "الحالات لكل م.ن";
  static const dpom = "الوفيات لكل م.ن";

  static String getTxtWithName(String txt, String name) {
    return "$name$txt";
  }
}