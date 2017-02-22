//
//  CommentViewController.h
//  MyTwitter
//
//  Created by Mohini on 19/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserServices.h"
#import "AlertManager.h"
#import "ActivityIndicator.h"
#import "CommentTableViewCell.h"
#import "Post.h"
#import "Comment.h"
#import "DateUtils.h"

@interface CommentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) IBOutlet UILabel *postLabel;
@property (strong, nonatomic) IBOutlet UITextField *addCommentTextField;
@property (strong,nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) Post *displayPost;
@property (strong,nonatomic) NSArray *commentTableData;
@property(strong,nonatomic) ActivityIndicator *activityIndicator;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)okCommentButtonPressed:(id)sender;



-(void)populateData;












@end
