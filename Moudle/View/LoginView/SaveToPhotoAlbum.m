//
//  SaveToPhotoAlbum.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/9.
//

#import "SaveToPhotoAlbum.h"

@interface SaveToPhotoAlbum()

@property (weak, nonatomic) IBOutlet UILabel *SaveNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *SavePasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *SaveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *SaveTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *SaveTitleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *SaveTitleLabel2;
@property (weak, nonatomic) IBOutlet UIButton *SaveButton;
@property (weak, nonatomic) IBOutlet UIButton *SkipButton;

- (IBAction)BackAction:(id)sender;
- (IBAction)SaveAction:(id)sender;
- (IBAction)SkipAction:(id)sender;


@end

@implementation SaveToPhotoAlbum

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"SaveToPhotoAlbum" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.SaveButton.layer setMasksToBounds:YES];
        [self.SaveButton.layer setCornerRadius:5.0f];
        [self.SkipButton.layer setMasksToBounds:YES];
        [self.SkipButton.layer setCornerRadius:5.0f];
    }
    return self;
}

//退出 登录页面
- (IBAction)BackAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(RegistSuccessDelegate)])
    {
        [self.delegate RegistSuccessDelegate];
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
    if([self.delegate respondsToSelector:@selector(RegistSuccessDelegate)])
    {
        [self.delegate RegistSuccessDelegate];
    }
}

//更新 玩家信息
- (void)UpdateUserInfo:(NSString *)userName withPassword:(NSString *)password
{
    NSString *unTitle = @"用户名：";
    NSString *pwTitle = @"密码：";
    NSString *title1 = @"请牢记账号信息";
    NSString *title2 = @"强烈建议您截图保存账号信息";
    NSString *title3 = @"您也可以在账号管理界面绑定手机";
    
    NSMutableAttributedString *nameString = [[QY_CommonController sharedComController] SetOneTitle:unTitle oneColor:[UIColor blackColor] twoTitle:userName twoColor:[UIColor redColor]];
    NSMutableAttributedString *passwordString = [[QY_CommonController sharedComController] SetOneTitle:pwTitle oneColor:[UIColor blackColor] twoTitle:password twoColor:[UIColor redColor]];
    NSString *msgTime = [self GetNowTime];
    NSMutableAttributedString *str1 = [[QY_CommonController sharedComController] SetOneTitle:@"" oneColor:[UIColor blackColor] twoTitle:title1 twoColor:[UIColor redColor]];
    NSMutableAttributedString *str2 = [[QY_CommonController sharedComController] SetOneTitle:title2 oneColor:[UIColor blackColor] twoTitle:@"" twoColor:[UIColor redColor]];
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
