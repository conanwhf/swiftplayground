//: Playground - noun: a place where people can play
import Foundation

let TESTURL = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip="

func getDataFromURL() -> NSData? {
    let url = NSURL(string:TESTURL)!
    var data :NSData? = nil
    
    /* 一般情况，直接拿NSData
    // Get data by NSData
    guard data = NSData(contentsOfURL: url)  else{
        print("Can't get any data")
        return nil
    }
    return data
    */
    
    //如果需要针对网站预先处理
    do {
        var st :String = try String.init(contentsOfURL: url)
        // TODO: 任意特殊处理部分
        /*Hardcode 测试数据, dict 模式
        {
            "person": {
                "employees": 
                [
                    {"id": 1, "firstName": "Bill", "lastName": "Gates"},
                    {"id": 2, "firstName": "George", "lastName": "Bush"}
                ],
            "boss": [
                    {"id": 1, "firstName": "Bill", "lastName": "Gates"}
            ]
        }}
        */
        //st="{\n            \"person\": {\n                \"employees\": \n                [\n                    {\"id\": 1, \"firstName\": \"Bill\", \"lastName\": \"Gates\"},\n                    {\"id\": 2, \"firstName\": \"George\", \"lastName\": \"Bush\"}\n                ],\n            \"boss\": [\n                    {\"id\": 1, \"firstName\": \"Bill\", \"lastName\": \"Gates\"}\n            ]\n        }}"
        data = st.dataUsingEncoding(NSUTF8StringEncoding)
    } catch {
        print("Cant get data from URL, \(error)")
    }
    
    // for test, save to file
    //let manager = NSFileManager.defaultManager()
    //manager.createFileAtPath( NSHomeDirectory()+"/wether.json" , contents: data, attributes: nil)
    
    return data
}


func parserJSON(){
    guard let data = getDataFromURL() else {  exit(0)  }
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        json
        // Dict case
        let dic : NSDictionary? = json["person"] as? NSDictionary
        // Array case
        let arr : NSArray? = dic?["employees"] as? NSArray
        arr?.count
        
        // 实际URL测试数据
        let res  = json as? NSDictionary
        print("You're at: \(res?["city"]), \(res?["country"])")
        
    } catch {
        print("JSONObjectWithData: \(error)")
    }
}



func createJSON(){
    //利用字典NSDictionary转换为键/值格式的数据。
    // 如果数组或者字典中存储了  NSString, NSNumber, NSArray, NSDictionary, or NSNull 之外的其他对象,就不能直接保存成文件了.也不能序列化成 JSON 数据.
    let dict: [NSObject : AnyObject] = ["name":"me", "do":"something", "with":"her", "address":"home"]
    // 判断当前对象是否能够转换成JSON数据.YES if obj can be converted to JSON data, otherwise NO
    if NSJSONSerialization.isValidJSONObject(dict) {
        do {
            let jsonData: NSData = try NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
            jsonData.writeToFile(NSHomeDirectory()+"/dict.json", atomically: true)
            print("\(NSString(data: jsonData, encoding: NSUTF8StringEncoding))")
        }  catch {
            print("JSON数据生成失败，请检查数据格式")
        }
    }
    
    //通过JSON序列化可以转换数组，但转换结果不是标准化的JSON格式。
    let array: [AnyObject] = ["qn","18","ya","wj"]
    if NSJSONSerialization.isValidJSONObject(array) {
        do {
            let data: NSData = try NSJSONSerialization.dataWithJSONObject(array, options: .PrettyPrinted)
            data.writeToFile(NSHomeDirectory()+"/test.json", atomically: true)
            print("\(NSString(data: data, encoding: NSUTF8StringEncoding))")
        } catch {
            print("JSON数据生成失败，请检查数据格式")
        }
    }
}

parserJSON()
createJSON()
