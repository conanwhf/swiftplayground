//: [Previous](@previous)

import Foundation

func base(){
    struct PersonalInfo{
        var birth = (year:1970, month:1,day:1){
            willSet{
                print("Will set birthday")
            }
            didSet{
                print("birtday set done!")
            }
            
        }
        var location = ""
        init(local:String){
            print("I'm from \(local)")
            location = local
        }
    }


    class MyClass{
        var name = ""
        static let male = false
        lazy var info = PersonalInfo(local: "Singapore")
        
        init(name s:String){
            name=s
            print("My name is \(s)")
        }
        
        func whoIs(){
            print(name)
        }
        
        //可读写
        var birthday:(Int, Int, Int){
            get{
                return info.birth
            }
            set(new){
                info.birth = new
            }
        }
        
        //只读(不能只写！！！)
        var sex:String{
            get{
                return MyClass.male ? "male" : "female"
            }
        }
        
        subscript(year:Int)->Int{
            get {
                return year-info.birth.year
            }
            set (newage){
                info.birth.year = year-newage
                print("\(name)'s birthday is changed to \(info.birth)!")
            }
        }
        
        subscript(local:String)->Bool{
            print("Guess: where is \(name) from \(local)?")
            return local ==  info.location
        }
    }

    struct MyStruct{
        var name = ""
        static let male = true
        lazy var info = PersonalInfo(local: "Singapore")
        
        init(name s:String){
            name=s
            print("My name is \(s)")
        }
        
        func whoIs(){
            print(name)
        }

        //可读写
        var birthday:(Int, Int, Int){
             mutating get{
                return info.birth
            }
            set(new){
                info.birth = new
            }
        }
        
        //只读(不能只写！！！)
        var sex:String{
            get{
                return MyStruct.male ? "male" : "female"
            }
        }

        subscript(year:Int)->Int{
            mutating get {
                return year-info.birth.year
            }
            set (newage){
                info.birth.year = year-newage
                print("\(name)'s birthday is changed to \(info.birth)!")
            }
        }
        
        subscript(local:String)->Bool{
            mutating get{
                print("Guess: where is \(name) from \(local)?")
                return local ==  self.info.location
            }
        }
    }


    var conan=MyClass(name: "Conan")
    var hy=MyStruct(name:"HY")
    //值类型和引用类型
    sizeofValue(conan)
    sizeofValue(hy)

    print("Test for lazy:")
    conan.info.location
    hy.info.location

    conan.birthday=(1984,11,04)
    hy.birthday=(1977,04,10)

    //类型属性
    MyClass.male
    MyStruct.male

    //下标
    conan[2015]
    conan["China"]
    hy[2015]=30
    hy["Singapore"]
}



func more_OO(){
    class Father{
        var money = 1000
        var house = 3
        
        final func showFamliy(){
            print("My famliy is Wang!")
        }
        
        func showInfo(){
            print("I have \(money) money & \(house) house!")
        }
    }
    
    class Son: Father{
        var dad:Father?=nil
        
        init(father:Father){
            super.init()
            money = father.money/3
            father.money -= money
            self.dad=father
        }
        
        init?(money:Int){
            super.init()
            print("I don't know who my father is!")
            if money < 100{
                print("Failed! No money to feed me!")
                return nil
            }
        }
        /* WRONG!!!
        override func showFamliy(){
        print("My famliy is Wang!")
        }*/
        override func showInfo(){
            print("I'm a rich son....")
        }
        
        deinit{
                print("WOW~~I'm dying")
                dad?.money+=money
        }
    }
    
    let a=Father()
    var b:Son?=Son(father: a)
    _=Son(money: 50)
    
    a.showInfo()
    b!.showInfo()
    b!.showFamliy()
    
    a.money
    b?.money
    b=nil
    a.money
    
    
    struct Poor{
        var money = 10{
            didSet{
                if money<=0 {
                    if house<=0{
                        print("No money & house, but my life will be refresh!")
                        self = Poor(money: 50, house: house, famliyName: famliyName+"R")
                    }
                    else {
                        print("No money, but I have house!")
                        self = Poor(money: money+1000, house: house-1, famliyName: famliyName)
                    }
                }
            }
        }
        var house = 0
        var famliyName="T"
        
        func reburn(){
        
        }
        
        func showInfo(){
            print("I have \(money) money & \(house) house!")
        }
    }

    var man=Poor(money: 5, house: 1, famliyName: "T")
    man.money -= 100
    man.money
    man.money -= 1000
    print(man)
}





//base()
//more_OO()
