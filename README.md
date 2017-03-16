KRNImagePickerController
========================

KRNImagePickerController is a wrapper under UIImagePickerController to simplify its usage.


##Installation
- Drag the `KRNImagePickerController/KRNImagePickerController` folder into your project.
- `#import "KRNImagePickerController.h"` where appropriate.
Or use pod 'KRNImagePickerController'.

##Usage

(see sample Xcode project in `/KRNImagePickerController`)

## Pick an image

For picking image just use next method without need to create any instances of UIImagePickerController, conform to UIImagePickerDelegate protocol, write delegate methods etc.

```objc

+ (void)pickFromSource:(UIImagePickerControllerSourceType)sourceType fromViewController:(UIViewController *)viewController withCompletion:(KRNImagePickerCompletionWithImage)completion;
```

1. sourceType - is a type of source you want to pick from an image (UIImagePickerControllerSourceTypePhotoLibrary,
UIImagePickerControllerSourceTypeCamera or UIImagePickerControllerSourceTypeSavedPhotosAlbum).
2. viewController -  is an instance of UIViewController from which UIImagePickerController will be presenting
3. completion - is a block which will be called after picking the image or if error is occured.

For example, if you have instance of UIImageView in your ViewController and you want to pick UIImage for that UIImageView instance, you can easily use the method above:

```objc
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

...
__weak typeof (self) weakSelf = self;
[KRNImagePickerController pickFromSource:UIImagePickerControllerSourceTypePhotoLibrary 
fromViewController:self 
withCompletion:^(UIImage *image, NSError *error) {
if (!error) {
    weakSelf.imageView.image = image;
} else {
    if (error.code == KRNImagePickerOperationIsCancelled) return; // cancelation of operation is also considered to be an error so you may just return here 
    // handle the error
}
}];
```
Cancelation of operation is also considered to be an error for simplification. If user canceled picking operation KRNImagePickerOperationIsCancelled error would be passed in completion block which you can handle and perform appropriate operations.
### Convinient methods
If you are sure which source you need you may use one of convinient methods with already chosen source:
```objc
// from Photo Library
+ (void)pickFromPhotoLibraryFromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage)completion; 

// from Camera
+ (void)pickFromCameraFromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage)completion;

// from Saved photos album
+ (void)pickFromSavedPhotosAlbumFromViewController:(UIViewController *) viewController withCompletion:(KRNImagePickerCompletionWithImage)completion; 
```
## Mapping to UIImageView
KRNImagePickerController allows you to map picked image to "image" property of UIImageView instance.
For mapping you can use next method:
```objc
+ (void) pickFromSource:(UIImagePickerControllerSourceType)sourceType fromViewController:(UIViewController *)viewController andMapToImageView:(UIImageView *)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed;
```
##### Example:

```objc
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

...
__weak typeof (self) weakSelf = self;
[KRNImagePickerController pickFromSource:UIImagePickerControllerSourceTypePhotoLibrary fromViewController:self andMapToImageView:weakSelf.imageView withSucceed:^(NSError *error) {
if (error) {
    if (error.code == KRNImagePickerOperationIsCancelled) return;
    //handle error here
}
}];
```
### Convinient methods
There are also convinient methods which you can use to map picked image to UIImageView instance:
```objc
// from Photo Library
+ (void)pickFromPhotoLibraryFromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed;

// from Camera
+ (void)pickFromCameraFromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed;

// from Saved photos album
+ (void)pickFromSavedPhotosAlbumFromViewController:(UIViewController *) viewController andMapToImageView:(UIImageView*)imageView withSucceed:(KRNImagePickerSucceedBlock)succeed;
```

## Requirements

* iOS 8.0 and above
* XCode 6+

## License

KRNImagePickerController is released under the MIT license. See LICENSE for details.

## Contact

Any suggestion or question? Please create a Github issue or reach me out.

[linkedin](https://www.linkedin.com/in/julian-drapaylo)

