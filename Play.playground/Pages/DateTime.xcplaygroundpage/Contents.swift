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

//判断是否同一天
func isSameDay(when:NSDate, now:NSDate=NSDate()) -> Bool {
    let fmt: NSDateFormatter = NSDateFormatter()
    fmt.dateFormat = "yyyy-MM-dd"
    return (fmt.stringFromDate(now) == fmt.stringFromDate(when))
}

//比较两个时间
func compareTime(when:NSDate, now:NSDate=NSDate()) -> String {
    let calendar: NSCalendar = NSCalendar.currentCalendar()
    //计算两个日期之间的差值,NSCalendarUnit枚举代表想获得哪些差值
    let unit: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute]
    let cmps: NSDateComponents = calendar.components(unit, fromDate: when, toDate: now, options: .MatchStrictly)
    //print(cmps)
    if cmps.year != 0 {
        return "\(cmps.year.distanceTo(0)) 年" + (cmps.year>0 ? "前" : "后")
    }
    if cmps.month != 0 {
        return "\(cmps.month.distanceTo(0)) 个月" + (cmps.month>0 ? "前" : "后")
    }
    if cmps.day != 0 {
        return "\(cmps.day.distanceTo(0)) 天" + (cmps.day>0 ? "前" : "后")
    }
    if cmps.hour != 0 {
        return "\(cmps.hour.distanceTo(0)) 小时" + (cmps.hour>0 ? "前" : "后")
    }
    if cmps.minute != 1 {
        return "\(cmps.minute.distanceTo(0)) 分钟" + (cmps.minute>0 ? "前" : "后")
    }
    return "刚刚"
}

/**判断当前时间是否处于某个时间段内 */
func validateWithStartTime(start: NSDate, withExpireTime expire: NSDate, time:NSDate = NSDate() ) -> Bool {
    return time.compare(start) == .OrderedDescending && time.compare(expire) == .OrderedAscending
}

let a=getNSDateByString("Thu Oct 16 17:06:25 +0700 2015",fmt: "EEE MMM dd HH:mm:ss Z yyyy")!
getStringByNSDate(NSDate())
getWeekFromLocal()
compareTime(NSDate(), now: a)
isSameDay(a,now:a)
validateWithStartTime(getNSDateByString("2016-05-05 21:17:00")!, withExpireTime: getNSDateByString("2017-05-05 21:20:00")!)