//
//  Themes.swift
//  Memorize
//
//  Created by SK Ruban on 5/7/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

// Assignment 5 Task 1 - Change Int? to Int
// Assignment 5 Task 2 - Change to Codable to enable JSON
struct Theme: Codable {
    var name: String
    var emojis: [String]
    var colorRGB: UIColor.RGB
    var noOfPairs: Int

    var color: Color {
        Color(colorRGB)
    }
    
    var json: Data? {
        try? JSONEncoder().encode(self)
    }
}

let themes: [Theme] = [
    Theme(
        name: "Halloween",
        emojis: ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"],
        colorRGB:  UIColor.orange.rgb,
        noOfPairs: 8),
    Theme(
        name: "Flags",
        emojis: ["🇸🇬","🇯🇵","🏴‍☠️","🏳️‍🌈","🇬🇧","🇹🇼","🇺🇸","🇦🇶","🇰🇵","🇭🇰","🇲🇨","🇼🇸"],
        colorRGB: UIColor.red.rgb,
        noOfPairs: 10),
    Theme(
        name: "Animals",
        emojis: ["🦑","🦧","🦃","🦚","🐫","🦉","🦕","🦥","🐸","🐼","🐺","🦈"],
        colorRGB:  UIColor.green.rgb,
        noOfPairs: 6),
    Theme(
        name: "Places",
        emojis: ["🗽","🗿","🗼","🎢","🌋","🏝","🏜","⛩","🕍","🕋","🏯","🏟"],
        colorRGB:  UIColor.purple.rgb,
        noOfPairs: 8),
    Theme(
        name: "Sports",
        emojis: ["🤺","🏑","⛷","⚽️","🏀","🪂","🥏","⛳️","🛹","🎣","🏉","🏓"],
        colorRGB:  UIColor.blue.rgb,
        noOfPairs: 8),
    Theme(
        name: "Foods",
        emojis: ["🌮","🍕","🍝","🍱","🍪","🍩","🥨","🥖","🍟","🍙","🍢","🍿"],
        colorRGB:  UIColor.yellow.rgb,
        noOfPairs: 10)
]

