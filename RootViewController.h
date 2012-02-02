//
//  RootViewController.h
//  coreData2
//
//  Created by Alan Gonzalez on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coreDataAppDelegate.h"

@interface RootViewController : UIViewController{
    UILabel *statusLabel;
    UITextField *nameField;
    UITextField *phoneField;
    UITextField *addressField;

    
}

- (void) saveButtonClick;
- (void) findButtonClick;

@end
