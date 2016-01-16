//: [Previous](@previous)

import UIKit

let backView = UIView(frame:CGRectMake(0.0, 0.0, 100.0,  300.0))

func transform(demo: UIView) {
    //缩放参数
    let sx =  200 / demo.frame.width
    let sy =  200 / demo.frame.height
    let transf_scale = CGAffineTransformMakeScale(sx, sy)
    //旋转参数
    let transf_rotate = CGAffineTransformMakeRotation(CGFloat(Double(90) * M_PI  / 180.0))

    //case 1, rotate(scale, x)
    demo.transform = CGAffineTransformRotate(transf_scale, CGFloat(Double(90) * M_PI  / 180.0))
demo.frame.size     //600*67
//print("case 1, res=\(demo.transform)")

    //case 2, scale(rotate, x)
    demo.transform = CGAffineTransformScale(transf_rotate, sx, sy)
demo.frame.size     //200*200
//print("case 2, res=\(demo.transform)")
    
    //case 3, scale+rotate
    demo.transform = CGAffineTransformConcat(transf_scale, transf_rotate)
demo.frame.size     //200*200
//print("case 3, res=\(demo.transform)")
    
    //case 4, rotate+scale
    demo.transform = CGAffineTransformConcat(transf_rotate, transf_scale)
demo.frame.size     //600*67
//print("case 4, res=\(demo.transform)")

}


func corner(demo: UIView){
//圆角
    demo.layer.cornerRadius = 60;
    demo.layer.masksToBounds = true;
    demo.layer.cornerRadius = CGRectGetHeight(demo.frame)/2;
    demo.layer.cornerRadius = CGRectGetWidth(demo.frame)*2;
    demo.layer.cornerRadius = min(demo.frame.height, demo.frame.width)/2
}

backView.backgroundColor = UIColor.blackColor()
//corner(backView)
transform(backView)
backView
