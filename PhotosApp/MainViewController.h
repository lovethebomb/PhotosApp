//
//  MainViewController.h
//  PhotosApp
//
//  Created by HEYMES Lucas on 25/10/12.
//  Copyright (c) 2012 Heymès Lucas. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (retain, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (retain, nonatomic) IBOutlet UIImageView *photoView;

- (IBAction)showInfo:(id)sender;
- (IBAction)cameraButtonPressed:(id)sender;
- (IBAction)imageButtonPressed:(id)sender;

@end
