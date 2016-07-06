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
        return generateRedBall().sort() + generateBlueBall()
    }
    
    private func generateRedBall()->[Int]{
        var redBalls = Set<Int>()
        var tempRedBalls:[Int]?
//        var reEntryCount = 0
        repeat{
//            reEntryCount = reEntryCount + 1
//            print("reEntrying: \(count)")
            tempRedBalls = generateNumberUsingWebAPI(1,max:33, count:6-redBalls.count)
            for member in tempRedBalls!{
                redBalls.insert(member)
            }
        }while(redBalls.count < 6)
        return [Int](redBalls)
    }
    
    private func generateBlueBall()->[Int]{
            return generateNumberUsingWebAPI(1,max: 16,count: 1)
    }
    
    
    private func generateNumberUsingWebAPI(min: Int,  max: Int, count: Int)->[Int]{
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let urlString = "https://www.random.org/integers/?num=\(count)&min=\(min)&max=\(max)&col=1&base=10&format=plain&rnd=new"
        
        let condition = NSCondition()
        session.dataTaskWithURL(NSURL(string: urlString)!){ [unowned self] (data, response, error) in
            condition.lock()
            if let errors = error {
//                    print("Error: \(error)")
                    self.errorOccured = errors
                } else if let data = data{
//                    print("DATA:\n\(String(data).utf8)\nEND DATA\n")
                    self.dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                }
            condition.signal()
            condition.unlock()
        }.resume()
        
        condition.lock()
        condition.wait()
        session.finishTasksAndInvalidate()
        condition.unlock()

        if let string = dataString where errorOccured==nil{
                return parseDataString(string as String)
        }
        else{
            return [Int]()
        }
    }
    
    private func parseDataString(string:String)->[Int]{
        let result =  string.componentsSeparatedByString("\n")
        return result[0 ..< result.count-1].map({Int($0)!})
    }
}

