//: [Previous](@previous)

import Foundation

/**
 Encoding相关方法，重编码
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


func encodingTest(){
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
    let st               = "www.google.com/测%111 🙃test/."
    let utf8str          = addEncoding(st)
    // UTF8转成中文
    rmEncoding(utf8str!)
}


func rawDataTest() {
    let st               = "王 A 王"

    //字符串获取Rawdata
    var data             = st.dataUsingEncoding(NSUTF8StringEncoding)!
    //Other sample
    st.dataUsingEncoding(NSUTF16StringEncoding)
    st.dataUsingEncoding(NSUTF32StringEncoding)
    st.dataUsingEncoding(NSUnicodeStringEncoding)
    st.dataUsingEncoding(NSASCIIStringEncoding)

    // RawData 转成字符串
    // by rawdata get before
    String(data: data, encoding: NSUTF8StringEncoding)
    NSString(data: data, encoding: NSUTF8StringEncoding)
    // by manually fill
    let byte :[UInt8]    = [0xe7, 0x8e, 0x8b, 0x20, 0xe3, 0x8e, 0x8f]
    data                 = NSData(bytes: byte, length: byte.count)
    String(data: data, encoding: NSUTF8StringEncoding)
}


/**
 utf8转成中文，使用rawdata方法
 */
func stConvert(var st: String) ->String{
    var byte :[UInt8]    = []
    let start            = st.startIndex
    var range: Range?    = Range(start: start, end: start)

    while !st.isEmpty {
        range                = String(st.characters.dropFirst()).rangeOfString("%")
        if (range != nil) {     //still have next "%"
            // because the range is for dropfirst, the endIndex is the the true endof no %
            range!.startIndex    = start
        }
        else {  //no "%" any more
            range                = Range(start:start, end:st.endIndex)
        }
        //print("\(st), \(String(range!))")
        if st.hasPrefix("%"){
            var res:UInt32       = 0
            range!.endIndex      = range!.startIndex.advancedBy(3)
            var temp             = st.substringWithRange(range!)
            temp                 = temp.stringByReplacingOccurrencesOfString("%", withString: "0x")
            NSScanner.localizedScannerWithString(temp).scanHexInt(&res)
            byte.append(UInt8(res))
        }
        else {
            let temp :NSString   = st.substringWithRange(range!)
            for i in 0..<temp.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
                byte.append(UInt8(temp.UTF8String[i]))
            }

        }
        st.removeRange(range!)
    }

    let data             = NSData(bytes: byte, length: byte.count)
    return String(data: data, encoding: NSUTF8StringEncoding)!
}


encodingTest()
rawDataTest()

//Unicode转换
var dogInt:UInt32    = 0x1F436
let dog:String       = UnicodeScalar(dogInt).escape(asASCII: false)
dog.dataUsingEncoding(NSUnicodeStringEncoding)

// utf8转成中文，使用rawdata方法
stConvert("1%2B12%EF%BC%9A%E9%80%9A%E5%90%91%E5%B8%B8%E8%AF%86%E7%9A%84%E9%81%93%E8%B7%AF%20%28%E6%80%9D%E4%BA%AB%E5%AE%B6%E4%B8%9B%E4%B9%A6%29%20-%20%E5%88%98%E8%8B%8F%E9%87%8C%F0%9F%90%B6.mobi")




/*******************************
    I don't know how to use, it's from internet to convert coding, but seems not success
    实现Object-C下代码：
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
 */
func UTF8ToGB2312(str: String) -> (NSData?, UInt) {
    let enc              = CFStringConvertEncodingToNSStringEncoding(UInt32(CFStringEncodings.GB_18030_2000.rawValue))
    let data             = str.dataUsingEncoding(enc, allowLossyConversion: false)
    
    return (data, enc)
}
let (data, enc)      = UTF8ToGB2312("123中文")
NSString(data: data!, encoding: enc)!
