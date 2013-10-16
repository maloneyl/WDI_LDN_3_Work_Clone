class Book < ActiveRecord::Base
  attr_accessible :title, :author, :content

  scope :published, -> { where(published: true) } # this is a lambda named published
  scope :unpublished, -> { where(published: false) } # you can have one for unpublshed too
  scope :by_gerry, -> { where(author: "gerry") } # you can make lambdas for whatever you want!
  scope :by_author, -> (author) { where(author: author) } # and you can have the lambda take an argument

  before_save do
    puts "This record will be saved soon."
    self.author = "no author" if self.author.nil?
  end

  after_save do    
    puts "You've just saved the record."
  end

  after_create do
    puts "Your record has been created." # this comes after before_save and before after_save
  end

  after_initialize do 
    puts "You've just initialized a new book."
  end

  before_destroy do 
    puts "We will destroy a book :("
  end


end
