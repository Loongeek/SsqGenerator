//
//  ViewController.swift
//  SimpleSsqGenerator
//
//  Created by loongeek on 6/26/16.
//  Copyright © 2016 loongeek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    
    private var resultNumber:[Int]{
        set {
            if newValue.count == 7{
                let numberStr = newValue.reduce("", combine: {(str, number) in
                    return str + String(number)+" "
                    })
                let lastNumberWidth = String(newValue[6]).characters.count+1
                let numberColoredStr = NSMutableAttributedString(string: numberStr)
                numberColoredStr.setAttributes(
                    [NSForegroundColorAttributeName : UIColor.redColor()],
                    range: NSRange(location: 0, length: numberStr.characters.count))
                numberColoredStr.setAttributes([NSForegroundColorAttributeName : UIColor.blueColor()], range: NSRange(location: numberStr.characters.count-lastNumberWidth,length: lastNumberWidth))
                result.attributedText = numberColoredStr
                
            }
            else{
                result.attributedText = NSAttributedString(string: "个数错误")
            }
        }
        get{
            return self.resultNumber
        }
    }
    @IBAction func generate(sender: UIButton) {
//        resultNumber = generateNumber()
        resultNumber = generateNumberUsingWebAPI()
    }
    
    private func generateNumberUsingWebAPI()->[Int]{
        let redNumber = generateNumberUsingWebAPI(1,max: 33,count: 6)
        let blueNumber = generateNumberUsingWebAPI(1,max: 16,count: 1)
        return redNumber + blueNumber
    }
    
    private func generateNumberUsingWebAPI(min:Int, max:Int, count:Int)->[Int]{
        //make http request
        //request
        //translate returned result
        return [Int]()
    }
    
    private func generateNumber()->[Int]{
        var redNumber = Set<Int>()
        while redNumber.count<6{
            redNumber.insert(Int(random()%33+1))
        }
        let blueNumber = Int(random()%16+1)
        var result = [Int]()
        for number in redNumber{
            result.append(number)
        }
        result.append(blueNumber)
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

