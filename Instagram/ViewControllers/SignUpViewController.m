//
//  SignUpViewController.m
//  Instagram
//
//  Created by Trustin Harris on 7/11/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"
#import "Post.h"


@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)FaceBookSignUp:(id)sender {
    [self AlertController:@"Signing up with Facebook is unavailable please try again later"];
}

- (IBAction)hideKeyboard:(id)sender {
     [self.view endEditing:YES];
}



- (IBAction)SignUpButton:(id)sender {
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [self AlertController:error.localizedDescription];
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"SignUpSegue" sender:nil];
        }
    }];
}

- (IBAction)LoginButton:(id)sender {
     [self dismissViewControllerAnimated:true completion:nil];
}

-(void)AlertController:(NSString *)Message{
    NSString *title = @"Error!";
    NSString *message = Message;
    NSString *text = @"OK";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *button = [UIAlertAction actionWithTitle:text style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:button];
    
    [self presentViewController:alert animated:YES completion:nil];
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
