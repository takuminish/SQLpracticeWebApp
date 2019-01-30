require 'active_record'

config  = YAML.load(ERB.new(File.read("./database.yml")).result)
ActiveRecord::Base.establish_connection(config["test"])

class Problem < ActiveRecord::Base

end
