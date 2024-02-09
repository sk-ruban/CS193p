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
    
    @State private var chosenPalette: String = ""
    
    init(document: EmojiArtDocument) {
        self.document = document
        _chosenPalette = State(wrappedValue: self.document.defaultPalette)
    }

    var body: some View {
        VStack {
            HStack{
                PaletteChooser(document: document, chosenPalette: $chosenPalette)
                ScrollView(.horizontal){
                    HStack {
                        // map turns String into array of Strings
                        ForEach(chosenPalette.map { String($0) }, id: \.self ) { emoji in
                            Text(emoji)
                                .font(Font.system(size: self.defaultEmojiSize))
                                .onDrag { NSItemProvider(object: emoji as NSString) }
                        }
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
                    }
                    
                    // Dropped Emojis
                    if self.isLoading {
                        // Loading Image
                        Image(systemName: "hourglass").imageScale(.large).spinning()
                    } else {
                        ForEach(self.document.emojis) { emoji in
                            Text(emoji.text)
                                .font(animatableWithSize: emoji.fontSize * self.zoomScale(for: emoji))
                                .position(self.position(for: emoji, in: geometry.size))
                                .onTapGesture {
                                    self.selectedEmojis.toggleMatching(emoji)
                                }
                                .gesture(self.dragEmojis(for: emoji))
                                .gesture(self.longPress(for: emoji))
                                .shadow(color: self.emojiSelected(emoji) ? .blue : .clear , radius: 10)
                        }
                    }
                }
                // Prevents Image from clipping
                .clipped()
                .gesture(self.panGesture())
                .gesture(self.zoomGesture())
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                // Resizes when changing backgroundImage
                .onReceive(self.document.$backgroundImage) { image in
                    self.zoomToFit(image, in: geometry.size)
                }
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
            .navigationBarItems(trailing: Button(action: {
                if let url = UIPasteboard.general.url, url != self.document.backgroundURL {
                    self.confirmBackgroundPaste = true
                } else {
                    self.explainBackgroundPaste = true
                }
            }, label: {
                Image(systemName: "doc.on.clipboard").imageScale(.large)
                    .alert(isPresented: self.$explainBackgroundPaste) {
                        return Alert(
                            title: Text("Paste Background"),
                            message: Text("Copy the URL of an image to make it the background"),
                            dismissButton: .default(Text("OK")))
                }
            }))
            }
            .zIndex(-1)
        }
        .alert(isPresented: self.$confirmBackgroundPaste) {
                return Alert(
                    title: Text("Paste Background"),
                    message: Text("Replace your background with \(UIPasteboard.general.url?.absoluteString ?? "nothing")?."),
                    primaryButton: .default(Text("OK")) {
                        self.document.backgroundURL = UIPasteboard.general.url
                    },
                    secondaryButton: .cancel()
            )
        }
    }
    
    @State private var explainBackgroundPaste = false
    @State private var confirmBackgroundPaste = false
    
    var isLoading: Bool {
        document.backgroundURL != nil && document.backgroundImage == nil
    }
    
    // For Pinching Gesture
    // Use @State because temporary
    @GestureState private var gestureZoomScale: CGFloat = 1.0
    
    @State var selectedEmojis: Set<EmojiArt.Emoji> = []
    
    // Checks whether a specific emoji is selected
    private func emojiSelected(_ emoji: EmojiArt.Emoji) -> Bool {
        selectedEmojis.contains(matching: emoji)
    }
    
    // Are any emojis selected?
    private var hasSelection: Bool {
        !selectedEmojis.isEmpty
    }
    
    private func longPress(for emoji: EmojiArt.Emoji) -> some Gesture {
        LongPressGesture(minimumDuration: 1)
            .onEnded { _ in
                self.document.removeEmoji(emoji)
        }
    }
    
    private var zoomScale: CGFloat {
        //steadyStateZoomScale * gestureZoomScale
        document.steadyStateZoomScale * (hasSelection ? 1 : gestureZoomScale)
    }
    
    private func zoomScale(for emoji: EmojiArt.Emoji) -> CGFloat {
        if emojiSelected(emoji) {
            return document.steadyStateZoomScale * gestureZoomScale
        } else {
            return zoomScale
        }
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale, body: { (latestGestureScale, gestureZoomScale, transaction) in
                gestureZoomScale = latestGestureScale
            })
            .onEnded { finalGestureScale in
                if self.hasSelection {
                    // zoom selected Emojis
                    self.selectedEmojis.forEach { emoji in
                        self.document.scaleEmoji(emoji, by: finalGestureScale)
                    }
                } else {
                    self.document.steadyStateZoomScale *= finalGestureScale
                }
            }
    }
    
    @GestureState private var emojiOffset: CGSize = .zero
    
    private func dragEmojis(for emoji:EmojiArt.Emoji) -> some Gesture {
        // Extra Credit
        let isEmojiPartOfSelection = self.emojiSelected(emoji)
        
        return DragGesture()
            .updating($emojiOffset) { latestDragGestureValue, emojiOffset, transaction in
                emojiOffset = latestDragGestureValue.translation / self.zoomScale
            }
            .onEnded { finalDragGestureValue in
                let distanceDragged = finalDragGestureValue.translation / self.zoomScale
                // if part of Selection, move whole selection
                if isEmojiPartOfSelection {
                    for emoji in self.selectedEmojis {
                        self.document.moveEmoji(emoji, by: distanceDragged)
                    }
                // else just move the unselected emoji
                } else {
                    self.document.moveEmoji(emoji, by: distanceDragged)
                }
            }
    }
    
    @GestureState private var gesturePanOffset: CGSize = .zero
    

    private var panOffset: CGSize {
        (document.steadyStatePanOffset + gesturePanOffset) * zoomScale
    }

    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, transaction in
                gesturePanOffset = latestDragGestureValue.translation / self.zoomScale
            }
            .onEnded { finalDragGestureValue in
                self.document.steadyStatePanOffset = self.document.steadyStatePanOffset + (finalDragGestureValue.translation / self.zoomScale)
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
        if let image = image, image.size.width > 0, image.size.height > 0, size.height > 0, size.width > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            document.steadyStatePanOffset = .zero
            document.steadyStateZoomScale = min(hZoom, vZoom)
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
            self.document.backgroundURL = url
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


