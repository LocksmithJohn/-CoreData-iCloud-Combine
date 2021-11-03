//
//  DateManager.swift
//  Trening_icloud3
//
//  Created by User on 24/08/2021.
//

import Combine
import Foundation

final class DateManager {
    
    var timerPublisher: AnyPublisher<String?, Never>?
    
    private var timerSubject = PassthroughSubject<String?, Never>()
    private var lastSynchDate = Date()

    private func getTime() -> String {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: lastSynchDate, to: Date())
        let hours = String(diffComponents.hour ?? 0)
        let minutes = String(diffComponents.minute ?? 0)
        let seconds = String(diffComponents.second ?? 0)
        
        var value = ""
        if diffComponents.minute ?? 0 == 0 &&
            diffComponents.second ?? 0 < 10 {
            value = "now"
        } else if diffComponents.minute ?? 0 == 0 {
            value = String(seconds) + " sec"
        } else if diffComponents.minute ?? 0 < 2 {
            value = String(minutes) + " : " + String(seconds)
        } else {
            value = String(minutes) + " min"
        }
        
        return "Last sync: " + value
    }
    
    func startSyncTimer() {
        print("filter startSyncTimer()")
        timerPublisher = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
            .autoconnect()
            .map { [weak self] _ in self?.getTime() }
            .eraseToAnyPublisher()
    }
    
    func updateDate() {
        lastSynchDate = Date()
    }
    
}
//
//public typealias MyAnyPublisher<T> = AnyPublisher<T, Never> // tutaj do opublicznych aliasow
//public typealias MyPassthroughSubject<T> = PassthroughSubject<T, Never>
