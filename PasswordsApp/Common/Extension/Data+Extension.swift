//
//  Data+Extension.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/5/22.
//

import Foundation

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
