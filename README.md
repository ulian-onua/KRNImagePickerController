KRNImagePickerController
========================

KRNImagePickerController is a wrapper under UIImagePickerController to simplify its usage.


##Installation
- Drag the `KRNImagePickerController/KRNImagePickerController` folder into your project.
- `#import "KRNImagePickerController.h"` where appropriate.

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

