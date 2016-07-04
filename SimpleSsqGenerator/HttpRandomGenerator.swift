//
//  HttpRandomGenerator.swift
//  SsqGenerator
//
//  Created by loongeek on 7/3/16.
//  Copyright © 2016 loongeek. All rights reserved.
//

import Foundation

typealias CompletionHandler = () -> Void

class HttpRandomGenerator : NSObject{
    private var completionHandlers: [String: CompletionHandler] = [:]
    private static var errorOccured : NSError?
    private static var dataString : NSString?
    private static var isSessionFinished : Bool = false
    
    class func generateNumberUsingWebAPI(min: Int,  max: Int, count: Int)->[Int]{
        let defaultConfiguration  = NSURLSessionConfiguration.defaultSessionConfiguration()
        let sessionWithoutADelegate = NSURLSession(configuration: defaultConfiguration)
        let urlString = "https://www.random.org/integers/?num=\(count)&min=\(min)&max=\(max)&col=1&base=10&format=plain&rnd=new"
        if let url = NSURL(string: urlString) {
            (sessionWithoutADelegate.dataTaskWithURL(url){ (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    errorOccured = error
                } else if let response = response,
                    let data = data{
                    print("Response: \(response)")
                    print("DATA:\n\(String(data).utf8)\nEND DATA\n")
                    dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                }
                    isSessionFinished = true
                }).resume()
        }
        
        while(isSessionFinished==false){}
        if let string = dataString where errorOccured==nil{
                return parseDataString(string as String)
        }
        else{
            return [Int]()
        }
    }
}

private func parseDataString(string:String)->[Int]{
    var resultArray = [Int]()
    let numberArray = string.componentsSeparatedByString("\n")
    for numberStr in numberArray{
        if numberStr != "" {
            resultArray.append(Int(numberStr)!)
        }
    }
    return resultArray
}