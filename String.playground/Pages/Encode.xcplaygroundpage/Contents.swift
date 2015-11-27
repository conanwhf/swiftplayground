//: [Previous](@previous)

import Foundation


func strReEncode(st:String)->String{
    
    var name = ""
    
    print("那 些 年 我 们 一 起 读 过 的 文 学 经 典（ 套 装 共 11   册".dataUsingEncoding(NSUTF8StringEncoding))
    
    var st="%E9%82%A3 %E4%BA%9B% E5%B9%B4 %E6%88%91 %E4%BB%AC %E4%B8%80 %E8%B5%B7% E8%AF%BB %E8%BF%87 %E7%9A%84 %E6%96%87 %E5%AD%A6 %E7%BB%8F %E5%85%B8 %EF%BC%88 %E5%A5%97 %E8%A3%85 %E5%85%B1 11 %E5%86%8C"
    st = st.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range:nil)
    
    let arr=st.componentsSeparatedByString("%")
    var i = 1
    
    while i<arr.count
    {
        var temp = arr[i]+arr[i+1]+arr[i+2]
        let tail = arr[i+2].characters.dropFirst(2)
        temp.characters.count
        let range = temp.startIndex.advancedBy(6)..<temp.endIndex
        temp.removeRange(range)
        
        
        //}
        /*
        for j in temp.utf8 {
        if Int(j)>64 {
        n += (Int(j)-65+10)
        }
        else {
        n += (Int(j)-48)
        }
        }
        n
        
        */
        for index in temp.characters.indices{
            switch temp[index]
            {
                //  case "0"..."1": n += Int(temp[index])
                // case "A"..."F":
            default: break
            }
            
            //n += Int(string.characters[index])
        }
        
        //let n=UInt16(arr[i])!<<8+UInt16(arr[i+1])!<<4
        let n=0xe982A3
        name+="那"
        name += String(tail)
        i += 3
    }
    
    return name
}


var test="那"
test.characters.count
for i in test.utf8 {
    Int(i)
}
for i in test.characters.indices{
    test[i]
}

/*
var str = "{\"test\":\"\\Ue982a3\\u82a3\"}";
/*
var json =
try NSJSONSerialization.JSONObjectWithData(str.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: NSJSONReadingOptions.MutableLeaves)

(json as! NSDictionary).objectForKey("test")
*/
NSCharacterEncodingDocumentAttribute
NSStringEncodingDetectionUseOnlySuggestedEncodingsKey

NSString *encodedString = (NSString *)

CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,

(CFStringRef)urlString,

(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",

NULL,

kCFStringEncodingUTF8);

*/


