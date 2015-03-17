class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  validates_presence_of :content, :chat_session, :sender, :receiver
  belongs_to :sender, class_name: "User", inverse_of: "id"
  belongs_to :receiver, class_name: "User", inverse_of: "id"
  belongs_to :chat_session
  field :content, type: String
  field :readed, type: Boolean, default: false
  scope :unread, -> {where(readed: false)}
end
