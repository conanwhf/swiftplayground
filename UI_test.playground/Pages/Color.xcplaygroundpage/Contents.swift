//: Playground - noun: a place where people can play

import UIKit
let backView = UIView(frame:CGRectMake(0.0, 0.0, 320.0,  480.0))

func RGBA (r:Int, g:Int, b:Int, a:Int)->UIColor {
    return UIColor (red : CGFloat(Float(r)/255.0) , green:CGFloat(Float(g)/255.0) , blue:CGFloat(Float(b)/255.0) , alpha:CGFloat(Float(a)/255.0))
}


func showTheColor(){
    
    let colors =
    [
        "black":    (r:0,g:0,b:0,name:"黑"),
        "white":    (r:255,g:255,b:255,name:"白"),
        "red":      (r:255,g:0,b:0,name:"赤"),
        "green":    (r:0,g:255,b:0,name:"绿"),
        "blue":     (r:0,g:0,b:255,name:"蓝"),
        "grey":     (r:125,g:125,b:125,name:"灰"),
        "yellow":   (r:255,g:255,b:0,name:"黄"),
        "orange":   (r:255,g:125,b:0,name:"橙"),
        "aAA":      (r:0,g:0,b:100,name:""),
        "cCC":      (r:100,g:0,b:200,name:""),
        "fFF":      (r:0,g:200,b:100,name:""),
        "eEE":      (r:0,g:100,b:200,name:"")
    ]

    var index = 0
    
    for (i,j) in colors{
        let colorStripe = UILabel(frame: CGRectMake(0.0, CGFloat(index++ * 50), 320.0, 48.0))
        
        backView.addSubview(colorStripe)
        colorStripe.backgroundColor = RGBA(j.r, g: j.g, b: j.b, a: 255)
        //colorName.textAlignment
        colorStripe.font = UIFont(name:"Arial",size:20.0)
        colorStripe.textColor = RGBA(128-j.r, g: 128-j.g, b: 128-j.b, a: 128)
        colorStripe.text = "\(i) \(j.name)"
    }
    
    backView.backgroundColor = UIColor.purpleColor()
    
    //Another way to get the list:
    for (i,j) in colors.enumerate(){
        print("index=\(i), key=\(j.0), name=\(j.1.name)\n\t\(RGBA(j.1.r, g: j.1.g, b: j.1.b, a: 255))")
    }
}


showTheColor()

