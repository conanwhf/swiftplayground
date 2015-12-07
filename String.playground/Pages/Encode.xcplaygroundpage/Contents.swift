//: [Previous](@previous)

import Foundation

/**
 Encoding测试
 */
func addEncoding(st : String ) ->String? {
    if #available(iOS 7.0, OSX 10.9, *) {
        return st.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
    }
    else {
        return  st.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    }
}

func rmEncoding(st : String ) ->String? {
    if #available(iOS 7.0, OSX 10.9, *) {
        return  st.stringByRemovingPercentEncoding
    }
    else {
       return st.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    }
}

let s1               = "王"// s1为中文字符串- 王
Array(s1.utf8.enumerate())
let s2               = addEncoding(s1)!// s2为编码后utf8字符串- %E7%8E%8B
let s3               = addEncoding(s2)!// s3为补全%25(即为空字符)后编码字符串
let s4               = addEncoding(s3)!

rmEncoding(s4)
rmEncoding(s3)
rmEncoding(s2)
rmEncoding(s1)



// 包含中文字符串转成utf8编码
let st               = "www.google.com/测 🙃test/."
let utf8str          = addEncoding(st)
// 中文URL转换
var  nsurl           = NSURL(string: st)
nsurl                = NSURL(string: utf8str!)
// UTF8转成中文
    rmEncoding(utf8str!)



/**
 UTF8ToGB2312
 实现Object-C下代码：
NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
 */
func UTF8ToGB2312(str: String) -> (NSData?, UInt) {
let enc              = CFStringConvertEncodingToNSStringEncoding(UInt32(CFStringEncodings.GB_18030_2000.rawValue))

let data             = str.dataUsingEncoding(enc, allowLossyConversion: false)

    return (data, enc)
}
let url              = "123中文"
let (data, enc2)     = UTF8ToGB2312(url)
let gbkStr           = NSString(data: data!, encoding: enc2)!
