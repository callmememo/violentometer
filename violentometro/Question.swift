//
//  Question.swift
//  violentometro
//
//  Created by Memo Rodriguez on 2/27/19.
//  Copyright © 2019 Guillermo Rodriguez. All rights reserved.
//

import UIKit

enum Answer: Int {
    case yes = 0
    case no = 1
}

enum Level {
    case one
    case two
    case three
    case four
    case five
}

struct Question {
    var question: String
    var answer: Answer?
    var level: Level
    
    init(question: String, level: Level) {
        self.question = question
        self.level = level
    }
}
