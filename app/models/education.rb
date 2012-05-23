class Education
  include Mongoid::Document
  field :name, :type => String
  field :school_name, :type => String
  field :degree, :type => String
  field :field_of_study, :type => String
  field :start_date, :type => String
  field :end_date, :type => String
  field :grade, :type => String
  embedded_in :user
  validates_presence_of :name,:degree,:start_date,:end_date
end
