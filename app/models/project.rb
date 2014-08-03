class Project < ActiveRecord::Base

  has_and_belongs_to_many :notificators
  has_many :payloads, through: :notificators

end
