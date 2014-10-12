//
//  DynamicHeightTableViewCell.m
//  Time Savor
//
//  Created by Salman Rajput on 8/5/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import "DynamicHeightTableViewCell.h"

@implementation DynamicHeightTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    self.mainTextLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.mainTextLabel.frame);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
