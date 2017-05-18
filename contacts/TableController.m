//
//  ViewController.m
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "TableController.h"
#import "Model.h"
#import "ContactInfo.h"
#import "DetailedInfoViewController.h"
#import "ContactCell.h"
#import "VKLoginViewController.h"
@import FBSDKLoginKit;
@import FBSDKCoreKit;

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 7) green:((g) / 7) blue:((b) / 7) alpha:1.0]

typedef NS_ENUM(NSInteger, SelectedSocialNetwork){
    SelectedSocialNetworkVkontakte,
    SelectedSocialNetworkFacebook
};

@interface TableController ()

@property(strong,nonatomic) Model * model;
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) UIToolbar *bottomBar;
@property(assign,nonatomic) SelectedSocialNetwork selectedSocialNetwork;
@property(strong,nonatomic) UIButton *loginButton;

@end

@implementation TableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect frame = self.view.frame;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 56;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[ContactCell class] forCellReuseIdentifier:@"Cell"];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"VK", @"FB"]];
    segmentedControl.selectedSegmentIndex=0;
    [segmentedControl addTarget:self action:@selector(segmentedControlDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:segmentedControl];
    
    self.loginButton=[UIButton new];
    self.loginButton.frame=CGRectMake(0,0,60,20);
    self.loginButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.loginButton setTitle: @"Log in" forState: UIControlStateNormal];
    [self.loginButton setTitleColor: UIColor.redColor forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.loginButton];
    
    self.navigationItem.title=@"Contacts";
    self.model=[Model new];
    self.selectedSocialNetwork = SelectedSocialNetworkVkontakte;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.selectedSocialNetwork == SelectedSocialNetworkVkontakte) {
        if ([VKLoginViewController currentAccessToken]){
            [self.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
            [self.loginButton setTitleColor: UIColor.blueColor forState:UIControlStateNormal];
            __weak typeof(self) weakSelf=self;
            [self.model getNamesWithCompletionHandler:^{
                [weakSelf.tableView reloadData];
            }];
        }
    } else if (self.selectedSocialNetwork == SelectedSocialNetworkFacebook){
        if ([FBSDKAccessToken currentAccessToken]) {
            [self.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
            [self.loginButton setTitleColor: UIColor.blueColor forState:UIControlStateNormal];
            __weak typeof(self) weakSelf=self;
            [self.model getContactsFromFacebookWithCompletionHandler:^{
                [weakSelf.tableView reloadData];
            }];
        }
    }
}

- (IBAction)segmentedControlDidChangeValue:(UISegmentedControl *)segmentedControl {
    self.model.contacts=nil;
    self.bottomBar.items=nil;
    [self.tableView reloadData];
    switch (segmentedControl.selectedSegmentIndex) {
        case 0: {
            self.selectedSocialNetwork = SelectedSocialNetworkVkontakte;
            if (![VKLoginViewController currentAccessToken]){
                [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
                [self.loginButton setTitleColor: UIColor.redColor forState:UIControlStateNormal];
            } else {
                [self.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
                [self.loginButton setTitleColor: UIColor.blueColor forState:UIControlStateNormal];
                __weak typeof(self) weakSelf=self;
                [self.model getNamesWithCompletionHandler:^{
                    [weakSelf.tableView reloadData];
                }];
            }
            break;
        }
        case 1: {
            self.selectedSocialNetwork = SelectedSocialNetworkFacebook;
            if (![FBSDKAccessToken currentAccessToken]) {
                [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
                [self.loginButton setTitleColor: UIColor.redColor forState:UIControlStateNormal];
            } else {
                [self.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
                [self.loginButton setTitleColor: UIColor.blueColor forState:UIControlStateNormal];
                __weak typeof(self) weakSelf=self;
                [self.model getContactsFromFacebookWithCompletionHandler:^{
                    [weakSelf.tableView reloadData];
                }];
            }
        }
    }
}

#pragma mark - UITableView DataSource

- (ContactCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    ContactInfo* contact = self.model.contacts[indexPath.row];
    cell.nameLabel.text=[NSString stringWithFormat:@"%@, %@",contact.name,contact.surname];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@%@",[contact.name substringToIndex:1],[contact.surname substringToIndex:1]];
    
    NSUInteger hash=[cell.titleLabel.text substringToIndex:1].hash;
    
    cell.titleLabel.layer.backgroundColor=[UIColor colorWithRed:(hash%7)/7.0 green:(hash%49)/49.0 blue:(hash%343)/343.0 alpha:1].CGColor;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.contacts.count;
}


# pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    
    UIGraphicsBeginImageContext(cell.titleLabel.frame.size);
    [cell.titleLabel.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    DetailedInfoViewController *dvc=[DetailedInfoViewController new];
    ContactInfo* contact = self.model.contacts[indexPath.row];
    dvc.name=contact.name;
    dvc.surname=contact.surname;
    dvc.titleImage=image;
    [self.navigationController pushViewController:dvc animated:YES];
}

# pragma mark - login

- (void)loginButtonClicked {
    if ([self.loginButton.titleLabel.text isEqualToString:@"Log out"]) {
        [self logout];
        return;
    }
    
    if (self.selectedSocialNetwork == SelectedSocialNetworkVkontakte) {
        [self.navigationController pushViewController:[VKLoginViewController new] animated:YES];
    } else if (self.selectedSocialNetwork == SelectedSocialNetworkFacebook) {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions: @[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                NSLog(@"Process error");
            } else if (result.isCancelled) {
                NSLog(@"Cancelled");
            } else {
                NSLog(@"Logged in");
                __weak typeof(self) weakSelf=self;
                [self.model getContactsFromFacebookWithCompletionHandler:^{
                    [weakSelf.tableView reloadData];
                }];
            }
        }];
    }
}

- (void)logout {
    if (self.selectedSocialNetwork == SelectedSocialNetworkVkontakte) {
        [VKLoginViewController logout];
    } else if (self.selectedSocialNetwork == SelectedSocialNetworkFacebook) {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
    }
    [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    [self.loginButton setTitleColor: UIColor.redColor forState:UIControlStateNormal];
    self.model.contacts = nil;
    
}

@end
