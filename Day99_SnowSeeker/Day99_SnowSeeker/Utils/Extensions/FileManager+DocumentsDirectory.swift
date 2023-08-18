//
//  FileManager+DocumentsDirectory.swift
//  Day99_SnowSeeker
//
//  Created by cem on 18.08.2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
