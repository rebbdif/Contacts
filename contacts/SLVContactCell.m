//
//  TableViewCell.m
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SLVContactCell.h"

@implementation SLVContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, self.frame.size.height / 2 - 10, self.frame.size.width - 72, 20)];
        [self.contentView addSubview:self.nameLabel];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 40, 40)];
        self.titleLabel.layer.cornerRadius = 20;
        self.titleLabel.layer.borderWidth = 0.7;
        self.titleLabel.layer.opacity = 0.7;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        self.titleLabel.shadowOffset = CGSizeMake(0.7, 0.7);
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

@end
