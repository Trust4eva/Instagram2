//
//  Post.m
//  Instagram
//
//  Created by Trustin Harris on 7/9/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import "Post.h"
#import "Parse/Parse.h"
#import <ParseUI/ParseUI.h>


@implementation Post
@dynamic postID,userID,author,caption,image,likeCount,commentCount,profilepic;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption  withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    [newPost saveInBackgroundWithBlock: completion];
    
}



+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
