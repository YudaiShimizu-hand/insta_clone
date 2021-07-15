# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  name             :string(255)      not null
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  authenticates_with_sorcery!
  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  # you can use changes[:crypted_password] instead of crypted_password_changed? と書いてあった
  # 何が違うのか、調べたがよく分からなかった
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :active_relationships, class_name:  'Relationship',
  foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  scope :recent, ->(count) { order(created_at: :desc).limit(count) }

  def own?(object)
    id == object.user_id
  end
  
  def like(post)
    # likes.create(post_id: post.id)
    #
    # Like.create(user_id: current_user.id, post_id: post.id)

    like_posts << post
  end

  # インプット・・・投稿のインスンタス
  # アウトプット・・・返り値はなし
  def unlike(post)
    like_posts.destroy(post)
  end

  def like?(post)
    like_posts.include?(post)
	end

   
   def follow(other_user)
    following << other_user
   end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy

    # 別解
    following.destroy(other_user)
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    Post.where(user_id: following_ids << id)
  end

end
