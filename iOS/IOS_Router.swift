//
//  IOS_Router.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Foundation

class IOS_Router: ObservableObject {

    @Published private (set) var screens: [Screen] = [] {
        didSet { printStactInfo() }
    }
        
    private func send(_ action: StackAction) {
        switch action {
        case .set(let types):
            screens.removeAll()
            addScreens(types)
        case .push(let type):
            guard !exists(type) else { return }
            addScreen(type)
        case .pushExisting(let type):
            screens.removeAll { type == $0.type }
            addScreen(type)
        case .present(let type):
            let screen = Screen(type: type)
            screen.isModal = true
            screens.append(screen)
        case .dismiss:
            objectWillChange.send()
            screens.removeAll { $0.isModal }
            printStactInfo()
        case .pop:
            guard !screens.isEmpty else { return }
            screens.removeLast()
        }
    }
    
    private func addScreens(_ types: [IOS_SType]) {
        types.forEach {
            addScreen($0)
        }
    }
    
    private func addScreen(_ type: IOS_SType) {
        screens.append(Screen(type: type))
    }
    
    private func removeScreen(_ type: IOS_SType) {
        screens.removeAll { $0.type == type }
    }
    
    private func exists(_ type: IOS_SType) -> Bool {
        screens.contains(where: { $0.type == type})
    }
    
    private func printStactInfo() {
        print("screen     ----Screens----")
        screens.reversed().forEach {
            print("screen     |screen: \(String(describing: $0.type.title)) \($0.isModal ? "is Modal" : "")")
        }
        print("screen     -----------------")
    }
    
    func pop() {
        send(.pop)
    }
    
    
    func route(from type: IOS_SType?, strategy: Strategy = .first) {
        switch type {
            
        // MARK: - initial tab bar screens
        case .none where strategy == .first: // initial inbox
            send(.set([.inbox]))
        case .none where strategy == .second: // initial tasks
            send(.set([.tasks]))
        case .none where strategy == .third: // initial projects
            send(.set([.projects]))
            
            // MARK: - Inbox screens flow
        case .inbox where strategy == .first:
//            send(.push(.inputDetails))
            send(.present(.inputDetails))
            
            // MARK: - Tasks screens flow
        case .tasks where strategy == .first:
            send(.push(.taskDetails))
            
            // MARK: - Projects screens flow
        case .projects where strategy == .first:
            send(.push(.projectCreate))
        case .projects where strategy == .second:
            send(.push(.projectDetails))
        default: break
        }
    }
    
    func setInitial(_ type: IOS_SType) {
        send(.push(type))
    }
    
    func hideModal() {
        send(.dismiss)
    }
    
}
