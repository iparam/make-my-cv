class Education
  include Mongoid::Document
  field :name, :type => String
  field :degree, :type => String
  field :field, :type => String
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :grade, :type => String
  field :user_id
 # embedded_in :user
 belongs_to :user
# referenced_in :user
end
