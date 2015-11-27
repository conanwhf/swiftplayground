//: Playground - noun: a place where people can play

import UIKit

func string_base(){
    
    /*************************************/
    var str = ""
    str = "\0(空字符),\\(反斜线),\t(水平制表符),\n(换行符),\r(回车符),\"(双引号),\'(单引号)"
    //Unicode 标量，写成\u{n}(u为小写)，其中n为任意的1-8位十六进制数
    var str2 = "\u{24} \u{2665} \u{1F496}"
    
    str2.unicodeScalars
    print(str+str2)
    var ch :Character = "!"
    
    str = String()
    str.isEmpty
    //———!!!
    //Strings can be +, but string & char can't
    str2 += "testtestlenlenlen"
    //str += ch
    str.append(ch)
    [str+"看看 "].count
    
    /*************************************/
    ch="\u{301}"
    ch = "\u{65}\u{301}"
    ch = "\u{1112}\u{1161}\u{11AB}"
    str="---\u{1112}"
    str2="\u{1161}---"
    str.characters.count
    str2.characters.count
    str += str2
    str.characters.count
    
}

func string_function(){
    
    let str = "Hey, String, it is a code day"
    str.hasPrefix("Hello")
    str.hasSuffix("day")
    str.capitalizedString
    str
    str.uppercaseString
    str.lowercaseString
    
    var str2="我 AB｛😊>1"
    for i in str2.utf8 {
        //putchar(Int32(i))
        print("_\(i), ")
    }
    for i in str2.utf16 {
        //putchar(Int32(i))
        print("_\(i), ")
    }
    for i in str2.unicodeScalars {
        print("\(i.value)-\(i), ")
    }
    
    //join
    let str3 = ",  *"
    ["123", "456", "我坏蛋"].joinWithSeparator(str3)
    
    //trim
    let str4 = "   ,,,,fjdafjda    fdafda....    "
    str4.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    str4.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " .*"))
}


func index_range(){
    
    var str="It is a cold, winter~day   ! it a a test !~"
    let str2="我是 conan, 我 怕~谁？"
    /*************************************/
    // Split 1
    str.componentsSeparatedByString(" ")
    str.componentsSeparatedByString("  ")
    str2.componentsSeparatedByString(" ")
    // Split 2
    str.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: " ~,"))
    str2.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: " ~,"))
    
    /*************************************/
    let start = str.startIndex
    _ = str.endIndex
    var offset = start.advancedBy(10)
    var strRange = Range<String.Index>(start:start,end:offset)
    
    str.rangeOfString("cold")
    str.rangeOfString("Cold", options: NSStringCompareOptions.CaseInsensitiveSearch)
    str.rangeOfString("Cold", options: NSStringCompareOptions.CaseInsensitiveSearch, range: strRange)
    
    str.substringFromIndex(offset)
    str.substringToIndex(offset)
    strRange = Range<String.Index>(start:start.successor(),end:offset.predecessor())
    str.substringWithRange(strRange)
    
    /*************************************/
    str = "0123456789ABCDEF"
    offset = start.advancedBy(3)
    str.insert("啊", atIndex: offset)
    str.removeAtIndex(offset.successor())
    
    strRange = Range<String.Index>(start:offset, end:str.endIndex.predecessor())
    str.removeRange(strRange)
    
    strRange = Range<String.Index>(start:str.startIndex.successor(), end:offset)
    str.stringByReplacingCharactersInRange(strRange, withString: "哈哈😄Tes\nt")
}
 
//string_base()
//string_function()
//index_range()
