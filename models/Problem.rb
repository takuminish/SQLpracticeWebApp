require 'active_record'

config  = YAML.load(ERB.new(File.read("./database.yml")).result)
#ActiveRecord::Base.establish_connection(config["test"])
ActiveRecord::Base.establish_connection(config[ENV['APP_ENV']])

class Problem < ActiveRecord::Base
  validates :title, presence: true
  validates :statement, presence: true
  validates :answer, presence: true
  validates :level, presence: true
end
