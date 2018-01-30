require 'unirest'

while true
  system "clear"

  puts "You have engaged your Contacts Program"
  puts "Please, choose an option: "
  puts "[1] Show all contacts"
  puts "[1.5] Search contact by first name"
  puts "[2] Show one contact"
  puts "[3] Create a new contact"
  puts "[4] Update a contact"
  puts "[5] Destroy a contÎact"
  puts "[6] Signup a user"
  puts "[7] Login"
  puts "[8] Logout"
  puts "[q] To quit" 

  input_option = gets.chomp
  system "clear"

  if input_option == "1"
    response = Unirest.get("http://localhost:3000/contacts")
    contacts = response.body
    puts JSON.pretty_generate(contacts)
  elsif input_option == "1.5"
    puts "Enter search term: "
    search = gets.chomp
    puts "Here are all the matching contacts: "
    response = Unirest.get("http://localhost:3000/contacts?search=#{search}")
    contacts = response.body
    puts JSON.pretty_generate(contacts)
  elsif input_option == "2"
    print "Enter a contact id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
    contact = response.body
    puts JSON.pretty_generate(contact)
  elsif input_option == "3"
    puts "Enter information for a new contact"
    client_params = {}

    print "First Name: "
    client_params[:first_name] = gets.chomp

    print "Last Name: "
    client_params[:last_name] = gets.chomp

    print "Email: "
    client_params[:email] = gets.chomp

    print "Phone Number: "
    client_params[:phone_number] = gets.chomp

    print "Middle Name: "
    client_params[:middle_name] = gets.chomp

    print "Bio: "
    client_params[:bio] = gets.chomp

    response = Unirest.post(
                            "http://localhost:3000/contacts",
                            parameters: client_params
                            )
    contact = response.body
    puts JSON.pretty_generate(contact)
  elsif input_option == "4"
    print "Enter a contact id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
    contact = response.body

    puts "Enter new information for contact ##{input_id}"
    client_params = {}

    print "First Name (#{contact["first_name"]}): "
    client_params[:first_name] = gets.chomp

    print "Last Name (#{contact["last_name"]}): "
    client_params[:last_name] = gets.chomp

    print "Email (#{contact["email"]}): "
    client_params[:email] = gets.chomp

    print "Phone Number (#{contact["phone_number"]}): "
    client_params[:phone_number] = gets.chomp

    print "Middle Name (#{contact["middle_name"]}): "
    client_params[:middle_name] = gets.chomp

    print "Bio (#{contact["bio"]}): "
    client_params[:bio] = gets.chomp

    client_params.delete_if {|key, value| value.empty? }

    response = Unirest.patch(
                            "http://localhost:3000/contacts/#{input_id}",
                            parameters: client_params
                            )
    contact = response.body
    puts JSON.pretty_generate(contact)
  elsif input_option == "5"
    print "Enter a contact id that you want to delete: "
    input_id = gets.chomp

    response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
    data = response.body
    puts data["message"]
  elsif input_option == "6"
    params = {}
    puts "User name: "
    params[:name] = gets.chomp
    puts "User email: "
    params[:email] = gets.chomp
    puts "Password: "
    params[:password] = gets.chomp
    puts "Password Confirmation: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/users", parameters: params)
    user = response.body
    puts JSON.pretty_generate(user)
  elsif input_option == "7"
    puts "User email: "
    input_email = gets.chomp
    puts "Password: "
    input_password = gets.chomp
    response = Unirest.post("http://localhost:3000/user_token",
      parameters: {
        auth: {
          email: input_email,
          password: input_password
        }
      }
    )
    # Save the JSON web token from the response
    jwt = response.body["jwt"]
    puts jwt
    # Include the jwt in the headers of any future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}")
  elsif input_option == "8"
    jwt = ""
    Unirest.clear_default_headers()
  elsif input_option == "q"
    puts "Bye!"
    break
  end
  "Press any key to continue"
  gets.chomp
end


















