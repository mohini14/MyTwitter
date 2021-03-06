//
//  UserProfile.h
//  MyTwitter
//
//  Created by Mohini on 18/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "UserServices.h"
#import "AlertManager.h"
#import "UserPost.h"
#import "CommentViewController.h"
#import "PostTableCell.h"

@interface UserProfile : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    
}

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *emailIdLabel;
@property (strong, nonatomic) NSDictionary *dict;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSDictionary *userProfileData;
@property (strong,nonatomic) UIImageView* getImageNameForRow;
@property (strong,nonatomic) NSArray *userarr;

@property(nonatomic, strong) NSArray *postsTableData;
@property(nonatomic, strong) SessionData *sessionData;

-(void) onClickFromSelectedRowToComments;

//- (IBAction)addNewPostButton:(UIButton *)sender;
-(IBAction)unwindFromUserPost:(UIStoryboardSegue *)segue;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
//-(void) preapareForSuccessfullLoginSEaguewithResponseData:(NSDictionary *)responseData;
















@end
