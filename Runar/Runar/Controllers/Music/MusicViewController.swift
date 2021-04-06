//
//  MusicViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 6.04.21.
//

import UIKit
import AVKit

extension String {
    static let ledFirstSong = "led_Mat moys skazala_master"
    static let ledSecondSong = "led_chernaya ladya_master"
    static let danheimFirstSong = "Danheim-Runar_master"
    static let danheimSecondSong = "Danheim-Kala_master"
}

class MusicViewController: UIViewController, AVAudioPlayerDelegate {
    
    static let shared = MusicViewController()
    var currentSoundsIndex = Int.random(in: 0...3)
    let soundList = [String.ledFirstSong, String.ledSecondSong, String.danheimFirstSong, String.danheimSecondSong]
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
    super.viewDidLoad()
        
    playCurrentSong()
    }

    func playCurrentSong() {
    
        audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: soundList[currentSoundsIndex], ofType: "mp3")!))
   
        audioPlayer?.delegate = self
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        
    }


    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if currentSoundsIndex < soundList.count - 1 { currentSoundsIndex += 1} else {
            currentSoundsIndex = 0
        }

    playCurrentSong()
    }

}


