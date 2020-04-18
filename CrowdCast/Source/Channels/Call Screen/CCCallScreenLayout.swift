//
//  CCCallScreenLayout.swift
//  CrowdCast
//
//  Created by Usman on 19/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit


///UNUSED (Will be used in future)
class CCCallScreenLayout : NSObject {
    
    var numberOfCells   = 0
    var frame           = CGRect()
    
    init(numberOfCellsInput: Int, frameInput: CGRect) {
        super.init()
        numberOfCells   = numberOfCellsInput
        frame           = frameInput
    }
}

extension CCCallScreenLayout : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (numberOfCells == 1){
            return CGSize(width: frame.size.width, height: frame.size.height)
        } else if (numberOfCells == 2){
            return CGSize(width: frame.size.width, height: frame.size.height/CGFloat(2))
        } else if (numberOfCells == 3) {
            let lowerHeight = frame.size.height/(CGFloat(Double(numberOfCells)/2).rounded(.up))
            if(indexPath.row == numberOfCells - 1){
                return CGSize(width: frame.size.width, height: frame.size.height - lowerHeight)
            } else {
                return CGSize(width: frame.size.width/2 - 0.5, height: lowerHeight)
            }
        } else if (numberOfCells == 4){
            return CGSize(width: (frame.size.width / 2) - 0.5, height: frame.size.height / 2)
        } else {
            if(indexPath.row<4){
                return CGSize(width: (frame.size.width / 2) - 0.5, height: (frame.height) * 1.1/3 )
            } else {
                return CGSize(width: (frame.size.width / CGFloat(numberOfCells - 4)) - 0.1, height:  (frame.height) * 0.8/3 )
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}
