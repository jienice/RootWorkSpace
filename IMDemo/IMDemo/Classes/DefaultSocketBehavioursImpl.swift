//
//  DefaultSocketBehavioursImpl.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/4.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework
import CocoaAsyncSocket

public class DefaultSocketBehavioursImpl: Object, SocketBehaviours, GCDAsyncSocketDelegate {
    
    let configuration: SocketConfiguration
    
    let dataEncoder: SocketDataEncoder
    
    let dataDecoder: SocketDataDecoder
    
    let statusHandler: SocketStatusCompoundHandler
    
    let messageHandler: ImMessageCompoundHandler
        
    lazy var socket = GCDAsyncSocket(delegate: self, delegateQueue: queue)
    
    private let queue = DispatchQueue.init(label: "com.defaultSocketBehavioursImpl.queue")

    init(configuration: SocketConfiguration,
         dataEncoder: SocketDataEncoder,
         dataDecoder: SocketDataDecoder,
         statusHandler: SocketStatusCompoundHandler,
         messageHandler: ImMessageCompoundHandler) {
        self.configuration = configuration
        self.dataEncoder = dataEncoder
        self.dataDecoder = dataDecoder
        self.statusHandler = statusHandler
        self.messageHandler = messageHandler
        super.init()
    }

    public func connect() {
        do {
            try socket.connect(toHost: configuration.host, onPort: configuration.port)
        } catch {
            statusHandler.doHandle(.connectFail)
        }
    }

    public func reconnect() {
        connect()
    }

    public func disconnect() {
        socket.disconnectAfterReadingAndWriting()
    }
    
    public func sendImMessage(_ message: ImMessage) {
        guard let sendElement = dataEncoder.encode(data: message) else {
            return
        }
        sendData(sendElement)
    }

    public func sendData(_ data: SocketSendElement) {
        socket.write(data.data, withTimeout: configuration.readWriteTimeOut, tag: -1)
    }
    
    public func readData() {
        socket.readData(withTimeout: configuration.readWriteTimeOut, tag: 1)
    }
    
    public func sendBeat(_ beat: SocketSendElement) {
        sendData(beat)
    }

}

public extension DefaultSocketBehavioursImpl {

    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        statusHandler.doHandle(.connected)
    }

    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        if let _ = err {
            
        }
    }

    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        
    }

    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        // todo:
        guard let element = data.convert() else { return }
        guard let imMessage = dataDecoder.decode(data: element)else { return }
        messageHandler.doHandle(imMessage)
    }

    func socket(_ sock: GCDAsyncSocket, shouldTimeoutWriteWithTag tag: Int, elapsed: TimeInterval, bytesDone length: UInt) -> TimeInterval {
        return -1
    }

}


private extension Data {
    
    func convert() -> SocketSendElement? {
        nil
    }
}
