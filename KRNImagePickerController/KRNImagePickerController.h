//
//  KRNImagePickerController.h
//  KRNImagePickerController
//
//  Created by ulian_onua on 16.07.16.
//  Copyright © 2016 ulian_onua. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

//Error constants
extern NSString* const KRNImagePickerControllerErrorDomain;
static const NSInteger KRNImagePickerSourceTypeIsNotAvailable = 0;
static const NSInteger KRNImagePickerOperationIsCancelled = 1;

// Typedefs
typedef void(^KRNImagePickerCompletionWithImage)(UIImage* image, NSError* error);
typedef void(^KRNImagePickerSucceedBlock)(NSError* error);  // if succeed error is nil


@interface KRNImagePickerController : NSObject

//image is returned in completion handler
//if operation is cancelled image is nil

#pragma mark - Picker methods with completion block -

//designated method
+ (void)pickFromSource:(UIImagePickerControllerSourceType)sourceType fromViewController:(UIViewController *)viewController withCompletion:(KRNImagePickerCompletionWithImage)completion;

//convinience methods
+ (void)pickFromPhotoLibraryFromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage)completion;
+ (void)pickFromCameraFromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage)completion;
+ (void)pickFromSavedPhotosAlbumFromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage)completion;



#pragma mark - Image View mapping -

//mapping picked image to UIImageView instance with contentMode set to AspectFit

+ (void)pickFromPhotoLibraryFromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed;
+ (void)pickFromCameraFromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed;
+ (void)pickFromSavedPhotosAlbumFromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed;

+ (void) pickFromSource:(UIImagePickerControllerSourceType)sourceType fromViewController:(UIViewController *)viewController andMapToImageView:(UIImageView *)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed;


#pragma mark - Clear memory -

+ (void) clearMemory; // clear memory, used by class

@end
