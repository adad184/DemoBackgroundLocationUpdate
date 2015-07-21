//
//  MMLoc.h
//  DemoBackgroundLocationUpdate
//
//  Created by Ralph Li on 7/21/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <Realm/Realm.h>

@interface MMLoc : RLMObject

@property NSDate        *date;
@property NSString      *loc;
@property BOOL          background;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<MMLoc>
RLM_ARRAY_TYPE(MMLoc)
