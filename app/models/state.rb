class State < ActiveRecord::Base
  belongs_to :country
  def self.show_state
    pluck(:name, :id)
  end
end
