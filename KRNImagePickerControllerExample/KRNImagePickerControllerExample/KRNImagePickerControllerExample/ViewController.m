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

@end
