class Link < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user
  has_many :comments

  searchable do 
    text :title
  end|
    
  end

  def self.search(query)
    # whenever passing strings into db, make sure to use this syntax:
    where('title LIKE ?', "%#{query}.gsub(/ /, '%')}%")
    # % means wild card in sqlite. Above is searching for any character before & after the query.
  end

end
