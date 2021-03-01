class Test
  attr_reader :redis_client

  def initialize
    @redis_client = Redis.current

  end

  def call

      data = ::Exmo::Public::Client.create('trades','pair=BTC_USD').call
      btc_usd = data['BTC_USD']

      # get trade_id
      saved_ids = redis_client.lrange('ids',0,-1).map(&:to_i) || []

      # not working yet select
      new_trades = btc_usd.select{|x| !saved_ids.include?(x['trade_id']) }
      return unless new_trades.present?

      ids = new_trades.pluck('trade_id')
      puts ids.inspect
      redis_client.rpush("ids", ids)

      redis_client.rpush('trades', new_trades)

      puts new_trades.inspect
      #trades_ids = redis_client.get('trades_ids')


  end
end
