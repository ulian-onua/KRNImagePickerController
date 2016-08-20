//
//  BLEAlertController.m
//  BLE Nearby
//
//  Created by Drapaylo Yulian on 18.06.16.
//  Copyright © 2016 Drapaylo Yulian. All rights reserved.
//

#import "KRNAlertController.h"

@implementation KRNAlertController

+(void) showAlertControllerFromViewController:(UIViewController*) viewController WithTitle:(NSString*) title Message:(NSString*) message andButtonTitle:(NSString*) buttonTitle 
{
    
    if ([UIAlertController class]) // use Alert Controller for iOS 8 and later
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController* myAlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleAlert];
            
            [myAlertController addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [myAlertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            
            [viewController presentViewController:myAlertController animated:YES completion:nil];
            
        });
    }
    
    else // using UIAlertView
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles: nil];
            [alertView show];
        });
    }
}

@end
