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
    self.imageView.layer.borderWidth = 0.5f;
    self.imageView.layer.borderColor = [UIColor redColor].CGColor;
    
}
    
#pragma mark - Pick an image actions -
    
- (IBAction)fromRandomSource:(id)sender {
    __weak typeof (self) weakSelf = self;
    
    [KRNImagePickerController pickFromSource:arc4random() % 3 fromViewController:self withCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            weakSelf.imageView.image = image;
        } else {
            if (error.code == KRNImagePickerOperationIsCancelled) return;
            
            [KRNAlertController showAlertControllerFromViewController:weakSelf WithTitle:@"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)fromCamera:(id)sender {
    __weak typeof (self) weakSelf = self;
    
    [KRNImagePickerController pickFromCameraFromViewController:self withCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            weakSelf.imageView.image = image;
        } else {
            if (error.code == KRNImagePickerOperationIsCancelled) return;
            
            [KRNAlertController showAlertControllerFromViewController:weakSelf WithTitle:@"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}

- (IBAction)fromPhotoLibrary:(id)sender {
    __weak typeof (self) weakSelf = self;
    
    [KRNImagePickerController pickFromPhotoLibraryFromViewController:weakSelf withCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            weakSelf.imageView.image = image;
        } else {
            [KRNAlertController showAlertControllerFromViewController:weakSelf WithTitle:(error.code == KRNImagePickerOperationIsCancelled) ?@"IMAGE HASN'T BEEN PICKED" : @"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)fromSavedPhotosAlbum:(id)sender {
    __weak typeof (self) weakSelf = self;
    
    [KRNImagePickerController pickFromSavedPhotosAlbumFromViewController:self withCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            weakSelf.imageView.image = image;
        } else {
            [KRNAlertController showAlertControllerFromViewController:weakSelf WithTitle:(error.code == KRNImagePickerOperationIsCancelled) ?@"IMAGE HASN'T BEEN PICKED" : @"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
#pragma mark - Map to image actions -
- (IBAction)mapFromRandomSource:(id)sender {
    __weak typeof (self) weakSelf = self;
    
    [KRNImagePickerController pickFromSource:arc4random() % 3 fromViewController:self andMapToImageView:weakSelf.imageView withSucceed:^(NSError *error) {
        if (error) {
            if (error.code == KRNImagePickerOperationIsCancelled) return;
            
            [KRNAlertController showAlertControllerFromViewController:weakSelf WithTitle:@"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)mapFromCamera:(id)sender {
     __weak typeof (self) weakSelf = self;
    
    [KRNImagePickerController pickFromCameraFromViewController:self andMapToImageView:weakSelf.imageView withSucceed:^(NSError *error) {
        if (error) {
            if (error.code == KRNImagePickerOperationIsCancelled) return;
            
            [KRNAlertController showAlertControllerFromViewController:weakSelf WithTitle:@"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)mapFromPhotoLibrary:(id)sender {
    __weak typeof (self) weakSelf = self;
    
    [KRNImagePickerController pickFromPhotoLibraryFromViewController:self andMapToImageView:weakSelf.imageView withSucceed:^(NSError *error) {
        if (error) {
            [KRNAlertController showAlertControllerFromViewController:weakSelf WithTitle:(error.code == KRNImagePickerOperationIsCancelled) ?@"IMAGE HASN'T BEEN PICKED" : @"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
    }];
}
    
- (IBAction)mapFromSavedPhotosAlbum:(id)sender {
    __weak typeof (self) weakSelf = self;
    
    [KRNImagePickerController pickFromSavedPhotosAlbumFromViewController:self andMapToImageView:weakSelf.imageView withSucceed:^(NSError *error) {
        if (error) {
            [KRNAlertController showAlertControllerFromViewController:weakSelf WithTitle:(error.code == KRNImagePickerOperationIsCancelled) ?@"IMAGE HASN'T BEEN PICKED" : @"ERROR" Message:error.localizedDescription andButtonTitle:@"OK"];
        }
        
    }];
}


#pragma mark - Dealloc -

- (void)dealloc{
    NSLog(@"Image Picker Controller was deallocated");
}

@end
