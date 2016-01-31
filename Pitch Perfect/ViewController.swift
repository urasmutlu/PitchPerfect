//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Uras Mutlu on 31/01/16.
//  Copyright © 2016 Uras Mutlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.hidden = false
        stopButton.hidden = false
        //TODO: Record audio
    }

    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true
        stopButton.hidden = true
    }
}

