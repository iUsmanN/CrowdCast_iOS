//
//  CCError.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

enum CCError : Error {
    
    //FIREBASE
    case channelFetchFailure
    case networkEngineFailure
    case firebaseFailure
    case emptyFields
    case CodableError
    case internetError
    
    //TWILIO
    case twilioVideoError
    case twilioCredentialsError
    case channelDataWriteFailure
    
    case RequiredValuesEmpty
    
    //IMAGE PICKING
    case ImageSelectionFailure
    case ImageUploadFailure
}
