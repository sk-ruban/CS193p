//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by SK Ruban on 14/7/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument

    var body: some View {
        VStack {
            ScrollView(.horizontal){
                HStack {
                    ForEach(EmojiArtDocument.palette.map { String($0) }, id: \.self ) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.defaultEmojiSize))
                            .onDrag { NSItemProvider(object: emoji as NSString) }
                    }
                }
            }
            .padding(.horizontal)
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                            // With Group don't need a View for the else case
                            Group {
                                if self.document.backgroundImage != nil {
                                    Image(uiImage: self.document.backgroundImage!)
                                }
                            })
                        .edgesIgnoringSafeArea([.horizontal, .bottom])
                        // For Drag & Drop Image
                        .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                            // Convert iPad Coords to Centre Coords
                            var location = geometry.convert(location, from: .global)
                            location =  CGPoint(
                                x: location.x - geometry.size.width/2,
                                y: location.y - geometry.size.height/2
                            )
                            return self.drop(providers: providers, at: location)
                    }
                    
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(self.font(for: emoji))
                            .position(self.position(for: emoji, in: geometry.size))
                    }
                }
            }
        }
    }
    
    private func font(for emoji: EmojiArt.Emoji) -> Font {
        Font.system(size: emoji.fontSize)
    }
    
    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        CGPoint(
            x: emoji.location.x + size.width/2,
            y: emoji.location.y + size.height/2
        )
    }
    
    // Drag & Drop Image
    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            print("dropped \(url)")
            self.document.setBackgroundURL(url)
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
            }
        }
        return found
    }
    
    private let defaultEmojiSize: CGFloat = 40
}

//struct EmojiArtDocumentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiArtDocumentView()
//    }
//}


