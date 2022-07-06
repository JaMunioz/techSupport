#Asumptions:
# The start time in this seed is "2022-07-17 12:00"
# Deadline is actualized y the request and executive_asiggn

#Users.
u1 = User.create(email: "john.doe@example.com",first_name: "John", last_name: "Doe", telephone: "9 1234 5678",role: "user", password:"123456")
u2 = User.create(email: "reis@example.com",first_name: "Re", last_name: "Ist", telephone: "9 1234 5611",role: "executive", password:"123456")
u3 = User.create(email: "tree@example.com",first_name: "Han", last_name: "Hills", telephone: "9 1234 1252",role: "user", password:"123456")
u4 = User.create(email: "coal@example.com",first_name: "Pedro", last_name: "Wood", telephone: "9 1234 5621",role: "user", password:"123456")
u5 = User.create(email: "a_s2@example.com",first_name: "Ed", last_name: "Cliffs", telephone: "9 1344 2278",role: "user", password:"123456")
u6 = User.create(email: "you@incognit.com",first_name: "Mist", last_name: "Erious", telephone: "9 6312 3125",role: "user", password:"123456")
u8 = User.create(email: "zelda@example.com",first_name: "Homer", last_name: "Riu", telephone: "9 7731 2134",role: "executive", password:"123456")
u11 = User.create(email: "br@example.com",first_name: "Benjamin", last_name: "Rodriguez", telephone: "9 1232 1231",role: "supervisor", password:"123456")
u12 = User.create(email: "admin@example.com",first_name: "Agustin", last_name: "Sotomich", telephone: "9 5623 6231",role: "admin", password:"123456")
u13 = User.create(email: "nes@example.com",first_name: "Crisstof", last_name: "Astorria", telephone: "9 1273 6723",role: "supervisor", password:"123456")
u14 = User.create(email: "lopez@example.com",first_name: "Roberto", last_name: "Lopez", telephone: "9 7777 2134",role: "executive", password:"123456")



#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t1 = Ticket.create(incident_creation_date: "2022-07-12 18:00", date_incident: "2022-03-19 14:30", date_ticket_resolution: "",
                   title: "I had an issue with..", description: "my problem irradicate in the following..", priority: "Normal",
                   status: "Pending", tags: "green", documents: "1?.png",ticket_deadline:"2022-07-22 11:00", assisted: false, reopen: false)  #<- [tags:green] means have 1 or more
                                                                                                                                              #days to ask as executive.
#The first request of a ticket takes the same description of the ticket as request, and the ticket_creation_date as date_request.
Request.create(ticket: t1,user: u1,request:"my problem irradicate in the following..",date_request:"2022-07-12 18:00")
ExecutiveAssigned.create(ticket:t1, user: u2, date_ticket_assigned: "2022-07-13 12:00")  #<- This will be set the deadline to 5 days since this time, because the priority was normal.
Comment.create(ticket: t1,user: u2, comment:"I dont know if i have permisions for that..",date_comment: "2022-07-13 12:10")
Comment.create(ticket: t1,user: u12, comment:"Go ahead.",date_comment: "2022-07-13 13:20")
r1 = Response.create(ticket: t1,user: u2,response:"Here comes my answer of ..",date_response:"2022-07-13 14:00",state:false)
Request.create(ticket: t1,user: u1,request:"I had an issue with..",date_request:"2022-07-15 11:00")
#The last action in the ticket was a Request this means [status: Pending]
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t2 = Ticket.create(incident_creation_date: "2022-07-12 20:00", date_incident: "2022-07-12 12:00", date_ticket_resolution: "2022-07-13 16:00",
                   title: "My problem is...", description: "I have troubles with..", priority: "Urgent",
                   status: "Closed", tags: "yellow", documents: "2?.png",ticket_deadline:"2022-07-14 12:00", assisted: true, reopen: false)#<- [tags:yellow] means have less than
                                                                                                                                            #a day to ask as executive.
Request.create(ticket: t2,user: u1,request:"I have troubles with..",date_request:"2022-07-12 20:00")
ExecutiveAssigned.create(ticket:t2, user: u8, date_ticket_assigned: "2022-07-12 23:59")#<- This will be set the deadline to 1 day since this time, because the priority was Urgent.
r2 = Response.create(ticket: t2,user: u8,response:"Dont worry as a company we have..",date_response:"2022-07-13 15:00",state:true)#<- [state:true] the response was accepted by the user.
ExecutiveReport.create(ticket:t2, user: u8, calification: 5, date:"2022-07-13 16:00")
#The last action in the ticket was a ExecutiveReport this means [status: Closed]
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t3 = Ticket.create(incident_creation_date: "2022-07-12 20:01", date_incident: "2022-07-02 23:50", date_ticket_resolution: "",
                   title: "OMG", description: "two weeks ago..", priority: "High",
                   status: "Pending", tags: "red", documents: "3?.png",ticket_deadline:"2022-07-17 12:00", assisted: false, reopen: false)#<- [tags:red] The tickets is out of time.
Request.create(ticket: t3,user: u1,request:"two weeks ago..",date_request:"2022-07-12 20:01")
ExecutiveAssigned.create(ticket:t3, user: u2, date_ticket_assigned: "2022-07-12 20:15")
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t4 = Ticket.create(incident_creation_date: "2022-07-12 20:15", date_incident: "2022-05-19 16:32", date_ticket_resolution: "2022-07-14 16:00",
                   title: "This concert will be..", description: "last time in the concert..", priority: "Urgent",
                   status: "Closed", tags: "yellow", documents: "4?.png",ticket_deadline:"2022-07-12 20:15", assisted: false, reopen: true)
Request.create(ticket: t4,user: u3,request:"last time in the concert..",date_request:"2022-07-14 20:15")
ExecutiveAssigned.create(ticket:t4, user: u8, date_ticket_assigned: "2022-07-13 12:00")
r3 = Response.create(ticket: t4,user: u8,response:"You should..",date_response:"2022-07-13 13:00",state:false)
Request.create(ticket: t4,user: u3,request:"the last time..",date_request:"2022-07-13 14:15")
r4 = Response.create(ticket: t4,user: u8,response:"Is perfect for us to tell you..",date_response:"2022-07-13 14:15",state:true)
ExecutiveReport.create(ticket:t4, user: u8, calification: 3, date:"2022-07-13 15:15")
Request.create(ticket: t4,user: u3,request:"I was wondering about the solution..",date_request:"2022-07-14 11:00")
ExecutiveAssigned.create(ticket:t4, user: u2, date_ticket_assigned: "2022-07-14 12:00")
Comment.create(ticket: t4,user: u2, comment:"I dont know why the solution..",date_comment: "2022-07-14 13:10")
Comment.create(ticket: t4,user: u11, comment:"Maybe..",date_comment: "2022-07-14 13:12")
Comment.create(ticket: t4,user: u2, comment:"So I could..",date_comment: "2022-07-14 13:17")
Comment.create(ticket: t4,user: u13, comment:"No, my partner is trying to tell you about..",date_comment: "2022-07-14 13:20")
Comment.create(ticket: t4,user: u2, comment:"received.",date_comment: "2022-07-14 13:21")
r5 = Response.create(ticket: t4,user: u8,response:"Glad to present you the next solution..",date_response:"2022-07-14 15:00",state:true)
ExecutiveReport.create(ticket:t4, user: u2, calification: 4, date:"2022-07-14 16:00")
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t5 = Ticket.create(incident_creation_date: "2022-07-12 20:20", date_incident: "2002-07-11 20:00", date_ticket_resolution: "",
                   title: "The issue with rails..", description: "This records of ..", priority: nil,
                   status: "Sended", tags: "", documents: "5?.png",ticket_deadline:"", assisted: false, reopen: false)
Request.create(ticket: t5,user: u4,request:"This records of ..",date_request:"2022-07-12 20:20")

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t6 = Ticket.create(incident_creation_date: "2022-07-12 20:22", date_incident: "2022-07-11 20:00", date_ticket_resolution: "",
                   title: "The issue with rails..", description: "This time I fix the incident date, so..", priority: nil,
                   status: "Sended", tags: "", documents: "6?.png",ticket_deadline:"", assisted: false, reopen: false)
Request.create(ticket: t6,user: u4,request:"This time I fix the incident date, so..",date_request:"2022-07-12 20:22")
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t7 = Ticket.create(incident_creation_date: "2022-07-13 08:20", date_incident: "2022-06-20 06:22", date_ticket_resolution: "",
                   title: "About..", description: "Yeah, about..", priority: nil,
                   status: "Sended", tags: "", documents: "7?.png",ticket_deadline:"", assisted: false, reopen: false)
Request.create(ticket: t7,user: u5,request:"Yeah, about..",date_request:"2022-07-13 08:20")
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t8 = Ticket.create(incident_creation_date: "2022-07-13 08:30", date_incident: "2022-06-13 08:30", date_ticket_resolution: "",
                   title: "This epic..", description: "Exactly one month ago..", priority: "Low",
                   status: "Asked", tags: "green", documents: "8?.png",ticket_deadline:"2022-07-23 08:30", assisted: false, reopen: false)
Request.create(ticket: t8,user: u5,request:"Exactly one month ago..",date_request:"2022-07-13 08:30")
ExecutiveAssigned.create(ticket:t8, user: u8, date_ticket_assigned: "2022-07-13 08:50")
r6 = Response.create(ticket: t8,user: u8,response:"I think the solution is..",date_response:"2022-07-13 14:00",state:false)
Request.create(ticket: t8,user: u5,request:"No, I dont like this..",date_request:"2022-07-13 14:10")
Comment.create(ticket: t8,user: u8, comment:"Help please, I think..",date_comment: "2022-07-13 15:00")
Comment.create(ticket: t8,user: u11, comment:"Try to..",date_comment: "2022-07-14 15:02")
Comment.create(ticket: t8,user: u8, comment:"Oh, this is perfect..",date_comment: "2022-07-14 15:10")
r7 = Response.create(ticket: t8,user: u8,response:"I have the next option for you..",date_response:"2022-07-14 15:30",state:false)
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t9 = Ticket.create(incident_creation_date: "2022-07-13 09:20", date_incident: "2022-05-19 18:00", date_ticket_resolution: "2022-07-17 08:20",
                   title: "Here you..", description: "go with the other..", priority: "High",
                   status: "Closed", tags: "red", documents: "9?.png",ticket_deadline:"2022-07-18 14:11", assisted: false, reopen: false)
Request.create(ticket: t9,user: u5,request:"This time i fix the incident date, so..",date_request:"2022-07-13 09:20")
ExecutiveAssigned.create(ticket:t9, user: u8, date_ticket_assigned: "2022-07-13 12:00")
r8 = Response.create(ticket: t9,user: u8,response:"Somehow you..",date_response:"2022-07-13 13:33",state:false)
Request.create(ticket: t9,user: u5,request:"I dont know if you..",date_request:"2022-07-13 14:11")
r9 = Response.create(ticket: t9,user: u8,response:"Option 1, or..",date_response:"2022-07-17 08:00",state:true)
ExecutiveReport.create(ticket:t9, user: u8, calification: 2, date:"2022-07-17 08:20")
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t10 = Ticket.create(incident_creation_date: "2022-07-13 10:55", date_incident: "2022-07-03 12:00", date_ticket_resolution: "",
                    title: "A luck of travel", description: "after all..", priority: nil,
                    status: "Pending", tags: "", documents: "10?.png",ticket_deadline:"", assisted: true, reopen: false)
Request.create(ticket: t10,user: u6,request:"after all..",date_request:"2022-07-13 10:55")
ExecutiveAssigned.create(ticket:t10, user: u8, date_ticket_assigned: "2022-07-13 12:00")
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t11 = Ticket.create(incident_creation_date: "2022-07-13 08:30", date_incident: "2022-06-13 08:30", date_ticket_resolution: "",
                   title: "Problem", description: "New problem with..", priority: "Low",
                   status: "Asked", tags: "green", documents: "8?.png",ticket_deadline:"2022-07-23 08:30", assisted: false, reopen: false)
Request.create(ticket: t11,user: u1,request:"New problem with..",date_request:"2022-07-13 08:30")
ExecutiveAssigned.create(ticket:t11, user: u8, date_ticket_assigned: "2022-07-13 08:50")
Response.create(ticket: t11,user: u8,response:"I think the solution is..",date_response:"2022-07-13 14:00",state:false)

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t12 = Ticket.create(incident_creation_date: "2022-07-13 10:20", date_incident: "2022-05-19 19:00", date_ticket_resolution: "2022-07-17 09:20",
                   title: "Hi i am Doe", description: "need attention to..", priority: "Urgent",
                   status: "Closed", tags: "red", documents: "12?.png",ticket_deadline:"2022-07-18 15:11", assisted: false, reopen: false)
Request.create(ticket: t12,user: u1,request:"need attention to..",date_request:"2022-07-13 10:20")
ExecutiveAssigned.create(ticket:t12, user: u8, date_ticket_assigned: "2022-07-13 12:00")
r10 = Response.create(ticket: t12,user: u8,response:"Do the next step..",date_response:"2022-07-17 08:00",state:true)
ExecutiveReport.create(ticket:t12, user: u8, calification: 5, date:"2022-07-17 08:20")
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t13 = Ticket.create(incident_creation_date: "2022-07-13 10:30", date_incident: "2022-06-13 10:30", date_ticket_resolution: "",
                    title: "My new problem is..", description: "New problem with..", priority: "Urgent",
                    status: "Asked", tags: "yellow", documents: "8?.png",ticket_deadline:"2022-07-14 10:30", assisted: false, reopen: false)
Request.create(ticket: t13,user: u1,request:"New problem with..",date_request:"2022-07-13 10:30")
ExecutiveAssigned.create(ticket:t13, user: u2, date_ticket_assigned: "2022-07-13 10:50")
Response.create(ticket: t13,user: u2,response:"I think the solution is..",date_response:"2022-07-13 14:00",state:false)

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
t14 = Ticket.create(incident_creation_date: "2022-07-14 10:30", date_incident: "2022-06-13 10:30", date_ticket_resolution: "",
                    title: "Problem with..", description: "The problem is..", priority: "High",
                    status: "Asked", tags: "green", documents: "8?.png",ticket_deadline:"2022-07-17 10:30", assisted: false, reopen: false)
Request.create(ticket: t14,user: u1,request:"The problem is..",date_request:"2022-07-14 10:30")
ExecutiveAssigned.create(ticket:t14, user: u2, date_ticket_assigned: "2022-07-14 10:50")
Comment.create(ticket: t14,user: u2, comment:"There could be two...",date_comment: "2022-07-14 15:02")
Response.create(ticket: t14,user: u2,response:"Try this...",date_response:"2022-07-15 14:00",state:false)

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#