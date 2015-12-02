//: [Previous](@previous)

import Foundation

var sNum   = "01234567"// Total 8 numbers
var sEn    = "abcdEFGH .!"// Total 8 letters & 3 symbols
var sCn    = "中文测试，空格结尾。 "// Total 8 Chinese char, 2 全角标点 & 1 space

/**
 各种属性
 */
func string_attributes() {
    //为空
    sNum.isEmpty

    //Char内容
    Array(sNum.characters)
    Array(sEn.characters)
    Array(sCn.characters)

    //长度
    sNum.characters.count
    sEn.characters.count
    sCn.characters.count

    //Index
    sNum.startIndex
    sCn.endIndex
    var i      = sNum.startIndex.successor()
    sNum.endIndex.predecessor()
    sNum[i]
    i          = i.advancedBy(2)        //起始位之后3个字符，即第四个字符
    i.distanceTo(sNum.endIndex)
    sNum[i]
    sNum.characters[i]
    sCn[i]

    //大小写
    sEn.uppercaseString
    sCn.uppercaseString
    sEn.lowercaseString
    sEn.capitalizedString

    //不同的编码输出
    Array(sCn.utf8.enumerate()).count
    Array(sCn.utf16.enumerate()).count
    Array(sCn.unicodeScalars.enumerate()).count
    Array(sCn.nulTerminatedUTF8).count
}


/**
 单一String的相关操作
 */
func string_operation(){
    let offset = sNum.startIndex.advancedBy(2)// offset: 3rd char
    let range  = Range(start: sNum.startIndex.advancedBy(3), end: sNum.endIndex.advancedBy(-2))// range: 3..<6, "345"
    var st     = sNum

    //强制类型转换/格式化
    let n      = Int(sNum)!
    String("the number is \(n)")
    String(format:"%.2f,  %i", 9.1, 304)

    // 翻转
    String(sNum.characters.reverse())

    //（部分）删除
    st.removeRange(range)
    st.removeAtIndex(offset)
    st      //01567
    String(st.characters.dropFirst())
    String(st.characters.dropFirst(3))
    String(st.characters.dropLast())
    String(st.characters.dropLast(3))
    st      //以上均不改变原来的值！
    // 删除头尾空白字符
    "     I love you ".stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    // 删除头尾字符集
    " I love you, too!".stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: ",. !"))
    st.removeAll()

    //获取固定位置的子串
    sNum.substringToIndex(offset)
    sNum.substringFromIndex(offset)
    sNum.substringWithRange(range)
    sNum[range]

    //分割
    st         = "<123, test2,???>   <测试: 数据  .>"
    // 用固定字符分割
    st.componentsSeparatedByString(" ")
    // 用固定字符集分割
    st.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ", ."))

    // 过滤/替换（替换字符串为空即为过滤）
    // 替换固定位置子串
    st.stringByReplacingCharactersInRange(range, withString: "!!!")
    // 查找所有匹配并替换/过滤
    st.stringByReplacingOccurrencesOfString("???", withString: "~")
    st.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    // 过滤字符集合(分割后合并)
    let arr    = st.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString:"-<>"))
    arr.joinWithSeparator("")
}


/**
 多个String操作
 */
func more_str_operation(){
    let offset = sNum.startIndex.advancedBy(2)// offset: 3rd char
    let range  = Range(start: sNum.startIndex.advancedBy(3), end: sNum.endIndex.advancedBy(-2))
    var st     = sNum

    //合并/拼接
    sNum + sEn + sCn
    st.appendContentsOf("123")
    st.stringByAppendingString("000")         //不改变原值！
    st.stringByAppendingFormat("- num %d ", 100)      //不改变原值！
    // 以固定字符串为分隔符拼接
    [sNum, sEn, sCn].joinWithSeparator("\n")

    //插入
    st         = sNum
    st.insert(" ", atIndex: offset)
    st.insertContentsOf(" hello".characters, at: offset)
    st.replaceRange(Range( start:offset, end: offset ), with: "???OK!!!")

    //判断前缀或后缀
    sNum.hasPrefix("01")
    sNum.hasSuffix("567")

    // 比较字符串
    sEn.characters.elementsEqual(sNum.characters)
    sNum.characters.elementsEqual("01234567".characters)
    sEn == sNum
    "111" < "222"

    // 匹配字符串
    sEn.rangeOfString("efg")
    sEn.rangeOfString("efg", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)

    //部分替换
    sNum.replaceRange(range, with: "test_for_replace")
    sNum.stringByReplacingCharactersInRange(range, withString: "哈哈😄Tes\nt")
}


//string_attributes()
//string_operation()
//more_str_operation()
