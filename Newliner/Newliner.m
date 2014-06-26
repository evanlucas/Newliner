//
//  Newliner.m
//  Newliner
//
//  Created by Evan Lucas on 12/27/13
//  Copyright (c) 2013 Evan Lucas. All rights reserved.
//

#import "Newliner.h"
#define NEWLINER_KEY @"EnableNewliner"
static NSUserDefaults *defaults;
@interface Newliner ()
- (id)initWithController:(CodaPlugInsController *)inController;
@end

@implementation Newliner

- (id)initWithPlugInController:(CodaPlugInsController *)aController plugInBundle:(NSObject<CodaPlugInBundle> *)plugInBundle {
  return [self initWithController:aController];
}

- (id)initWithPlugInController:(CodaPlugInsController *)aController bundle:(NSBundle *)yourBundle {
  return [self initWithController:aController];
}

- (id)initWithController:(CodaPlugInsController *)inController {
  if (self = [super init]) {
    controller = inController;
    defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:NEWLINER_KEY] == YES) {
      [controller registerActionWithTitle:[self titleEnabled] target:self selector:@selector(newliner:)];
    } else {
      [controller registerActionWithTitle:[self titleDisabled] target:self selector:@selector(newliner:)];
    }
  }
  return self;
}

- (BOOL)enabled {
  return [defaults boolForKey:NEWLINER_KEY] == YES;
}

- (void)enable {
  [defaults setBool:YES forKey:NEWLINER_KEY];
  [defaults synchronize];
}

- (void)disable {
  [defaults setBool:NO forKey:NEWLINER_KEY];
  [defaults synchronize];
}

- (void)newliner:(id)sender {
  NSMenuItem *menuItem = (NSMenuItem *)sender;
  if ([self enabled]) {
    // disable
    [self disable];
    [menuItem setTitle:[self titleDisabled]];
  } else {
    // enable
    [self enable];
    [menuItem setTitle:[self titleEnabled]];
  }
}

- (NSString *)titleEnabled {
  return @"Disable Newliner";
}

- (NSString *)titleDisabled {
  return @"Enable Newliner";
}

- (NSString *)name {
  return @"Newliner";
}

- (void)textViewWillSave:(CodaTextView *)textView {
  if (![self enabled]) {
    return;
  }
  NSString *s = textView.string;
  if ([s isEqualToString:@""]) {
    return;
  }
  NSArray *lines = [s componentsSeparatedByString:@"\n"];
  NSString *last = [s substringFromIndex:s.length-1];
  if (![last isEqualToString:@"\n"]) {
    // insert newline
    NSString *lastLine = lines[lines.count-1];
    NSInteger lastLineLen = lastLine.length;
    NSString *nll = [lastLine stringByAppendingString:@"\n"];
    NSRange r = NSMakeRange(s.length-lastLineLen, lastLineLen);
    [textView replaceCharactersInRange:r withString:nll];
  }
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
  BOOL result = YES;
  if ([menuItem title] == [self titleEnabled] || [menuItem title] == [self titleDisabled]) {
    CodaTextView *tv = [controller focusedTextView:self];
    if (tv == nil) {
      result = NO;
    }
  }
  return result;
}
@end
