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
    var parsedString = string.substringWithRange(string.startIndex.successor() ..< string.endIndex.predecessor())
    parsedString = parsedString.stringByReplacingOccurrencesOfString(" ", withString: "")
    let numberArray = parsedString.componentsSeparatedByString("0a")
    for numberStr in numberArray{
        if numberStr != "" {
        var number = ""
        for (index,chars) in numberStr.characters.enumerate(){
            if(index%2 != 0){
                number.append(chars)
            }
        }
            resultArray.append(Int(number)!)
        }
    }
    return resultArray
}




////首先判断能不能转换
//if (!NSJSONSerialization.isValidJSONObject(user)) {
//    print("is not a valid json object")
//    return
//}
////利用OC的json库转换成OC的NSData，
////如果设置options为NSJSONWritingOptions.PrettyPrinted，则打印格式更好阅读
//let data : NSData! = try? NSJSONSerialization.dataWithJSONObject(user, options: [])
////NSData转换成NSString打印输出
//let str = NSString(data:data, encoding: NSUTF8StringEncoding)
////输出json字符串
//print("Json Str:"); print(str)
//
////把NSData对象转换回JSON对象
//let json : AnyObject! = try? NSJSONSerialization
//    .JSONObjectWithData(data, options:NSJSONReadingOptions.AllowFragments)
//print("Json Object:"); print(json)
////验证JSON对象可用性
//let uname : AnyObject = json.objectForKey("uname")!
//let mobile : AnyObject = json.objectForKey("tel")!.objectForKey("mobile")!
//print("get Json Object:"); print("uname: \(uname), mobile: \(mobile)")
//}