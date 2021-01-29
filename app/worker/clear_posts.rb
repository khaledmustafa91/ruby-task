class CleanPosts
  include Sidekiq::Worker
  sidekiq_options :queue => :default , :retry => 1
  #include Sidetiq::Schedulable

  #recurrence { daily }

  def perform
    Post.where('created_at >= :thirty_days_ago', thiryty_days_ago: Time.now - 1.days).destroy
  end
end