//
//  CCError.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

enum CCError : Error {
    
    //MARK: FIREBASE
    case channelFetchFailure
    case networkEngineFailure
    case firebaseFailure
    case emptyFields
    case CodableError
    case internetError
    
    //MARK: TWILIO
    case twilioVideoError
    case twilioCredentialsError
    case channelDataWriteFailure
    
    //MARK: UI
    case RequiredValuesEmpty
    
    //MARK: IMAGE PICKING
    case ImageSelectionFailure
    case ImageUploadFailure
    case ImageCacheFailure
    
    //MARK: FIRESTORE
    case groupCreationFailure
}
