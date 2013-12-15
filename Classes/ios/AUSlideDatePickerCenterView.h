//
//  BCCenterSliderItemView.h
//  Beacons
//
//  Created by Piotrek on 09.10.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUSlideDatePickerCenterView : UIView

/**
 *  Day name of the week label (abbr.)
 */
@property (nonatomic, strong, readonly) UILabel *dayLabel;

/**
 *  Day of the mounth
 */
@property (nonatomic, strong, readonly) UILabel *dayNoLabel;

/**
 *  Month name (abbr.)
 */
@property (nonatomic, strong, readonly) UILabel *monthLabel;

/**
 *  Background image view
 */
@property (nonatomic, strong, readonly) UIImageView *backgroundImageView;

@end
