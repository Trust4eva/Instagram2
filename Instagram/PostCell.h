//
//  PostCell.h
//  Instagram
//
//  Created by Trustin Harris on 7/10/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Post.h"

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *PostedPicIV;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ProfilePicIV;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (nonatomic) BOOL liked;
@property (weak, nonatomic) IBOutlet UILabel *user2name2Label;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;

-(void)setCell:(Post *)posts;

@end
