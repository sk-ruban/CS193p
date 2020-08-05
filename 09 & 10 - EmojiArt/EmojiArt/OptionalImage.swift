//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by SK Ruban on 17/7/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        // With Group don't need a View for the else case
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}
