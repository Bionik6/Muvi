import Network
import Combine
import Foundation

public struct NetworkPath {
  public var status: NWPath.Status
  
  public init(status: NWPath.Status) {
    self.status = status
  }
}

extension NetworkPath {
  public init(rawValue: NWPath) {
    self.status = rawValue.status
  }
}

public struct PathMonitorClient {
  public var networkPublisher: AnyPublisher<NetworkPath, Never>
  
  public init(networkPublisher: AnyPublisher<NetworkPath, Never>) {
    self.networkPublisher = networkPublisher
  }
}


extension PathMonitorClient {
  public static func live(queue: DispatchQueue) -> Self {
    let monitor = NWPathMonitor()
    let subject = PassthroughSubject<NWPath, Never>()
    monitor.pathUpdateHandler = subject.send
    monitor.start(queue: queue)
    
    return Self(
      networkPublisher: subject
        .handleEvents(receiveSubscription: { _ in monitor.start(queue: queue) }, receiveCancel: monitor.cancel)
        .map(NetworkPath.init(rawValue:))
        .eraseToAnyPublisher()
    )
  }
}
