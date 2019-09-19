//
//  ProxyConfigRemoteProcessProtocol.h
//  com.west2online.ClashX.ProxyConfigHelper
//
//  Created by yichengchen on 2019/8/17.
//  Copyright © 2019 west2online. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^stringReplyBlock)(NSString *);
typedef void(^boolReplyBlock)(BOOL);
typedef void(^dictReplyBlock)(NSDictionary *);

@protocol ProxyConfigRemoteProcessProtocol <NSObject>
@required

- (void)getVersion:(stringReplyBlock)reply;

- (void)enableProxyWithPort:(int)port
          socksPort:(int)socksPort
           authData:(NSData *)authData
            error:(stringReplyBlock)reply;

- (void)disableProxyWithAuthData:(NSData *)authData error:(stringReplyBlock)reply;

- (void)restoreProxyWithCurrentPort:(int)port
                          socksPort:(int)socksPort
                               info:(NSDictionary *)dict
                           authData:(NSData *)authData
                              error:(stringReplyBlock)reply;

- (void)getCurrentProxySetting:(dictReplyBlock)reply;
@end
