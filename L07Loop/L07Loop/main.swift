//
//  main.swift
//  L07Loop
//
//  Created by zhanghl on 16/1/6.
//  Copyright © 2016年 zhanghl. All rights reserved.
//

import Foundation

var arrayTest:[String] = []

for index in 1...100{
    arrayTest.append("Items:\(index)")
}

//
//for tmp in arrayTest{
//    print(tmp)
//}
//print(arrayTest)

//
//var arrayCount = arrayTest.count
//while arrayCount>0{
//    arrayCount--
//    print(arrayTest[arrayCount])
//}

var dirt = ["name":"test","age":11]

for(key,value)in dirt{
    print("\(key):\(value)")
}
