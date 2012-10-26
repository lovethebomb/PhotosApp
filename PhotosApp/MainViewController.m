//
//  MainViewController.m
//  PhotosApp
//
//  Created by HEYMES Lucas on 25/10/12.
//  Copyright (c) 2012 Heymès Lucas. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    BOOL takingPhoto;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
    {
        self.cameraButton.enabled = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"This device doesn't support camera feature" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
    takingPhoto = NO;
    
    // Rechargement de l'image
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folderPath = [pathsArray objectAtIndex:0];
    NSString *fullPath = [folderPath stringByAppendingPathComponent:@"photo.jpg"];
    UIImage *photo = [UIImage imageWithContentsOfFile:fullPath];
    self.photoView.image = photo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/* Image Picker */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    takingPhoto = NO;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@", info);
    UIImage *photo = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.photoView.image = photo;
    if (takingPhoto) {
        UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil);
        NSData *imageData = UIImageJPEGRepresentation(photo, 0.8);
        NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *folderPath = [pathsArray objectAtIndex:0];
        NSString *fullPath = [folderPath stringByAppendingPathComponent:@"photo.jpg"];
        [imageData writeToFile:fullPath atomically:YES];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    takingPhoto = NO;
}

/* Buttons */
- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil] autorelease];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)cameraButtonPressed:(id)sender {
    UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    takingPhoto = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)imageButtonPressed:(id)sender {
    UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

/* Memory Dealloc */
- (void)dealloc {
    [_cameraButton release];
    [_photoView release];
    [super dealloc];
}

@end
