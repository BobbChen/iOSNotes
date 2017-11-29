//
//  ArcViewController.swift
//  SwiftDemo
//
//  Created by 侨品汇 on 2017/11/29.
//  Copyright © 2017年 陈博. All rights reserved.
//

import UIKit


//MARK: 自动引用计数
// 引用计数仅仅应用于类的实例，结构体和枚举是值类型，不是引用类型


class ArcViewController: UIViewController {

    // 可选项会被初始化为nil，不会用到person的实例
    var person1: Person?
    var person2: Person?
    var person3: Person?

    var john: Person?
    var unit4A: Apartment?
    
    var carder: Customer?
    
    var paragraph: HTMLElement?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        
        
        // Person的新实例会赋给person1，person1到Person新实例之间会建立一个强引用
        person1 = Person(name: "DADY");
        
        // 现在Person的新实例已经有三个强引用了
        person2 = person1
        person3 = person1
        
        
        // 将person的所有强引用断开之后，Arc会销毁Person的实例
        person2 = nil
        person1 = nil
        person3 = nil
        
        //MARK: 类之间的循环强引用
        john = Person(name: "john")
        unit4A = Apartment(unit: "4A")
        
        // 将john和unit4A之间建立强引用关系
        john!.apartment = unit4A
        unit4A!.tenant = john
        
        /*
         将john和unit4A设置为nil之后Person和Apartment的实例并没有被ARC销毁，因为对Person和Apartment的实例还有Apartment和john
         **/
        john = nil
        unit4A = nil
        
        
        //MARK: 解决实例之间的循环引用(弱引用和无主引用)
        /*
         weak: 适用于两个属性的值都允许为nil
         unowned: 适用于一个属性的值允许为nil，另一个允许为nil
         隐式解析可选属性: 两个属性值都不允许为nil
         **/
        
        //持卡人的customer属性是无主引用，unowned和weak类似
        carder = Customer(name: "carder")
        carder?.card = CreditCard(number: 123_321_321, customer: carder!)
        carder = nil
        
        
        paragraph = HTMLElement(name: "p", text: "HELLO")
        print(paragraph!.asHTML)
        
        
        
    }
}
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being init")
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinit")
    }
}
class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
        print("\(unit) is being init")

    }
    // weak 弱引用
    weak var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinit")
    }
}

class CreditCard {
    let number:UInt64
    //无主引用
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("card \(number) being deinit")
    }
}

class Customer {
    let name:String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) being deinit")
    }
}


class Country {
    let name: String
    // 通过加上!将capitalCity设置为隐式解析可选类型
    var capitalCity: City!
    init(name: String, capitalName:String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    // 无主引用
    unowned let country:Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//MARK: 闭包引起的循环引用
class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        /* 在闭包内，需要定义捕获列表来防止循环引用，捕获列表放在最开始的地方
           如果被捕获的应用绝不会变成nil，则应该将闭包内的捕获定义为无主引用，反之则为弱引用
        **/
        [unowned self] in
        
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}















