require_dependency Rails.root.join('app', 'models', 'image').to_s

class Image < ActiveRecord::Base
  MIN_SIZE = 400
  MAX_IMAGE_SIZE = 3.megabyte
  ACCEPTED_CONTENT_TYPE = %w(image/jpeg image/jpg image/png image/gif).freeze
end
