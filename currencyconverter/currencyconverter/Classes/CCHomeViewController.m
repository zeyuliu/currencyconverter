//
//  CCHomeViewController.m
//  currencyconverter
//
//  Created by Alex Liu on 12/11/13.
//  Copyright (c) 2013 Andrew Liu. All rights reserved.
//

#import "CCHomeViewController.h"
#import "CCInfoViewController.h"
#import "CCConverterViewController.h"

@interface CCHomeViewController ()

// private properties
@property (nonatomic, strong) UIButton *currencyButton;

@end

@implementation CCHomeViewController

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
    
    [self setupCurrencyButton];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setupCurrencyButton {
    self.currencyButton.frame = CGRectMake(self.view.frame.origin.x + 20, self.view.frame.origin.y + 100, self.view.frame.size.width - 2*20, 100);
    [self.view addSubview:self.currencyButton];
}

- (void) currencyButtonClicked: (id) sender {
    
    // when currency button clicked, show the ConverterViewController
    CCConverterViewController *cvc = [[CCConverterViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
}

# pragma mark - Override methods
- (void) setupNavigationBar {
    UIButton *leftNavButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [leftNavButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftNavButton];
}

- (void) backButtonClicked:(id)sender {
    
    // when back button clicked, show info view controller
    CCInfoViewController *ivc = [[CCInfoViewController alloc] init];
    [self.navigationController pushViewController:ivc animated:YES];
}

# pragma mark - Subviews

- (UIButton *) currencyButton {
    if (!_currencyButton) {
        _currencyButton = [[UIButton alloc] init];
        
        [_currencyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_currencyButton setTitle:@"Press me!" forState:UIControlStateNormal];
        [_currencyButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_currencyButton setBackgroundColor:[UIColor redColor]];
        [_currencyButton addTarget:self action:@selector(currencyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _currencyButton;
}

@end
