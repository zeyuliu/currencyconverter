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
@property (nonatomic, strong) UITextField *originalCurrency;
@property (nonatomic, strong) UITextField *finalCurrency;

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
    
    self.originalCurrency.frame = CGRectMake(self.view.frame.origin.x + 20, 100, self.view.frame.size.width / 2 - 30, 50);
    self.finalCurrency.frame = CGRectMake(self.originalCurrency.frame.origin.x + self.originalCurrency.frame.size.width + 20, self.originalCurrency.frame.origin.y, self.originalCurrency.frame.size.width, self.originalCurrency.frame.size.height);
    [self.view addSubview:self.originalCurrency];
    [self.view addSubview:self.finalCurrency];
    
    
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

- (UITextField *) originalCurrency {
    if (!_originalCurrency) {
        _originalCurrency = [[UITextField alloc] init];
        [_originalCurrency setFont:[UIFont systemFontOfSize:16]];
        [_originalCurrency setPlaceholder:@"Original Amount"];
        [_originalCurrency setKeyboardType:UIKeyboardTypeDecimalPad];
        [_originalCurrency setBorderStyle:UITextBorderStyleRoundedRect];
    }
    
    return _originalCurrency;
}

- (UITextField *) finalCurrency {
    if (!_finalCurrency) {
        _finalCurrency = [[UITextField alloc] init];
        [_finalCurrency setFont:[UIFont systemFontOfSize:16]];
        [_finalCurrency setPlaceholder:@"Final Amount"];
        [_finalCurrency setKeyboardType:UIKeyboardTypeDecimalPad];
        [_finalCurrency setBorderStyle:UITextBorderStyleRoundedRect];
    }
    
    return _finalCurrency;
}

@end
