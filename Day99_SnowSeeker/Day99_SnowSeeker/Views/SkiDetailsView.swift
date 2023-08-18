//
//  SkiDetailsView.swift
//  Day99_SnowSeeker
//
//  Created by cem on 18.08.2023.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: ResortModel
    
    var body: some View {
        Group {
            VStack {
                Text("Elevation")
                    .font(.caption.bold())
                Text("\(resort.elevation)m")
                    .font(.title3)
            }
            
            VStack {
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)cm")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort : ResortModel.example)
    }
}
