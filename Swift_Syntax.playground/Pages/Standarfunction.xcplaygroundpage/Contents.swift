//: Playground - noun: a place where people can play

import UIKit

var intValue    = -10
var doubleValue = 4.15
let constArr    = [0,2,4,6,8]
let str         = "ABCDEFG"


/*************************************/
func math_values(){
    //绝对值
    abs(intValue)
    abs(doubleValue)

    //移动
    intValue.advancedBy(30)


    //生成随机数
    Int(arc4random()%100)

    //计算距离
    9.distanceTo(13)

    //长度计算
    alignof(Float)
    alignof(Int)
    alignofValue(str)
    alignofValue(constArr)

    //内存计算
    strideof(Int)
    strideofValue("  a  ")
    strideofValue([0,1,0,0])
    strideofValue([0 ])

    //包含
    constArr.contains(2)
    str.containsString("C")

    //统计元素个数
    [20...39].count
    constArr.count
    str.characters.count

    //最大最小值
    max(1, 2, 4, 8, 19, 200)
    min(0.3, 0.5, 0.111, 9.8)

    //转换成字符串
    String(constArr)
    String(doubleValue)

}


/*************************************/
func output(){
    //断言，参数如果为`true`则继续，否则抛出异常
    // assert mentioned on page 55
    assert(true, "error")

    //调试输出
    debugPrint("abc")

    //打印出某个对象object的所有信息
    dump(constArr)

    //打印
    print("Hello world")

}


/*************************************/
func multi_element(){

let arrString   = ["0x1F", "0x2E", "0x3D"]
var arr         = [1, 9, 8, 4, 11]
let arr1        = Array(arr.reverse())

    //导出对象内容
    for (i,j) in arrString.enumerate(){
        print("\(i), \(j)")
    }

    //截去第一个元素后的数组，不改变原始数组
    constArr.dropFirst()
    //截去最后一个元素后的数组，不改变原始数组
    constArr.dropLast()

    //判断两个序列是否相等
    arr.elementsEqual(arr1)


    //查找元素，第一个参数为源数据，第二个参数为目标数据
    //obj.indexOf(<#T##element: Int##Int#>)
    //返回序列sequence中某元素element的位置index。如果序列中不存在此元素，则返回nil。
    arr.indexOf(2)
    arrString.indexOf("0x2E")
    str.characters.indexOf("D")

    //过滤，第一个参数为源数据，第二个为过滤方法（闭包）
    //sequence.filter(includeElementClosure)：
    //对序列sequence中每个元素都执行includeElementClosure闭包，并将所有闭包结果为true的元素合成一个新序列sequence并返回。
    arr             = arr1.filter({ $0 > 6 } )
    arr

    //indices(sequence)：返回序列sequence中所有元素的位置（indices是index的复数）
    arr.indices

    //最大最小元素
    arr.maxElement()
    arr1.minElement()

    //连接数组元素
    //join(separator, sequence)：将序列sequence通过分隔符separator连成一个字符串，并返回此字符串。
    arrString.joinWithSeparator("---")

    //映射，map的第一个参数为源数据，第二个参数为映射的方法（闭包）
    //map(sequence, transformClosure)：
    //对序列sequence中每个元素都执行includeElementClosure闭包，并将所有闭包的结果合成一个新序列sequence并返回。
    arr             = arr1.map({ $0 + 10 })
    arr             = arr.flatMap({ $0 - 10 })
    arr

    //化简,reduce(sequence, initial, combineClosure)：
    //给定一个序列sequence，以及一个初始值initial，然后将initial和序列里的第1个元素作为参数传入combineClosure中进行运算，得到的结果保存到initial
    //然后再将initial和第2个元素传入combineClosure中计算，结果保存到initial；重复计算直到所有sequence中的元素都计算完毕，并返回最终的initial值。
    // SUM()+base
    [1,2,3].reduce(100, combine: { return $0 + $1 })    //1+100=1, 101+2=103, 103+3=106
    // *all : 1*1*9*8*4*11=3168
    arr
    arr.reduce(1, combine: { return $0 * $1 })
    //String ++ operation
    arrString.reduce(" ", combine: { $0 + $1 + $0 + $1 + "; "})

    //逆序:reverse(sequence)：返回逆序的序列sequence。
    Array(arr.reverse())

    //排序
    arr1.sort()

    //如果序列sequence1中开头的元素跟序列sequence2中的所有元素都相等，则返回true，否则返回false。
    "foobar".hasPrefix("foo")
    [10...100].startsWith([9...15])
    arr1.startsWith([11, 14, 18])
}

//math_values()
//output()
//multi_element()
