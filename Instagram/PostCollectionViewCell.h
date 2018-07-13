//
//  PostCollectionViewCell.h
//  Instagram
//
//  Created by Trustin Harris on 7/12/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "Post.h"

@interface PostCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postCell;
-(void)setCell:(Post*)posts;

@end
