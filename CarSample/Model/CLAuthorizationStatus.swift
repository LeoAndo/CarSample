//
//  CLAuthorizationStatus.swift
//  CarSample
//
//  Created by LeoAndo on 2022/05/28.
//

import CoreLocation

extension CLAuthorizationStatus: CustomStringConvertible {
  public var description: String {
    switch self {
    case .authorizedAlways:
      return "Always Authorized"
    case .authorizedWhenInUse:
      return "Authorized When In Use"
    case .denied:
      return "Denied"
    case .notDetermined:
      return "Not Determined"
    case .restricted:
      return "Restricted"
    @unknown default:
      return "🤷‍♂️"
    }
  }
}
