@IsTest
public class LeadTriggerHandlerTest {

    @IsTest
    static void test_handleTitleNormalization() {
        //test data 
        Lead leadVp = new Lead( FirstName = 'Miles', LastName = 'Dyson', Company = 'CyberDyne', Title = 'v.p. of Marketing', 
        Status = 'Open - Not Contacted');
        Lead leadManager = new Lead(FirstName = 'Michael', LastName = 'Scott', Company = 'Dunder Mifflin', Title = 'mgr', 
        Status = 'Open - Not Contacted');
        Lead leadExecutive = new Lead(FirstName = 'Harvey', LastName = 'Spector', Company = 'Pearson Spector', Title = 'chief', 
        Status = 'Open - Not Contacted');
        Lead leadAssistant = new Lead(FirstName = 'Rachel', LastName = 'Zane', Company = 'Pearson Spector', Title = 'assist', 
        Status = 'Open - Not Contacted');


        // add leads to the list
        List<Lead> leads = new List<Lead>{leadVp, leadManager, leadExecutive, leadAssistant};
        System.debug('The leads list reflects as : ' + leads);
        // add leads to Salesforce 
        insert leads;
        System.debug('The leads list : ' + leads);

        // now testing the data to ensure the method is working
        List<Lead> leadsUpdated = [SELECT Id, Title
                     FROM Lead
                     ];
        if( leadsUpdated[0].title != Null){
            Assert.areEqual('Vice President', leadsUpdated[0].title, 'The expected title Updated does not match, the result is: ' 
            + leadsUpdated[0].title);
        }
        if( leadsUpdated[1].title != Null){
            Assert.areEqual('Manager', leadsUpdated[1].title, 'The expected title Updated does not match, the result is: ' 
            + leadsUpdated[1].title);
        }
        if( leadsUpdated[2].title != Null){
            Assert.areEqual('Executive', leadsUpdated[2].title, 'The expected title Updated does not match, the result is: ' 
            + leadsUpdated[2].title);
        }
        if( leadsUpdated[3].title != Null){
            Assert.areEqual('Assistant', leadsUpdated[3].title, 'The expected title Updated does not match, the result is: ' 
            + leadsUpdated[3].title);
        }
    }

    @IsTest
    static void test_handleAutoLeadScoring(){
        // Test Data Creation
        Lead leadScore0 = new Lead(FirstName = 'Adrian', LastName = 'Monk',
                                    Company = 'CyberDyne', Status = 'Open - Not Contacted');
        Lead leadScore3 = new Lead(FirstName = 'Frank', LastName = 'Johnson', LeadSource = 'Website', 
                                   Company = 'CyberDyne', Email= 'fjohnson@test.com', Status = 'Open - Not Contacted');
        Lead leadScore5 = new Lead(FirstName = 'Joe', LastName = 'Samson', Phone = '877-649-1111',
                                   Company = 'CyberDyne', Status = 'Open - Not Contacted');
        Lead leadScore8 = new Lead(FirstName = 'Sam', LastName = 'Johnson', LeadSource = 'Website',
                                   Company = 'CyberDyne', Email= 'sjohnson@test.com', Phone = '888-222-1980', Status = 'Open - Not Contacted');
        Lead leadScore10 = new Lead(FirstName = 'Monica', LastName = 'Thakur', Industry = 'Technology',
                                   Company = 'CyberDyne', Status = 'Open - Not Contacted');
        Lead leadScore13 = new Lead(FirstName = 'Sahil', LastName = 'Nayar', LeadSource = 'Website',
                                   Company = 'CyberDyne', Email= 'sjohnson@test.com', Industry = 'Technology', Status = 'Open - Not Contacted');
        Lead leadScore15 = new Lead(FirstName = 'Sejal', LastName = 'Nayar', Phone = '888-222-1980',
                                   Company = 'CyberDyne', Industry = 'Technology', Status = 'Open - Not Contacted');
        Lead leadScore18 = new Lead(FirstName = 'Narayan', LastName = 'Thakur', LeadSource = 'Website',
                                    Phone = '888-222-1980', Company = 'CyberDyne', Industry = 'Technology',
                                    Email= 'sjohnson@test.com', Status = 'Open - Not Contacted');
        // add leads to the list
        List<Lead> leadScore = new List<Lead>{leadScore0,leadScore3, leadScore5,
                                              leadScore8,leadScore10, leadScore13, 
                                              leadScore15, leadScore18};

        // insert Leads list
        insert leadScore;
        System.debug('The list of lead Scores : ' + leadScore);

        // call the method handleAutoLeadScoring from LeadTriggerHandler to handle lead scoring
        LeadTriggerHandler.handleAutoLeadScoring(leadScore);

        //  Test Asserts
        
        //Lead Score 0 
        if( leadScore0 != Null){
            Assert.areEqual(0, leadScore0.Lead_Score__c, 'The Lead score does not match results are : '  + leadScore0.Lead_Score__c );
        }

        //Lead Score 3
        if( leadScore3 != Null){
            Assert.areEqual(3, leadScore3.Lead_Score__c, 'The Lead score does not match, results are : '  + leadScore3.Lead_Score__c );
        }

        //Lead Score 5
        if( leadScore15 != Null){
            Assert.areEqual(5, leadScore5.Lead_Score__c, 'The Lead score does not match, results are : '  + leadScore5.Lead_Score__c );

        }
        //Lead Score 8
        if( leadScore8 != Null){
            Assert.areEqual(8, leadScore8.Lead_Score__c, 'The Lead score does not match, results are : '  + leadScore8.Lead_Score__c );
        }
        
         //Lead Score 10
         if( leadScore10 != Null){
            Assert.areEqual(10, leadScore10.Lead_Score__c, 'The Lead score does not match, results are : '  + leadScore10.Lead_Score__c );
        }
         //Lead Score 13
         if( leadScore13 != Null){
            Assert.areEqual(13, leadScore13.Lead_Score__c, 'The Lead score does not match, results are : '  + leadScore13.Lead_Score__c );
        }

         //Lead Score 15
         if( leadScore15 != Null){
            Assert.areEqual(15, leadScore15.Lead_Score__c, 'The Lead score does not match, results are : '  + leadScore15.Lead_Score__c );
        }

         //Lead Score 18
         if( leadScore18 != Null){
            Assert.areEqual(18, leadScore18.Lead_Score__c, 'The Lead score does not match, results are : '  + leadScore18.Lead_Score__c );
        }


    }
      
    @IsTest
    static void test_handleLeadAutoConvert(){
        // TEST DATA CREATION

        // Create Test Account 
        Account acct = new Account(Name = 'TestAccount');
        insert acct;

        // Lead Data 
        Lead lead1 = new Lead(FirstName = 'Frank', LastName = 'Johnson', LeadSource = 'Website', 
                                   Company = 'CyberDyne', Email= 'fjohnson@test.com');
        Lead lead2 = new Lead(FirstName = 'Joe', LastName = 'Samson', Phone = '877-649-1111',
                                   Company = 'CyberDyne', Email= 'jsamson@test.com');
        Lead lead3 = new Lead(FirstName = 'Sam', LastName = 'Johnson', LeadSource = 'Website',
                                   Company = 'CyberDyne', Email= 'sjohnson@test.com', Phone = '888-222-1980');
        Lead lead4 = new Lead(FirstName = 'Monica', LastName = 'Thakur', Industry = 'Technology',
                                   Company = 'CyberDyne', Email= 'mthakur@test.com');
        Lead lead5 = new Lead(FirstName = 'Sahil', LastName = 'Nayar', LeadSource = 'Website',
                                   Company = 'CyberDyne', Email= 'snayar@test.com', Industry = 'Technology');
        Lead lead6 = new Lead(FirstName = 'Sejal', LastName = 'Nayar', Email= 'stnayar@test.com',
                                   Company = 'CyberDyne', Industry = 'Technology');
        Lead lead7 = new Lead(FirstName = 'Narayan', LastName = 'Thakur', LeadSource = 'Website',
                                    Phone = '888-222-1980', Company = 'CyberDyne', Industry = 'Technology',
                                    Email= 'narthakur@test.com'); 

        // Add to Lead List 
        List<Lead> leadList = new List<Lead>{lead1, lead2, lead3, lead4, lead5, lead6, lead7};

        // Create Contacts 

        Contact contact1 = new Contact(LastName = 'Johnson', Email = 'fjohnson@test.com', AccountId = acct.Id);
        Contact contact2 = new Contact(LastName = 'Nayar', Email = 'snayar@test.com', AccountId = acct.Id);
        Contact contact3 = new Contact(LastName = 'Thakur', Email = 'narthakur@test.com', AccountId = acct.Id);

        // add contacts to list

        List<Contact> contactList = new List<Contact>{contact1, contact2, contact3};
        insert contactList;

        // insert Leads
        Test.startTest();
        insert leadList;
        Test.stopTest();

        //Assert Tests
        List<Lead> updatedLeads = [SELECT Id, IsConverted
                                   FROM Lead
                                   WHERE IsConverted = True];
        System.debug('The amount of converted Leads are : ' + updatedLeads.size());

        Assert.areEqual(3, updatedLeads.size());

    }   
    

}