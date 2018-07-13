//
//  DetailViewController.m
//  Instagram
//
//  Created by Trustin Harris on 7/11/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import "DetailViewController.h"
#import "Post.h"
#import <ParseUI/ParseUI.h>
#import "LoginViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ProfilePicIV;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postedPicIV;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPost:self.post];
    [self setUserID:_usernameLabel.text];
    self.ProfilePicIV.layer.cornerRadius = self.ProfilePicIV.frame.size.height/2;
    
}

-(void)setPost:(Post *)post{
    _post = post;
    self.commentLabel.text = post.caption;
    self.postedPicIV.file = post.image;
    [self.postedPicIV loadInBackground];
    self.usernameLabel.text = post.author.username;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUserID:(NSString *)userID {
    _usernameLabel.text = userID;
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
