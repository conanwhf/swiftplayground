//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let APIURL = "http://api.openweathermap.org/data/2.5/weather?q=China,bj&lang=zh_cn"


if let url = NSURL(string: APIURL) {
    
    if let jsonData = NSData(contentsOfURL: url) {
        
        if let jsonObj:NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.allZeros, error:nil) as? NSDictionary{
            
            if let weathers:NSArray = jsonObj["weather"] as? NSArray {
                
                var weatherSummary = "北京天气情况："
                
                for weather in weathers {
                    
                    if let desc:String = weather["description"] as? String {
                        
                        weatherSummary += desc + " "
                        
                    }
                    
                }
                
                print(weatherSummary)
                
            }
            
        }
        
    }
    
}


