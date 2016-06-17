class History < ActiveRecord::Base
  belongs_to :historiable, polymorphic: true
end
