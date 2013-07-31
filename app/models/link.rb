class Link < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user
  has_many :comments

  searchable do 
    text :title
  end
  # bundle exec rake sunspot:solr:run

  def self.db_search(query)
    # whenever passing strings into db, make sure to use this syntax:
    where('title LIKE ?', "%#{query}.gsub(/ /, '%')}%")
    # % means wild card in sqlite. Above is searching for any character before & after the query.
  end

  # Use the documentation to define search. https://github.com/sunspot/sunspot#readme
  def self.search(query, params={})
    solr_search do

      fulltext query do
        
      end

      paginate :page => params[:page], :per_page => params[:per_page]
  end

end
