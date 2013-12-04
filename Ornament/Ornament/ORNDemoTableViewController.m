//
//  ORNPlainDemoTableViewController.m
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNDemoTableViewController.h"
#import "ORNNavigationController.h"
#import "ORNTableViewCell.h"
#import "UIColor+ORNAdditions.h"

enum {
    ORNDemoTableViewSectionStyles,
    ORNDemoTableViewSectionOptions,
    ORNDemoTableViewSectionMore
};

enum {
    ORNDemoTableViewStatsCurrentStyle,
    ORNDemoTableViewStatsSwitch
};

@implementation ORNDemoTableViewController
{
    NSArray *_sections;
    BOOL _isStatusBarOpaque;
}

#pragma mark - UIViewController

- (NSString *)title
{
    return @"Ornament";
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - ORNTableViewController

- (instancetype)initWithTableViewStyle:(ORNTableViewStyle)style
{
    if (self = [super initWithTableViewStyle:style]) {
        _sections = @[@[@"Plain", @"Grouped", @"Grouped Etched", @"Grouped Card", @"Grouped Metal", @"Grouped Groove", @"Custom"],
                      @[@"Current Style", @"Opaque Status Bar"],
                      @[@"More…"]];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sections[section] count];
}

#pragma mark UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section != ORNDemoTableViewSectionOptions);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.section == ORNDemoTableViewSectionStyles) {
        self.tableViewStyle = indexPath.row;

        ORNNavigationController *navigationController = (ORNNavigationController *)self.navigationController;
        if (navigationController) {
            ORNNavigationBarStyle navigationBarStyle;
            switch (self.tableViewStyle) {
                case ORNTableViewStylePlain:
                case ORNTableViewStyleMetal:
                    navigationBarStyle = ORNNavigationBarStyleBlackTranslucent;
                    break;
                case ORNTableViewStyleGrouped:
                case ORNTableViewStyleCard:
                case ORNTableViewStyleCustom:
                    navigationBarStyle = ORNNavigationBarStyleBlue;
                    break;
                case ORNTableViewStyleGroupedEtched:
                    navigationBarStyle = ORNNavigationBarStyleBlueSimple;
                    break;
                case ORNTableViewStyleGroove:
                    navigationBarStyle = ORNNavigationBarStyleBlack;
                    break;
            }
            navigationController.navigationBarStyle = navigationBarStyle;
        }
    }
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ORNTableViewCell *cell = (ORNTableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *text = _sections[indexPath.section][indexPath.row];
    if (indexPath.section == ORNDemoTableViewSectionOptions && indexPath.row == ORNDemoTableViewStatsCurrentStyle) {
        NSString *style = _sections[ORNDemoTableViewSectionStyles][self.tableViewStyle];
        cell.textContents = @[text, style];
    } else {
        cell.textContents = @[text];
    }
    cell.booleanContents = @[@(_isStatusBarOpaque)];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case ORNDemoTableViewSectionStyles:
            return @"Styles";
        case ORNDemoTableViewSectionOptions:
            return @"Options";
        default:
            return nil;
    }
}

#pragma mark ORNTableViewDelegate

- (ORNTableViewCellStyle)tableView:(ORNTableView *)tableView cellStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case ORNDemoTableViewSectionStyles:
            return ORNTableViewCellStyleDefault;
        case ORNDemoTableViewSectionOptions:
            switch (indexPath.row) {
                case ORNDemoTableViewStatsCurrentStyle:
                    return ORNTableViewCellStyleValue1;
                default:
                    return ORNTableViewCellStyleDefault;
            }
        default:
            return ORNTableViewCellStyleCentered;
    }
}

- (ORNTableViewCellAccessory)tableView:(ORNTableView *)tableView cellAccessoryTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case ORNDemoTableViewSectionStyles:
            return (indexPath.row == self.tableViewStyle) ? ORNTableViewCellAccessoryCheckmark : ORNTableViewCellAccessoryNone;
        case ORNDemoTableViewSectionOptions:
            switch (indexPath.row) {
                case ORNDemoTableViewStatsCurrentStyle:
                    return ORNTableViewCellAccessoryNone;
                default:
                    return ORNTableViewCellAccessorySwitch;
            }
        default:
            return ORNTableViewCellAccessoryNone;
    }
}

#pragma mark - ORNSwitchDelegate

- (void)switch:(ORNSwitch *)s didSetOn:(BOOL)on forIndexPath:(NSIndexPath *)indexPath
{
    _isStatusBarOpaque = on;
}

@end