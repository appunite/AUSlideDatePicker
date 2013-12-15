//
//  DateSliderCell.h
//  Beacons
//
//  Created by Piotrek on 08.10.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUSlideDatePickerCell : UICollectionViewCell 

/**
 *  Day name of the week label (abbr.)
 */
@property (nonatomic, strong, readonly) UILabel *dayLabel;

/**
 *  Day of the mounth
 */
@property (nonatomic, strong, readonly) UILabel *dayNoLabel;

@end
