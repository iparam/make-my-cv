class Education
  include Mongoid::Document
  field :name, :type => String
  field :degree, :type => String
  field :field_of_study, :type => String
  field :start_date, :type => String
  field :end_date, :type => String
  field :grade, :type => String
  field :user_id
  embedded_in :user
end
