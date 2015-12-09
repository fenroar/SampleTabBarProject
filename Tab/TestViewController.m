//
//  TestViewController.m
//  Tab
//
//  Created by Peter Su on 09/12/2015.
//  Copyright © 2015 fenroar. All rights reserved.
//

#import "TestViewController.h"
#import "TestHiddenTabViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) UINavigationBar *testNavBar;

@end

@implementation TestViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.tabBarItem.image = [UIImage imageNamed:@"ic_menu"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Test 123";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadView {
    [super loadView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Resolves issue with the back button title being the title of the view that pushed to the VC
    // Still enables the swipe to go back gesture ;)
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
//    [self setupTestNavBar];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    if (self.testNavBar) {
        UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Test"];
        navItem.rightBarButtonItem = rightBarButton;
        [self.testNavBar setItems:@[ navItem ]];
    } else {
        self.navigationItem.rightBarButtonItem = rightBarButton;
    }
}

- (void)setupTestNavBar {
    self.navigationController.navigationBarHidden = YES;
    self.testNavBar = [[UINavigationBar alloc] init];
    self.testNavBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.testNavBar];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.testNavBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.testNavBar attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.testNavBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.testNavBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test {
    TestHiddenTabViewController *testController = [[TestHiddenTabViewController alloc] initWithNibName:@"TestHiddenTabViewController" bundle:nil];
    // Has to overwrite the bottom, left and right extended layouts
    testController.edgesForExtendedLayout = UIRectEdgeBottom|UIRectEdgeLeft|UIRectEdgeRight;
    // Can show the navigation bar
    testController.navigationController.navigationBarHidden = NO;
    testController.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:testController animated:YES];
}

@end
