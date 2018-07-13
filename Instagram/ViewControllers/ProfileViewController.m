//
//  ProfileViewController.m
//  Instagram
//
//  Created by Trustin Harris on 7/12/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import "ProfileViewController.h"
#import "ParseUI.h"
#import "Post.h"
#import "PostCollectionViewCell.h"

@interface ProfileViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *profilePicIV;
@property(strong,nonatomic) NSArray *imagesArrary;
@property (weak, nonatomic) IBOutlet UICollectionView *imagescollectionView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagescollectionView.dataSource = self;
    [self Refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Refresh{
    PFUser *user = [PFUser currentUser];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"author = %@",user];
    PFQuery *query = [PFQuery queryWithClassName:@"Post" predicate:predicate];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.imagesArrary = posts;
            [self.imagescollectionView reloadData];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCollectionViewCell *cell = [self.imagescollectionView dequeueReusableCellWithReuseIdentifier:@"PostCC" forIndexPath:indexPath];
    [cell setCell:self.imagesArrary[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArrary.count;
}





@end
