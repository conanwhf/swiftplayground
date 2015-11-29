//: [Previous](@previous)

import UIKit

var str = "Hello, playground"

//: [Next](@next)

class ViewController: UIViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textField = UITextField(frame: CGRectMake(10,160,200,30))
        //设置边框样式为圆角矩形
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.returnKeyType = UIReturnKeyType.Done
        textField.delegate=self
        self.view.addSubview(textField)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text)
        return true;
    }
}

