//
//  FileManager+DocumentsDirectory.swift
//  Day85_HotProspects
//
//  Created by cem on 14.08.2023.
//

import Foundation

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
