//
//  HomeViewController.m
//  Instagram
//
//  Created by Trustin Harris on 7/9/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Post.h"
#import "PostCell.h"
#import "DetailViewController.h"
#import "ParseUI.h"

@interface HomeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *CameraButton;
@property(strong,nonatomic) NSArray *imagesArrary;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Refresh];
    self.myTableView.rowHeight = 491;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(Refresh) forControlEvents:UIControlEventValueChanged];
    [self.myTableView insertSubview:self.refreshControl atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)LogOut:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;\
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        appDelegate.window.rootViewController = loginViewController;
    }];
}

- (IBAction)tapCameraButton:(id)sender {
    [self performSegueWithIdentifier:@"cameraSegue" sender:nil];
}

-(void)Refresh{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.imagesArrary = posts;
            [self.myTableView reloadData];
            [self.refreshControl endRefreshing];
            
        
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"cameraSegue"]){
        
    } else {
        
    
    PostCell *cell = sender;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
    Post *post = self.imagesArrary[indexPath.row];
    
    DetailViewController *controller = [segue destinationViewController];
    controller.post = post;
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"PostCell"];
    [cell setCell:self.imagesArrary[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imagesArrary.count;
}



@end
