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
                    // map turns String into array of Strings
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
                    // Background Image
                    Color.white.overlay(
                        OptionalImage(uiImage: self.document.backgroundImage)
                            .scaleEffect(self.zoomScale)
                            .offset(self.panOffset)
                    )
                    .gesture(self.doubleTapToZoom(in: geometry.size))
                    .onTapGesture {
                        self.selectedEmojis.removeAll()
                        print(self.selectedEmojis)
                    }
                    
                    // Dropped Emojis
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(animatableWithSize: emoji.fontSize * self.zoomScale)
                            .position(self.position(for: emoji, in: geometry.size))
                            .onTapGesture {
                                self.selectedEmojis.toggleMatching(emoji)
                            }
                            .gesture(self.dragEmojis(for: emoji))
                            .shadow(color: self.emojiSelected(emoji) ? .blue : .clear , radius: 10)
                    }
                }
                // Prevents Image from clipping
                .clipped()
                .gesture(self.panGesture())
                .gesture(self.zoomGesture())
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                    // For Drag & Drop Image
                    // of: The types being dropped
                    // providers: the dropped items
                    // location: drop location
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    // Convert iPad Coords to Centre Coords
                    var location = geometry.convert(location, from: .global)
                    location =  CGPoint(
                        x: (location.x - geometry.size.width/2 - self.panOffset.width) / self.zoomScale,
                        y: (location.y - geometry.size.height/2 - self.panOffset.height) / self.zoomScale
                    )
                    return self.drop(providers: providers, at: location)
                }
            }
        }
    }
    
    // For Pinching Gesture
    // Use @State because temporary
    @State private var steadyStateZoomScale: CGFloat = 1.0
    @GestureState private var gestureZoomScale: CGFloat = 1.0
    
    @State var selectedEmojis: Set<EmojiArt.Emoji> = []
    
    private func emojiSelected(_ emoji: EmojiArt.Emoji) -> Bool {
        selectedEmojis.contains(matching: emoji)
    }
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale){ latestGestureScale, gestureZoomScale, transaction in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { finalGestureScale in
                self.steadyStateZoomScale *= finalGestureScale
            }
    }
    
    @GestureState private var emojiOffset: CGSize = .zero
    
    private func dragEmojis(for emoji:EmojiArt.Emoji) -> some Gesture {
        DragGesture()
            .updating($emojiOffset) { latestDragGestureValue, emojiOffset, transaction in
                emojiOffset = latestDragGestureValue.translation / self.zoomScale
            }
            .onEnded { finalDragGestureValue in
                let distanceDragged = finalDragGestureValue.translation / self.zoomScale
                for emoji in self.selectedEmojis {
                    self.document.moveEmoji(emoji, by: distanceDragged)
                }
            }
    }
    
    @State private var steadyStatePanOffset: CGSize = .zero
    @GestureState private var gesturePanOffset: CGSize = .zero
    

    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }

    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, transaction in
                gesturePanOffset = latestDragGestureValue.translation / self.zoomScale
            }
            .onEnded { finalDragGestureValue in
                self.steadyStatePanOffset = self.steadyStatePanOffset + (finalDragGestureValue.translation / self.zoomScale)
            }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    self.zoomToFit(self.document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize){
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            self.steadyStatePanOffset = .zero
            self.steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        CGPoint(
            x: ((emoji.location.x * zoomScale) + size.width/2 + panOffset.width),
            y: ((emoji.location.y * zoomScale) + size.height/2 + panOffset.height)
        )
    }
    
    // Drop Image
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


