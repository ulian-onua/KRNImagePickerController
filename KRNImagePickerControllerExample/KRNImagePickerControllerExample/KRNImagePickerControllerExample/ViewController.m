//
//  ViewController.m
//  KRNImagePickerControllerExample
//
//  Created by ulian_onua on 20.08.16.
//  Copyright © 2016 ulian_onua. All rights reserved.
//

#import "ViewController.h"
#import "KRNAlertController.h"
#import "KRNImagePickerController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
    
#pragma mark - Pick an image actions -
    
- (IBAction)fromRandomSource:(id)sender {
    [KRNImagePickerController pickFromSource:arc4random() % 3 fromViewController:self withCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            self.imageView.image = image;
        } else {
            if (error.code == KRNImagePickerOperationIsCancelled) return;
            
            [KRNAlertController showAlertControllerFromViewController:self WithTitle:@"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)fromCamera:(id)sender {
    [KRNImagePickerController pickFromCameraFromViewController:self withCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            self.imageView.image = image;
        } else {
            if (error.code == KRNImagePickerOperationIsCancelled) return;
            
            [KRNAlertController showAlertControllerFromViewController:self WithTitle:@"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}

- (IBAction)fromPhotoLibrary:(id)sender {
    [KRNImagePickerController pickFromPhotoLibraryFromViewController:self withCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            self.imageView.image = image;
        } else {
            [KRNAlertController showAlertControllerFromViewController:self WithTitle:(error.code == KRNImagePickerOperationIsCancelled) ?@"IMAGE HASN'T BEEN PICKED" : @"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)fromSavedPhotosAlbum:(id)sender {
    [KRNImagePickerController pickFromSavedPhotosAlbumFromViewController:self withCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            self.imageView.image = image;
        } else {
            [KRNAlertController showAlertControllerFromViewController:self WithTitle:(error.code == KRNImagePickerOperationIsCancelled) ?@"IMAGE HASN'T BEEN PICKED" : @"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
#pragma mark - Map to image actions -
- (IBAction)mapFromRandomSource:(id)sender {
    [KRNImagePickerController pickFromSource:arc4random() % 3 fromViewController:self andMapToImageView:self.imageView withSucceed:^(NSError *error) {
        if (error) {
            if (error.code == KRNImagePickerOperationIsCancelled) return;
            
            [KRNAlertController showAlertControllerFromViewController:self WithTitle:@"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)mapFromCamera:(id)sender {
    [KRNImagePickerController pickFromCameraFromViewController:self andMapToImageView:self.imageView withSucceed:^(NSError *error) {
        if (error) {
            if (error.code == KRNImagePickerOperationIsCancelled) return;
            
            [KRNAlertController showAlertControllerFromViewController:self WithTitle:@"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)mapFromPhotoLibrary:(id)sender {
    [KRNImagePickerController pickFromPhotoLibraryFromViewController:self andMapToImageView:self.imageView withSucceed:^(NSError *error) {
        if (error) {
            [KRNAlertController showAlertControllerFromViewController:self WithTitle:(error.code == KRNImagePickerOperationIsCancelled) ?@"IMAGE HASN'T BEEN PICKED" : @"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)mapFromSavedPhotosAlbum:(id)sender {
    [KRNImagePickerController pickFromSavedPhotosAlbumFromViewController:self andMapToImageView:self.imageView withSucceed:^(NSError *error) {
        if (error) {
            [KRNAlertController showAlertControllerFromViewController:self WithTitle:(error.code == KRNImagePickerOperationIsCancelled) ?@"IMAGE HASN'T BEEN PICKED" : @"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
        
    }];
}


@end
