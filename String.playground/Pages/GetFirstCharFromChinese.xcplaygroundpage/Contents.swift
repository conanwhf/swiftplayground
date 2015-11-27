//: [Previous](@previous)

import Foundation

func firstCharactor(aString: String) -> String {
    //转成了可变字符串
    let str: NSMutableString = NSMutableString(string: aString)
    
    //先转换为带声调的拼音
    CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false)
    str
    //再转换为不带声调的拼音
    CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
    str
    //转化为大写拼音
    let pinYin: String = str.capitalizedString
    return pinYin.substringToIndex(pinYin.startIndex.successor())
}


firstCharactor("王")
