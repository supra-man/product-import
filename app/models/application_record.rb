class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # ActiveStorage::Current.host = "http://localhost:3000"
  ActiveStorage::Current.url_options = { host: 'http://localhost:3000' }
end
