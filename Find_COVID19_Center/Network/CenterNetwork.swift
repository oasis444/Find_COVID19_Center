//
//  CenterNetwork.swift
//  Find_COVID19_Center
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import Foundation
import Combine

class CenterNetwork {
    private let session: URLSession
    let api = CenterAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCenterList() -> AnyPublisher<[Center], URLError> {
        guard let url = api.getCenterListComponents().url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher() // eraseToAnyPublisher는 Publisher를 AnyPublisher로 변환하는 역할
        }
        var request = URLRequest(url: url)
        request.setValue("Infuser 44lJtzZAK2zYUZb4bI3Zk7VwFweyxnZNJ8UH78gHEIXfZnwvPHNqEsMnl8qLB6q4HWrbzA2OX7ex0steTx10Rw==", forHTTPHeaderField: "Authorization")
        let dataTaskPublisher = session.dataTaskPublisher(for: request)
        return getData(data: dataTaskPublisher)
    }
    
    private func getData(data: URLSession.DataTaskPublisher) -> AnyPublisher<[Center], URLError> {
        // tryMap: 각 요소에 변환 함수를 적용하고, 변환 중에 발생하는 오류를 처리할 수 있는 기능을 제공
        data.tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.unknown) }
            switch httpResponse.statusCode {
            case 200..<300:
                return data
            case 400..<500:
                throw URLError(.clientCertificateRejected)
            case 500..<599:
                throw URLError(.badServerResponse)
            default:
                throw URLError(.unknown)
            }
        }
        .decode(type: CenterAPIRespose.self, decoder: JSONDecoder())
        .map { $0.data }
        .mapError { $0 as! URLError }
        .eraseToAnyPublisher() // eraseToAnyPublisher는 Publisher를 AnyPublisher로 변환하는 역할
    }
}
