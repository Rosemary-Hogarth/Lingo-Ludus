class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  def sender?(a_user)
    puts "COMPARING user IDs: user.id=#{user.id}, a_user.id=#{a_user.id}"
    logger.debug "Comparing user IDs: user.id=#{user.id}, a_user.id=#{a_user.id}"

    user.id == a_user.id
  end
end
