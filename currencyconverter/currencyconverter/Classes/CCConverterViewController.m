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
@property (nonatomic, strong) UITextField *originalCurrencyTextField;
@property (nonatomic, strong) UITextField *finalCurrencyTextField;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

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
    
    self.title = @"Currency Converter";
    
    // XXX temporarily hard-coded
    CCCurrency *usd = [[CCCurrency alloc] initWithName:@"USD" value:[NSNumber numberWithFloat:1]];
    CCCurrency *yuan = [[CCCurrency alloc] initWithName:@"Chinese Yuan" value:[NSNumber numberWithFloat:6.4]];
    [self.currencyArray addObject:usd];
    [self.currencyArray addObject:yuan];
    
    // XXX 162 is default size of picker view
    self.pickerView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height - 162, self.view.frame.size.width, 162);
    [self.view addSubview:self.pickerView];
    
    self.originalCurrencyTextField.frame = CGRectMake(self.view.frame.origin.x + 20, 100, self.view.frame.size.width / 2 - 30, 50);
    self.finalCurrencyTextField.frame = CGRectMake(self.originalCurrencyTextField.frame.origin.x + self.originalCurrencyTextField.frame.size.width + 20, self.originalCurrencyTextField.frame.origin.y, self.originalCurrencyTextField.frame.size.width, self.originalCurrencyTextField.frame.size.height);
    [self.view addSubview:self.originalCurrencyTextField];
    [self.view addSubview:self.finalCurrencyTextField];
    
    // make keyboards disappear when you click on background
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dismissKeyboard {
    [self.originalCurrencyTextField resignFirstResponder];
    [self.finalCurrencyTextField resignFirstResponder];
    
    [self calculateExchangeRate];
}

- (void) calculateExchangeRate {

    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSInteger row2 = [self.pickerView selectedRowInComponent:1];
    
    CCCurrency *originalCurrency = [self.currencyArray objectAtIndex:row1];
    CCCurrency *finalCurrency = [self.currencyArray objectAtIndex:row2];
    
    CGFloat exchangeRate = [finalCurrency.value floatValue] / [originalCurrency.value floatValue];
    
    CGFloat finalValue = [self.originalCurrencyTextField.text floatValue] * exchangeRate;
    self.finalCurrencyTextField.text = [NSString stringWithFormat:@"%.2f", finalValue];
    
}

#pragma mark - pickerview delegates
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // implement selector here
    
    if ([self.currencyArray count] > row) {
        CCCurrency *currency = [self.currencyArray objectAtIndex:row];
        if (component == 0) {
            [self.originalCurrencyTextField setPlaceholder:currency.name];
        }
        else if (component == 1) {
            [self.finalCurrencyTextField setPlaceholder:currency.name];
        }
        
        [self calculateExchangeRate];
    }
    
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

- (UITextField *) originalCurrencyTextField {
    if (!_originalCurrencyTextField) {
        _originalCurrencyTextField = [[UITextField alloc] init];
        [_originalCurrencyTextField setFont:[UIFont systemFontOfSize:16]];
//        [_originalCurrencyTextField setPlaceholder:@"Original Amount"];
        [_originalCurrencyTextField setKeyboardType:UIKeyboardTypeDecimalPad];
        [_originalCurrencyTextField setBorderStyle:UITextBorderStyleRoundedRect];
    }
    
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    if ([self.currencyArray count] > row) {
        CCCurrency *currency = [self.currencyArray objectAtIndex:row];
        [_originalCurrencyTextField setPlaceholder: currency.name];
    }
    
    return _originalCurrencyTextField;
}

- (UITextField *) finalCurrencyTextField {
    if (!_finalCurrencyTextField) {
        _finalCurrencyTextField = [[UITextField alloc] init];
        [_finalCurrencyTextField setFont:[UIFont systemFontOfSize:16]];
//        [_finalCurrencyTextField setPlaceholder:@"Final Amount"];
        [_finalCurrencyTextField setKeyboardType:UIKeyboardTypeDecimalPad];
        [_finalCurrencyTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [_finalCurrencyTextField setUserInteractionEnabled:NO];
    }
    
    NSInteger row = [self.pickerView selectedRowInComponent:1];
    if ([self.currencyArray count] > row) {
        CCCurrency *currency = [self.currencyArray objectAtIndex:row];
        [_finalCurrencyTextField setPlaceholder:currency.name];
    }
    return _finalCurrencyTextField;
}

- (UITapGestureRecognizer *) tapGestureRecognizer {
    if (!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    }
    return  _tapGestureRecognizer;
}
@end
