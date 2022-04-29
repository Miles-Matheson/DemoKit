//
//  SaveToPhotoAlbum.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/9.
//

#import "SaveToPhotoAlbumTwo.h"

@interface SaveToPhotoAlbumTwo()

@property (weak, nonatomic) IBOutlet UILabel *SaveTitle;
@property (weak, nonatomic) IBOutlet UILabel *SaveNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *SavePasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *SaveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *SaveTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *SaveTitleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *SaveTitleLabel2;
@property (weak, nonatomic) IBOutlet UIButton *SaveButton;
@property (weak, nonatomic) IBOutlet UIButton *SkipButton;
@property (nonatomic, assign) NSInteger nType;

- (IBAction)BackAction:(id)sender;
- (IBAction)SaveAction:(id)sender;
- (IBAction)SkipAction:(id)sender;


@end

@implementation SaveToPhotoAlbumTwo

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"SaveToPhotoAlbumTwo" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.SaveButton.layer setMasksToBounds:YES];
        [self.SaveButton.layer setCornerRadius:5.0f];
        [self.SkipButton.layer setMasksToBounds:YES];
        [self.SkipButton.layer setCornerRadius:5.0f];
        
        NSString *SDKName = [[KeyController sharedKeyController] GetSDKName];
        [self.SaveTitle setText:SDKName];
    }
    return self;
}

//退出 登录页面
- (IBAction)BackAction:(id)sender {
    if (self.nType == 1 || self.nType == 2) {
        if([self.delegate respondsToSelector:@selector(QuitActionDelegate)])
        {
            [self.delegate QuitActionDelegate];
        }
    }
    else {
        if([self.delegate respondsToSelector:@selector(BackAccountDelegate)])
        {
            [self.delegate BackAccountDelegate];
        }
    }
}

//保存到相册
- (IBAction)SaveAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(SaveToPhotoAlbumDelegate)])
    {
        [self.delegate SaveToPhotoAlbumDelegate];
    }
}

//退出 登录页面
- (IBAction)SkipAction:(id)sender {
    if (self.nType == 1 || self.nType == 2) {
        if([self.delegate respondsToSelector:@selector(QuitActionDelegate)])
        {
            [self.delegate QuitActionDelegate];
        }
    }
    else {
        if([self.delegate respondsToSelector:@selector(BackAccountDelegate)])
        {
            [self.delegate BackAccountDelegate];
        }
    }
}

//更新 玩家信息
- (void)UpdateUserInfoWithType:(NSInteger)nType withDefault:(BOOL)isDefault
{
    self.nType = nType;
    NSString *nameTitle = @"用户名：";
    NSString *phoneTitle = @"手机号：";
    NSString *title1 = isDefault? @"该账户可使用用户名或手机号登录":@"该账户只可使用用户名登录";
    NSString *title2 = @"请牢记账号信息";
    NSString *title3 = @"强烈建议您截图保存账号信息";
    NSString *sName = [[KeyController sharedKeyController] GetUserName];
    NSString *sPhone = [[KeyController sharedKeyController] GetUserMobile];
    
    NSMutableAttributedString *nameString = [[QY_CommonController sharedComController] SetOneTitle:nameTitle oneColor:[UIColor blackColor] twoTitle:sName twoColor:[UIColor redColor]];
    NSMutableAttributedString *passwordString = [[QY_CommonController sharedComController] SetOneTitle:phoneTitle oneColor:[UIColor blackColor] twoTitle:sPhone twoColor:[UIColor redColor]];
    NSString *msgTime = [self GetNowTime];
    NSMutableAttributedString *str1 = [[QY_CommonController sharedComController] SetOneTitle:@"" oneColor:[UIColor blackColor] twoTitle:title1 twoColor:[UIColor redColor]];
    NSMutableAttributedString *str2 = [[QY_CommonController sharedComController] SetOneTitle:@"" oneColor:[UIColor blackColor] twoTitle:title2 twoColor:[UIColor redColor]];
    NSMutableAttributedString *str3 = [[QY_CommonController sharedComController] SetOneTitle:title3 oneColor:[UIColor blackColor] twoTitle:@"" twoColor:[UIColor redColor]];
    
    [self.SaveTimeLabel setText:msgTime];
    [self.SaveNameLabel setAttributedText:nameString];
    [self.SavePasswordLabel setAttributedText:passwordString];
    [self.SaveTitleLabel setAttributedText:str1];
    [self.SaveTitleLabel1 setAttributedText:str2];
    [self.SaveTitleLabel2 setAttributedText:str3];
    
}

//获取当前时间
- (NSString *)GetNowTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

@end
