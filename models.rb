require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password

    validates :password,
      format: {with:/(?=.*?[a-z])(?=.*?[0-9])/},
      length: {in: 5..10}
      
    has_many :categories
    has_many :tasks
    has_many :reviews
end

class Task < ActiveRecord::Base
    belongs_to :user
end

class Category < ActiveRecord::Base
    belongs_to :user
end

class Review < ActiveRecord::Base
    belongs_to :user
end

class Todo < ActiveRecord::Base
    belongs_to :user
end
