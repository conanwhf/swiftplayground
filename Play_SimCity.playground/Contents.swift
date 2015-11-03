//: Playground - noun: a place where people can play

import UIKit
import XCPlayground


///

let str="fdafafsadfsda "

XCPCaptureValue("test", value: [0,1,3,4,5])
//XCPCaptureValue("test", "b")
//XCPCaptureValue("test", "c")
//XCPCaptureValue("test", "e")





/*
let Groups = [
    "原料",
    "五金",
    "农贸",
    "建材",
    "家具",
    "园艺",
    "甜品",
    "时装",
    "快餐",
    "家电",
]

/*
struct Rule {                               //生产规则，也用于表示一个可行的生产队列表
    var time:Double = 0
    var need: Array<(String, Int)>?
}
*/
let rules/*: Dictionary<String,Rule>*/ =
[
    "钢铁" :   (time: 1.0, need:1), //(time:1.0,    need:nil),
//    "木材":   (time:3.0,    need:nil),
/*    "塑料":   (9.0,    nil),
    "玻璃":   (5.0*60, nil),
    "糖":     (4.0*60, nil),
    "布":     (3.0*60, nil),
    "种子":   (20.0,   nil),
    "饲料":   (6.0*60, nil),
    "矿石":   (30.0,   nil),
    "电子元件":(7.0*60, nil),
    "化学物质":(2.0*60, nil),
    "钉子":(2.0*60, [("aaa", 3), ("bbb", 2)]),*/
]


struct GoodsInfo {
    var name:String = ""
    var group:String = Groups[0]    // 物品类别
    var level:Int = 0               // 物品级别，表示从原材料到最终产品需要多少层
    var price:Int = 0               // 价格
    var buyHard:Double = 1          // 购买难度，动态，在0.1-1.0之间
    var have:Int = 0                // 库存量
    var pic:Int = 0                 // 图片（暂时无）
    
    
}

func setHave(a:Int){            // 设置库存量
    have = a
}

func unpack()-> Array<(String, Int)>? {           // 展开
    return nil
}

func getTime(a: GoodsInfo)-> Double {     // 计算最少需要的时间，基于当前库存，原材料则为生产时间
    
    if a.group == Groups[0] {
        let temp = rules[a.name]
        return 0.0
    }
    
    //对于原材料可并行，1级以上材料同类串行，不同类并行
    var time = rules[a.name]!.time
    return time
}

/*
var things:Array< GoodsInfo > = [
    (name:"aaa", group: Groups[0], level:0, price:10, buyHard:0.1, have:0, pic:0),
]
debugprintln(things)
*/
var thing = GoodsInfo()
debugPrint(thing)

*/
