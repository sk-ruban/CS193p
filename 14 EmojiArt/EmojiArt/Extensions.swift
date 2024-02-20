//
//  Extension.swift
//  Emoji Art
//
//  Created by CS193p Instructor on 5/8/23.
//  Copyright (c) 2023 Stanford University
//

import SwiftUI

typealias CGOffset = CGSize

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    init(center: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: center.x-size.width/2, y: center.y-size.height/2), size: size)
    }
}

extension CGOffset {
    static func +(lhs: CGOffset, rhs: CGOffset) -> CGOffset {
        CGOffset(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    static func +=(lhs: inout CGOffset, rhs: CGOffset) {
        lhs = lhs + rhs
    }
}

extension String {
    // removes any duplicate Characters
    // preserves the order of the Characters
    var uniqued: String {
        // not super efficient
        // would only want to use it on small(ish) strings
        // and we wouldn't want to call it in a tight loop or something
        reduce(into: "") { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
}

extension AnyTransition {
    static let rollUp: AnyTransition = .asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top))
    static let rollDown: AnyTransition = .asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom))
}

struct AnimatedActionButton: View {
    var title: String? = nil
    var systemImage: String? = nil
    var role: ButtonRole?
    let action: () -> Void
    
    init(_ title: String? = nil,
         systemImage: String? = nil,
         role: ButtonRole? = nil,
         action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.role = role
        self.action = action
    }
    
    var body: some View {
        Button(role: role) {
            withAnimation {
                action()
            }
        } label: {
            if let title, let systemImage {
                Label(title, systemImage: systemImage)
            } else if let title {
                Text(title)
            } else if let systemImage {
                Image(systemName: systemImage)
            }
        }
    }
}

extension Character {
    var isEmoji: Bool {
        // Swift does not have a way to ask if a Character isEmoji
        // but it does let us check to see if our component scalars isEmoji
        // unfortunately unicode allows certain scalars (like 1)
        // to be modified by another scalar to become emoji (e.g. 1️⃣)
        // so the scalar "1" will report isEmoji = true
        // so we can't just check to see if the first scalar isEmoji
        // the quick and dirty here is to see if the scalar is at least the first true emoji we know of
        // (the start of the "miscellaneous items" section)
        // or check to see if this is a multiple scalar unicode sequence
        // (e.g. a 1 with a unicode modifier to force it to be presented as emoji 1️⃣)
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}

extension String {
    mutating func remove(_ ch: Character) {
        removeAll(where: { $0 == ch })
    }
}
