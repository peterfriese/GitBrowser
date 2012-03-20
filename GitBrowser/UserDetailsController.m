//
//  UserDetialsController.m
//  GitBrowser
//
//  Created by Peter Friese on 20.03.12.
//  Copyright (c) 2012 peterfriese.de. All rights reserved.
//

#import "UserDetailsController.h"
#import "GithubUser.h"

@interface UserDetailsController ()
- (QRootElement *)createUserDetailsForm;
@end

@implementation UserDetailsController

@synthesize userName = _userName;

-(id)init
{
    self = [super initWithRoot:[self createUserDetailsForm]];
    return self;
}

- (void)setUserName:(NSString *)userName
{
    _userName = userName;
    
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[GithubUser class]];
    [objectMapping mapKeyPath:@"user.id" toAttribute:@"id"];
    [objectMapping mapKeyPath:@"user.name" toAttribute:@"name"];
    [objectMapping mapKeyPath:@"user.company" toAttribute:@"company"];
    [objectMapping mapKeyPath:@"user.location" toAttribute:@"location"];    
    [objectMapping mapKeyPath:@"user.blog" toAttribute:@"blog"];        
    [objectMapping mapKeyPath:@"user.following-count" toAttribute:@"following"];   
    [objectMapping mapKeyPath:@"user.followers-count" toAttribute:@"followers"];       
    [objectMapping mapKeyPath:@"user.email" toAttribute:@"email"];           
    
    RKObjectManager* manager = [RKObjectManager objectManagerWithBaseURL:@"http://github.com"];
    [manager loadObjectsAtResourcePath:[NSString stringWithFormat:@"api/v2/xml/user/show/%@", userName] 
                         objectMapping:objectMapping 
                              delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    GithubUser *user = [objects objectAtIndex:0];
    NSLog(@"Loaded User IDName: %@, Company: %@", user.name, user.company);
    [self.root bindToObject:user];
    

}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
}

- (QRootElement *)createUserDetailsForm 
{
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"UserDetailsController";
    root.grouped = YES;
    root.title = @"User Detail";
    
    QSection *main = [[QSection alloc] init];
    main.headerImage = @"logo";
    
//    <user>
//    <name>The Octocat</name>
//    <company>GitHub</company>
//    <gravatar-id>7ad39074b0584bc555d0417ae3e7d974</gravatar-id>
//    <location>San Francisco</location>
//    <created-at type="datetime">2011-01-25T10:44:36-08:00</created-at>
//    <blog>http://www.github.com/blog</blog>
//    <public-gist-count type="integer">4</public-gist-count>
//    <public-repo-count type="integer">3</public-repo-count>
//    <following-count type="integer">0</following-count>
//    <id type="integer">583231</id>
//    <permission nil="true"></permission>
//    <type>User</type>
//    <followers-count type="integer">135</followers-count>
//    <login>octocat</login>
//    <email>octocat@github.com</email>
//    </user>    
    
    QLabelElement *name = [[QLabelElement alloc] init];
    name.title = @"Name";
    name.key = @"name";
    name.bind = @"value:name";
    [main addElement:name];
    
    QLabelElement *company = [[QLabelElement alloc] init];
    company.title = @"Company";
    company.key = @"company";
    company.bind = @"value:company";
    [main addElement:company];
    
    QLabelElement *location = [[QLabelElement alloc] init];
    location.title = @"Location";
    location.key = @"location";
    location.bind = @"value:location";
    [main addElement:location];

    QLabelElement *blog = [[QLabelElement alloc] init];
    blog.title = @"Blog";
    blog.key = @"blog";
    blog.bind = @"value:blog";
    [main addElement:blog];

    QLabelElement *following = [[QLabelElement alloc] init];
    following.title = @"Following";
    following.key = @"following";
    following.bind = @"value:following";
    [main addElement:following];    
 
    QLabelElement *followers = [[QLabelElement alloc] init];
    followers.title = @"Followers";
    followers.key = @"followers";
    followers.bind = @"value:followers";
    [main addElement:followers];

    QLabelElement *email = [[QLabelElement alloc] init];
    email.title = @"E-mail";
    email.key = @"email";
    email.bind = @"value:email";
    [main addElement:email];
    
    
    [root addSection:main];
    
    return root;
}

@end
