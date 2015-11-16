//
//  Game.swift
//  Simon
//
//  Created by Kevin Mann on 11/13/15.
//  Copyright © 2015 Freedom Software. All rights reserved.
//

import Foundation

public enum GameColors: String {
    case Red = "red"
    case Blue = "blue"
    case Green = "green"
    case Yellow = "yellow"
}

public enum GameStatus: String {
    case Unstarted = "unstarted"
    case Started = "started"
    case Animating = "animating"
}


class Game {
    
    var currentSequence: [GameColors]
    var currentSequenceLength: Int
    var currentStatus: GameStatus
    
    init() {
        currentSequenceLength = 0
        currentSequence = []
        currentStatus = GameStatus.Unstarted
    }
    
    func getNextSequence() -> [GameColors] {
        currentSequenceLength++
        currentSequence.removeAll()
        for _ in 1...currentSequenceLength {
            currentSequence.append(getRandomColor())
        }
        return currentSequence
    }
    
    func getRandomColor() -> GameColors {
        let randomNumber = arc4random_uniform(4) + 1
        if randomNumber == 1 {
            return GameColors.Red
        } else if randomNumber == 2 {
            return GameColors.Blue
        } else if randomNumber == 3 {
            return GameColors.Green
        } else {
            return GameColors.Yellow
        }
    }
    
    func setStatus(status: GameStatus) {
        currentStatus = status
    }
    
    func getCurrentStatus() -> GameStatus {
        return currentStatus
    }
    
}