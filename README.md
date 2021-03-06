# MyPlayground In Swift
> This is a playground for Conan by Xcode. It include the basic trying code while studying the Swift. There are small code snippets too, and ready to build a real project.
> 
> 自己的一个练习场地，包含学习Swift & iOS 开发的一些练习代码，以及实现的一些小功能，为实战开发项目做积累。每个playground里面分别有几个page，Xcode默认显示第一个，View->Navigators->Show Project Navigator显示Page列表

## File list:

### Swift Syntax
Swift语法学习代码，包括各种类型和语法特性，以及和C不同的小细节。顺序是按照官方文档的章节安排。Page列表：

- **Base**，基础类型，控制流，数值计算，结构体&枚举
1. **String**，字符串和字符
1. **MultiElement**，数组，集合，字典
1. **Function**，函数
2. **Enum**，枚举
1. **Closures**，闭包
1. **Enum**，枚举
2. **Class&Struct**，类，结构体
1. **ARC**，自动引用计数
1. **Protocol**，协议
1. **StandardFunc**，常用标准函数


### String
As String is a useful & complex type, which is have more extra define such as NSString, NSmutilestring, etc, we need to lean more about it.
通常意义上的字符串太常用，也相当复杂，有多种形式和用法（NSString等等），所以单独拉出来溜溜。包括常用用法，也包括一些高级用法的小功能实现。主要是Swfit的String太麻烦了，也不好用，多数时候功能性的东西还是用NSString系列。

- **Simple**，简单的常用例子
2. **GetFirstCharFromChinese**，中文提取拼音首字母
3. **Encode**，字符编码的一些东西
4. **NS-**，NS系列相互的类型转换，包括String, NSString，NSData，NSURL
5. **TypeTans**，String和其他数据类型的转换，包括16进制转换
6. **ASCII**，简单的Ascii码转换函数
7. **Regular**，正则表达式匹配的实现


### Exercise_Demo
The demos for my study list.
已转移到[练手小项目](https://github.com/conanwhf/iOS_ShortPractice)


### UI_Test
Some tests for Cocoa UI API
对Cocoa UI控件API的一些测试，主要是了解用法

-  **Color**，颜色测试
1. **Text**，Text，主要是HTML显示和字体
2. **View**，UIView拿基本参数
3. **RGB_UIColor**，16进制表示的RGB颜色与UIColor互转


### Play
一些自己写着玩的东西，有的是测试，有的是探索

- **Sort**，sort()的几个测试
1. **Draw**，一个拿函数画图的合集，画着玩
2. **JSON**，JSON数据获得和解析，以及生成JSON数据
2. **Math**，
1. **Rename**，因为下载导致的文件名乱码修复
3. **File**，Swift文件操作
4. **GetXML**，XML解析
5. **Precision**，类型精度测试
6. **DateTime**，时间日期相关
7. **System**，系统状态相关


### WenXueCity
某新闻网站拿取新闻的Demo，两个版本。第一遍直接写流程，后来重写数据结构，用OO定义数据
