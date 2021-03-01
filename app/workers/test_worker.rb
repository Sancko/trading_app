class TestWorker
  include Sidekiq::Worker

  def perform
    Test.new.call
    logger.info "test getting info"
  end
end
