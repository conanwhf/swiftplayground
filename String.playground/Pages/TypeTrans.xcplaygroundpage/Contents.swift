//: [Previous](@previous)

import Foundation

/**
 其他类型转换为String
 - parameter a: <#a description#>
 - returns: <#return value description#>
 */
func toString<T>(a: T) -> String{
    // Way one, format
    //return "\(a)"
    // Way two, new string
    return String(a)
}
toString(123)
toString(0.007)
toString([4, 8, 32, 5 ])
toString("test".startIndex)


/**
String 转换为其他类型
*/
Int("123")
Float("3.1")


/**
 进制转换
 */
func Hex(){

    // 数值转为String
    // Way 1, 格式化转String
    String(format:"%i,  0x%x,  0o%o,  %.2f", 31, 31,  31, 3.1)
    // Way 2
    String().stringByAppendingFormat("%x",31)
    String().stringByAppendingFormat("%o",31)

    //单个字符转换成为数值
    let s1           = "0xA"
    let s2           = "你我他"
    // Way 1
    for i in s1.utf8 {
        i
    }
    for i in s2.utf16 {
        i
    }
    // Way 2 只适用于Ascii码
    let str:NSString = s1
    for i in 0..<s1.characters.count {
        str.UTF8String[i]
    }

    //十六进制String转整数
    var res:UInt32   = 0
    NSScanner.localizedScannerWithString(s1).scanHexInt(&res)
    res
}
Hex()
