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
    @IBOutlet weak var redBall1: UILabel!
    @IBOutlet weak var redBall2: UILabel!
    @IBOutlet weak var redBall3: UILabel!
    @IBOutlet weak var redBall4: UILabel!
    @IBOutlet weak var redBall5: UILabel!
    @IBOutlet weak var redBall6: UILabel!
    @IBOutlet weak var blueBall: UILabel!
    @IBOutlet weak var generatorButton: UIButton!
    
    private var resultNumber:[Int]{
        set {
            if newValue.count == 7{
//                let numberStr = newValue.reduce("", combine: {(str, number) in
//                    return str + String(number)+" "
//                })
//                let lastNumberWidth = String(newValue[6]).characters.count+1
//                let numberColoredStr = NSMutableAttributedString(string: numberStr)
//                numberColoredStr.setAttributes(
//                    [NSForegroundColorAttributeName : UIColor.redColor()],
//                    range: NSRange(location: 0, length: numberStr.characters.count))
//                numberColoredStr.setAttributes([NSForegroundColorAttributeName : UIColor.blueColor()], range: NSRange(location: numberStr.characters.count-lastNumberWidth,length: lastNumberWidth))
//                result.attributedText = numberColoredStr
                result.text = "显示结果"
                redBall1.text = String(newValue[0])
                redBall2.text = String(newValue[1])
                redBall3.text = String(newValue[2])
                redBall4.text = String(newValue[3])
                redBall5.text = String(newValue[4])
                redBall6.text = String(newValue[5])
                blueBall.text = String(newValue[6])
                
            }
            else{
//                result.attributedText = NSAttributedString(string: "个数错误")
                result.text = "个数错误"
            }
            generatorButton.enabled = true
        }
        get{
            return self.resultNumber
        }
    }
    
    @IBAction func generate(sender: UIButton) {
        //        resultNumber = generateNumber()
        result.text = "获取结果中..."
        generatorButton.enabled = false
        resultNumber = generateNumberUsingWebAPI()
    }
    
    private func generateNumberUsingWebAPI()->[Int]{
        var totalRedNumber = Set<Int>()
        var totalNumber = [Int]()
        repeat{
        totalRedNumber.removeAll()
        totalNumber = HttpRandomGenerator.generateNumberUsingWebAPI(1,max: 33,count: 7)
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
    
//    
//    private func generateNumber()->[Int]{
//        var redNumber = Set<Int>()
//        while redNumber.count<6{
//            redNumber.insert(Int(random()%33+1))
//        }
//        let blueNumber = Int(random()%16+1)
//        var result = [Int]()
//        for number in redNumber{
//            result.append(number)
//        }
//        result.append(blueNumber)
//        return result
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        redBall1.backgroundColor = UIColor(patternImage: UIImage(named: "RedBall")!)
        redBall2.backgroundColor = UIColor(patternImage: UIImage(named: "RedBall")!)
        redBall3.backgroundColor = UIColor(patternImage: UIImage(named: "RedBall")!)
        redBall4.backgroundColor = UIColor(patternImage: UIImage(named: "RedBall")!)
        redBall5.backgroundColor = UIColor(patternImage: UIImage(named: "RedBall")!)
        redBall6.backgroundColor = UIColor(patternImage: UIImage(named: "RedBall")!)
        blueBall.backgroundColor = UIColor(patternImage: UIImage(named: "BlueBall")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

