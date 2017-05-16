//
//  DetailedInfoViewController.m
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "DetailedInfoViewController.h"

@interface DetailedInfoViewController ()

@end

@implementation DetailedInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 120, self.view.frame.size.width-160, 40)];
    nameLabel.text=self.name;
    [self.view addSubview:nameLabel];
    
    UILabel *surnameLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 170, self.view.frame.size.width-160, 40)];
    surnameLabel.text=self.surname;
    [self.view addSubview:surnameLabel];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-20, 80, 40, 40)];
    imageView.image=self.titleImage;
    [self.view addSubview:imageView];

    self.navigationItem.title=[NSString stringWithFormat:@"%@, %@",self.name,self.surname];
}


@end
