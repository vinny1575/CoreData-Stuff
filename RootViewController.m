//
//  RootViewController.m
//  coreData2
//
//  Created by Alan Gonzalez on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320 ,480)];
    [[self view] setBackgroundColor:[UIColor grayColor]];
    
    //Status Label
    statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 150, 30)];
    [statusLabel setBackgroundColor:[UIColor clearColor]];
    [[self view] addSubview:statusLabel];
    
    
    //Name Label 
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 80, 30)];
    [nameLabel setText:@"Name"];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [[self view] addSubview:nameLabel];
    
    //Name Field
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(150, 50, 100, 30)];
    [nameField setBorderStyle:UITextBorderStyleRoundedRect];
    [[self view] addSubview:nameField];
    
    //Phone Label
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 80, 30)];
    [phoneLabel setText:@"Phone"];
    [phoneLabel setBackgroundColor:[UIColor clearColor]];
    [[self view] addSubview:phoneLabel];
    
    //Phone Field
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(150, 100, 100, 30)];
    [phoneField setBorderStyle:UITextBorderStyleRoundedRect];
    [[self view] addSubview:phoneField];
    
    //Address Label
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 80, 30)];
    [addressLabel setText:@"Address"];
    [addressLabel setBackgroundColor:[UIColor clearColor]];
    [[self view] addSubview:addressLabel];
    
    //Address Field
    addressField = [[UITextField alloc] initWithFrame:CGRectMake(150, 150, 100, 30)];
    [addressField setBorderStyle:UITextBorderStyleRoundedRect];
    [[self view] addSubview:addressField];
    
    //Save Button
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveButton setFrame:CGRectMake(50, 200, 80, 30)];
    [[self view] addSubview:saveButton];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //Find Button
    UIButton *findButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [findButton setFrame:CGRectMake(200, 200, 80, 30)];
    [[self view] addSubview:findButton];
    [findButton setTitle:@"Find" forState:UIControlStateNormal];
    [findButton addTarget:self action:@selector(findButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//SaveButton Click
- (void)saveButtonClick{
    coreDataAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *saveContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
    
    [saveContact setValue:[nameField text] forKey:@"name"];
    [saveContact setValue:[phoneField text] forKey:@"phone"];
    [saveContact setValue:[addressField text] forKey:@"address"];
    
    [nameField setText:@""];
    [phoneField setText:@""];
    [addressField setText:@""];
    
    NSError *error;
    
    [context save:&error];
    
    [statusLabel setText:@"Data Saved!!!"];
}

//FindButton Click
- (void)findButtonClick{
    //Points to the current instance of the App Deligate.
    coreDataAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //managed Object context is used with persistant stores. Gets our current context to find coreData.xcDatamodelid
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    //object to encapsolate the entity in the coreData.xcDatamodelid
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:context];
    //setup the request to use the entity description above from the coreData.xcDatamodelid
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //Predicate used to match the name field with a saved object with the same name field. (name = [name text])
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", [nameField text]];
    [request setPredicate:pred]; //sets the request to use the predicate
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if([objects count] == 0){
        [statusLabel setText:@"No Matches"];
    }else{
        matches = [objects objectAtIndex:0];
        [addressField setText:[matches valueForKey:@"address"]];
        [nameField setText:[matches valueForKey:@"name"]];
        [phoneField setText:[matches valueForKey:@"phone"]];
        [statusLabel setText:[NSString stringWithFormat:@"%d matches found", [objects count]]];
    }
}

@end
