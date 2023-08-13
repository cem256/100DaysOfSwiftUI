//
//  FileManager+DocumentsDirectory.swift
//  Day73_Bucketlist
//
//  Created by cem on 13.08.2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
