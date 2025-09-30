import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui' as ui show window;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ArticleProvider {
  static Future<Article> fetchArticle(int articleId) async {
    final String response = await rootBundle.loadString('packages/reader/mock/article_${articleId}.json');
    final jsonMap = jsonDecode(response) as Map<String, dynamic>;
    var artical = Article.fromJson(jsonMap["data"]);
    artical.id = articleId;
    return artical;
  }

  static Future<List<dynamic>> fetchCatalog(int articleId) async {
    final String response = await rootBundle.loadString('packages/reader/mock/catalog.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return data["data"];
  }
}

class Chapter {
  late int id;
  late String title;
  late int index;

  Chapter.fromJson(Map data) {
    id = data['id'];
    title = data['title'];
    index = data['index'] ?? 0;
  }
}

class Styles {
  static List<BoxShadow> get borderShadow {
    return [BoxShadow(color: Color(0x22000000), blurRadius: 8)];
  }
}

class Article {
  late int id;
  late int novelId;
  late String title;
  late String content;
  late int price;
  late int index;
  late int nextArticleId;
  late int preArticleId;

  late List<Map<String, int>> pageOffsets;

  Article.fromJson(Map data) {
    id = data['id'];
    novelId = data['novel_id'];
    title = data['title'];
    content = data['content'];
    content = '　　' + content;
    content = content.replaceAll('\n', '\n　　');
    price = data['price'] ?? 0;
    index = data['index'];
    nextArticleId = data['next_id'];
    preArticleId = data['prev_id'];
  }

  String stringAtPageIndex(int index) {
    var offset = pageOffsets[index];
    return this.content.substring(offset['start']!, offset['end']);
  }

  int get pageCount {
    return pageOffsets.length;
  }
}

class SQColor {
  static Color primary = Color(0xFF23B38E);
  static Color secondary = Color(0xFF51DEC6);
  static Color red = Color(0xFFFF2B45);
  static Color orange = Color(0xFFF67264);
  static Color white = Color(0xFFFFFFFF);
  static Color paper = Color(0xFFF5F5F5);
  static Color lightGray = Color(0xFFBBBBBB);
  static Color darkGray = Color(0xFF333333);
  static Color gray = Color(0xFF888888);
  static Color blue = Color(0xFF3688FF);
  static Color golden = Color(0xff8B7961);
}

class Screen {
  static double get width {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width;
  }

  static double get height {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.height;
  }

  static double get scale {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.devicePixelRatio;
  }

  static double get textScaleFactor {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.textScaleFactor;
  }

  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }
}

class Utility {
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future popToFirstPage(BuildContext context) async {
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
  }

  static afterLayout(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      callback();
    });
  }

  static fixedFontSize(double fontSize) {
    return fontSize / Screen.textScaleFactor;
  }

  static List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}
