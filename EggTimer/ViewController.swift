//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    let times: [String : Int] = [
        "Soft" : 5,
        "Medium" : 7,
        "Hard" : 12,
    ]
    var cookTime: Int = 0
    var timer = Timer()
    var counter = 0
    var player = AVAudioPlayer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //Stop the timer if it is already running
        timer.invalidate()
        progressBar.progress = 0.0
        
        //Set variables to get cooktime
        let hardness = sender.currentTitle!
        cookTime = times[hardness]!
        counter = cookTime
        
        //Update label for the egg type you selected
        myLabel.text = "Starting Timer for \(hardness)"

        //Start a timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        let increment = (100 / Float(counter + 1)) / 100

        if cookTime > 0 {
            //increment the progress bar
            progressBar.progress += increment
            
            //Update the cooktime in the console
            print ("\(cookTime) seconds.")
            cookTime -= 1
        } else {
            //Do the final progress bar increment
            progressBar.progress += increment
            
            //turn off the timer
            timer.invalidate()
            
            //update label text to done
            myLabel.text = "Done"
            
            //play alarm when finished
            playAlarm()
        }
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: url!)

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
