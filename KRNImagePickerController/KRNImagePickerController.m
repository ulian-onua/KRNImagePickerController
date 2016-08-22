//
//  KRNImagePickerController.m
//  KRNImagePickerController
//
//  Created by ulian_onua on 16.07.16.
//  Copyright © 2016 ulian_onua. All rights reserved.
//

#import "KRNImagePickerController.h"

NSString* const KRNImagePickerControllerErrorDomain = @"com.KRNImagePickerController.ErrorDomain";

NSString* const KRNPhotoLibraryIsNotAvailableMessage = @"Photo Library is not available";
NSString* const KRNPhotoLibraryIsNotAvailableSuggestion = @"Probably photo library is empty.";
NSString* const KRNCameraIsNotAvailableMessage = @"Camera is not available";
NSString* const KRNCameraIsNotAvailableSuggestion = @"Probably camera is already in use.";
NSString* const KRNSavedPhotosAlbumIsNotAvailableMessage = @"Saved photos album is not available";
NSString* const KRNSavedPhotosAlbumIsNotAvailableSuggestion = @"Probably saved photos album is empty.";

NSString* const KRNOperationWasCancelled = @"Operation was cancelled by user";



static KRNImagePickerController *imagePickerController;

@interface KRNImagePickerController()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) KRNImagePickerCompletionWithImage KRNImagePickerCompletionWithImage;


@end


@implementation KRNImagePickerController

- (instancetype)init
{
    return [self initWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (instancetype)initWithSourceType:(UIImagePickerControllerSourceType) sourceType {
    
    self = [super init];
    if (self) {
        _imagePicker = [UIImagePickerController new];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
        _imagePicker.sourceType = sourceType;
    }
    return self;
}


#pragma mark - Picker methods with completion block -

+ (void)pickFromPhotoLibraryFromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage) completion {
    

    [self pickFromSource:UIImagePickerControllerSourceTypePhotoLibrary fromViewController:viewController withCompletion:completion];

}

+ (void)pickFromCameraFromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage) completion
{
    [self pickFromSource:UIImagePickerControllerSourceTypeCamera fromViewController:viewController withCompletion:completion];
}
+ (void)pickFromSavedPhotosAlbumFromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage) completion
{
    [self pickFromSource:UIImagePickerControllerSourceTypeSavedPhotosAlbum fromViewController:viewController withCompletion:completion];
}


+ (void) pickFromSource:(UIImagePickerControllerSourceType)sourceType fromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage) completion {
    
    
    
    //check if source type is available
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        NSError* error = [self _getErrorForUnavailableSourceType:sourceType];
        completion(nil, error);
        return;
    }

    //create or reuse imagePickerController
    imagePickerController = [self _getImagePickerController];
    
    //set source type
    if (imagePickerController.imagePicker.sourceType != sourceType) {
        imagePickerController.imagePicker.sourceType = sourceType;
    }
    
    imagePickerController.KRNImagePickerCompletionWithImage = completion;
    [viewController presentViewController:imagePickerController.imagePicker animated:YES completion:nil];

}

#pragma mark - Image View mapping -

+ (void)pickFromPhotoLibraryFromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed {
    [self pickFromSource:UIImagePickerControllerSourceTypePhotoLibrary fromViewController:viewController andMapToImageView:imageView withSucceed:succeed];
}

+ (void)pickFromCameraFromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed
{
    [self pickFromSource:UIImagePickerControllerSourceTypeCamera fromViewController:viewController andMapToImageView:imageView withSucceed:succeed];
}

+ (void)pickFromSavedPhotosAlbumFromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed
{
    [self pickFromSource:UIImagePickerControllerSourceTypeSavedPhotosAlbum fromViewController:viewController andMapToImageView:imageView withSucceed:succeed];
}


+ (void)pickFromSource:(UIImagePickerControllerSourceType)sourceType fromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed
{
    __weak UIImageView *weakImageView = imageView;
    
    [self pickFromSource:sourceType fromViewController:viewController withCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            weakImageView.image = image;
            if (succeed) {
                succeed(nil);
            }
        }
        else {
            if (succeed) {
                succeed(error);
            }
        }
    }];
    

}

#pragma mark - Private Methods -

+ (KRNImagePickerController*) _getImagePickerController {
    if (!imagePickerController) {
        imagePickerController = [KRNImagePickerController new];
    }
    return imagePickerController;
}

+ (NSError*)_getErrorForUnavailableSourceType:(UIImagePickerControllerSourceType) sourceType {
    
    switch (sourceType) {
        case UIImagePickerControllerSourceTypePhotoLibrary:
            return [NSError errorWithDomain:KRNImagePickerControllerErrorDomain code:KRNImagePickerSourceTypeIsNotAvailable userInfo:@{NSLocalizedDescriptionKey : KRNPhotoLibraryIsNotAvailableMessage, NSLocalizedRecoverySuggestionErrorKey : KRNPhotoLibraryIsNotAvailableSuggestion}];
            break;
        case UIImagePickerControllerSourceTypeCamera:
            return [NSError errorWithDomain:KRNImagePickerControllerErrorDomain code:KRNImagePickerSourceTypeIsNotAvailable userInfo:@{NSLocalizedDescriptionKey : KRNCameraIsNotAvailableMessage, NSLocalizedRecoverySuggestionErrorKey : KRNCameraIsNotAvailableSuggestion}];
            break;
        case UIImagePickerControllerSourceTypeSavedPhotosAlbum:
            return [NSError errorWithDomain:KRNImagePickerControllerErrorDomain code:KRNImagePickerSourceTypeIsNotAvailable userInfo:@{NSLocalizedDescriptionKey : KRNCameraIsNotAvailableMessage, NSLocalizedRecoverySuggestionErrorKey : KRNCameraIsNotAvailableSuggestion}];
            break;
            return [NSError errorWithDomain:KRNImagePickerControllerErrorDomain code:KRNImagePickerSourceTypeIsNotAvailable userInfo:@{NSLocalizedDescriptionKey : KRNSavedPhotosAlbumIsNotAvailableMessage, NSLocalizedRecoverySuggestionErrorKey : KRNSavedPhotosAlbumIsNotAvailableSuggestion}];
            
        default:
            [NSError errorWithDomain:KRNImagePickerControllerErrorDomain code:KRNImagePickerSourceTypeIsNotAvailable userInfo:nil]; // for future usage
            break;
    }
    
    return nil;
    
}

#pragma mark - Clear memory -

+ (void) clearMemory
{
    imagePickerController = nil;
}

#pragma mark - UIImagePickerControllerDelegate -


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage* image = info[@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (self.KRNImagePickerCompletionWithImage) {  //call block
        self.KRNImagePickerCompletionWithImage(image, nil);
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSError* error = [NSError errorWithDomain:KRNImagePickerControllerErrorDomain code:KRNImagePickerOperationIsCancelled userInfo:@{NSLocalizedDescriptionKey : KRNOperationWasCancelled}];
        
        if (self.KRNImagePickerCompletionWithImage) {  //call block
            self.KRNImagePickerCompletionWithImage(nil, error);
        }
    }];
  
}

@end
