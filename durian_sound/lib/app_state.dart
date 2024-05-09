import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  List<int>? recordedAudio;
  String? recordedFileName;
  String? recordedFile;
  String? accessToken;
  String? storeName;
  List<int> incompleteRecordedAudio = [];
  Map<int, String?> storeNameMap = {};
  Map<int, String?> recordedFileNameMap = {};
  Map<int, String?> recordedFileNameOLDMap = {};
  late final int index;

  get recordedFileMap => null;

  void setStoreNameByIndex(int index, String? name) {
    storeNameMap[index] = name;
    notifyListeners();
  }

  void setRecordedFileNameByIndex(int index, String? fileName) {
    recordedFileNameMap[index] = fileName;
    notifyListeners();
  }
  void setRecordedFileNameOLDByIndex(int index, String? fileName) {
    recordedFileNameOLDMap[index] = fileName;
    notifyListeners();
  }

  void setRecordedAudio(List<int>? audioData) {
    recordedAudio = audioData;
    notifyListeners();
  }

  void setIncompleteRecordedAudio(List<int> audio) {
    incompleteRecordedAudio = audio;
    notifyListeners();
  }

  void setRecordedFileName(String? fileName) {
    recordedFileName = fileName;
    notifyListeners();
  }

  void setRecordedFile(String? file) {
    recordedFile = file;
    notifyListeners();
  }

  void setAccessToken(String? accessToken) {
    this.accessToken = accessToken;
    notifyListeners();
  }

  String? getStoreName() {
    return storeName;
  }

  void setStoreName(String name, int index) {
    storeName = name;
  }

  void updateStoreName(int index, String newValue) {}
}
