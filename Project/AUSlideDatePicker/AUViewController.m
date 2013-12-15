//
//  AUViewController.m
//  AUSlideDatePicker
//
//  Created by Emil Wojtaszek on 15.12.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUViewController.h"
#import "AUSlideDatePickerCenterView.h"

@implementation AUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImage *rubyImage = [UIImage imageNamed:@"dateSliderCenterItemBg"];
    UIImage *pickerBacgroundImage = [UIImage imageNamed:@"dateSliderBg"];
    
    CGRect datePickerRect = CGRectMake(0.f, 200.f, CGRectGetWidth(self.view.bounds), 55.f);
    CGRect centerViewRect = CGRectMake(0.f, 0.f, rubyImage.size.width, rubyImage.size.height);
    
    // create date picker
    AUSlideDatePickerView *datePicker = [[AUSlideDatePickerView alloc] initWithFrame:datePickerRect itemSize:CGSizeMake(53.f, 55.f)];
    [datePicker setBackgroundColor:[UIColor colorWithPatternImage:pickerBacgroundImage]];
    [self.view addSubview:datePicker];

    // set date picker range
    [datePicker setStartDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*3]];
    [datePicker setEndDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*3]];
    [datePicker setDelegate:self];

    // move to current date
    [datePicker scrollToDate:[NSDate date] animated:NO];
    
    // set center view
    AUSlideDatePickerCenterView *centerView = [[AUSlideDatePickerCenterView alloc] initWithFrame:centerViewRect];
    [centerView.backgroundImageView setImage:rubyImage];
    [datePicker setCenterView:centerView];
    
    // reload data
    [datePicker reloadData];
    
}

- (void)slideDatePickerView:(AUSlideDatePickerView *)dateSliderView
              didChangeDate:(NSDate *)date {
    NSLog(@"%@", date);
}

@end
