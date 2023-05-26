class HomePageModels {
  static List<String> tasks = List.generate(10, (index) => "Hello $index");

  static List<bool> checkList = List.generate(10, (index) => false);

  static changeCheckStatus(int index) {
    checkList[index] = !checkList[index];
  }
}
