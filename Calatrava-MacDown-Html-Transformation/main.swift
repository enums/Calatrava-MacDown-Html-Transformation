//
//  main.swift
//  MarkDownHerf
//
//  Created by 郑宇琦 on 2016/12/14.
//  Copyright © 2016年 Enum. All rights reserved.
//

import Foundation

extension String {
    static func readFromFile(path: String) -> String {
        let url = URL.init(fileURLWithPath: path)
        let data = try! Data.init(contentsOf: url)
        let str = String.init(data: data, encoding: String.Encoding.utf8) ?? ""
        return str
    }
}

guard CommandLine.arguments.count == 3 else {
    print("Error: arguments have to be [InputPath][OutputPath]")
    exit(0)
}


let inPath = CommandLine.arguments[1]
let outPath = CommandLine.arguments[2]


let inData = String.readFromFile(path: inPath)
var outData = inData.replacingOccurrences(of: "href=", with: "target=\"_blank\" href=")
let bodyBegin = outData.range(of: "<body>")!.upperBound
let bodyEnd = outData.range(of: "</body>")!.lowerBound
outData = outData.substring(with: bodyBegin..<bodyEnd)

try! outData.write(toFile: outPath, atomically: true, encoding: .utf8)


print("done")
