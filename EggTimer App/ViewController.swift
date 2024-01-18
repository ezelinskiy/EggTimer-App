//
//  ViewController.swift
//  EggTimer App
//
//  Created by Evgeniy Zelinskiy on 18.01.2024.
//

import UIKit
import AVFoundation

enum EggType: String {
    case soft = "Soft"
    case medium = "Medium"
    case hard = "Hard"
}

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        secondPassed = 0
        progressView.progress = 0.0
        progressView.isHidden = false
        
        var currentEggType: EggType?
        if sender.currentTitle != nil {
            titleLabel.text = sender.currentTitle!
            currentEggType = EggType(rawValue: sender.currentTitle!)
        }
        switch currentEggType {
        case .soft:
            totalTime = 300
        case .medium:
            totalTime = 420
        case .hard:
            totalTime = 720
        case .none: break
        }
        
        if totalTime > 0 {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            progressView.progress = Float(secondPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            progressView.isHidden = true
            playDoneSound()
        }
    }
    
    func playDoneSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

