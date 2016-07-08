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
    
    private var generator:BallNumberGenerator = HttpRandomGenerator()
    
    private var resultNumber:[Int]{
        set {
            if newValue.count == 7{
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
                    }
                }
                result.text = "显示结果😁"
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
        dispatch_async(dispatch_queue_create("generate", nil)){ [unowned self] in
        self.resultNumber = self.generator.generate()
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.  
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
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

