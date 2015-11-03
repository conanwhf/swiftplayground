//: Playground - noun: a place where people can play

import UIKit

func single_arr(){
    /*************************************/
    var arr1=["aaa","bbbb"]
    
    arr1 += ["ccc", "ddd", "eee"]
    arr1.count
    //———!!!
    //using the index & new value to replace the old one, can append but the index should not out of range
    //arr1[2...7] = ["0", "1", "2", "3", "4", "5"]    //WRONG
    arr1[2...3] = ["11", "22", "33", "44", "55"]
    arr1
    arr1.insert("BB", atIndex: 3)
    arr1.removeAtIndex(5)
    arr1.removeRange(1...4)
    
    for i in arr1{
        i
    }
    //———!!!
    //the arry.count is total count, need using (0..count]
    for i in 0...arr1.count-1 {
        arr1[i]
    }
    for i in 0..<arr1.count {}
    for (i, j) in enumerate(arr1){
        println("i=\(i), j=\(j)")
    }
    for i in enumerate(arr1){
        i
    }
    
    /*************************************/
    let arr2 = [Int]()
    let arr3:[Int] = []
    var arr4 = Array<Int>()
    var arr5 : Array<Int> = []
    var arr6 = [Int](count:3, repeatedValue: 5)
    
    arr4 = [0,1,2]
    arr5 = [4,3]
    arr6 = arr4 + arr5
    
}

func set_demo(){
    /*************************************/
    var set = Set<Int>()
    var set2 = Set<Float>()
    var set3 = Set<String>(["A","B","C"])

    set = [1,2,3]
    //———!!!
    //the type is float so....
    set2 = [1e-19, 12e-20, 0, 0.123456701, 0.1234567]
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
    let set1 : Set<Int> = [11, 4, 0, 8]
    set
    //———!!!
    //return a new set but not change org one
    set.intersect(set1)     //求交集
    set.union(set1)         //合并
    set.exclusiveOr(set1)   //排除交集后合并
    set.subtract(set1)       //对set排除交集
    
    set = [8,0,4,11]
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
    
    set = [8,0,4,11,5]      //真父集
    set.isSubsetOf(set1)
    set.isSupersetOf(set1)
    set.isDisjointWith(set1)
    set.isStrictSubsetOf(set1)
    set.isStrictSupersetOf(set1)
}

func dict_demo(){
    /*************************************/
    var dict = [7:"aaa", -1:"bbb", 4:"ccc"]
    var dict1 = Dictionary<Int,String>()
    var dict2 = [Int, String]()
    //———!!!
    // This is a array for 元组, not dict!!!
    let try = [Int, String](count:3, repeatedValue:(0xE,"test"))
    //dump(try)
    
    /*************************************/
    //———!!!
    // no append(), just new or renew the value
    dict[3]="test"
    dict[3]="aaa"
    dict[0]="test"
    dict.count
    dict[3]=nil
    dict.count
    println("\(dict[7]), \(dict[7]!), \(dict[8])")
    
    var str = dict.updateValue("aaa", forKey: 0)
    str = dict.updateValue("new3", forKey: 3)
    dict.removeValueForKey(4)
    dict

    /*************************************/
    for i in dict{
        println(i)
    }
    for (i, j) in enumerate(dict){
        println("\(i) \(j)")
    }
    for i in enumerate(dict){
        println(i)
    }
    for (i, j) in dict{
        println("\(i)-\(j)")
    }
    
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


func arrs(){
    var a = Array <Array<Int>>()
    
    for i in 0..<10 {
        a.append(Array(count:10, repeatedValue:i))
    }
    a
}


//single_arr()
//set_demo()
//dict_demo()
arrs()

/*******************??????????????????????******************/
var arry = [0,111,"fda", 111]
var test = ("", 1, false)
arry[1] = "2222"
arry[1] = 345
arry[1] = false

arry=[1,2,3]
arry=["b"]

for i in arry{
    dump(i)
}


