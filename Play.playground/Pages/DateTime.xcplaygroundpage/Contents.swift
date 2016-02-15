//: [Previous](@previous)

import Foundation


let date: NSDate = NSDate.init()
var dateFormatter: NSDateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
let dateString=dateFormatter.stringFromDate(date)
