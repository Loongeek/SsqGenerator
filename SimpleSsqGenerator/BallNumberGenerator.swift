//
//  RandomGenerator.swift
//  SsqGenerator
//
//  Created by loongeek on 7/4/16.
//  Copyright © 2016 loongeek. All rights reserved.
//

import Foundation

protocol BallNumberGenerator{
    //return an array of 7 numbers, first 6 are redball numbers, last one is blueball numbers
    func generate()->[Int]
}
