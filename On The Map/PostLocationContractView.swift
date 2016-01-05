//
//  PostLocationContractView.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/3/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreLocation

protocol PostLocationContractView {
    
    var presenter: PostLocationContractPresenter! {get set}
    
    func showMapWithLocation(coordinate: CLLocationCoordinate2D)
    
    func showLinkInput()
    
    func swapFindPlaceWithSubmitButton()
    
    func showError(message: String)
    
    func dismissView()
    
    func toggleActivityIndicator(visible: Bool)
    
    func disableUIForFindingPlace()
    
    func enableUI()
}