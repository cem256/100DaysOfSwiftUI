//
//  Day56_BookwormApp.swift
//  Day56_Bookworm
//
//  Created by cem on 9.08.2023.
//

import SwiftUI

@main
struct Day56_BookwormApp: App {
    @StateObject private var dataController = DataController()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
