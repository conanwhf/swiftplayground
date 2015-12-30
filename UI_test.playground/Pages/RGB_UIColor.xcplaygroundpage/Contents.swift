//: [Previous](@previous)

import UIKit

let view = UIView(frame:CGRectMake(0.0, 0.0, 480,  640.0))

//16进制颜色与UIColor互转
func HexToColor(color: String) -> UIColor {
     let char = color.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString.characters
        
    // String should be 6 or 8 characters
    guard char.count >= 6 else{
        return UIColor.clearColor()
    }

    var res:UInt32   = 0
    let st = String(char.dropFirst(char.count-6))
    guard NSScanner.localizedScannerWithString(st).scanHexInt(&res) else {
        return UIColor.clearColor()
    }
    
    let rgb = (r: Float((res & 0xFF0000)>>16), g: Float((res & 0xFF00)>>8), b: Float(res & 0xFF))
    return UIColor(red: CGFloat(rgb.r/255.0), green: CGFloat(rgb.g/255.0), blue: CGFloat(rgb.b/255.0), alpha: 1.0)
}

func colorToHex(color: UIColor) -> (String, CGFloat) {
    var rgba: (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
    color.getRed(&rgba.0, green: &rgba.1, blue: &rgba.2, alpha: &rgba.3)
    return (String(format:"%02X%02X%02X",Int(rgba.0*255), Int(rgba.1*255),Int(rgba.2*255)),  alpha: rgba.3)
}

view.backgroundColor = HexToColor("#44558F")
colorToHex(view.backgroundColor!)