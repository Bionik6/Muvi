import Foundation

public enum NetworkError: LocalizedError, Equatable {
  
  public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    lhs.recoverySuggestion == rhs.recoverySuggestion
  }
  
  case noInternetConnectivity
  case notDetermined
  case unauthorized
  case unprocessableData
  case serverError
  
  public var failureReason: String? {
    switch self {
      case .noInternetConnectivity:
        return "Please verify your internet connectivity."
      case .unauthorized:
        return "API Key not valid or not provided"
      case .unprocessableData:
        return "Cannot decode data"
      case .serverError, .notDetermined:
        return "Something wrong happens, please retry later."
    }
  }
}
