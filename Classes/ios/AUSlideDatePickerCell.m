//
//  DateSliderCell.m
//  Beacons
//
//  Created by Piotrek on 08.10.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUSlideDatePickerCell.h"

@implementation AUSlideDatePickerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        UIColor *textColor = [UIColor colorWithRed:203.f/255.f green:203.f/255.f blue:203.f/255.f alpha:1.f];
        
        // add center day of month label
        _dayNoLabel = [[UILabel alloc] init];
        [_dayNoLabel setBackgroundColor:[UIColor clearColor]];
        [_dayNoLabel setTextColor:textColor];
        [_dayNoLabel setFont:[UIFont boldSystemFontOfSize:32.f]];
        [_dayNoLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_dayNoLabel];
        
        // add top day of week
        _dayLabel = [[UILabel alloc] init];
        [_dayLabel setBackgroundColor:[UIColor clearColor]];
        [_dayLabel setTextColor:textColor];
        [_dayLabel setFont:[UIFont systemFontOfSize:10.f]];
        [_dayLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_dayLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect rect = CGRectInset(self.bounds, 1.f, 1.f);
    
    // layout day name label
    CGSize daySize = [_dayLabel.text sizeWithFont:_dayLabel.font forWidth:CGRectGetWidth(rect) lineBreakMode:_dayLabel.lineBreakMode];
    CGRect dayRect = CGRectMake(CGRectGetMaxX(rect) - daySize.width - 5.f, CGRectGetMinY(rect), daySize.width, daySize.height);
    _dayLabel.frame = dayRect;
    
    // layout day number label
    CGSize dayNoSize = [_dayNoLabel.text sizeWithFont:_dayNoLabel.font forWidth:CGRectGetWidth(rect) lineBreakMode:_dayNoLabel.lineBreakMode];
    CGRect dayNoRect = CGRectIntegral(CGRectMake(CGRectGetMidX(rect) - dayNoSize.width * .5f, CGRectGetMidY(rect) - dayNoSize.height * .5f, dayNoSize.width, dayNoSize.height));
    _dayNoLabel.frame = dayNoRect;
}

@end
