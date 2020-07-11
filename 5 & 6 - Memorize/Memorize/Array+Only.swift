//
//  Array+Only.swift
//  Memorize
//
//  Created by SK Ruban on 27/6/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
