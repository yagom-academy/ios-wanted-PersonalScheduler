//
//  APIProvider.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/09.
//

import Foundation
import Combine

protocol APIProvider {

    func excute(_ target: TargetType, useCaching: Bool) -> AnyPublisher<(data: Data, response: URLResponse), Error>

}
