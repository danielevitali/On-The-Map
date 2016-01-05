//
//  PostLocationPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/3/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreLocation

class PostLocationPresenter: PostLocationContractPresenter {
    
    let view: PostLocationContractView
    var coordinate: CLLocationCoordinate2D!
    var address: String!
    
    init(view: PostLocationContractView) {
        self.view = view
    }
    
    func onCancelClick() {
        view.dismissView()
    }
    
    func onFindPlaceClick(address: String) {
        guard address != "" else {
            view.showError("Type your city")
            return
        }
        view.toggleActivityIndicator(true)
        view.disableUIForFindingPlace()
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            self.view.toggleActivityIndicator(false)
            self.view.enableUI()
            if let error = error {
                self.view.showError(error.localizedDescription)
                return
            } else if let placemarks = placemarks where placemarks.count > 0 {
                let placemark = placemarks[0] as CLPlacemark
                if let location = placemark.location {
                    self.coordinate = location.coordinate
                    self.address = "\(placemark.locality!), \(placemark.country!)"
                    self.showPlaceFoundUI(location.coordinate)
                } else {
                    self.view.showError("Place not found")
                }
            } else {
                self.view.showError("Place not found")
            }
        })
    }
    
    private func showPlaceFoundUI(coordinate: CLLocationCoordinate2D){
        view.showMapWithLocation(coordinate)
        view.showLinkInput()
        view.swapFindPlaceWithSubmitButton()
    }
    
    func onSubmitClick(url: String) {
        view.toggleActivityIndicator(true)
        
        guard url != "" && NSURL(string: url) != nil else {
            view.showError("Type a valid URL")
            return
        }
        
        DataManager.getInstance().setStudentInformation(coordinate, address: address, url: url, updateInformationCompleteHandler: { (userInformation, errorMessage) in
            self.view.toggleActivityIndicator(false)
            if let errorMessage = errorMessage {
                self.view.showError(errorMessage)
            } else  {
                guard userInformation != nil else {
                    self.view.showError("Unknown error")
                    return
                }
                self.view.dismissView()
            }
        })
    }
    
}