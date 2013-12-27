//
//  Newliner.h
//  Newliner
//
//  Created by Evan Lucas on 12/27/13
//  Copyright (c) 2013 Evan Lucas. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CodaPlugInsController.h"

@interface Newliner : NSObject <CodaPlugIn>
{
	CodaPlugInsController *controller;
}
@end
