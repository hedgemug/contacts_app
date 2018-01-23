class ContactsController < ApplicationController
  def index
    contacts = Contact.all
    render json: contacts.as_json
  end

  def create
    contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      middle_name: params[:middle_name],
      bio: params[:bio]
    )
    contact.save
    render json: contact.as_json
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact.as_json
  end

  def update
    contact = Contact.find(params[:id])
    
    contact.first_name = params[:first_name] || contact.first_name
    contact.last_name = params[:last_name] || contact.last_name
    contact.email = params[:email] || contact.email
    contact.phone_number = params[:phone_number] || contact.phone_number
    contact.middle_name = params[:middle_name] || contact.middle_name
    contact.bio = params[:bio] || contact.bio
    contact.save

    render json: contact.as_json
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: {message: "Successfully destroyed contact ##{contact.id}"}
  end
end











