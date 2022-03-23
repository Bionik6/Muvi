import Foundation

public struct BackendError: Error, Decodable {
  public var code: String
  public var message: String
  public var httpCode: Int
  
  enum CodingKeys: String, CodingKey {
    case code, message
    case httpCode = "http_code"
  }
}

public struct BackendErrorResponse: Decodable {
  public var status: Int
  public var error: BackendError
}

public enum NetworkError: LocalizedError, Equatable {
  
  public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    lhs.recoverySuggestion == rhs.recoverySuggestion
  }
  
  case noInternetConnectivity
  case backendError(BackendError)
  case notDetermined
  case unauthorized
  case unprocessableData
  case serverError
  
  public var recoverySuggestion: String? {
    switch self {
      case .noInternetConnectivity:
        return "Please verify your internet connectivity."
      case .unauthorized:
        return "API Key not valid or not provided"
      case .unprocessableData:
        return "Cannot decode data"
      case .serverError, .notDetermined:
        return "Something wrong happens, please retry later."
      default: return nil
    }
  }
}
