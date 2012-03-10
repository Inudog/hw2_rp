class Movie < ActiveRecord::Base
  public 
  def self.getRatings
    return ['G','PG','PG-13','R','NC-17']
  end

end
