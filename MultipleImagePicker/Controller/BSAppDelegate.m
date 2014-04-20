// The MIT License (MIT)
//
// Copyright (c) 2014 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "BSAppDelegate.h"
#import "BSImageSelectionController.h"
#import "BSImagePickerController.h"

@interface BSAppDelegate () <UIImagePickerControllerDelegate>

@property (nonatomic, strong) BSImagePickerController *imagePicker;
@property (nonatomic, strong) UIImagePickerController *oldImagePicker;

@end

@implementation BSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    
    UIButton *pressMe2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 35)];
    [pressMe2 setTitle:@"UIImagePicker" forState:UIControlStateNormal];
    [pressMe2 setTitleColor:viewController.view.tintColor forState:UIControlStateNormal];
    [pressMe2 addTarget:self action:@selector(doUIImagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [viewController.view addSubview:pressMe2];
    
    UIButton *pressMe = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 200, 35)];
    [pressMe setTitle:@"BSImagePicker" forState:UIControlStateNormal];
    [pressMe setTitleColor:viewController.view.tintColor forState:UIControlStateNormal];
    [pressMe addTarget:self action:@selector(doBSImagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [viewController.view addSubview:pressMe];
    
    
    [self setImagePicker:[[BSImagePickerController alloc] init]];
    [self setOldImagePicker:[[UIImagePickerController alloc] init]];
    [self.window setRootViewController:viewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)doUIImagePicker:(id)sender
{
    [self.oldImagePicker setDelegate:self];
    
    [self.window.rootViewController presentViewController:self.oldImagePicker animated:YES completion:nil];
}

- (void)doBSImagePicker:(id)sender
{
    [self.window.rootViewController presentImagePickerController:self.imagePicker
                                                        animated:YES
                                                      completion:nil
                                                          toggle:^(NSDictionary *info, BOOL select) {
                                                              if(select) {
                                                                  NSLog(@"Image selected");
                                                              } else {
                                                                  NSLog(@"Image deselected");
                                                              }
                                                          }
                                                           reset:^(NSArray *infoArray, BSImageReset reset) {
                                                               switch (reset) {
                                                                   case BSImageResetCancel:
                                                                       NSLog(@"Image picker canceled");
                                                                       break;
                                                                   case BSImageResetAlbum:
                                                                       NSLog(@"Image picker changed album");
                                                                       break;
                                                                   case BSImageResetDone:
                                                                       NSLog(@"Image picker done");
                                                                       break;
                                                               }
                                                           }];
}



























@end
