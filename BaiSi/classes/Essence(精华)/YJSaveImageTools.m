
#import "YJSaveImageTools.h"

@implementation YJSaveImageTools

+ (void)saveImageToCustomCollection:(UIImage *)image title:(NSString *)title success:(void (^)())success failure:(void (^)())failure
{
    // 1.将图片保存到【camera roll相机胶卷】中
    __block NSString *assetId = nil;
    // 添加图片到相机胶卷必须要在这个block中执行
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetId = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];
    
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil];
    
    
    
    // 2.创建自定义相册
    // 先要判断自定义相册是否已经创建了，如果没有创建才需要创建，如果已经创建了就不需要在创建了
    // 遍历法:获取相簿里所有的相册，判断相册的名称是否和自定义相册的名称相同，如果相同说明已经创建过了，否则就需要创建自定义相册
    // 自定义相册的名称一般默认情况是应用的名称相同
    // 获取当前应用的名称
    // CFStringRef:是 Core Fundation框架
    // cf开头的对象，在arc内存管理下，不会cf开头的对象进行内存管理，只会管理ns开头的对象的内存
    // 如果想让arc内存管理机制来管理cf对象的内存，就需要把cf开头的对象转换成ns开头的对象
    // 问题:CFStringRef转换成NSString 桥接__bridge
    if (title == nil||[title isEqualToString:@""]) {
        title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    }
   
    // 声明自定义相册
    PHAssetCollection *createdColleciton = nil;
    // 获取相簿里所有的相册
    /*
     PHAssetCollectionType:相册的类型
     PHAssetCollectionTypeAlbum 相簿
     PHAssetCollectionTypeSmartAlbum 智能相册,
     PHAssetCollectionTypeMoment     时刻,
     */
    PHFetchResult<PHAssetCollection *> *collections =[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            createdColleciton = collection;
            break; // 结束遍历
        }
    }
    //自定义相册没有创建
    if (createdColleciton == nil) {//
        __block NSString *createdCollectionId = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        } error:nil];
        createdColleciton = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].lastObject;
        
        
    }
    //第三步  将图片添加到自定义相册中
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdColleciton];
        [request insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    if (error) { // error有值保存失败
        if (failure) {
            // 调用失败的block
            failure();
        }
    }else{
        if (success) {
            // 调用成功的block
            success();
        }
    }
}



@end
