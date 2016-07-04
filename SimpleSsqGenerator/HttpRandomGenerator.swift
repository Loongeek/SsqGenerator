//
//  HttpRandomGenerator.swift
//  SsqGenerator
//
//  Created by loongeek on 7/3/16.
//  Copyright © 2016 loongeek. All rights reserved.
//

import Foundation

typealias CompletionHandler = () -> Void

class HttpRandomGenerator : NSObject, BallNumberGenerator{
    private var completionHandlers: [String: CompletionHandler] = [:]
    
    private var errorOccured : NSError?
    private var dataString : NSString?
    private var isSessionFinished : Bool = false
    
    func generate() -> [Int] {
        var totalRedNumber = Set<Int>()
        var totalNumber = [Int]()
        repeat{
            totalRedNumber.removeAll()
            totalNumber = generateNumberUsingWebAPI(1,max: 33,count: 7)
            if totalNumber.count != 7
            {
                return totalNumber
            }
            
            for i in 0..<6{
                totalRedNumber.insert(totalNumber[i])
            }
        }while(totalRedNumber.count<6)
        
        totalNumber[6] = totalNumber[6]%16+1
        return totalNumber
    }
    
    private func generateNumberUsingWebAPI(min: Int,  max: Int, count: Int)->[Int]{
        let defaultConfiguration  = NSURLSessionConfiguration.defaultSessionConfiguration()
        let sessionWithoutADelegate = NSURLSession(configuration: defaultConfiguration)
        let urlString = "https://www.random.org/integers/?num=\(count)&min=\(min)&max=\(max)&col=1&base=10&format=plain&rnd=new"
        if let url = NSURL(string: urlString) {
            (sessionWithoutADelegate.dataTaskWithURL(url){ (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    self.errorOccured = error
                } else if let response = response,
                    let data = data{
                    print("Response: \(response)")
                    print("DATA:\n\(String(data).utf8)\nEND DATA\n")
                    self.dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                }
                    self.isSessionFinished = true
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

}

