//
//  ViewController.swift
//  SwiftDemo
//
//  Created by 侨品汇 on 2017/11/22.
//  Copyright © 2017年 陈博. All rights reserved.
//

import UIKit

//MARK: 7.枚举和结构体
enum Rank: Int {
    case Ace = 1
    
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    
    func simpleDescri() -> String {
        switch self {
        case .Ace:
            return "ace"
        default:
            return String(self.rawValue)
        }
    }
    
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.simpleValue()
        self.classDemo()
    }

    func simpleValue(){
        //MARK: 1.常量和变量
        
        /* 变量
         在没有显示指定类型的情况下会进行类型推断，当推断浮点数的时候会优先选择Double而不是Float
         
         let intMax = Int.max + 1
         指定的数值不能超过数值类型的最大范围
         
         **/
        var age = 50
        age = 100;
        
        //typealias: 类型别名
        typealias customeType = UInt64
        let customeTypeValue: customeType = 1080
        
        // tuples: 元祖,
        let(statusCode,statusMessage) = (404,"错误")
        print("元祖：\(statusCode)")
        

        // 常量，Int类型长度与当前平台的原生字长 相同
        let years = 100
        
        // 指定声明常量的数据类型，类型标注
        let name: String = "字符串类型"
        
        // 值类型转换,两个类型不同的值需要将其中一个值进行显式转换
        let newValue  = name + String(age)
        
        let newValue2 = "new value is \(age)"
        
        
        print(age,years,name,newValue,newValue2)
        
        //MARK: 运算符
        /*
         一元运算符只对单一操作对象操作 -a
         二元运算符操作两个操作对象 a+b
         三元运算符只有一个三目运算符
         a??b 空合运算符将对可选类型a进行空判断，如果存在值就解封否则返回b
         **/
        let newValue3 = "空合运算符"
        var newValue4: String?
        var newValue5 = newValue4 ?? newValue3
        print("newValue5 == \(newValue5)")
        
        
        //MARK: 字符串和字符（字符串是值类型）
        // 初始化空字符串
        var emptyStr1 = ""
        var emptyStr2 = String()
        
        // Unicode 标量，写成 \u{n} (u为小写)，其中 n 为任意一到八位十六进制数且可用的 Unicode 位码。

        let dollarSign = "\u{1F425}"
        print("dollarSign == \(dollarSign)")
        
        
        // MARK: 2.集合
        var fruitList = ["apple","banner"]
        fruitList[1] = "oranger"
        
        var fruitDict = ["apple":100,"banner":200]
        fruitDict["cantaloupe"] = 300
        
        // 空集合
        let emptyArray = Array<String>()
        let emptyDict = Dictionary<String,Float>()
        
        print("集合:",fruitList,fruitDict,emptyArray,emptyDict)
        
        //MARK: 3.控制流
        let scoreArray = [100,40,30,200,1000]
        var teamScore = 0
        
        for score in scoreArray {
            // if控制流中条件必须是一个bool表达式
            if score > 50 {
                teamScore += 3
            }else{
                teamScore += 1
            }
        }
        print("控制流",teamScore)
        
        //MARK: 4.可选项
        var optionalString: String? = nil
        optionalString = "hello"
        
        /* 这种情况下optionalStr的可选类型为Int？表示可能有值或者为nil,在Swift中nil表示的是值缺失
 
        **/
        let optionalValue = "Optional"
        let optionalStr = Int(optionalValue)
        
        // 强制解析，当确定一个可选类型一定有值的时候可以使用强制解析取值
        var optionalV: String?
        optionalV = "optionalV"
        print("optionalV确定有值:\(optionalV!)")
        
        // 隐式解析可选类型,不需要每次获取值的时候都进行解析
        let assumedString: String! = "assumedString"
        
        // 断言assert用来检查不合法的状态，传入一个bool和一条调试信息,release模式下断言会被禁止
        let assertAge = -100
        assert(assertAge > 0,"年龄不能小于0")
        
        
        
        
        // 可选绑定
        
        if let name = optionalString {
            print("这是可选项",name)
        }
        
        
        
        
        
        let vegetable = "red pepper"
        switch vegetable {
        case "celerty":
            print("celerty")
        case "new":
            print("new")
        case let x where x.hasSuffix("pepper"):
            print("包含pepper")
        default:
            print("无匹配值")
        }
        
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25]
        ]
        var largest = 0
        var largestKind : String = ""
        
        for (kind,numbers) in interestingNumbers {
            for number in numbers {
                if number > largest{
                    largest = number;
                    largestKind = kind
                }
            }
            
        }
        print("最大值是:",largest,"所属的kind:",largestKind);
        
        /* 区间运算符
           a...b  从a到b，包括a和b
           a..<b  从a到b，但不包括b,常用于列表
         **/
        var value = 0
        for j in 0...3 {
            value += j;
        }
        print("value = ",value)
        
        
        //MARK: 5.函数和闭包
        
        // -> 指定函数返回值
        func greet(name: String, day: String) -> String {
            return "hello:\(name),today is \(day)"
        }
        print(greet(name: "张三", day: "2017"))
        
        // 用元祖表示多个返回值
        func getGasPrices() -> (String,String,String){
            return("hello","word","me")
        }
        print("元祖表示多个返回值\(getGasPrices())")
        
        /* 函数参数可变
         函数内部可以嵌套函数，被嵌套的函数可以访问外侧函数的变量
        **/
        var sum = 0
        func sumOf(numbers: Int...) -> Int {
            for number in numbers {
                sum += number
            }
            return sum
        }
        
        print("多个参数:",sumOf(numbers: 100,200,300))
        
        // 函数作为返回值返回
        func makeIncrementer() -> ((Int) -> Int){
            func addOne(number: Int) -> Int{
                return 1 + number;
            }
            return addOne(number:)
        }
        let incrementer = makeIncrementer()
        print("返回值为函数：\(incrementer(1))")
        
        // 函数作为参数传入
        func hasAnyMatches(list: [Int],codition: (Int) -> Bool) -> Bool {
            for item in list {
                if codition(item) {
                    return true
                }
            }
            return false
        }
        // 创建需要当做参数传入的函数
        func lessThanTen(number: Int) -> Bool{
            return number < 10
        }
        
        let numbers = [20,19,29,100]
        let boolValue = hasAnyMatches(list: numbers, codition: lessThanTen)
        print("\(boolValue)")
        
    }
    
    //MARK: 6.对象和类
    class shop: NSObject {
        var number: Int?
        var name: String?
        
        init(name: String) {
            self.name = name;
        }
        func simpleDescription() -> String {
            return "hahaha"
        }
    }
    class subclassOfShop: shop {
        var gender: String {
            get {
                return "get方法"
            }
            set {
                print("set方法")
                
            }
        }
        
        override func simpleDescription() -> String {
            return ("shop重写之后的方法")
        }
    }

    func classDemo(){
        let classOfShop = shop(name: "haha")
        classOfShop.number = 100
        print("shop类的描述是:\(classOfShop.simpleDescription())","类变量是:",classOfShop.number!)
        
        // 继承于shop的子类
        
        let subclass = subclassOfShop(name: "haha")
        
        subclass.gender = "男"
        
        print("\(subclass.simpleDescription()) gender == \(subclass.gender)")
        
        
        let ace = Rank.Ace;
        let four = Rank.Four
        print("枚举类型:",ace,four.rawValue)
        
        //MARK: 8.接口和扩展
        var extensionValue = 7
        print("扩展现有类的方法：",extensionValue.adjust())
        
        //MARK: 9.泛型
//        func repat<ItemType>(item: ItemType,times: Int) -> [ItemType] {
//            var result = ItemType>()
//            for i in 0...times {
//                result += item
//
//            }
//            return result
//
//        }
        
//        repat(item: "knock", times: 4)
        
    }
}
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
extension Int: ExampleProtocol{
    var simpleDescription: String {
        return "The Number \(self)"

    }
    mutating func adjust() {
        self += 42
    }
}

