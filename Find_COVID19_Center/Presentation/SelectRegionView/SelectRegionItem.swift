//
//  SelectRegionItem.swift
//  Find_COVID19_Center
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import SwiftUI

struct SelectRegionItem: View {
    
    var region: Center.Sido
    var count: Int
    
    var body: some View {
        ZStack {
            Color(white: 0.9)
            VStack {
                Text(region.rawValue)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                Text("\(count)")
                    .font(.callout)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct SelectRegionItem_Previews: PreviewProvider {
    static var previews: some View {
        let region0 = Center.Sido.부산광역시
        SelectRegionItem(region: region0, count: 3)
    }
}
