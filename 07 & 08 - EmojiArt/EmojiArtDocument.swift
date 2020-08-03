//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by SK Ruban on 14/7/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

// ViewModel

// Need Observable Object for ViewModel
class EmojiArtDocument: ObservableObject {
    
    // static as it doesn't depend on the Instance
    static var palette: String = "🥕🥥🥝🏓🔥🦀🌴"
    
    @Published private var emojiArt: EmojiArt {
        // Watches for changes and stores to UserDefaults
        didSet {
            // print("json = \(emojiArt.json?.utf8 ?? "nil")")
            UserDefaults.standard.set(emojiArt.json, forKey: EmojiArtDocument.untitled)
        }
    }
    
    private static let untitled = "EmojiArtDocument.Untitled"
    
    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.untitled)) ?? EmojiArt()
        fetchBackgroundImageData()
    }
    
    // Published because changes will redraw the View
    @Published private(set) var backgroundImage: UIImage?
    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
    
    // MARK: - Intents
    
    func removeEmoji(_ emoji: EmojiArt.Emoji){
        if let index = emojiArt.emojis.firstIndex(matching: emoji){
            emojiArt.emojis.remove(at: index)
        }
    }
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    func setBackgroundURL(_ url: URL?){
        //.imageURL uses extension to grab IMAGE URL from complicated URLs
        emojiArt.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }
    
    private func fetchBackgroundImageData() {
        backgroundImage = nil
        if let url = self.emojiArt.backgroundURL {
            // Dispatch to Background Queue
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url) {
                    // Execute UI changes ONLY on Main thread
                    DispatchQueue.main.async {
                        // Check whether it's the image the user wants to place incase of lag
                        if url == self.emojiArt.backgroundURL {
                            self.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
}

// Why is Extension here???
extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y))}
}
