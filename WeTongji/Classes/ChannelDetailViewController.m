//
//  ChannelDetailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelDetailViewController.h"
#import "NSString+Addition.h"
#import "NSUserDefaults+Addition.h"

@interface ChannelDetailViewController ()

@property (nonatomic, strong) Activity *activity;

@end

@implementation ChannelDetailViewController

@synthesize organizerNameLabel = _organizerNameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize placeLabel = _placeLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize activityCategoryLabel = _activityCategoryLabel;
@synthesize titleLabel = _titleLabel;
@synthesize scrollView = _scrollView;
@synthesize subOrganizerNameLabel = _subOrganizerNameLabel;
@synthesize favoriteButton = _favoriteButton;
@synthesize likeButton = _likeButton;
@synthesize scheduleButton = _scheduleButton;
@synthesize favoriteLabel = _favoriteLabel;
@synthesize likeLabel = _likeLabel;
@synthesize scheduleLabel = _scheduleLabel;

@synthesize activity = _activity;

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
    // Do any additional setup after loading the view from its nib.
    [self configureNavBar];
    [self configureIBOutlets];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.organizerNameLabel = nil;
    self.timeLabel = nil;
    self.placeLabel = nil;
    self.descriptionLabel = nil;
    self.activityCategoryLabel = nil;
    self.titleLabel = nil;
    self.scrollView = nil;
    self.subOrganizerNameLabel = nil;
    self.favoriteButton = nil;
    self.likeButton = nil;
    self.scheduleButton = nil;
}

- (id)initWithActivity:(Activity *)activity {
    self = [super init];
    if(self) {
        self.activity = activity;
    }
    return self;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"活动"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [UIBarButtonItem getBackButtonItemWithTitle:@"频道" target:self action:@selector(didClickBackButton)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureIBOutlets {
    self.titleLabel.text = self.activity.title;
    self.descriptionLabel.text = self.activity.activity_description;
    [self.descriptionLabel sizeToFit];
    CGRect rect = self.descriptionLabel.frame;
    if(rect.size.height >= 110)
        rect.size.height = 110;
    self.descriptionLabel.frame = rect;
    self.organizerNameLabel.text = self.activity.organizer;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + 1);
    self.timeLabel.text = [NSString timeConvertFromBeginDate:self.activity.begin_time endDate:self.activity.end_time];
    self.placeLabel.text = self.activity.location;
    self.subOrganizerNameLabel.text = self.activity.sub_organizer;
    NSArray *channelNames = [NSUserDefaults getChannelNameArray];
    self.activityCategoryLabel.text = [NSString stringWithFormat:@"发表%@", [channelNames objectAtIndex:self.activity.channel_id.intValue]];
    self.likeLabel.text = [NSString stringWithFormat:@"%d", self.activity.like_count.intValue];
    self.scheduleLabel.text = [NSString stringWithFormat:@"%d", self.activity.hot_count.intValue];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", self.activity.follow_count.intValue];
    
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didClickFavoriteButton:(UIButton *)sender {
    [self.favoriteButton setSelected:!sender.selected];
}

- (IBAction)didClickLikeButton:(UIButton *)sender {
    [self.likeButton setSelected:!sender.selected];
}
- (IBAction)didClickScheduleButton:(UIButton *)sender {
    [self.scheduleButton setSelected:!sender.selected];
}

@end
