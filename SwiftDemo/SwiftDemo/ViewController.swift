//
//  ViewController.swift
//  SwiftDemo
//
//  Created by 侨品汇 on 2017/11/22.
//  Copyright © 2017年 陈博. All rights reserved.
//

import UIKit

//MARK: 7.枚举
/*
 swift中的枚举在创建时候不会被赋予默认值(0,1,2,3)，只有当枚举被指定类型时候才会默认赋予原始值
 **/
enum Rank {
    case Ace
    
    // 多个枚举成员可以出现在同一行上
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    // swift枚举值可以存储任意类型的值
    case qrCode(String)
    
}
//MARK: 指定枚举类型
enum Rank2: Int {
    case one = 1 // 如果不指定1，默认是0
    case two, three
    func simpleDescri() -> String {
        switch self {
        case .one:
            return "ace"
        default:
            return String(self.rawValue)
        }
    }
}

//MARK: 递归枚举（indirect）
// 有一个或多个枚举成员使用该枚举类型的实例作为关联值，indirect放在单个枚举成员之前表示该成员可递归，放在enum之前表示所有成员都可以
indirect enum ArithmeticExpression {
    case number(Int)
    case multiplication(ArithmeticExpression,ArithmeticExpression)
    
}
struct Resolutions {
    var width = 0
    var height = 0
}






class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.simpleValue()
//        self.classDemo()
        self.closureFunction()
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
        let enptyArray2 = [String]()
        
        // 创建一个带有默认值的集合
        let threeDoubles = Array(repeating: 0.0, count: 3)
        let fourDoubles = Array(repeating:1.0,count:3)
        let addDoublesArray = threeDoubles + fourDoubles
        
        // 数组字面量构造数组
        var literalArray: [String] = ["a","b","c","d","e","f"]
        // 修改数组元素
        literalArray[2...5] = ["1","2"]
        print("\(literalArray)")
        
        // 数组的遍历除了forin之外还可以用enumerated()
        for (index,value) in literalArray.enumerated() {
            print("index:\(index):\(value)")
        }
        
        //MARK: Set集合用来存储相同类型没有确定顺序的值
        // set空集合
        var letters = Set<Character>()
        // 字面量
        var lettersSet: Set = ["1","3","2"]
        var lettersSet2: Set<String> = ["4","0","5"]
        var lettersSet3: Set = ["3","2","7"]
        
        // 将两个集合合并进行sorted()排序
        var addLetters = lettersSet.union(lettersSet2).sorted()
        // 将两个set中不同元素放到一个新的集合中
        var symmetriLetters = lettersSet.symmetricDifference(lettersSet2).sorted()
        
        // 将不在lettersSet3中的元素组合成一个新的set
        var subtracLetters = lettersSet.subtracting(lettersSet3).sorted()
        
        print("addLetters：\(addLetters),symmetriLetters:\(symmetriLetters),subtracLetters:\(subtracLetters)")
        
        
        //MARK: 字典
        // 创建空字典
        var namesOfIntegers = [Int: String]()
        var dict = ["1":"a","2":"b"]
        dict.updateValue("c", forKey: "2")
        print("\(dict)")
        
        
        let emptyDict = Dictionary<String,Float>()
        
        print("集合:",fruitList,fruitDict,emptyArray,emptyDict)
        
        //MARK: 3.控制流
        let scoreArray = [100,40,30,200,1000]
        var teamScore = 0
        
        //MARK: forin遍历
        // 如果不需要每一项的值，可以用"_"来代替
        for score in scoreArray {
            // if控制流中条件必须是一个bool表达式
            if score > 50 {
                teamScore += 3
            }else{
                teamScore += 1
            }
        }
        print("控制流",teamScore)
        
        //MARK: Repeat-While
        var repeatValue = 20
        repeat {
            repeatValue -= 1
            print("repeatValue:\(repeatValue)")
        } while repeatValue > 0
        
        //MARK: Switch
        // 在判断枚举类型的时候必须穷举所有情况
        let switchStr = "a"
        // 匹配到可执行的代码之后会终止switch，不用显示添加break
        switch switchStr {
        case "a","A":
            print("\(switchStr)")
        default:
            print("Not Found")
        }

        // 区间匹配
        let switchNumber = 50
        switch switchNumber {
        case 0..<40:
            print("0-40")
        default:
            print(">= 40")
        }
        
        // 值绑定 - case 分支允许将匹配的值绑定到一个临时的常量或变量，并且在case分支体内使用，可以用where来判断额外的条件
        let switchPoint = (2,0)
        switch switchPoint {
        case (let x, 0) where x < 1:
            print("绑定到的值:\(x)")
        case (0,let y):
            print("绑定到的值:\(y)")
        default:
            print("default")
        }
        
        
        //MARK: 控制转移语句
        /*
         Continue: 离开本次循环，重新开始下次循环，不会离开循环体
         break: 结束整个控制流的执行
         fallthrough: switch中代码块执行到fallthrough会直接贯穿到default中
         
         **/
        //MARK: 提前退出-guard
        
        func greet(person:[String: String]){
            guard let name = person["name"]
                else {
                print("Not found key of name")
                    return
            }
            print("name = \(name)")
        }
        
        
        
        
        
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
        
        
        let ace = Rank.Two;
        let four = Rank.Four
        
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
    
    //MARK: 5.函数
    func actionFunction() {
        // -> 指定函数返回值
        func greet(name: String, day: String) -> String {
            return "hello:\(name),today is \(day)"
        }
        print(greet(name: "张三", day: "2017"))
        
        //MARK: 用元祖表示多个返回值
        func getGasPrices() -> (String,String,String){
            return("hello","word","me")
        }
        print("元祖表示多个返回值\(getGasPrices())")
        
        
        // 在没有对返回的元祖元素进行非nil判断时候将元祖变成optionl类型，可以为nil
        func minMax(array:[Int]) -> (min:Int, max:Int)? {
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                }else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin,currentMax)
        }
        let minMaxArray = minMax(array: [8,1,2,33,-12,322])
        print("max = \(minMaxArray?.max ?? 100),min = \(minMaxArray?.min ?? 100)")
        
        //MARK: 参数标签和参数名称
        // 每个函数参数都有一个参数标签( argument label )以及一个参数名称( parameter name )。参数标签在调用函 数的时候使用;调用的时候需要将函数的参数标签写在对应的参数前面。参数名称在函数的实现中使用。默认情 况下，函数参数使用参数名称来作为它们的参数标签
        func someFunction(argumentLabel functionName: Int){
            print("\(functionName)")
        }
        someFunction(argumentLabel: 10)
        
        // 参数标签用"_"代替，在调用函数的时候会忽略掉参数标签
        func someFunction2(_ functionName: Int){
            print("\(functionName)")
        }
        someFunction2(10)
        
        //MARK: 参数默认值，如果给含有默认值参数不传参数，函数内部默认调用参数会使用默认值
        func defaultFunction(parameter1: Int,parameter2: Int = 12){
            print("\(parameter2)")
        }
        
        
        
        
        
        //MARK: 可变参数 ，一个函数最多拥有一个可变参数
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
        
        
        //MARK: 输入输出参数,在函数内部修改外部传入的参数值时候需要在参数定义前加inout，并且传入的参数加&，表示这个值可以被函数修改。
        func swapTwoInts(_ a: inout Int, _ b: inout Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt = \(someInt), anotherInt = \(anotherInt)")
        
        
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
    //MARK: 6.闭包(闭包是引用类型)
    func closureFunction(){
        
        //MARK: 内联闭包
        /* 闭包表达式语法，不能对参数设置默认值
            闭包的函数体部分由关键字 in 引入
            内联闭包表达式中，函数和返回值类型都写在大括号内，而不是 大括号外
         { (parameters) -> returnType in
         statements
         }
        **/
        let names = ["a","e","c","o","h","c"]
        let reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 < s2 } )
        
        // 根据上下文推断类型
        // 一般的内联闭包能够推断出闭包的参数类型和返回值类型，通过隐藏return来隐式返回单行表达式的结果
        let newNames = names.sorted(by: {s1,s2 in s1 > s2})
        
        // 参数名称缩写
        // 内联闭包可以进行参数缩写，直接通过$0,$1,$2来顺序表示
        let newNames2 = names.sorted(by: {$0 < $1})
        print("\(newNames2)")
        
        // 更简化的运算符方法
        let newNames3 = names.sorted(by: >)
        
        
        //MARK: 尾随闭包
        // 如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
        
        func someFunctionClosure(closure:() -> Void){
            
        }
        // 当闭包表达式是函数的唯一参数的时候，可以省略()
        someFunctionClosure {
            
        }
        
        let digitNames = [0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
                          5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"]
        let numbers = [16,56,510]
        
        let strings = numbers.map { (number) -> String in
            var number = number
            var output = ""
            repeat{
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        print("转换之后数字对应的字符串:\(strings)")
        
        
        //MARK: 值捕获
        // 闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值
        func makeIncrementer(forIncrement amout: Int) -> () -> Int{
            var runningTotal = 0
            func incrementer() -> Int {
                // 在函数外部捕获了runningTotal和amout变量的引用，捕获引用保证在调用完makeIncrementer之后runningTotal和amout不会消失并且保证下一次runningTotal下一次执行incrementer依旧存在
                
                runningTotal += amout
                return runningTotal
            }
            return incrementer
        }
        
        let incrementTen = makeIncrementer(forIncrement: 10)
        // 在调用的时候需要加上()
        print("\(incrementTen())")
        
        //MARK: 逃逸闭包(@escaping)
        class someClass {
            var x = 10;
            // 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸
            var completionHandlers: [() -> Void] = []
            func someFunctionWithEscapingClosure(completionHanler: @escaping () -> Void){
                completionHandlers.append(completionHanler)
                
            }
            
            // 创建一个非逃逸闭包
            func someFunctionWithNoEscapingClosue(closure: () -> Void){
                closure()
            }

            func dosomeThings() {
                // 使用逃逸闭包需要显式调用self
                someFunctionWithEscapingClosure {
                    self.x = 100
                }
                someFunctionWithNoEscapingClosue {
                    x = 200
                }
            }
        }
        
        let instance = someClass()
        instance.dosomeThings()
        
        print("instance.x = \(instance.x)")
        
        //MARK: 自动闭包
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: { customersInLine.remove(at: 0) } )
        
        func serves(customer customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serves(customer: customersInLine.remove(at: 0))

    }
    
    
    //MARK: 8.类和结构体
    /* 相同点
     1. 定义属性用于存储值
     2. 定义方法用于提供功能
     3. 定义下标操作使得可以通过下标语法来访问实例所包含的值
     4. 定义构造器用于生成初始化值
     5. 通过扩展以增加默认实现的功能
     6 实现协议以提供某种标准功能
     
     类比结构体更多的功能点:
     1. 继承允许一个类继承另一个类的特征
     2. 类型转换允许在运行时检查和解释一个类实例的类型 • 析构器允许一个类实例释放任何其所被分配的资源
     3. 引用计数允许对一个类的多次引用
     **/
    
    struct Resolution {
        var width = 0
        var height = 0
    }
    
    class VideoModel {
        var resolution = Resolution()
        var interface = false
        var name: String?
    }
    
    //MARK: 结构体的逐一成员构造器,类没有
    let vga = Resolution(width: 100, height: 100)
    
    
    //MARK: 类和枚举都是值类型,在传递的过程中其值会被拷贝,所有的基本类型都是值类型(底层都是使用结构体实现)，类是引用类型
    /*
     当改变vga的width = 1000的时候，hd中的width仍然是100
     var hd = vga
     **/
    
    
    //MARK: 恒等运算符，===表示两个类类型是否引用同一个实例，!== 与之相反
    
    
    //MARK: 9.属性
    // 常量存储属性用let 变量存储属性用var
    struct FixedLengthRange {
        var firstValue: Int
        let length: Int
        // 只有当调用的时候才会实例化 Lazy 声明的属性
    }
    // 当 rangeOfThreeItems是常量的时，rangeOfThreeItems所有属性都是不可变常量，这和引用类型的类不同
    
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

