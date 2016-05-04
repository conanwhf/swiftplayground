//: [Previous](@previous)

import Foundation


// 设置日期格式（声明字符串里面每个数字和单词的含义）
// E:星期几
// M:月份
// d:几号(这个月的第几天)
// H:24小时制的小时
// m:分钟
// s:秒
// y:年
func getNSDateByString( s:String, fmt:String="YYYY-MM-dd HH:mm:ss")->NSDate?{
    let dateFormatter = NSDateFormatter()
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
    dateFormatter.dateFormat = fmt
    return dateFormatter.dateFromString(s)
}
func getStringByNSDate(date:NSDate, fmt:String="YYYY-MM-dd HH:mm:ss")->String{
    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
    dateFormatter.dateFormat = fmt
    return dateFormatter.stringFromDate(date)
}

//现在星期几
func getWeekFromLocal() -> String {
    let date = NSDate()
    let dateFormatter: NSDateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "EEEE"
    //EEE&other:Sat, EEEE:Saturday, EEEEE:S, EEEEEE:Sa
    let dateString = dateFormatter.stringFromDate(date)
    return dateString
}

/**
 1.今年
 1.1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 1.2> 昨天
 * 昨天 xx:xx
 1.3> 其他
 * xx-xx xx:xx
 2.非今年
 2.1> xxxx-xx-xx xx:xx
 */
func compareTime(when:NSDate, now:NSDate=NSDate()) -> String {

    func isThisYear(creatDate: NSDate) -> Bool {
        var calendar: NSCalendar = NSCalendar.currentCalendar()
        var dateCmps: NSDateComponents = calendar.components(.Year, fromDate: creatDate)
        var nowCmps: NSDateComponents = calendar.components(.Year, fromDate: NSDate())
        return dateCmps.year == nowCmps.year
    }
    
    func isToday(creatDate: NSDate) -> Bool {
        /** 另一种方法*/
        var fmt: NSDateFormatter = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        var now: NSDate = NSDate()
        var nowStr: String = fmt.stringFromDate(now)
        var dateStr: String = fmt.stringFromDate(creatDate)
        return (nowStr == dateStr)
    }
    
    func isYesterday(creatDate: NSDate) -> Bool {
        var fmt: NSDateFormatter = NSDateFormatter()
        fmt.dateFormat = "dd"
        var now: NSDate = NSDate()
        var nowStr: String = fmt.stringFromDate(now)
        var dateStr: String = fmt.stringFromDate(creatDate)
        var isSure: Bool = false
        if Int(nowStr)! - Int(dateStr)! == 1 {
            isSure = true
        }
        //WBLog(@"%d",xx);
        return isSure
    }
    
    
    //1，美国时间转为中国时间
    //2, 转为各种模式显示
    let fmt = NSDateFormatter()
    var calendar: NSCalendar = NSCalendar.currentCalendar()
    //计算两个日期之间的差值,NSCalendarUnit枚举代表想获得哪些差值
    var unit: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute]
    var cmps: NSDateComponents = calendar.components(unit, fromDate: when, toDate: now, options: .MatchStrictly)
    if isThisYear(when) {
        if isYesterday(when) {
            fmt.dateFormat = "昨天 HH:mm"
            return fmt.stringFromDate(when)
        }
        else if isToday(when) {
            if cmps.hour > 1 {
                return "\(cmps.hour)小时前"
            }
            else if cmps.minute > 1 {
                return "\(cmps.minute)分钟前"
            }
            else {
                return "刚刚"
            }
        }
        else {
            //今年其他日子
            fmt.dateFormat = "MM-dd HH:mm"
            return fmt.stringFromDate(when)
        }
    }
    else {
        //非今年
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        return fmt.stringFromDate(when)
    }
}



let a=getNSDateByString("Thu Oct 16 17:06:25 +0700 2015",fmt: "EEE MMM dd HH:mm:ss Z yyyy")
getStringByNSDate(NSDate())
getWeekFromLocal()
compareTime(a!)
