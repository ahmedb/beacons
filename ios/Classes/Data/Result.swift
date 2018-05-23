//
//  Copyright (c) 2018 Loup Inc.
//  Licensed under Apache License v2.0
//

import Foundation

struct Result<T: Codable> : Codable {
  let isSuccessful: Bool
  let region: BeaconRegion?
  let data: T?
  let error: ResultError?
  
  static func success <T> (with data: T, for region: BeaconRegion? = nil) -> Result<T> {
    return Result<T>(isSuccessful: true, region: region, data: data, error: nil)
  }
  
  static func failure <T> (of type: ResultError.Kind, message: String? = nil, fatal: Bool? = nil, for region: BeaconRegion? = nil) -> Result<T> {
    return Result<T>(isSuccessful: false, region: region, data: nil, error: ResultError(type: type, message: message, fatal: fatal))
  }
}

struct ResultError: Codable {
  let type: Kind
  let message: String?
  let fatal: Bool?
  
  enum Kind: String, Codable {
    case runtime = "runtime"
    case permissionDenied = "permissionDenied"
    case serviceDisabled = "serviceDisabled"
    case rangingUnavailable = "rangingUnavailable"
    case monitoringUnavailable = "monitoringUnavailable"
  }
}

