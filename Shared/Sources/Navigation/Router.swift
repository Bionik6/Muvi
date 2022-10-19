/**
 *  Muvi
 *  Router.swift
 *  Copyright (c) Ibrahima Ciss 2022
 */

import SwiftUI

public struct NavigationRoute {
  public let path: String
  public let destination: any View
  
  public init(path: String, destination: any View) {
    self.path = path
    self.destination = destination
  }
  
  public func render() -> some View {
    AnyView(destination)
  }
}



public class Router: ObservableObject {
  public var registeredRoutes: [NavigationRoute] = []
  
  public init() { }
  
  public func resolve(path: String) -> some View {
    guard let route = registeredRoutes.first(where: { $0.path == path }) else { fatalError("route not registered") }
    return route.render()
  }
  
  public func register(route: NavigationRoute) {
    guard registeredRoutes.filter({ $0.path == route.path }).first == nil else { return }
    self.registeredRoutes.append(route)
  }
  
  public func register(routes: [NavigationRoute]) {
    for route in routes { self.register(route: route) }
  }
}
