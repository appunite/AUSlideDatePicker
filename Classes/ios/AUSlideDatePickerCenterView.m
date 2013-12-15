//
//  BCCenterSliderItemView.m
//  Beacons
//
//  Created by Piotrek on 09.10.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUSlideDatePickerCenterView.h"

@implementation AUSlideDatePickerCenterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // add background view
        _backgroundImageView = [[UIImageView alloc] init];
        [_backgroundImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_backgroundImageView];
        
        // add center day of month label
        _dayNoLabel = [[UILabel alloc] init];
        [_dayNoLabel setBackgroundColor:[UIColor clearColor]];
        [_dayNoLabel setTextColor:[UIColor whiteColor]];
        [_dayNoLabel setFont:[UIFont boldSystemFontOfSize:44.f]];
        [_dayNoLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_dayNoLabel];
        
        // add top day of week
        _dayLabel = [[UILabel alloc] init];
        [_dayLabel setBackgroundColor:[UIColor clearColor]];
        [_dayLabel setTextColor:[UIColor whiteColor]];
        [_dayLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_dayLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_dayLabel];
        
        // add bottom month name
        _monthLabel = [[UILabel alloc] init];
        [_monthLabel setBackgroundColor:[UIColor clearColor]];
        [_monthLabel setTextColor:[UIColor whiteColor]];
        [_monthLabel setFont:[UIFont systemFontOfSize:11.f]];
        [_monthLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_monthLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = CGRectInset(self.bounds, 22.f, 2.f);

    // layout background image view
    CGSize imageSize = _backgroundImageView.image.size;
    CGRect imageFrame = CGRectMake(0, CGRectGetMaxY(self.bounds) - imageSize.height, imageSize.width, imageSize.height);
    [_backgroundImageView setFrame:imageFrame];
    
    // layout day name label
    CGSize daySize = [_dayLabel.text sizeWithFont:_dayLabel.font forWidth:CGRectGetWidth(rect) lineBreakMode:_dayLabel.lineBreakMode];
    CGRect dayRect = CGRectMake(CGRectGetMaxX(rect) - daySize.width, CGRectGetMinY(rect), daySize.width, daySize.height);
    _dayLabel.frame = dayRect;
    
    // layout day number label
    CGSize dayNoSize = [_dayNoLabel.text sizeWithFont:_dayNoLabel.font forWidth:CGRectGetWidth(rect) lineBreakMode:_dayNoLabel.lineBreakMode];
    CGRect dayNoRect = CGRectIntegral(CGRectMake(CGRectGetMidX(rect) - dayNoSize.width * .5f, CGRectGetMidY(rect) - dayNoSize.height * .5f, dayNoSize.width, dayNoSize.height));
    _dayNoLabel.frame = dayNoRect;
    
    // layout month label
    CGSize monthSize = [_monthLabel.text sizeWithFont:_monthLabel.font forWidth:CGRectGetWidth(rect) lineBreakMode:_monthLabel.lineBreakMode];
    CGRect monthRect = CGRectIntegral(CGRectMake(CGRectGetMidX(rect) - monthSize.width * .5f, CGRectGetMaxY(dayNoRect) - 8.f, monthSize.width, monthSize.height));
    _monthLabel.frame = monthRect;
    
}

@end
