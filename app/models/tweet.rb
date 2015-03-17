class Tweet 
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :content, type: String, default: ""
  field :votes,           type: Integer, default: 0
  field :feedback,           type: Integer, default: 0
  field :location,           type: Array
  validates_inclusion_of :feedback, in: [0, 1, -1]
  belongs_to :user
  has_many :comments
  has_many :images
  has_many :sub_comments
  has_one :foot_point, as: :element
  validates_length_of :content, minimum: 1

  def share_url
    "http://abc"
  end

  def self.comment_block
    Proc.new {|c| {
      id: c.id.to_s,
      created_at: c.created_at,
      avatar: c.user.avatar,
      username: c.user.username,
      content: c.content,
      sub_comments: c.sub_comments.map {|sb| {username: sb.user.username, content: sb.user.content}},
    }}
  end

  def self.tweet_block
    Proc.new {|t|{
      content: t.content, id: t.id.to_s, 
      username: t.user.username,
      avatar: t.user.avatar,
      share_url: t.share_url,
      votes: t.votes,
      comments_counts: t.comments.count,
      created_at: t.created_at,
      images: t.images.map(&:url),
      id: t.id.to_s,
      feedback: t.feedback
    }}
  end
end
