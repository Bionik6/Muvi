import Foundation

public enum RequestParams {
    case body(Encodable)
    case url([String: Any])
}
