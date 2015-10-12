//
//  AppDelegate.m
//  E3
//
//  Created by colin liao on 7/27/15.
//  Copyright (c) 2015 Huihoo. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "CateGoryViewController.h"
#import "WishListViewController.h"
#import "CartViewController.h"
#import "MineViewController.h"
#import "SessionModel.h"
#import "UIImage+WLCategory.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [SessionModel saveSessionIDNew];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController* tabBarController = [[UITabBarController alloc] init];
    
    
    
    UIImage* homeChooseImage = [UIImage imageNamed:@"home_choose"];
    UIImage *homeImage = [UIImage imageNamed:@"home"];
    homeChooseImage = [homeChooseImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeImage = [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController* homeNaviController = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    homeNaviController.tabBarItem.title = @"首页";
    homeNaviController.tabBarItem.image = homeImage;
    homeNaviController.tabBarItem.selectedImage = homeChooseImage;
    
    
    
    UIImage* categoryChooseImage = [UIImage imageNamed:@"category_choose"];
    UIImage *categoryImage = [UIImage imageNamed:@"category"];
    categoryChooseImage = [categoryChooseImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    categoryImage = [categoryImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController* categoryNaviController = [[UINavigationController alloc] initWithRootViewController:[[CateGoryViewController alloc] init]];
    categoryNaviController.tabBarItem.title = @"分类";
    categoryNaviController.tabBarItem.image = categoryImage;
    categoryNaviController.tabBarItem.selectedImage = categoryChooseImage;
    
    
    UIImage* wishChooseImage = [UIImage imageNamed:@"wish_choose"];
    UIImage *wishImage = [UIImage imageNamed:@"wish"];
    wishChooseImage = [wishChooseImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    wishImage = [wishImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController* wishListNaviController = [[UINavigationController alloc] initWithRootViewController:[[WishListViewController alloc] init]];
    wishListNaviController.tabBarItem.title = @"心愿单";
    wishListNaviController.tabBarItem.image = wishImage;
    wishListNaviController.tabBarItem.selectedImage = wishChooseImage;
    
    
    
    UIImage* cartChooseImage = [UIImage imageNamed:@"cart_choose"];
    UIImage *cartImage = [UIImage imageNamed:@"cart"];
    cartChooseImage = [cartChooseImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cartImage = [cartImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController* cartNaviController = [[UINavigationController alloc] initWithRootViewController:[[CartViewController alloc] init]];
    cartNaviController.tabBarItem.title = @"购物车";
    cartNaviController.tabBarItem.image = cartImage;
    cartNaviController.tabBarItem.selectedImage = cartChooseImage;
    
    UIImage* mineChooseImage = [UIImage imageNamed:@"mine_choose"];
    UIImage *mineImage = [UIImage imageNamed:@"mine"];
    mineChooseImage = [mineChooseImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineImage = [mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController* mineNaviController = [[UINavigationController alloc] initWithRootViewController:[[MineViewController alloc] init]];
    mineNaviController.tabBarItem.title = @"我的";
    mineNaviController.tabBarItem.image = mineImage;
    mineNaviController.tabBarItem.selectedImage = mineChooseImage;
    
    
    tabBarController.viewControllers = @[homeNaviController,categoryNaviController,wishListNaviController,cartNaviController,mineNaviController];
    
    //设置文字选中与非选中的颜色。
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:WLColor(83, 212, 184), NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    
    [UINavigationBar appearance].translucent = NO;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage initWithColor:Color_Blue] forBarMetrics:UIBarMetricsCompact];
    [[UINavigationBar appearance] setBarTintColor:Color_Blue];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //去掉导航栏下的黑线问题
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "ColinLiao.E3" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"E3" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"E3.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
