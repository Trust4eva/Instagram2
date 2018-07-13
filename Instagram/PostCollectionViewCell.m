//
//  PostCollectionViewCell.m
//  Instagram
//
//  Created by Trustin Harris on 7/12/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import "PostCollectionViewCell.h"
#import "Post.h"
#import <ParseUI/ParseUI.h>

@implementation PostCollectionViewCell

-(void)setCell:(Post*)posts{
    self.postCell.file = posts.image;
    [self.postCell loadInBackground];
}

@end
