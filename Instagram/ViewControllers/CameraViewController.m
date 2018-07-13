//
//  CameraViewController.m
//  Instagram
//
//  Created by Trustin Harris on 7/10/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import "CameraViewController.h"
#import "Post.h"
#import "Parse/Parse.h"
#import "ParseUI.h"

@interface CameraViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *PictureIV;
@property (weak, nonatomic) IBOutlet UITextView *captionLabel;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)tappedImage:(id)sender {
     [self TakingAPhoto];
}

- (IBAction)ShareButtonTapped:(id)sender {
    [Post postUserImage:self.PictureIV.image withCaption:self.captionLabel.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (error) {
            NSLog(error.localizedDescription);
        } else {
            NSLog(@"Success!");
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)TakingAPhoto{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.PictureIV.image = editedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
