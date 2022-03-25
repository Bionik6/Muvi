import Network
import Combine
import Foundation

extension PathMonitorClient {
  public static let satisfied = Self(
    networkPublisher: Just(NetworkPath(status: .satisfied))
      .eraseToAnyPublisher()
  )
  
  public static let unsatisfied = Self(
    networkPublisher: Just(NetworkPath(status: .unsatisfied))
      .eraseToAnyPublisher()
  )
  
  public static let flakey = Self(
    networkPublisher: Timer.publish(every: 2, on: .main, in: .default)
      .autoconnect()
      .scan(.satisfied, { status, _ in
        status == .satisfied ? .unsatisfied : .satisfied
      })
      .map { NetworkPath(status: $0) }
      .eraseToAnyPublisher()
  )
}
