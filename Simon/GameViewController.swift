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
        UIView.animateWithDuration(0.35, delay: delay, options: [], animations: { () -> Void in
            button.backgroundColor = UIColor.blackColor()
        }, completion: {(finished:Bool) in
            UIView.animateWithDuration(0.35, animations: { () -> Void in
                button.backgroundColor = startingColor
            }, completion: {(finished:Bool) in })
        })
    }
    
    func animateSequence() {
        game.setStatus(GameStatus.Animating)
        let delay = 1.4
        
        for (i, color) in self.currentSequence.enumerate() {
            print(color)
            if color == GameColors.Red {
                self.animateButton(self.redButton, delay: delay*Double(i))
            } else if color == GameColors.Blue {
                self.animateButton(self.blueButton, delay: delay*Double(i))
            } else if color == GameColors.Green {
                self.animateButton(self.greenButton, delay: delay*Double(i))
            } else {
                self.animateButton(self.yellowButton, delay: delay*Double(i))
            }
        }
    }

    @IBAction func redButtonAction(sender: AnyObject) {
//        if game.getCurrentStatus() == GameStatus.Started {
            animateButton(redButton, delay: 0.0)
//        }
    }
    @IBAction func blueButtonAction(sender: AnyObject) {
//        if game.getCurrentStatus() == GameStatus.Started {
            animateButton(blueButton, delay: 0.0)
//        }
    }
    @IBAction func greenButtonAction(sender: AnyObject) {
//        if game.getCurrentStatus() == GameStatus.Started {
            animateButton(greenButton, delay: 0.0)
//        }
    }
    @IBAction func yellowButtonAction(sender: AnyObject) {
//        if game.getCurrentStatus() == GameStatus.Started {
            animateButton(yellowButton, delay: 0.0)
//        }
    }
    @IBAction func startGameAction(sender: AnyObject) {
        currentSequence = game.getNextSequence()
        game.setStatus(GameStatus.Started)
        animateSequence()
        
    }
}

