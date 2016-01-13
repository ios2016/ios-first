//
//  main.swift
//  L10Object
//
//  Created by zhanghl on 16/1/7.
//  Copyright © 2016年 zhanghl. All rights reserved.
//

import Foundation

class T1{
    func sayHello(name:String){
        print("hello \(name)")
    }
}


var cc = T1()
cc.sayHello("张三")


class T01:T1{

    override func sayHello(name: String) {
        print("child say hello \(name)")
        super.sayHello(name)
    }
}


var cb = T01()
cb.sayHello("李四")

class ab{
    var _name:String
    init(name:String){
        self._name=name
    }
    
    func sayHello(){
        print("hello \(_name)")
    }
}

var adfa = ab(name:"王五")
adfa.sayHello()
