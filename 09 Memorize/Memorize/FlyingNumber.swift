//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Ruban on 2024-02-15.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
