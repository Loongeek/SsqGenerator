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
    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var generatorButton: UIButton!
    
    private var resultNumber:[Int]{
        set {
            if newValue.count == 7{
                result.text = "显示结果😁"
                var curIndex = 0
                for ballLabel in ballView.subviews{
                    if let ball = ballLabel as? UILabel{
                        if ball.tag == 0{
                            ball.text = String(newValue[curIndex])
                            curIndex += 1
                        }
                        else{
                            ball.text = String(newValue[6])
                        }
                    }                }
            }
            else{
                result.text = "对不起，生成出错😭"
            }
            generatorButton.enabled = true
        }
        get{
            return self.resultNumber
        }
    }
    
    @IBAction func generate(sender: UIButton) {
        result.text = "生成结果..."
        generatorButton.enabled = false
        resultNumber = generateNumber()
    }
    
    private func generateNumber()->[Int]{
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.       
        for ballLabel in ballView.subviews {
            if let ball = ballLabel as? UILabel{
                if ball.tag == 0{
                    ball.backgroundColor = UIColor(patternImage: UIImage(named: "RedBall")!)
                }
                else{
                    ball.backgroundColor = UIColor(patternImage: UIImage(named: "BlueBall")!)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

