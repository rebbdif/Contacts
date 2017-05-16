//
//  ViewController.m
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "TableController.h"
#import "ContactsTV.h"
#import "Model.h"
#import "ContactInfo.h"
#import "DetailedInfoViewController.h"
#import "ContactCell.h"
@import FBSDKLoginKit;
@import FBSDKCoreKit;

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 7) green:((g) / 7) blue:((b) / 7) alpha:1.0]

@interface TableController ()

@property(strong,nonatomic) Model * model;
@property(strong,nonatomic) UITableView *tableView;

@end

@implementation TableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[ContactCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.rowHeight=56;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"VK", @"FB"]];
    segmentedControl.selectedSegmentIndex=0;
    [segmentedControl addTarget:self action:@selector(segmentedControlDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segmentedControlItem =[[UIBarButtonItem alloc]initWithCustomView:segmentedControl];
    self.navigationItem.rightBarButtonItem = segmentedControlItem;
    
    self.model=[Model new];
    __weak typeof(self) weakSelf=self;
    [weakSelf.model getNamesWithCompletionHandler:^{
        [weakSelf.tableView reloadData];
    }];
    self.navigationItem.title=@"Contacts";
}

- (IBAction)segmentedControlDidChangeValue:(UISegmentedControl *)segmentedControl{
    switch (segmentedControl.selectedSegmentIndex){
        case 0:{
            self.model.contacts=nil;
            [self.tableView reloadData];
            __weak typeof(self) weakSelf=self;
            [weakSelf.model getNamesWithCompletionHandler:^{
                [weakSelf.tableView reloadData];
            }];
        }
        case 1:{
            self.model.contacts=nil;
            [self.tableView reloadData];
            FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
            CGRect frame = self.view.frame;
            loginButton.center=CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2) ;
            if (![FBSDKAccessToken currentAccessToken]) {
                [self.view addSubview:loginButton];
            } else {
                loginButton.hidden=YES;
                __weak typeof(self) weakSelf=self;
                [weakSelf.model getContactsFromFacebookWithCompletionHandler:^{
                    [weakSelf.tableView reloadData];
                }];
            }
        }
    }
}

#pragma - UITableViewD

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

@end
