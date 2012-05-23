class UserInfo
  include Mongoid::Document
  
  field :first_name
  field :last_name
  field :display_name
  field :headline
  field :goal
  field :summary
  field :specialities
  validates_presence_of :first_name,:last_name
  embedded_in  :user
end
