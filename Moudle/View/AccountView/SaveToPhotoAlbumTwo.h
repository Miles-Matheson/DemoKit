//
//  SaveToPhotoAlbum.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/9.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SaveToPhotoAlbumTwoDelegate <NSObject>

/**  @代理 返回账号管理页面 */
- (void)BackAccountDelegate;
/**  @代理 关闭账号管理页面 */
- (void)QuitActionDelegate;
/**  @代理 保存到相册 */
- (void)SaveToPhotoAlbumDelegate;

@end

@interface SaveToPhotoAlbumTwo : BaseView

@property (nonatomic, weak) id <SaveToPhotoAlbumTwoDelegate> delegate;

//更新 玩家信息
- (void)UpdateUserInfoWithType:(NSInteger)nType withDefault:(BOOL)isDefault;


@end

NS_ASSUME_NONNULL_END
