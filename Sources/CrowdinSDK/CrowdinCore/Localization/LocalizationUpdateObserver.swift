//
//  LocalizationUpdateObserver.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 4/22/19.
//

import Foundation

protocol HandlerContainerProtocol {
    associatedtype HandlerType
    
    func subscribe(handler: HandlerType) -> Int
    func unsubscribe(with id: Int)
    func unsubscribe()
}

class HandlerContainer<HandlerType>: HandlerContainerProtocol {
    var handlers: [Int: HandlerType] = [:]
    
    func subscribe(handler: HandlerType) -> Int {
        let newId = (handlers.keys.max() ?? 0) + 1
        handlers[newId] = handler
        return newId
    }
    
    func unsubscribe(with id: Int) {
        handlers.removeValue(forKey: id)
    }
    
    func unsubscribe() {
        handlers.removeAll()
    }
}

public typealias LocalizationUpdateDownload = () -> Void
public typealias LocalizationUpdateError = ([Error]) -> Void

public class LocalizationUpdateObserver {
    static public var shared = LocalizationUpdateObserver()
    
    var downloadHandlerContainer = HandlerContainer<LocalizationUpdateDownload>()
    var errorHandlerContainer = HandlerContainer<LocalizationUpdateError>()
    
    public func addDownloadHandler(_ handler: @escaping LocalizationUpdateDownload) -> Int {
        return downloadHandlerContainer.subscribe(handler: handler)
    }
    
    public func removeDownloadHandler(_ id: Int) {
        downloadHandlerContainer.unsubscribe(with: id)
    }
    
    public func removeAllDownloadHandlers() {
        downloadHandlerContainer.unsubscribe()
    }
    
    public func addErrorHandler(_ handler: @escaping LocalizationUpdateError) -> Int {
        return errorHandlerContainer.subscribe(handler: handler)
    }
    
    public func removeErrorHandler(_ id: Int) {
        errorHandlerContainer.unsubscribe(with: id)
    }
    
    public func removeAllErrorHandlers() {
        errorHandlerContainer.unsubscribe()
    }
    
    public func notifyDownload() {
        downloadHandlerContainer.handlers.values.forEach({ $0() })
    }
    
    public func notifyError(with errors: [Error]) {
        errorHandlerContainer.handlers.values.forEach({ $0(errors) })
        errors.forEach({ CrowdinLogsCollector.shared.add(log: CrowdinLog(type: .error, message: "Localization downloading error - \($0.localizedDescription)")) })
    }
}
