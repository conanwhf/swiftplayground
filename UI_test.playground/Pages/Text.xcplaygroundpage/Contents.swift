//: [Previous](@previous)

import UIKit

let backView = UIView(frame:CGRectMake(0.0, 0.0, 480,  640.0))
let frame = CGRectMake(20, 30, 360, 500)

func textFiled() {
        let textField = UITextField(frame: frame)
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
    let post = UITextView(frame: frame)
    let opt = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
    let img_width = Int(post.frame.width / 2 )
    let fontsize = 16

    let test1 = "<div style=\"background-color:#F1F1F1; font-size:14px; color:#304182; \n  text-align:center; margin-left:10px; padding-right:10px\"> \n<p>iOS <span style=\"font-size:18px; color:#E88834;\">Developer中文测试</span> Tips</p>\n</div>"
    let test2 = "<div><img border=\"0\" src=\"http://img3.cache.netease.com/cnews/2015/12/24/2015122414411004ab6.jpg\"/></div><br/>现场图<br/><br/><img border=\"0\" src=\"http://img4.cache.netease.com/cnews/2015/12/24/2015122414411078bf4.jpg\"/><br/><br/>邓景辉<br/><br/><br/>据南华早报微博消息，早上约7时12分，香港太古城宝安阁一名40多岁男子从高处堕下，救护员接报到场，将堕楼男子送东区医院抢救后不治。警方正调查事件。据报堕楼的男子为有“新闻王子”之称的亚视前主播邓景辉。dbc行政总裁罗灿已到东区医院了解事件。<br/><br/><b>个人经历</b><br/><br/>测试结束<br/><br/>"
    var config = "img{max-width:\(img_width)px !important;}"   //img style
    config.appendContentsOf("body {font-size:\(fontsize)px;}")   //body style
    config.appendContentsOf("h1{font-size: \(fontsize+4)px}")      //title style
    config = "<head><style>" + config + "</style></head>"
    
    let html = config + "<h1>标题测试</h1><hr/>" + test1 + test2
    
    do{
        let attributedString = try NSMutableAttributedString(data: html.dataUsingEncoding(NSUnicodeStringEncoding)!, options:opt, documentAttributes: nil)
        post.attributedText = attributedString
        
        backView.addSubview(post)
    }catch {print(error)}
}

/**
 显示X的n次方
 */
func showX_N(n:Int){
    let fontsizeX:CGFloat = 40.0
    let fontX = UIFont(name: "Helvetica", size: fontsizeX)
    let fontN = UIFont(name: "Helvetica", size: fontsizeX/2)
    let post = UITextView(frame: frame)
    let strN = "\(n)"
    
    let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: "X"+strN, attributes: [NSFontAttributeName:fontX!])
    attributedString.setAttributes([NSFontAttributeName:fontN!,NSBaselineOffsetAttributeName: fontsizeX/2], range: NSRange(location:1,length:strN.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
    post.attributedText = attributedString
    
    backView.addSubview(post)
}


/*获取字符串的宽度和高度*/
func contentCellWithText(text: String, font: UIFont?, maxWidth: CGFloat = CGFloat.max, maxHeight: CGFloat = CGFloat.max) -> CGSize {
    let textFont = (font==nil ? UIFont(name: "Arial", size: 20)! : font!)
    let tdic = [NSFontAttributeName : textFont]
    var size: CGSize = CGSizeMake(CGFloat.max, CGFloat.max)
   
    size = text.boundingRectWithSize(size, options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: tdic, context: nil).size
    return size
}

//打印当前可用字体
func printAllFonts() {
    let fontFamilies = UIFont.familyNames()
    for i in fontFamilies {
        let names = UIFont.fontNamesForFamilyName(i)
        print("Famliy: \(i)- \(names)")
    }
}

//检查某字体是否已经下载
func isFontDownloaded(fontName: String) -> Bool {
    let aFont = UIFont(name: fontName, size: 12.0)
    let isDownloaded: Bool = (aFont != nil && (aFont?.fontName.compare(fontName) == .OrderedSame  || aFont?.familyName.compare(fontName) == .OrderedSame ))
    return isDownloaded
}

backView.backgroundColor = UIColor.grayColor()
//textFiled()
//showHTML()
//showX_N(3)
//contentCellWithText("测试", font: UIFont(name: "Arial", size: 40))
//printAllFonts()
isFontDownloaded("Arial")
