import Network
import Foundation


public struct APIClient {
  private var token: String?
  private var session: URLSession
  private var baseURLString: NSString { "https://charabia.app/api/v1/" }
  
  public init(
    token: String?,
    session: URLSession = .shared
  ) {
    self.token = token
    self.session = session
  }
  
  public func execute<D: BackendResponse, E: Encodable>(request: Request<E>) async throws -> D {
    let sessionRequest = prepareURLRequest(for: request)
    let (data, response) = try await session.data(for: sessionRequest)
    if let response = response as? HTTPURLResponse {
      if response.statusCode == 401 { NotificationCenter.default.post(Notification(name: Notification.Name("TOKEN_NOT_PROVIDED"))); throw NetworkError.serverError }
      if 400...599 ~= response.statusCode { throw NetworkError.serverError }
    }
    if let backendErrorObject = try? self.decoder.decode(BackendErrorResponse.self, from: data) { throw NetworkError.backendError(backendErrorObject.error) }
    guard let object = try? self.decoder.decode(D.self, from: data) else { throw NetworkError.unprocessableData }
    return object
  }
  
  func prepareURLRequest<E: Encodable>(for request: Request<E>) -> URLRequest {
    let fullURLString = baseURLString.appendingPathComponent(request.path)
    guard let url = URL(string: fullURLString) else { fatalError("The URL is not valid") }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    request.params.map { urlRequest.httpBody = try? JSONEncoder().encode($0) }
    
    if let headers = request.headers { headers.forEach { urlRequest.addValue($0.value , forHTTPHeaderField: $0.key) } }
    urlRequest.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Accept")
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    if let token = token { urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
    
    return urlRequest
  }
  
  
  public func uploadImage<D: Decodable, E: Encodable>(
    _ file: Data,
    imageKey: String,
    fileName: String,
    additionalData: [String: Any]?,
    request: Request<E>,
    completion: @escaping (Result<D, NetworkError>)->()
  ) {
    let fullURLString = baseURLString.appendingPathComponent(request.path)
    guard let url = URL(string: fullURLString) else { fatalError("The URL is not valid") }
    var urlRequest = URLRequest(url: url)
    var multipartData = MultipartForm()
    
    if let data = additionalData {
      data.forEach { multipartData.append(value: $0.value as? String ?? "", forKey: $0.key)  }
    }
    
    do {
      multipartData.append(data: file, forKey: imageKey, fileName: fileName, mimeType: "image/jpg")
      let data = try multipartData.encode()
      urlRequest.httpBody = data
    } catch let e { fatalError(e.localizedDescription) }
    
    if let headers = request.headers { headers.forEach { urlRequest.addValue($0.value , forHTTPHeaderField: $0.key) } }
    urlRequest.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Accept")
    urlRequest.addValue("multipart/form-data; boundary=\(multipartData.boundary)", forHTTPHeaderField: "Content-Type")
    if let token = token { urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
    
    urlRequest.httpMethod = request.method.rawValue
    
    let task = session.dataTask(with: urlRequest) { (data, response, error) in
      guard let data = data else { completion(.failure(.notDetermined)); return }
      (try? self.decoder.decode(BackendErrorResponse.self, from: data)).map { completion(.failure(.backendError($0.error))); return }
      (try? self.decoder.decode(D.self, from: data)).map { completion(.success($0)); return }
    }
    
    task.resume()
    session.finishTasksAndInvalidate()
  }
  
  private var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }
}
