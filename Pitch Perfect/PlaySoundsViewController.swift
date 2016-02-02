//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Uras Mutlu on 01/02/16.
//  Copyright © 2016 Uras Mutlu. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var player:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathURL)
        audioEngine = AVAudioEngine()
        let soundPath = receivedAudio.filePathURL
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        
        do {
            player = try AVAudioPlayer(contentsOfURL: soundPath)
        }
        catch {
            print("Path problem")
        }
        
        player.enableRate = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowButtonPressed(sender: UIButton) {

        playAudio(0.5)
        
    }

    @IBAction func fastButtonPressed(sender: UIButton) {
        
        playAudio(2.0)
    }
    
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    @IBAction func chipmunkButtonPressed(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func vaderButtonPressed(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func playAudio(rate: Float) {
        
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        player.stop()
        player.rate = rate
        player.currentTime = 0.0
        player.play()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
