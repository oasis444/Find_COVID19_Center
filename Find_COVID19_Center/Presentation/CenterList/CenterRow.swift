//
//  CenterRow.swift
//  Find_COVID19_Center
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import SwiftUI

struct CenterRow: View {
    var center: Center
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(center.facilityName)
                    .font(.headline)
                Text(center.centerType.rawValue)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            Text(center.address)
                .font(.footnote)
            
            if let url = URL(string: "tel:" + center.phoneNumber) {
                Link(center.phoneNumber, destination: url)
            }
        }
        .padding()
    }
}

struct CenterRow_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .부산광역시, facilityName: "시민공원 앞", address: "부산광역시 부산진구", lat: "36.5123", lng: "126.9513", centerType: .central, phoneNumber: "051-123-4567")
        CenterRow(center: center0)
    }
}
