//
//  DateSliderViewController.m
//  Beacons
//
//  Created by Piotrek on 08.10.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUSlideDatePickerView.h"

NSString * const kDateSliderCellIdentifier = @"kDateSliderCellIdentifier";

@interface AUSlideDatePickerView ()
@property (nonatomic, strong, readwrite) NSDate *currentDate;
@end

@implementation AUSlideDatePickerView {
    // collection of displayed dates
    NSMutableArray *_dates;
    
    // single cell size
    CGSize _itemSize;
}

@synthesize currentDate = _currentDate;

- (id)initWithFrame:(CGRect)rect itemSize:(CGSize)itemSize {
    self = [super initWithFrame:rect];
    if (self) {
        _itemSize = itemSize;
        
        // setup view
        [self setClipsToBounds:NO];
        
        // create flow layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = itemSize;

        // create collection view
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_collectionView setClipsToBounds:YES];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setDecelerationRate:UIScrollViewDecelerationRateFast];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_collectionView];

        // registe cell for collectio view
        [_collectionView registerClass:[AUSlideDatePickerCell class]
            forCellWithReuseIdentifier:kDateSliderCellIdentifier];
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // layout collection view
    CGRect rect = self.bounds;
    [_collectionView setFrame:rect];

    // layout center view
    CGSize centerViewSize = _centerView.frame.size;
    CGRect centerViewRect = CGRectIntegral(CGRectMake(CGRectGetMidX(rect) - centerViewSize.width * .5f, CGRectGetMaxY(rect) - centerViewSize.height, centerViewSize.width, centerViewSize.height));
    [_centerView setFrame:centerViewRect];
}

- (void)reloadData {
    NSParameterAssert(_endDate);
    NSParameterAssert(_startDate);
    NSAssert([_endDate compare:_startDate] != NSOrderedAscending, @"End date must be greater than start date!");
    
    CGFloat inset = floorf((CGRectGetMidX(self.bounds) - _itemSize.width * .5f));
    _collectionView.contentInset = UIEdgeInsetsMake(0.f, inset, 0.f, inset);
    
    // create empty dates array
    _dates = [NSMutableArray new];

    // get current calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // get dates between count
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:_startDate toDate:_endDate options:0];
    NSInteger daysBetween = abs([components day]) +1;

    // set up increment date components object
    components = [[NSDateComponents alloc] init];
    
    // fill dates between
    if (daysBetween > 0) {
        for (int day = 0; day < daysBetween; day++) {
            // move to next day
            [components setDay:day];
            // create new date
            NSDate *date = [calendar dateByAddingComponents:components toDate:_startDate options:0];
            // add new date
            [_dates addObject:date];
        }
    }
    
    // reload collection view
    [_collectionView reloadData];
}

- (void)scrollToDate:(NSDate *)date animated:(BOOL)animated {
    NSAssert([self.startDate compare:date] != NSOrderedDescending, @"Date out of range!");
    NSAssert([date compare:self.endDate] != NSOrderedDescending, @"Date out of range");
    
    // get calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // get dates between count
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:_startDate toDate:date options:0];
    NSInteger idx = abs([components day]);
    
    // get start offset
    CGFloat inset = floorf((CGRectGetMidX(self.bounds) - _itemSize.width * .5f));
    
    // change content offset
    [_collectionView setContentOffset:CGPointMake((idx * _itemSize.width) - inset, 0.f) animated:animated];

    // save current date, send delegate
    [self setCurrentDate:date];
}


#pragma mark - 
#pragma mark Setters & Getters

- (void)setCenterView:(AUSlideDatePickerCenterView *)centerView {
    if (centerView != _centerView) {

        // remove old view
        if (_centerView) {
            [_centerView removeFromSuperview];
            _centerView = nil;
        }
        
        _centerView = centerView;

        // set new center view
        if (_centerView) {
            [_centerView setUserInteractionEnabled:NO];
            [self addSubview:_centerView];
        }

        [self _updateCenterItem];
    }
}

- (void)setCurrentDate:(NSDate *)currentDate {
    if (!_currentDate || [currentDate compare:_currentDate] != NSOrderedSame) {
        // save new value
        _currentDate = currentDate;
        
        // send delegate
        if ([self.delegate respondsToSelector:@selector(slideDatePickerView:didChangeDate:)]) {
            [self.delegate slideDatePickerView:self didChangeDate:currentDate];
        }
        
        [self _updateCenterItem];
    }
}

#pragma mark - 
#pragma mark UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dates count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // get cell
    AUSlideDatePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDateSliderCellIdentifier
                                                                            forIndexPath:indexPath];
    
    // get date object
    NSDate *date = [_dates objectAtIndex:indexPath.row];
    
    // update labels
    [cell.dayNoLabel setText:[self _dayNoTextFromDate:date]];
    [cell.dayLabel setText:[self _dayTextForomDate:date]];
    [cell setNeedsLayout];
    
    return cell;
}


#pragma mark -
#pragma mark - ScrollView Delegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat inset = floorf((CGRectGetMidX(self.bounds) - _itemSize.width * .5f));

    //This is the index of the "page" that we will be landing at
    NSUInteger nearestIndex = (NSUInteger)((targetContentOffset->x + inset) / _itemSize.width + 0.5f);
    
    //This is the actual x position in the scroll view
    CGFloat xOffset = - inset + (nearestIndex * _itemSize.width);
    
    //I've found that scroll views will "stick" unless this is done
    xOffset = xOffset == 0 ? 1 : xOffset;
    
    //Tell the scroll view to land on our page
    *targetContentOffset = CGPointMake(xOffset, targetContentOffset->y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // get current date idx base on content offset
    NSInteger idx = [self _currentIndex];
    
    // save current date, send delegate
    [self setCurrentDate:[_dates objectAtIndex:idx]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // get selected date
    NSDate *date = [_dates objectAtIndex:indexPath.row];
    
    // scroll to selected date
    [self scrollToDate:date animated:YES];
}

#pragma mark -
#pragma mark Private

- (NSUInteger)_currentIndex {
    
    // calculate start content inset
    CGFloat inset = floorf((CGRectGetMidX(self.bounds) - _itemSize.width * .5f));
    
    //This is the index of the "page" that we will be landing at
    return (NSUInteger)((_collectionView.contentOffset.x + inset) / _itemSize.width + 0.5f);
}

- (void)_updateCenterItem {
    
    // get current date
    NSDate *date = [self currentDate];
    
    // update label
    [_centerView.dayLabel setText:[self _dayTextForomDate:date]];
    [_centerView.dayNoLabel setText:[self _dayNoTextFromDate:date]];
    [_centerView.monthLabel setText:[self _monthTextForomDate:date]];
    [_centerView setNeedsLayout];
}

- (NSString *)_dayNoTextFromDate:(NSDate *)date {
    
    // get shared calendar object
    NSCalendar * calendar = [NSCalendar autoupdatingCurrentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // update day name label
    NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit fromDate:date];
    return [@([dateComponents day]) stringValue];
}

- (NSString *)_dayTextForomDate:(NSDate *)date {
    
    // get shared date formatter
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
        [_dateFormatter setDateFormat:@"EEE"];
    });
    
    // update day name label
    return [[_dateFormatter stringFromDate:date] lowercaseString];
}

- (NSString *)_monthTextForomDate:(NSDate *)date {
    
    // get shared date formatter
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
        [_dateFormatter setDateFormat:@"MMMM"];
    });
    
    // update day name label
    return [[_dateFormatter stringFromDate:date] lowercaseString];
}

@end
