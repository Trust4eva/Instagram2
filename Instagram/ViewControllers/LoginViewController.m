//
//  LoginViewController.m
//  Instagram
//
//  Created by Trustin Harris on 7/9/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "Post.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *orLabel;
@property (weak, nonatomic) IBOutlet UIButton *FbLogin;
@property (weak, nonatomic) IBOutlet UIButton *regLoginButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.signupButton.layer.cornerRadius = self.signupButton.frame.size.height/2;
  
 
    
    //UIColor *topColor = [UIColor colorWithRed:160.0/255.0 green:83.0/255.0 blue:219/255.0 alpha:1];
    //UIColor *bottomColor = [UIColor colorWithRed:90.0/255.0 green:6.0/255.0 blue:155/255.0 alpha:1];
    
    UIColor *topColor = [UIColor colorWithRed:124.0/255.0 green:223.0/255.0 blue:154/255.0 alpha:1];
    UIColor *bottomColor = [UIColor colorWithRed:108.0/255.0 green:13.0/255.0 blue:232/255.0 alpha:1];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    gradient.frame = self.view.bounds;
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (IBAction)ForgetpasswordButton:(id)sender {
    [self AlertController:@"Make a new account :)"];
}


- (IBAction)LoginWithFB:(id)sender {
     [self AlertController:@"Logining in with Facebook is unavailable please try again later"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tapped:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)Login:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [self AlertController:error.localizedDescription];
        } else {
            NSLog(@"User logged in successfully");
            
            [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
        }
    }];
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






@end
