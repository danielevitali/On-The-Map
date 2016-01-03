//
//  PostLocationContractPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/3/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol PostLocationContractPresenter {
    
    var view: PostLocationContractView {get}
    
    func onCancelClick()
    
    func onSubmitClick(url: String)
    
    func onFindPlaceClick(address: String)
    
}