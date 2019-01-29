#require 'dotenv'
require 'active_record'

#Dotenv.load
config  = YAML.load(ERB.new(File.read("./database.yml")).result)
ActiveRecord::Base.establish_connection(config["development"])

class Problem < ActiveRecord::Base

end
