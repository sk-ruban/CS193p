//
//  ContentView.swift
//  Memorize
//
//  Created by Ruban on 2024-02-10.
//

import SwiftUI

let theme1: Array<String> = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
let theme2: Array<String> = ["⚽","🏏","🏓","🥏","🎾","🏄"]
let theme3: Array<String> = ["🦈", "🦑", "🐙","🦉","🐧","🦖","🦧"]

struct ContentView: View {
    @State var emojis = theme1
    @State var themeColor = Color.orange
    
    var body: some View {
        Text("Memorize!").font(.largeTitle)
        VStack {
            ScrollView {
                cards
            }
            themeSetters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(themeColor)
    }
    
    var themeSetters: some View {
        HStack(alignment: .lastTextBaseline) {
            themeSet(of: "Halloween", symbol: "party.popper.fill")
            themeSet(of: "Sports", symbol: "tennis.racket")
            themeSet(of: "Animals", symbol: "dog.fill")
        }
        .imageScale(.large)
    }
    
    
    func themeSet(of theme: String, symbol: String) -> some View {
        Button(action: {
            switch theme {
            case "Halloween":
                emojis = (theme1 + theme1).shuffled()
                themeColor = Color.orange
            case "Sports":
                emojis = (theme2 + theme2).shuffled()
                themeColor = Color.red
            case "Animals":
                emojis = (theme3 + theme3).shuffled()
                themeColor = Color.blue
            default: emojis = (theme1 + theme1).shuffled()
            }
        }, label: {
            VStack(spacing: 5) {
                Image(systemName: symbol).font(.title)
                Text(theme).font(.caption)
            }
        })
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1:0)
            base.fill().opacity(isFaceUp ? 0:1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
