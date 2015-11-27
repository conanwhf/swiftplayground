//: Playground - noun: a place where people can play

import UIKit

func single_arr(){
    /*************************************/
    var arr=["aaa","bbbb"]

    arr                   += ["ccc", "ddd", "eee"]
    arr.count
    //———!!!
    //using the index & new value to replace the old one, can append but the index should not out of range
    //arr[2...7] = ["0", "1", "2", "3", "4", "5"]    //WRONG
    arr[2...3]            = ["11", "22", "33", "44", "55"]
    arr
    arr.insert("BB", atIndex: 3)
    arr.removeAtIndex(5)
    arr.removeRange(1...4)

    /***************************************/
    // Some ways for traversal
    for i in arr { i }
    for i in arr.enumerate() { i }
    for i in 0...arr.count-1 {
        arr[i]  //———!!!/the arry.count is total count, need using (0..count]
    }
    for _ in 0..<arr.count {}
    for (i, j) in arr.enumerate(){
        print("i=\(i), j=\(j)")
    }

    /*************************************/
    let _                 = [Int]()
    let _:[Int]           = []
    var arr3              = Array<Int>()
    var arr4 : Array<Int> = []
    var arr5              = [Int](count:3, repeatedValue: 5)

    arr3                  = [0,1,2]
    arr4                  = [4,3]
    arr5                  = arr4 + arr3

}

func set_demo(){
    /*************************************/
    var set               = Set<Int>()
    var set2 : Set<Float>
    _                     = Set<String>(["A","B","C"])

    set                   = [1,2,3]
    //———!!!
    //the type is float so....
    set2                  = [1e-19, 12e-20, 0, 0.123456701, 0.1234567]
    set.count
    set.insert(3)
    set.insert(8)
    set.remove(5)
    set.remove(2)

    /*************************************/
    set.contains(10)
    set.contains(0)
    for i in set {
        i
    }
    /*************************************/
    let set1 : Set<Int>   = [11, 4, 0, 8]
    set
    //———!!!
    //return a new set but not change org one
    set.intersect(set1)     //求交集
    set.union(set1)         //合并
    set.exclusiveOr(set1)   //排除交集后合并
    set.subtract(set1)       //对set排除交集

    set                   = [8,0,4,11]
    set == set1
    set.isSubsetOf(set1)
    set.isSupersetOf(set1)
    set.isDisjointWith(set1)
    set.isStrictSubsetOf(set1)
    set.isStrictSupersetOf(set1)

    set.remove(4)           //[8,0,11]，真子集
    set.isSubsetOf(set1)    //为子集？
    set.isSupersetOf(set1)  //为父集？
    set.isDisjointWith(set1)    //交集为空？
    set.isStrictSubsetOf(set1)  //真子集？
    set.isStrictSupersetOf(set1)    //真父集？

    set                   = [8,0,4,11,5]//真父集
    set.isSubsetOf(set1)
    set.isSupersetOf(set1)
    set.isDisjointWith(set1)
    set.isStrictSubsetOf(set1)
    set.isStrictSupersetOf(set1)
}

func dict_demo(){
    /*************************************/
    var dict              = [7:"aaa", -1:"bbb", 4:"ccc"]
    var dict1             = Dictionary< Int, String >()
    var dict2             = [Int: Character]()

    //———!!!
    // no append(), just new or renew the value
    dict[3]="test"          //add new one
    dict
    dict[3]="aaa"
    dict[0]="test"
    dict.count
    dict[3]=nil             //delete one
    dict
    print("\(dict[7]), \(dict[7]!), \(dict[8])")

    var str               = dict.updateValue("newtest", forKey: 0)
    dict
    str                   = dict.updateValue("newtest", forKey: 3)
    dict.removeValueForKey(4)
    dict

    /*************************************/
    for i in dict{ i }
    for (i, j) in dict.enumerate(){ print("\(i)-\(j)") }
    for i in dict.enumerate(){ i }
    for (i, j) in dict{ print("\(i)-\(j)") }

    dict.keys
    dict.values
    for i in dict.keys{
        i
    }
    for i in dict.values {
        i
    }
    [Int](dict.keys)
    Array(dict.keys)
    //———!!!
    //The dict.values just list all values but not a value-set
    Array(dict.values)
}


func more_array(){
    var a2D                = Array <Array<Int>>()
    var a3D :[ [ [Int] ] ] = [
        [ [ 0, 1, 2],   [11, 12, 13] ],
        [ [ 21, 22, 23],   [31, 32, 33] ]
    ]

    for i in 0..<5 {
        a2D.append(Array(count:5, repeatedValue:i))
    }
    a2D

    a3D[1]                 = [ [101, 102 , 103], [8, 8, 8, 8, 8],  [5, 55, 555, 5555 ]]
    a3D.append([ [-1, -1] ])
    a3D[0][1][1]
    a3D.count
    a3D[0].count
    a3D[2].count
    a3D[1][0].count
    a3D[1][1].count

    for i in a3D.enumerate() {
        print(i)
    }

    /**************************************/
    // For this case, the array/tuple is for "ObjectType"
    var arry               = [0,111,"fda", 111]
    var test               = ("???", 1, false)
    arry[1]                = "2222"
    arry[1]                = 345
    arry[1]                = false
    arry                   = [1,2,3]
    arry                   = ["b"]

}


//single_arr()
//set_demo()
//dict_demo()
//more_array()
