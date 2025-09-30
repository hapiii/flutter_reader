<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->
源码来源于[flutter_shuqi](https://github.com/jayden320/flutter_shuqi)；
单独抽取其中阅读器部分代码，使用本地数据。



## Usage

将package引入本地，
在pubspec.yaml中引入：

```dart
  reader:
    path: XX/reader
```

进入阅读页面:
引入头文件，进入阅读页面。
```
import 'package:reader/reader/reader_page.dart';
 Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ReaderPage(articleId: 1000);
            }));
```
            
