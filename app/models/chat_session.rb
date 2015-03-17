class ChatSession
  include Mongoid::Document
  has_many :messages
end
