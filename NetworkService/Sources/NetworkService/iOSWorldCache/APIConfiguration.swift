//
//  APIConfiguration.swift
//  NetworkService
//
//  Created by Engkit Riswara on 07/01/26.
//

import Foundation

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
  case head = "HEAD"
}

/// Represents HTTP body payload.
public enum Body {
  /// JSON-encodable payload. This will be encoded using `JSONEncoder`.
  case json(Encodable)
  /// Arbitrary raw data with a specified content type.
  case raw(Data, contentType: String)
  /// No body.
  case none
}

/// Describes everything needed to build a URLRequest for an API call.
public protocol APIRequest {
  /// Base URL for the API, e.g. `https://api.example.com` (no trailing slash).
  var baseURL: URL { get }
  /// Path component appended to base URL, e.g. `/v1/users`.
  var path: String { get }
  /// HTTP method for the request.
  var method: HTTPMethod { get }
  /// Query items to append to the URL.
  var queryItems: [URLQueryItem]? { get }
  /// Headers to include in the request.
  var headers: [String: String]? { get }
  /// Body payload.
  var body: Body { get }
  /// Timeout interval for the request.
  var timeout: TimeInterval { get }
}

public extension APIRequest {
  var queryItems: [URLQueryItem]? { nil }
  var headers: [String: String]? { nil }
  var body: Body { .none }
  var timeout: TimeInterval { 60 }
}

/// Utilities to build URLRequest from APIRequest.
public struct APIRequestBuilder {
  public init() {}

  public static func makeURLRequest(from request: APIRequest) throws -> URLRequest {
    // Compose URL
    var components = URLComponents(url: request.baseURL, resolvingAgainstBaseURL: false)
    let normalizedPath: String
    if request.path.hasPrefix("/") {
      normalizedPath = request.path
    } else {
      normalizedPath = "/" + request.path
    }
    components?.path += normalizedPath
    if let items = request.queryItems, items.isEmpty == false {
      components?.queryItems = items
    }

    guard let url = components?.url else {
      throw URLError(.badURL)
    }

    // Build URLRequest
    var urlRequest = URLRequest(url: url, timeoutInterval: request.timeout)
    urlRequest.httpMethod = request.method.rawValue

    // Headers
    if let headers = request.headers {
      for (key, value) in headers { urlRequest.setValue(value, forHTTPHeaderField: key) }
    }

    // Body
    switch request.body {
    case .none:
      break
    case .raw(let data, let contentType):
      urlRequest.httpBody = data
      if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
        urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
      }
    case .json(let encodable):
      let encoder = JSONEncoder()
      encoder.dateEncodingStrategy = .iso8601
      // Encode via type erasure
      let boxed = AnyEncodable(encodable)
      let data = try encoder.encode(boxed)
      urlRequest.httpBody = data
      if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      }
    }

    return urlRequest
  }
}

/// Type erasure for Encodable to allow storing as `Encodable` in `Body.json`.
private struct AnyEncodable: Encodable {
  private let _encode: (Encoder) throws -> Void
  init(_ value: Encodable) {
    self._encode = value.encode
  }
  func encode(to encoder: Encoder) throws { try _encode(encoder) }
}
