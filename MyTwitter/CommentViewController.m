//
//  CommentViewController.m
//  MyTwitter
//
//  Created by Mohini on 19/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "CommentViewController.h"
#import "Post.h"
#import "SessionData.h"
#import "NSString+Utils.h"

@interface CommentViewController ()

@end

@implementation CommentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   self.activityIndicator= [ActivityIndicator getInstanceForView:self];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUp{
    self.sessionData=[SessionData getInstance];
    self.postLabel.text=self.sessionData.currentPost.post ;
    self.nameLabel.text= self.sessionData.currentPost.user.username;//fetching for displaying purpose
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self populateData];
    
}


#pragma delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentTableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
    if(cell==nil)
	   {
		  NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil];
		  cell = [nib objectAtIndex:0];

	   }
    
	   Comment *comment=_commentTableData[indexPath.row];
	   if(_commentTableData.count!=0){//if i tried to access empty array then its giving errori.e if a post does not have comment.
	   cell.commentLabel.text=comment.comment;
	   cell.usernameLabel.text=comment.user.username;
	   cell.postedatLabel.text=[DateUtils Datetoiso8601 : comment.createdAt];
	   }
    
    
        return cell;
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  120;
}



- (IBAction)okCommentButtonPressed:(id)sender {
    
    
    
    NSString *addCommentText=self.addCommentTextField.text;
    [_addCommentTextField resignFirstResponder];
    NSString *postID= [@"" append:self.sessionData.currentPost.postId];
    if(![addCommentText isempty]){
        [self.activityIndicator startActivityIndicatorWithMessage:@"adding your comment"];
        [UserServices addComment:addCommentText withPostID:postID withUserName:self.sessionData.loggedInUser.username andCallBackMethod:^(BOOL isSuccess, NSString *errorMessage) {
	   [self.activityIndicator stopActivityIndicator];
        if (isSuccess == TRUE) {
            [AlertManager showAlertPopupWithTitle:@"SUCCESS" andMessage:@"YOU HAVE SUCCESSFULLY ADDED COMMENT" andActionTitle:@"ok" forView:self];
            self.addCommentTextField.text=nil;
		    [self populateData];
        } else {
            [AlertManager showAlertPopupWithTitle:@"FAILED" andMessage:errorMessage andActionTitle:@"OK" forView:self];
	   }}];
    }else{
	   [AlertManager showAlertPopupWithTitle:@"OOOOPS" andMessage:@"YOU CANNOT POST AN EMPTY COMMENT" andActionTitle:@"ok" forView:self];
    }
}

-(void)populateData{

        NSString *postID=[NSString stringWithFormat:@"%@",self.sessionData.currentPost.postId];
	   [self.activityIndicator startActivityIndicatorWithMessage:@"loading comments"];
	   [UserServices getPostForPostID :postID andCallBackMethod:^(Post *post, NSString *errorMessage) {
       [self.activityIndicator stopActivityIndicator];
        if(post!=nil){
            self.commentTableData=post.comments;
            [self.tableView reloadData];
		    self.postLabel.text=post.post;//updating postlabel field again after populating data
            self.sessionData.currentPost=post;

        }else{
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
	   }

    }];
}



@end
