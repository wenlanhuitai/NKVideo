//
//  HNLCoreDataManager.h
//  HNLVideo
//
//  Created by 谢印超 on 2017/3/1.
//  Copyright © 2017年 谢印超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


typedef enum {
    HNLCoreDataSqliteType,
    HNLCoreDataXMLType,
    HNLCoreDataBinaryType,
    HNLCoreDataInMemoryType,
}HNLCoreDataStoreType;

typedef enum {
    HNLCoreDataTable_tutorial,
    HNLCoreDataTable_author,
}HNLCoreDataTableName;

#define pageNum 16

@interface HNLCoreDataManager : NSObject
+ (instancetype)defaultCoreData;

@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, copy) NSString *storeFileName;
@property (nonatomic, assign) HNLCoreDataStoreType storeType;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectMainContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSArray *)getListWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptions entityName:(NSString *)entityName limitNum:(NSNumber *)limitNum;



/***
 *  保存数据 （条件串，表明）
 *
 */

-(void) saveData:(NSMutableArray *)dataArray withTableName:(HNLCoreDataTableName)entitleTableName;

/***
 *  查找数据 （条件串，表明）
 *
 */

- (NSArray *) searchData:(NSString *)predicate sort:(NSArray *)sortDescriptors withTableName:(HNLCoreDataTableName)entitleTableName limitNum:(NSNumber *)limit offset:(NSUInteger) page;

/***
 * 删除一个表的所有数据，没有回掉
 *
 */
- (BOOL)deleteAllObjectWithEntityName:(NSString *)entityName;
/***
 * 删除一个表的所有数据，有回掉
 *
 */
- (void) deleteAllObjectWithEntityName:(NSString *)entityName complete:(void (^)(BOOL isSuccess)) complete;
@end
