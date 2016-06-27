class Country < ActiveRecord::Base
  has_many :states
  def self.show_country
    pluck(:name, :id)
  end
end
