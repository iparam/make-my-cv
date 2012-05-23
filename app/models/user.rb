class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable,validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  ## Database authenticatable
  field :email,              :type => String
  field :encrypted_password, :type => String, :null => false, :default => ""
  field :username,              :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :linkedin_access_token ,:type=>String
  field :linkedin_access_secret ,:type=>String
  field :linkedin_pin_verifier ,:type=>String
  field :linkedin_id,:type=>String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and 
 
  field :summary
  field :name

  embeds_many :educations
  embeds_many :experiences
  embeds_many :projects
  embeds_one :user_info

  accepts_nested_attributes_for :educations,:allow_destroy=>true
  accepts_nested_attributes_for :experiences,:allow_destroy=>true
  accepts_nested_attributes_for :user_info,:allow_destroy=>true
  accepts_nested_attributes_for :projects,:allow_destroy=>true  
  
  def full_name
    self.user_info.first_name+ "  "+self.user_info.last_name if user_info
  end
  def self.find_for_linkedin_oauth(access_token, signed_in_resource=nil)

    secret = access_token.extra["access_token"].secret
    token = access_token.extra["access_token"].token
    id = access_token.extra["raw_info"].id
    user = User.where("linkedin_id"=>id)
    if user.present? 
      user.first
    elsif signed_in_resource.present?
      signed_in_resource.update_attributes({:linkedin_access_secret =>secret,:linkedin_access_token=>token,:linkedin_id=>id})
    else # Create a user with a stub password. 
      self.create!(:username => id, :password => Devise.friendly_token[0,20],:linkedin_access_secret =>secret,:linkedin_access_token=>token) 
    end
  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.linkedin_data'] && session['devise.linkedin_data'].extra["raw_info"].id
        user.username = session['devise.linkedin_data'].extra["raw_info"].id
      end
    end
  end
  
  def fill_linkedin_data
    client =  LinkedIn::Client.new
    token = linkedin_access_token
    secret = linkedin_access_secret
    client.authorize_from_access(linkedin_access_token, linkedin_access_secret)
    basic_profile = client.profile(:public=>true)
    #profile =  client.profile(:fields => %w(positions skills educations))
    
    if user_info.present?
      user_info.update_attributes({:first_name=>basic_profile.first_name,:last_name=>basic_profile.last_name,
                                            :headline=>basic_profile.headline,:specialities=>basic_profile.specialties,
                                            :summary=>basic_profile.summary})
    else  
    user_information = self.build_user_info({:first_name=>basic_profile.first_name,:last_name=>basic_profile.last_name,
                                            :headline=>basic_profile.headline,:specialities=>basic_profile.specialties,:summary=>basic_profile.summary})
    user_information.save
    end 
  
    # EDUCations
    if basic_profile.educations && basic_profile.educations.all 
      basic_profile.educations.all.each do |edu|
        education = self.educations.new({"degree"=>edu.degree,"end_date"=>edu.end_date.year,"start_date"=>edu.start_date.year,
                            "field_of_study"=>edu.field_of_study,"school_name"=>edu.school_name,"name"=>edu.school_name})
        education.save
  
      end            
    end  
    # Company
    if basic_profile.positions && basic_profile.positions.all 
       basic_profile.positions.all.each do |pos|
        start_date= pos.start_date.year && pos.start_date.month ? Date.new(pos.start_date.year,pos.start_date.month) : Date.new(pos.start_date.year)
        end_date= pos.end_date.year && pos.end_date.month ? Date.new(pos.end_date.year,pos.end_date.month) : Date.new(pos.end_date.year) unless pos.is_current
   
        experience = self.experiences.create({"industry"=>pos.company.industry,"company_name"=>pos.company.name,"size"=>pos.company.size,
                              "company_type"=>pos.company.type ,"is_current"=>pos.is_current,
                              "start_date"=>start_date,"end_date"=>end_date,"title"=>pos.title,"description"=>pos.summary})
        experience.save

                  
      end  
    end
  end
end
