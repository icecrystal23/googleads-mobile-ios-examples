//  Copyright (c) 2014 Google. All rights reserved.

@import GoogleMobileAds;

#import "ViewController.h"

@interface ViewController()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) DFPBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bannerView = [[DFPBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    
    // Replace this ad unit ID with your own ad unit ID.
    self.bannerView.adUnitID = @"/6499/example/banner";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 12) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ad"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ad"];
        }
        CGRect frame = cell.frame;
        frame.size.height = self.bannerView.frame.size.height;
        cell.frame = frame;
        NSArray *subviews = cell.contentView.subviews;
        for (UIView *cellSubview in subviews) {
            if ([cellSubview isKindOfClass:[DFPBannerView class]]) {
                [cellSubview removeFromSuperview];
            }
        }
        self.bannerView.rootViewController = self;
        [self.bannerView loadRequest:[DFPRequest request]];
        [cell.contentView addSubview:self.bannerView];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row];
        return cell;
    }
}

@end
