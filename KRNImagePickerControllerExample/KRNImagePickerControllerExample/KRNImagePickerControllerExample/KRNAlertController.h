//
//  BLEAlertController.h
//  BLE Nearby
//
//  Created by Drapaylo Yulian on 18.06.16.
//  Copyright © 2016 Drapaylo Yulian. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface KRNAlertController : NSObject

//present alert controller or alert view (iOS 7) with custom values
+(void) showAlertControllerFromViewController:(UIViewController*) viewController WithTitle:(NSString*) title Message:(NSString*) message andButtonTitle:(NSString*) buttonTitle;


@end
