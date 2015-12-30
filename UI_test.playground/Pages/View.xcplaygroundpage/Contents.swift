//: [Previous](@previous)

import UIKit

let backView = UIView(frame:CGRectMake(0.0, 0.0, 320.0,  480.0))
backView.backgroundColor = UIColor.blackColor()

//圆角
backView.layer.cornerRadius = 60;
backView.layer.masksToBounds = true;
backView.layer.cornerRadius = CGRectGetHeight(backView.frame)/2;
backView.layer.cornerRadius = CGRectGetWidth(backView.frame)*2;
backView.layer.cornerRadius = min(backView.frame.height, backView.frame.width)/2
backView
