//
//  MusicViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 6.04.21.
//

import AVKit
import AVFoundation

extension String {
    static let ledFirstSong = "led_Mat moys skazala_master"
    static let ledSecondSong = "led_chernaya ladya_master"
    static let danheimFirstSong = "Danheim-Runar_master"
    static let danheimSecondSong = "Danheim-Kala_master"
}

class MusicViewController: UIViewController, AVAudioPlayerDelegate {
    
    static let shared = MusicViewController()
    var audioPlayer: AVAudioPlayer?
    
    var currentSoundsIndex = Int.random(in: 0...3)
    
    let soundList = [
        String.ledFirstSong,
        String.ledSecondSong,
        String.danheimFirstSong,
        String.danheimSecondSong
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackgroundMusic()
    }

    func initBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: soundList[currentSoundsIndex], ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.delegate = self
                audioPlayer.prepareToPlay()
            } catch {
                print("Don't find background music - \(error)")
            }
        }
    }

    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
    
    func playBackgroundMusic() {
        audioPlayer?.play()
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if currentSoundsIndex < soundList.count - 1 {
            currentSoundsIndex += 1
        } else {
            currentSoundsIndex = 0
        }
        
        if flag {
            initBackgroundMusic()
            playBackgroundMusic()
        } else {
            print("Did not finish successfully background music")
        }
    }
}


