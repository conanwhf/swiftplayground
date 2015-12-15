//: [Previous](@previous)

import Foundation

let _INDEX_URL = "https://raw.githubusercontent.com/GavinIsTheKing/TestXML/master/test.xml"
//let _INDEX_URL = "https://raw.githubusercontent.com/zhengkai/phpcs_test/master/ruleset.xml"


func saveURLtoFile() -> Bool {
    let manager = NSFileManager.defaultManager()        //根控制器
    let url = NSURL(string:_INDEX_URL)!
    do {
        let st = try String.init(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        let data = st.dataUsingEncoding(NSUTF8StringEncoding)
        manager.createFileAtPath( NSHomeDirectory()+"/Desktop/test.xml" , contents: data, attributes: nil)
        return true
        
    } catch {
        print(error)
        return false
    }
}

class XmlReader: NSObject, NSXMLParserDelegate {
    var currentName :String? = nil
    var level :Int = 0
    
    init(add :String ) {
        
        super.init()
        let url = NSURL(string:add)!
        guard let parserXML = NSXMLParser(contentsOfURL: url) else {
            return
        }
        saveURLtoFile()         //测试用
        parserXML.delegate = self
        parserXML.parse()
    }
    
   //文档开始时触发 ,开始解析时 只触发一次
    func parserDidStartDocument(parser: NSXMLParser) {
        print("    start")
    }
    
    
    // // 遇到文档结束时触发，进入该方法就意味着解析完成，需要清理一些成员变量，同时要将数据返回给表示层（表示图控制器） 通过广播机制将数据通过广播通知投送到 表示层
    func parserDidEndDocument(parser: NSXMLParser){
        print("    end")
    }
    
   //遇到一个开始标签触发
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        self.currentName = elementName
        self.level++
        print("\(level) start, \(elementName), \(attributeDict)")
        
        if currentName == "language" {
           // 获取language属性的内容
            //print("---------\(attributeDict)")
        }
    }
    
    
   //遇到结束标签触发，该方法主要是用来 清理刚刚解析完成的元素产生的影响，以便于不影响接下来解析
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("\(level) end, \(elementName)")
        self.currentName = nil
        self.level--
    }
    
   // 遇到字符串时 触发
    func parser(parser: NSXMLParser, var foundCharacters string: String) {
        
        //替换回车符 和空格,其中 stringByTrimmingCharactersInSet 是剔除字符的方法,[NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符;
        string = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if string.isEmpty {
            return
        }
        print("------- \(string)")
    }
    
    // 文档出错时触发
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError)
    }
    
}

//XmlReader(add: _INDEX_URL)

