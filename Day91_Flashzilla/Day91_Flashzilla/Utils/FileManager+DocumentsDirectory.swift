//
//  FileManager+DocumentsDirectory.swift
//  Day91_Flashzilla
//
//  Created by cem on 16.08.2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
