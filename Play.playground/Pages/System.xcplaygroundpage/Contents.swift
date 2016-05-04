//: [Previous](@previous)

import UIKit

var str = "Hello, playground"

//: [Next](@next)

func getDiskSize()->(free:Int, total: Int){
    let fm = NSFileManager.defaultManager()
    do {
        let fattributes = try fm.attributesOfFileSystemForPath(NSHomeDirectory())
        let free = fattributes[NSFileSystemFreeSize] as? Int
        let total = fattributes[NSFileSystemSize] as? Int
        return (free!/1000_000_000, total!/1000_000_000)
    } catch {
        print("\(error)\n")
    }
    return (0,0)
}

func isHTTPEnable() -> Bool {
    let flag = UIDevice.currentDevice().systemVersion.compare("9.0.0", options: NSStringCompareOptions.NumericSearch)
    
    if (flag != .OrderedAscending) {
        guard let infoDict = NSBundle.mainBundle().infoDictionary else {
            return false
        }
        guard let appTransportSecurity = infoDict["NSAppTransportSecurity"] else {
            return false
        }
        guard let allowsArbitraryLoads = appTransportSecurity["NSAllowsArbitraryLoads"] else{
            return false
        }
        guard let res = allowsArbitraryLoads else {
            return false
        }
        return res as! Bool 
    }
    else{// if system version<9.0.0, always allow
        return true
    }
}



//getDiskSize()
//isHTTPEnable()