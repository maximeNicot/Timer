//
//  ProtocolCellSegue.swift
//  Timer
//
//  Created by Antoine NICOT on 20/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class ProtocolCellSegue: NSObject {

    protocol cellDelegator{
        func segueFromCell(myData dataobject: AnyObject)
    }
}
