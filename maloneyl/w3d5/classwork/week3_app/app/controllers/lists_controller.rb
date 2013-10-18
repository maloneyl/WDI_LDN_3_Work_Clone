class ListsController < ApplicationController
  def show_form
    @lists = List.all
    @contacts = Contact.all
  end

  def add_contact
    contact_id = params[:contact_id]
    contact = Contact.find(contact_id)

    list_id = params[:list_id]
    list = List.find(list_id)

    list.contacts << contact  # contact.lists << list
  end
end
