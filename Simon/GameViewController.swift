//
//  ViewController.swift
//  Simon
//
//  Created by Kevin Mann on 11/12/15.
//  Copyright © 2015 Freedom Software. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var startGameButton: UIButton!
    
    var game: Game = Game()
    var currentSequence: [GameColors] = []
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateButton(button: UIButton, delay: Double) {
        let startingColor = button.backgroundColor
        UIView.animateWithDuration(0.20, delay: delay, options: [], animations: { () -> Void in
            button.backgroundColor = UIColor.blackColor()
        }, completion: {(finished:Bool) in
            UIView.animateWithDuration(0.20, animations: { () -> Void in
                button.backgroundColor = startingColor
            }, completion: {(finished:Bool) in })
        })
    }
    
    // See http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func animateSequence() {
        game.setStatus(GameStatus.Animating)
        let delayInterval = 1.0
        
        for (i, color) in self.currentSequence.enumerate() {
            delay(delayInterval*Double(i)) {
                
                if color == GameColors.Red {
                    self.animateButton(self.redButton, delay: 0.0)
                } else if color == GameColors.Blue {
                    self.animateButton(self.blueButton, delay: 0.0)
                } else if color == GameColors.Green {
                    self.animateButton(self.greenButton, delay: 0.0)
                } else {
                    self.animateButton(self.yellowButton, delay: 0.0)
                }
                
            }
        }
        
        delay(delayInterval*Double(currentSequence.count)) {
            self.game.setStatus(GameStatus.Started)
        }
    }
    
    func continueGame(color: GameColors, expectedColor: GameColors) {
        if color != expectedColor {
            gameOver()
        } else {
            if currentSequence.count == 0 {
                score++
                startGameButton.setTitle("SCORE: \(score)", forState: .Normal)
                let alert = UIAlertController(title: "Correct!", message: "You matched the sequence! Continue to try a longer sequence...", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: { action in
                    switch action.style {
                    default:
                        self.startGameAction(self)
                    }
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func gameOver() {
        startGameButton.setTitle("START GAME", forState: .Normal)
        game = Game()
        score = 0
        let alert = UIAlertController(title: "Game Over", message: "Sorry, you chose the wrong color! Hit the start game button to try again", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func redButtonAction(sender: AnyObject) {
        if game.getCurrentStatus() == GameStatus.Started {
            animateButton(redButton, delay: 0.0)
            let colorRemoved = currentSequence.removeFirst()
            continueGame(GameColors.Red, expectedColor: colorRemoved)
        }
    }
    @IBAction func blueButtonAction(sender: AnyObject) {
        if game.getCurrentStatus() == GameStatus.Started {
            animateButton(blueButton, delay: 0.0)
            let colorRemoved = currentSequence.removeFirst()
            continueGame(GameColors.Blue, expectedColor: colorRemoved)
        }
    }
    @IBAction func greenButtonAction(sender: AnyObject) {
        if game.getCurrentStatus() == GameStatus.Started {
            animateButton(greenButton, delay: 0.0)
            let colorRemoved = currentSequence.removeFirst()
            continueGame(GameColors.Green, expectedColor: colorRemoved)
        }
    }
    @IBAction func yellowButtonAction(sender: AnyObject) {
        if game.getCurrentStatus() == GameStatus.Started {
            animateButton(yellowButton, delay: 0.0)
            let colorRemoved = currentSequence.removeFirst()
            continueGame(GameColors.Yellow, expectedColor: colorRemoved)
        }
    }
    @IBAction func startGameAction(sender: AnyObject) {
        startGameButton.setTitle("SCORE: \(score)", forState: .Normal)
        if game.getCurrentStatus() != GameStatus.Animating {
            currentSequence = game.getNextSequence()
            game.setStatus(GameStatus.Started)
            animateSequence()
        }
    }
}

