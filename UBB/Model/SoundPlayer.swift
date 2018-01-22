//
//  SoundPlayer.swift
//  unlockMe
//
//  Created by Jonah Alle Monne on 18/11/2017.
//  Copyright © 2017 Jonah Alle Monne. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPlayer {
    
    static var audioPlayer :AVAudioPlayer?
    
    static func validSound() -> Void {
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "valid", ofType: "mp3")!)
        print(alertSound)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! audioPlayer = AVAudioPlayer(contentsOf: alertSound)
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
    }
}
