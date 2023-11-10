//
//  Sounds.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 10/11/2023.
//

import SwiftUI
import AVKit

class SoundManager {
    
    // Singleton Class
    // Use single instance in any class
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        // no need to explicitly set value because name is the same, if names are different - then set e.g. case tada = "tada-sound"
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error{
            print("Error playing sound! \(error.localizedDescription)")
        }
    }
}

struct Sounds: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Play sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Play sound 2") {
                SoundManager.instance.playSound(sound: .badum)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    Sounds()
}
