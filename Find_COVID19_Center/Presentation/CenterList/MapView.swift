//
//  MapView.swift
//  Find_COVID19_Center
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import SwiftUI
import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    var coordination: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    @State private var annotationItems = [AnnotationItem]()
    
    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: [AnnotationItem(coordinate: coordination)]) {
            MapMarker(coordinate: $0.coordinate)
        }
            .onAppear {
                setRegion(coordination)
                setAnnotationItems(coordination)
            }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
    
    private func setAnnotationItems(_ coordinate: CLLocationCoordinate2D) {
        annotationItems = [AnnotationItem(coordinate: coordinate)]
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .경기도, facilityName: "실내빙상장 앞", address: "경기도 안양시 동안구 평촌대로 389", lat: "37.404476", lng: "126.9491998", centerType: .local, phoneNumber: "031-8045-4843")
        MapView(coordination: center0.coordinate)
    }
}
