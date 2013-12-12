//
//  CCConverterViewController.m
//  currencyconverter
//
//  Created by Alex Liu on 12/11/13.
//  Copyright (c) 2013 Andrew Liu. All rights reserved.
//

#import "CCConverterViewController.h"
#import "CCCurrency.h"

@interface CCConverterViewController ()

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *currencyArray;

@end

@implementation CCConverterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // XXX temporarily hard-coded
    CCCurrency *usd = [[CCCurrency alloc] initWithName:@"USD" value:[NSNumber numberWithFloat:1]];
    CCCurrency *yuan = [[CCCurrency alloc] initWithName:@"Chinese Yuan" value:[NSNumber numberWithFloat:6.4]];
    [self.currencyArray addObject:usd];
    [self.currencyArray addObject:yuan];
    
    // XXX 162 is default size of picker view
    self.pickerView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height - 162, self.view.frame.size.width, 162);
    [self.view addSubview:self.pickerView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - pickerview delegates
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // implement selector here
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.currencyArray count];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    // one for the original currency and one for the new currency
    return 2;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    CCCurrency *currency = [self.currencyArray objectAtIndex:row];
    return currency.name;
}

# pragma mark - lazy loaded properties
- (NSMutableArray *) currencyArray {
    
    if (!_currencyArray) {
        _currencyArray = [NSMutableArray array];
    }
    
    return _currencyArray;
}

- (UIPickerView *) pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    
    return _pickerView;
}

@end
