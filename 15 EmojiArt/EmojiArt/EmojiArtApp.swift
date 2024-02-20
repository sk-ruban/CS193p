//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Ruban on 2024-02-17.
//

import SwiftUI

@main
struct Emoji_ArtApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: { EmojiArtDocument() }) { config in
            EmojiArtDocumentView(document: config.document)
        }
    }
}
