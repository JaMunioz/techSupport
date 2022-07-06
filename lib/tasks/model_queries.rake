namespace :db do
  task :model_queries => :environment do
    puts("Queries:")
    puts()
    puts("Query 0: Sample query; show the names users available")
    result = User.select(:first_name).distinct.map { |x| x.first_name }
    puts(result)
    puts("EOQ") # End Of Query -- always add this line after a query.
    puts()
    # Query 1: Get all tickets created by a user
    puts("Query 1: Get all tickets created by a user")
    result1 = Ticket.includes(requests: :user).where(requests: {user: User.where(role: "user").pluck("id").second})
    puts(result1)
    puts("EOQ")
    puts()
    # Query 2: Get all users who have tickets in ’open’ state.
    puts("Query 2: Get all users who have tickets in ’open’ state.")
    result2 = (User.joins(requests: :ticket).where(ticket: {status: ["Sended","Pending","Asked"]}, role:"user")
                   .distinct(:user_id))
    puts(result2)
    puts("EOQ")
    puts()
    # Query 3: Get all users who have all of their tickets in ’closed’ state.
    puts("Query 3: Get all users who have all of their tickets in ’closed’ state.")
    open = User.joins(requests: :ticket).where(tickets: {status:["Sended","Pending","Asked"]}).select(:id).distinct(:id)
    close = User.joins(requests: :ticket).where(tickets: {status: "Closed"}).select(:id).distinct(:id)
    result3 = User.where(id: ((close - open).pluck(:id)))
    puts(result3)
    puts("EOQ")
    puts()
    #Query 4: Get all all tickets that have been assigned to an executive in a date range.
    puts("Query 4: Get all all tickets that have been assigned to an executive in a date range.")
    result4 = (Ticket.joins(executive_assigneds: :user)
                     .where('date_ticket_assigned <= ?','2022-07-17 12:00')
                     .where('date_ticket_assigned >= ?','2022-07-13 09:00')
                     .where(users: {id:User.where(role: "executive").pluck("id").first}))
    puts(result4)
    puts("EOQ")
    puts()
    #Query 5: Get all resolutions of a ticket.
    puts("Query 5: Get all resolutions of a ticket.")
    result5 = Response.joins(:ticket).where(state: true,tickets: {id: 4})
    puts(result5)
    puts("EOQ")
    puts()
    #Query 6: Get all ratings of a given executive.
    puts("Query 6: Get all ratings of a given executive.")
    result6 = ExecutiveReport.where(user_id: User.where(role: "executive").second)
    puts(result6)
    puts("EOQ")
    puts()
    #Query 7: Get the average rating of a given executive.
    puts("Query 7: Get the average rating of a given executive.")
    result7 = ExecutiveReport.where(user_id: User.where(role: "executive").second).average(:calification)
    puts(result7)
    puts("EOQ")
    puts()
    #Query 8: Get all comments from a ticket, chronologically.
    puts("Query 8: Get all comments from a ticket, chronologically.")
    result8 = Comment.joins(:ticket).where(tickets: {id:4}).order('date_comment ASC')
    puts(result8)
    puts("EOQ")
    puts()
    #Query 9: Get all users with administrative privileges in the system.
    puts("Query 9: Get all users with administrative privileges in the system.")
    result9 = User.where(role:["executive","supervisor","admin"])
    puts(result9)
    puts("EOQ")
    puts()
    puts()

    puts("Validators:")
    puts()
    #Query 10: Users should have a unique username and/or email address.
    puts("Query 10: Users should have a unique username and/or email address.")
    u20 = User.create(email: "felipegon@example.com",first_name: "Felipe", last_name: "Gonzalez",
                      telephone: "9 3234 1234",role: "user")
    u21 = User.create(email: "felipegon@example.com",first_name: "Felipe", last_name: "Gonzalez",
                      telephone: "9 3111 1111",role: "user")
    puts(u21 = User.create(email: "felipegon@example.com",first_name: "Felipe", last_name: "Gonzalez",
                           telephone: "9 3111 1111",role: "user"))
    puts(u21.valid?)
    puts("EOQ")
    puts()
    #Query 11: E-mail addresses should be well-formed. Attempt to update a model with an ill-formatted
    # email address and show the validation error that occurs.
    puts("Query 11: Users should have a unique username and/or email address.")
    u22 = User.create(email: "danielgon@example.com",first_name: "Daniel", last_name: "Gonzalez",
                      telephone: "9 3234 1111",role: "user")
    puts(u22 = User.update(email: "daniel gon@example.com",first_name: "Felipe", last_name: "Gonzalez",
                           telephone: "9 3111 1111",role: "user"))
    puts("EOQ")

  end
end