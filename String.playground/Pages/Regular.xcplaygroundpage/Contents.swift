//: [Previous](@previous)

import Foundation

let str               = "18800002222---13144445555"
let pattern = "1[3|5|7|8][0-9]\\d{8}"

// 方法一：使用Range，返回范围
str.rangeOfString(pattern, options: NSStringCompareOptions.RegularExpressionSearch)


// 方法二：使用NSPredicate，返回bool
let pred: NSPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
pred.evaluateWithObject(str)


// 方法三：使用NSRegularExpression
var expr              = try NSRegularExpression(pattern: pattern, options: [])
var range             = NSMakeRange(0, str.characters.count)

expr.pattern    // Show the pattern
var res               = expr.firstMatchInString(str, options: NSMatchingOptions.ReportProgress, range: range)
print(res?.range)
var resAll            = expr.matchesInString(str, options: NSMatchingOptions.ReportProgress, range: range)
resAll.forEach{ print($0.range) }
expr.numberOfMatchesInString(str, options: NSMatchingOptions.ReportProgress, range: range)

var newStr = NSMutableString(string: str)
expr.replaceMatchesInString(newStr, options: [] , range: range, withTemplate: "phoneNum")
newStr



// URL的Parser
let url        = NSURL(string: "http://weibo.com/u/1864854042?sudaref=conanwhf.github.io&test=???&lalalvy=irobot")!
let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
let item       = components?.queryItems
item?.forEach { print($0.name, $0.value!) }
