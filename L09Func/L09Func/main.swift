//
//  main.swift
//  L09Func
//
//  Created by zhanghl on 16/1/7.
//  Copyright © 2016年 zhanghl. All rights reserved.
//

import Foundation

func hello(name:String){
    print("hello \(name)")
}


func t2()->(Int,String){
    return (1,"ccc")
}

hello("test")

var tet2 = t2()
print(tet2)


var (a1,a2) = t2()
print("func t2 return \(a1):\(a2)")


var h = hello

h("zhangsan")
