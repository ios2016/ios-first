//
//  main.swift
//  L08Flow
//
//  Created by zhanghl on 16/1/7.
//  Copyright © 2016年 zhanghl. All rights reserved.
//

import Foundation

for i in 1...100{
    if i%5==0 {
        print("index:\(i)")
    }
    
}


var myName:String? = "test"

myName=nil
if let name=myName{
    print("hello \(name)")

}

myName="zhangsan"

if myName==nil{
    print("没有name 不用hello")
}else{
    print("else 还需要hello \(myName)")
}

