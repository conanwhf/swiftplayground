//: [Previous](@previous)

import UIKit

var backView = UIView(frame:CGRectMake(0.0, 0.0, 320.0,  480.0))

func textFiled() {
        let textField = UITextField(frame: CGRectMake(10,160,200,30))
        //设置边框样式为圆角矩形
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.returnKeyType = UIReturnKeyType.Done
        backView.addSubview(textField)
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text)
        return true
    }
}

func showHTML() {
    let html = "<div style=\"background-color:#F1F1F1; font-size:14px; color:#304182; \n  text-align:center; margin-left:10px; padding-right:10px\"> \n<p>iOS <span style=\"font-size:18px; color:#E88834;\">Developer</span> Tips</p>中文\n</div>"
    //let html = "<div style=\"text-align: center;\"><img alt=\"\" border=\"0\" src= \"http://img1.cache.netease.com/catchpic/2/27/27ED954D15175AF0BD2A89E0040B1D44.jpg\"><br> <br> 爆炸地点位于二楼。<br> 测试结束"
    let opt = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
    
    let text = try? NSMutableAttributedString(data: html.dataUsingEncoding(NSUnicodeStringEncoding)!, options:opt, documentAttributes: nil)
    //NSMutableAttributedString(string: html, attributes: opt)
    
    let textLayer: CATextLayer = CATextLayer()
    textLayer.frame = CGRectMake(10, 60, 300, 400)
    textLayer.string =  text
    backView.layer.addSublayer(textLayer)
}

backView.backgroundColor = UIColor.grayColor()
//textFiled()
showHTML()
backView

