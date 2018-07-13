//
//  PostCell.m
//  Instagram
//
//  Created by Trustin Harris on 7/10/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import <ParseUI/ParseUI.h>

@implementation PostCell

-(void)setCell:(Post*)posts{
    self.PostedPicIV.file = posts.image;
    [self.PostedPicIV loadInBackground];
    self.commentLabel.text = posts.caption;
    self.ProfilePicIV.layer.cornerRadius = 30;
    self.usernameLabel.text = posts.author.username;
    self.user2name2Label.text = posts.author.username;
}

- (IBAction)likeButton:(id)sender {
    if(self.liked == NO){
        self.likeButton.selected = YES;
    } else {
        self.likeButton.selected = NO;
        self.liked = YES;
    }
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
