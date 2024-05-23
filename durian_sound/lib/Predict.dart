// class Predict {
//   late int level;
//   late String levelText;
//   late String title;
//   late String detail;
//   late String image;

//   Predict(predict) {
//     level = level;
//     title = title;
//     levelText = levelText;
//     detail = detail;
//     image = image;
//   }
//   getData() {
//     return {
//       "level": level,
//       "title": title,
//       "detail": detail,
//       "levelText": levelText,
//       "image": image
//     };
//   }
// }
class Predict {
  late int level;
  late String title;
  late String levelText;
  late String test;
  late String detail;
  late String image;

  Predict(this.level, this.title, this.levelText, this.test, this.detail,
      this.image);

  Map<String, dynamic> getData() {
    return {
      "level": level,
      "title": title,
      "levelText": levelText,
      "test": test,
      "detail": detail,
      "image": image
    };
  }
}
