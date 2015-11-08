namespace :comments do
  desc "fill in author column for comments"

  task :populate_comment_with_author => :environment do
    Comment.all.each do |comment|
      if comment.author.blank? && comment.user_id.present?
        comment.author = User.find(comment.user_id).email
        comment.save
      end
    end
  end
end