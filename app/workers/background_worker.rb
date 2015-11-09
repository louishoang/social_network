class BackgroundWorker
  include Sidekiq::Worker

  def perform(id)
    binding.pry
  end
end