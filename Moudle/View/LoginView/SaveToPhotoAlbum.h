//
//  SaveToPhotoAlbum.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/9.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SaveToPhotoAlbumDelegate <NSObject>

/**  @代理 注册成功 */
- (void)RegistSuccessDelegate;
/**  @代理 保存到相册 */
- (void)SaveToPhotoAlbumDelegate;

@end

@interface SaveToPhotoAlbum : BaseView

@property (nonatomic, weak) id <SaveToPhotoAlbumDelegate> delegate;

//更新 玩家信息
- (void)UpdateUserInfo:(NSString *)userName withPassword:(NSString *)password;


@end

NS_ASSUME_NONNULL_END
