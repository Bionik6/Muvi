/**
 *  Muvi
 *  RouterEnvironmentKey.swift
 *  Copyright (c) Ibrahima Ciss 2022
 */

import SwiftUI


private struct RouterEnvironmentKey: EnvironmentKey {
  public static let defaultValue: Router = Router()
}


extension EnvironmentValues {
  public var router: Router {
    get { self[RouterEnvironmentKey.self] }
    set { self[RouterEnvironmentKey.self] = newValue }
  }
}
