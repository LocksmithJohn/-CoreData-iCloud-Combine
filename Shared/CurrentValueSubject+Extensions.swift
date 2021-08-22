//
//  CurrentValueSubject+Extensions.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine

extension CurrentValueSubject {
    func updates<Value>(for keyPath: KeyPath<Output, Value>) ->
        AnyPublisher<Value, Failure> where Value: Equatable {
        return map(keyPath).removeDuplicates().eraseToAnyPublisher()
    }
}
