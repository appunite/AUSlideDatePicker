//
//  AUSlideDatePickerView.h
//  AUSlideDatePicker
//
//  Created by Piotrek Adamczak on 08.10.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

//Frameworks
#import <UIKit/UIKit.h>

//Cells
#import "AUSlideDatePickerCell.h"

//Views
#import "AUSlideDatePickerCenterView.h"

@protocol AUSlideDatePickerViewDelegate;
@interface AUSlideDatePickerView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

- (id)initWithFrame:(CGRect)rect itemSize:(CGSize)itemSize;

/**
 *  Update `startDate`, `endData` and reload cells of collectionView
 */
- (void)reloadData;

/**
 *  Delegate object. Default nil.
 */
@property (nonatomic, weak) id<AUSlideDatePickerViewDelegate> delegate;

/**
 *  Collection view which contain date cells
 */
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/**
 *  Current selected date view
 */
@property (nonatomic, strong) AUSlideDatePickerCenterView *centerView;

/**
 *  Minimal displayed date
 */
@property (nonatomic, strong) NSDate *startDate;

/**
 *  Maximal displayed date
 */
@property (nonatomic, strong) NSDate *endDate;

/**
 *  Current displayed date
 */
@property (nonatomic, strong, readonly) NSDate *currentDate;

/**
 *  Scroll collection view to date.
 *
 *  @param date     Date you want to scroll
 *  @param animated If yes, scroll with animation
 */
- (void)scrollToDate:(NSDate *)date animated:(BOOL)animated;

/**
 *  Return day number from `NSDate`
 *
 *  @param date `NSDate` object to transform
 *
 *  @return `NSString` of day number
 */
- (NSString *)dayNoTextFromDate:(NSDate *)date;

/**
 *  Return abbr. of name from `NSDate` (EEE)
 *
 *  @param date `NSDate` object to transform
 *
 *  @return `NSString` of day name
 */
- (NSString *)dayTextForomDate:(NSDate *)date;

/**
 *  Returnmonth name from `NSDate` (EEE)
 *
 *  @param date `NSDate` object to transform
 *
 *  @return `NSString` of month name
 */
- (NSString *)monthTextForomDate:(NSDate *)date;

@end

@protocol AUSlideDatePickerViewDelegate <NSObject>
- (void)slideDatePickerView:(AUSlideDatePickerView *)dateSliderView
              didChangeDate:(NSDate *)date;
@end

extern NSString * const kDateSliderCellIdentifier;
