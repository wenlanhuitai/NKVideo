//
//  HNLCoreDataManager.m
//  HNLVideo
//
//  Created by 谢印超 on 2017/3/1.
//  Copyright © 2017年 谢印超. All rights reserved.
//

#import "HNLCoreDataManager.h"
#import "Tutorial+CoreDataClass.h"
#define HNL_StoreType(_storeType) _storeType == HNLCoreDataSqliteType? return NSSQLiteStoreType:return NSXMLStoreType 
@interface HNLCoreDataManager()


@end

@implementation HNLCoreDataManager
 static HNLCoreDataManager* coreDataManager = nil;
@synthesize managedObjectMainContext = _managedObjectMainContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static NSString * const hnlModelNameExtension = @"momd"; //数据模型文件后缀
static NSString * const hnlStoreNameExtension = @"sqlite"; //数据模型文件后缀
+ (instancetype) defaultCoreData {
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        coreDataManager = [[HNLCoreDataManager alloc] init];
        coreDataManager.modelName = @"HNLVideo"; //默认视频数据库模型
    });
    
    return coreDataManager;
}


- (NSManagedObjectContext *) managedObjectMainContext {
    
    if (_managedObjectMainContext) {
        return _managedObjectMainContext;
    }
    
    if (self.persistentStoreCoordinator) {
        _managedObjectMainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectMainContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    
    return _managedObjectMainContext;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator{
    
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    
    NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption: @YES,
                               NSInferMappingModelAutomaticallyOption: @YES };
    
    //协调者绑定模型之后，需要绑定存储文件路径
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"HNL.sqlite"]];
                      
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[fileURL path]]) {
        //self.storeFileName = @"HNL"
        NSURL *storeURL = [self URLOfFileName:self.storeFileName withExtension:hnlStoreNameExtension];
        if (storeURL) {
            [fileManager copyItemAtURL:storeURL toURL:fileURL error:NULL];
        }
    }
    NSError *error = nil;
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileURL options:options error:&error]) {
#if DEBUG
        [self dealWithLinkStoreError:error];
#endif
    }
    return _persistentStoreCoordinator;
}

/***
 * 数据模型文件获取 HNLVideo momd文件模型
 *
 */
- (NSManagedObjectModel *) managedObjectModel {
    
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    //self.modelName = @"HNLVideo";
    NSURL *modelURL = [self URLOfFileName:self.modelName withExtension:hnlModelNameExtension];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSURL *) URLOfFileName:(NSString *)modelName withExtension:(NSString *)modelExtension {
    
    NSURL *modeUrl = [[NSBundle mainBundle] URLForResource:modelName withExtension:modelExtension];
    
    return modeUrl;
}


#pragma mark - 外部接口方法，增，删，改，查

/***
 * 数据存储外部接口
 * 参数：一个对象数组，对象的实体名
 */
-(void) saveData:(NSMutableArray *)dataArray withTableName:(HNLCoreDataTableName)entitleTableName {
    
    // 这个时候只是通过Mmoc 把新建的 模型对象 Tutorial，临时放入内存（这是context和协调者的功劳）
    
    //任何表模型实体对象 都是继承自 ：NSManagedObject -- > Tutorial
    //    Class entitleClass = NSClassFromString(entitleName);
    
    switch (entitleTableName) {
        case HNLCoreDataTable_tutorial:
        {
            for (Tutorial *tutor in  dataArray ){
                //                Tutorial *tutor =[NSEntityDescription insertNewObjectForEntityForName:@"tutorial" inManagedObjectContext:self.managedObjectMainContext];
                [self.managedObjectMainContext insertObject:tutor];
                
            }
            
            //存储
            if([self.managedObjectMainContext save:nil]) {
                NSLog(@"save success!");
            }
        }
            
            break;
        case HNLCoreDataTable_author:
            ;
            break;
            
        default:
            break;
    }
    
    for (NSObject *dataObj in dataArray) {
        
        //        entitleClass *tutor =[NSEntityDescription insertNewObjectForEntityForName:entitleName inManagedObjectContext:self.managedObjectMainContext];
        //
        //        tutor.title = @"titlesssss";
        //        tutor.star = 30;
        //        tutor.collect = 20;
        //        tutor.comment = 4;
        
    }
    
    
    
    //存储
    if([self.managedObjectMainContext save:nil]) {
        NSLog(@"save success!");
    }
    
}


/***
 * 修改数据
 *
 */
- (void) editData {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@",@"nihao"];
    NSArray *dataArrary = [[HNLCoreDataManager defaultCoreData] getListWithPredicate:predicate sortDescriptors:nil entityName:@"" limitNum:nil offset:0];
   
}

/***
 *  查找数据 （参训条件串，表明）
 *
 */

- (NSArray *) searchData:(NSString *)predicate sort:(NSArray *)sortDescriptors withTableName:(HNLCoreDataTableName)entitleTableName limitNum:(NSNumber *)limit offset:(NSUInteger) page{
    
     NSPredicate *predic = [NSPredicate predicateWithFormat:@"%@",predicate];
    NSString *tableName = @"";
    switch (entitleTableName) {
        case HNLCoreDataTable_tutorial:
        {
            tableName = @"";
        }
            break;
            
        default:
            break;
    }
    
    NSArray *dataArray = [self getListWithPredicate:predic sortDescriptors:sortDescriptors entityName:tableName limitNum:limit offset:pageNum * page ];
    
    return dataArray;
}


/***
 * 删除数据
 *
 */
- (void) delete {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"author == %@",@"1"];
    NSSortDescriptor *sortDesriptor = [[NSSortDescriptor alloc] initWithKey:@"" ascending:NO];
    NSArray *sortDesriptors = [[NSArray alloc] initWithObjects:sortDesriptor, nil];
    
    //从context中获取到要删除的数据
    NSArray *array = [[HNLCoreDataManager defaultCoreData] getListWithPredicate:predicate sortDescriptors:sortDesriptors entityName:@"" limitNum:@(1) offset:nil];
    __weak typeof(self) weakSelf = self;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.managedObjectMainContext deleteObject:obj];
    }];
}


/***
 * 内部方法
 *
 */
#pragma mark - 内部私有方法

- (BOOL) save {
    NSError *error = nil;
    BOOL isSuccess = [self.managedObjectMainContext save:&error];
    return isSuccess;
}

- (void) save:(void (^)(BOOL isSuccess)) complete {
    BOOL isSuccess = [self save];
    if (complete) {
        complete(isSuccess);
    }
}

- (BOOL) deleteObject:(NSManagedObject *)object {
    [self.managedObjectMainContext deleteObject:object];
    BOOL isSuccess = [self save];
    return isSuccess;
}

- (void)deleteObject:(NSManagedObject *) object complete:(void(^)(BOOL isSuccess)) complete {
    BOOL isSuccess = [self deleteObject:object];
    if (complete) {
        complete(isSuccess);
    }
}

- (NSArray *)getListWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptions entityName:(NSString *)entityName limitNum:(NSNumber *)limitNum offset:(NSUInteger )offset {
    NSError *error = nil;

    // 创建取回数据请求
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // 设置查询条件
    
    if (predicate != nil) {
         [fetchRequest setPredicate:predicate];
    }
   
    
    // 设置排序条件
    if (sortDescriptions != nil) {
         [fetchRequest setSortDescriptors:sortDescriptions];
    }
   
    // 查询条件的总数
    if (limitNum != nil) {
         [fetchRequest setFetchLimit:[limitNum integerValue]];
    }
    

    [fetchRequest setFetchOffset:offset];
    
   
    // 执行获取数据请求,返回数组
    NSArray *fetchResult = [self.managedObjectMainContext executeFetchRequest:fetchRequest error:&error];

    return fetchResult;
}

/***
 * 删除一个表的所有数据
 *
 */
- (BOOL)deleteAllObjectWithEntityName:(NSString *)entityName
{
    NSArray *allObjects = [self getListWithPredicate:nil sortDescriptors:nil entityName:entityName limitNum:nil];
    
    if(allObjects && 0 != allObjects.count)
    {
        for (NSManagedObject *object in allObjects)
        {
            [self.managedObjectMainContext deleteObject:object];
        }
        return [self save];
    }
    return NO;
}
- (void) deleteAllObjectWithEntityName:(NSString *)entityName complete:(void (^)(BOOL isSuccess)) complete {
    
    BOOL isSuccess = [self deleteAllObjectWithEntityName:entityName];
    if (isSuccess) {
        complete(isSuccess);
    }
}
/***
 * 错误处理
 *
 */
- (void) dealWithLinkStoreError:(NSError *)error {
    
}



@end
