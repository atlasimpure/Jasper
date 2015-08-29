//
//  ViewController.swift
//  EyeBalls
//
//  Created by Jasper on 5/12/15.
//  Copyright (c) 2015 Jasper. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController
{
  var currentValue = 0
  var targetValue = 0
  var score = 0
  var round = 0
    
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setSliderImageForSlider()
        startNewGame()
        updateLabels()
    }
    
    func setSliderImageForSlider()
    {
        var thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft")
        {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight")
        {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
    }
    
    
    @IBAction func Showalert()
    {
        let difference = abs(currentValue - targetValue)
        
        var points = (100 - difference)
        
        var title: String
        if difference == 0
        {
            title = "Nailed it! Super Bonus!"
            points += 100
        }
        else if difference < 5
        {
            title = "So close, you get bonus points!"
            if difference == 1
            {
            points += 50
            }
        }
        else if difference < 10
        {
            title =  "Try a little harder!"
        }
        else
        {
            title = "That's the best you can do?"
        }
        
        score += points
        
        let message = "You stopped on: \(currentValue)"
                    + "\nYou were aiming for: \(targetValue)"
                    + "\nYou got: \(points)"
        
        let alert = UIAlertController(  title: title,
                                        message: message,
                                        preferredStyle: .Alert)
        
        let action = UIAlertAction( title   : "Ready? Aim! And...",
                                    style   : .Default,
                                    handler :
                                    {
                                    action in
                                    self.startNewRound()
                                    self.updateLabels()
                                    })
        

        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider)
    {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver()
    {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }
    func startNewRound()
    {
        round = round + 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels()
    {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame()
    {
        score = 0
        round = 0
        startNewRound()
    }
}

