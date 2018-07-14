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


@interface ProfileViewController ()<UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet PFImageView *profilePicIV;
@property(strong,nonatomic) NSArray *imagesArrary;
@property (weak, nonatomic) IBOutlet UICollectionView *imagescollectionView;
@property (weak, nonatomic) IBOutlet UIButton *EditProfileButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagescollectionView.dataSource = self;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.imagescollectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
     CGFloat imagesPerRow = 3;
     CGFloat width = (self.imagescollectionView.frame.size.width - layout.minimumInteritemSpacing * (imagesPerRow-1)) / imagesPerRow;
    CGFloat height = width * 1.5;
    layout.itemSize = CGSizeMake(width, height);
    
    self.settingsButton.layer.borderWidth = 0.7;
    self.EditProfileButton.layer.borderWidth = 0.7;
    self.EditProfileButton.layer.cornerRadius = 5;
    self.settingsButton.layer.cornerRadius = 5;
    
    self.EditProfileButton.layer.borderColor = [[UIColor grayColor]CGColor];
    self.settingsButton.layer.borderColor = [[UIColor grayColor]CGColor];
    self.profilePicIV.layer.cornerRadius = 30;
    
    [self fetchUserImage];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self fetchUserImage];
    [self Refresh];
}

-(void)fetchUserImage{
    PFUser* user = PFUser.currentUser;
    self.profilePicIV.file = user[@"imageFile"];
   [self.profilePicIV loadInBackground];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapProfilePicture:(id)sender {
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
    
    self.profilePicIV.image = originalImage;
    
    PFUser * user = PFUser.currentUser;
    
    user[@"imageFile"] = [Post getPFFileFromImage:editedImage];
    [user saveInBackground];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
