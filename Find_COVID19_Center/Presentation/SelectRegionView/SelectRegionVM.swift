//
//  SelectRegionVM.swift
//  Find_COVID19_Center
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import Foundation
import Combine

class SelectRegionVM: ObservableObject {
    /*
     @Published를 사용하여 선언된 프로퍼티는 ObservableObject를 구현한 클래스 내에서 사용되어야 합니다.
     @Published는 감시자(property wrapper)로, 값의 변경을 관찰하고 구독자에게 알릴 수 있는 기능을 제공합니다.
     해당 값을 가져올 때는 $를 사용하여 가져온다.
     */
    @Published var centers = [Center.Sido: [Center]]()
    private var cancellables = Set<AnyCancellable>()
     
    init(centerNetwork: CenterNetwork = CenterNetwork()) {
        centerNetwork.getCenterList()
//            .receive(subscriber: RunLoop.main) // RunLoop는 마우스, 키보드 등의 이벤트 소스 입력을 처리하는 객체라서 작업이 busy한 경우 UI 업데이트를 즉시 하지 않을 수 있다.
            .receive(on: DispatchQueue.main) // 사용자 상호작용과 함께 UI 업데이트가 필요한 경우 DispatchQueue.main을 사용하는 것을 추천
            .sink { [weak self] in
                guard case .failure(let error) = $0 else { return }
                print(error.localizedDescription)
                self?.centers = [Center.Sido: [Center]]()
            } receiveValue: { [weak self] centers in
                self?.centers = Dictionary(grouping: centers) { $0.sido }
            }
            .store(in: &cancellables)
    }
}
