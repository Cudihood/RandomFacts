//
//  Extension.swift
//  RandomFacts
//
//  Created by Даниил Циркунов on 01.02.2024.
//

import Foundation

extension Array {
    func getValue(at index: Int) -> Element? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[index]
    }
}
