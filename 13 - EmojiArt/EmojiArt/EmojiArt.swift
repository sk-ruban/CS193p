//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by SK Ruban on 14/7/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import Foundation
// Don't need Swift UI for Model
// Model

// When using Codable protocol, all members must be codable
// Codable ensures JSON usability
struct EmojiArt: Codable {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Codable, Hashable {
        let text: String
        var x: Int      // Offset from the centre
        var y: Int      // Offset from the centre
        var size: Int
        let id: Int
        
        // fileprivate - Cannot create Emoji outside this file
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int){
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    // Failable init
    init?(json: Data?) {
        // if there is JSON, we get a newEmojiArt
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!){
            self = newEmojiArt
        } else {
            return nil
        }
    }
    
    init() { }
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int){
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiId))
    }
}
