//
//  SelectRegionView.swift
//  Find_COVID19_Center
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import SwiftUI

struct SelectRegionView: View {
    @ObservedObject var viewModel = SelectRegionVM()
    
    private var items: [GridItem] {
        Array(repeating: .init(.flexible(minimum: 80)), count: 2)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: items, spacing: 20) {
                    ForEach(Center.Sido.allCases) { sido in
//                        let aaa = viewModel.$centers
                        
                        let centers = viewModel.centers[sido] ?? []
                        NavigationLink(destination: CenterList(centers: centers)) {
                            SelectRegionItem(region: sido, count: centers.count)
                        }
                    }
                }
                .padding()
                .navigationTitle("코로나19 예방접종 센터")
            }
        }
    }
}

struct SelectRegionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SelectRegionVM()
        SelectRegionView(viewModel: viewModel)
    }
}
