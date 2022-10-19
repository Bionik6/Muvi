import Foundation


public struct APIClient {
  private var session: URLSession
  private var baseURLString: NSString { "https://api.themoviedb.org/3/" }
  
  public init(session: URLSession = .shared) {
    self.session = session
  }
  
  public func execute<D: Decodable>(request: Request) async throws -> D {
    let sessionRequest = prepareURLRequest(for: request)
    let (data, response) = try await session.data(for: sessionRequest)
    if let response = response as? HTTPURLResponse {
      if response.statusCode == 401 { throw NetworkError.unauthorized }
      if 400...599 ~= response.statusCode { throw NetworkError.serverError }
    }
    guard let object = try? self.decoder.decode(D.self, from: data) else { throw NetworkError.unprocessableData }
    return object
  }
  
  private func prepareURLRequest(for request: Request) -> URLRequest {
    let fullURLString = baseURLString.appendingPathComponent(request.path)
    guard let url = URL(string: fullURLString) else { fatalError("The URL is not valid") }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    
    if let headers = request.headers { headers.forEach { urlRequest.addValue($0.value , forHTTPHeaderField: $0.key) } }
    urlRequest.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Accept")
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else { fatalError("api key couldn't be found") }
    
    guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { fatalError("components can't be created") }
    components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    urlRequest.url = components.url
    
    return urlRequest
  }
  
  private var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }
}
