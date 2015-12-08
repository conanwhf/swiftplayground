//: [Previous](@previous)

import Foundation

var str           = "中.A"
var data :NSData?
var nstr : NSString?
var url : NSURL?
let enc           = CFStringConvertEncodingToNSStringEncoding(UInt32(CFStringEncodings.GB_18030_2000.rawValue))

    //NSString & String
    nstr              = str
    nstr              = String(str)

    // String to NSURL
    let utf8str       = str.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    url               = NSURL(string: utf8str)
    nstr              = utf8str
    url               = NSURL(string: String(nstr!))

    // NSURL to String
    url               = NSURL(string: "www.com")
    str               = String(url!)
    nstr              = NSString(string: url!.absoluteString)

    // Anything to NSData
    data              = str.dataUsingEncoding(NSUTF8StringEncoding)
    data              = str.dataUsingEncoding(NSUTF16StringEncoding)
    data              = str.dataUsingEncoding(NSUTF32StringEncoding)
    data              = str.dataUsingEncoding(NSUnicodeStringEncoding)
    data              = str.dataUsingEncoding(NSASCIIStringEncoding)
    data              = nstr?.dataUsingEncoding(NSUTF8StringEncoding)
    data              = url!.absoluteString.dataUsingEncoding(NSUTF8StringEncoding)

    // NSData to Anything
    str               = String(data: data!, encoding: NSUTF8StringEncoding)!
    nstr              = NSString(data: data!, encoding: NSUTF8StringEncoding)
    // by manually fill
    let byte :[UInt8] = [0xe4, 0x8d, 0xa9, 0x20, 0xe3, 0x8e, 0x8f]
    data              = NSData(bytes: byte, length: byte.count)
    str                 = String(data: data!, encoding: NSUTF8StringEncoding)!
    nstr               = NSString(data: data!, encoding: NSUTF8StringEncoding)
    url                 = NSURL(dataRepresentation: data!, relativeToURL: nil)
