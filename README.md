# README

### Command for initialize the program:
bundle install  
rails db:reset 
rails s

### Summary of implemented features:
For this assignment we incorporated different functionalities for
the ticket process, such as allowing executives,supervisors
and admins to write comments or a response to the user. Furthermore,
we added the feature for users to accept or declining a ticket response. This
feature also allows users to give a rating to the executive who wrote
the response. Finally, for the ticket process, a user can re open a ticket
that has been closed.

We also implemented the feature for supervisors and admins
to generate the executive and statistic reports. Also, this two roles, now have the capability for
upgrading or degrading different types of users.

Another important function that was incorporated, was the possibility
for filtering tickets by priority and closing date. This function is
only for executives, supervisors and admins.

Additionally, we implemented the registration and log in, by using
the devise gem.

Finally, we added new user feedback, the terms of use and services for the web page, we improved the css
and tickets are assigned automatically (in the case that executives don't have the same amount of tickets assigned).

### How to use the program:
1. Create a user or login as an existent one.
    1. We recommend to use the user "John Doe", as we created
       a sufficient amount of tickets to use all the features. First you can see tickets on
       the status "Sended" where information such as priority and ticket deadline are not defined. On the other hand,
       you will see tickets on "Pending" status where the priority and ticket deadline will appear. Also, you can
       accept or decline an executive response (on tickets that are with the status "Asked").
       If the user denies the response, then the ticket will change to the "Pending" state, where the executive
       will have to give another solution. In the other case, if the user accepts the response,
       then he will be redirected to evaluating the executive. Finally, you can
       reopen a ticket that has been closed (ticket on "Closed" status), this will change the status of the ticket to "Pending."
    2. User seed:
        1. email: john.doe@example.com
        2. password: 123456
2. Create a Ticket:
    1. If executives don't have the same amount of tickets it is
       going to be assigned automatically. If they all have the same amount of tickets
       a supervisor must assign the ticket manually.
3. Log in as a supervisor or admin
    1. Here you will see two tables, one that is for assigning
       the executive and priority and the other that is for only assigning the priority.
       On this tables you will see the corresponding tickets that were created. Then you choose the ticket that you want to edit,
       and you click on "Edit". After this, the supervisor chooses the corresponding priority (and executive, in the case that is needed) that thinks will suit better for the ticket.
       Finally, update the ticket.
    2. Supervisor seed:
        1. email: br@example.com
        2. password: 123456
    3. Admin seed:
        1. email: admin@example.com
        2. password: 123456
4. Log in as an executive
    1. After setting the priority, log in as the executive that the ticket was assigned to. For seeing all options and
       views, we recommend to log in as the executive "Re ist", as we created
       a sufficient amount of seeds to test it. Executives will have two status on their tickets, which are "Pending" and "Asked".
       If the ticket is in the "Pending" status, then he will need to send the response to the user. He will have the
       possibility for writing and seeing past comments on the ticket and the function for sending the response. Once the executive sends a response to the user,
       the ticket will change to the status "Asked", where the user will have to accept or deny the response. If the ticket is in
       the "Asked" state, then the executive will have the possibility for seeing the response that he
       sent to the user.
        1. Executive seed:
            1. email: reis@example.com
            2. password: 123456
5. Other functions
    1. You can log in as a supervisor or admin to generate the executive
       and the statistic report (see "Notes" for recommendation). Also, another feature is the
       possibility for upgrading and degrading different user roles. In the case you upgrade a user,
       all the tickets that are open of that user will be deleted, and in the case
       you upgrade or degrade an executive, all tickets open that are assigned to that executive,
       will be reassigned to another executive. You will also see a report with the overdue tickets,
       and a table with all tickets that are open. Finally, as mentioned above, you will have the capability
       for assigning executives and priority to tickets.

### Notes:

You need considerate the Gemfile to get all the requisites library's for run the initializer of the begin of this README.

We recommend for the statistics and executive report
to use the dates between january 2022 and december of
2022, as most of our seeds are created through different
months of the year.

We did not implement the function that allows executives
to update a ticket, because in the wireframe we incorporated
that this capability would be only for supervisors and admins.

We also did not implement the feature of filtering tickets by priority
and closing date for users, as we did not incorporated that function for users
in the wireframe.

We kept the changes to wireframe that were mentioned in assignment 3.

We did not implement the fake-data with FactoryBot & FFaker gems, as we asked the teacher if we could create our seeds
in seeds.rb instead of using the gem. He allowed this with the condition of having enough amount of data. We have 14
tickets seeds, that we think are sufficient to test the application without problems.
