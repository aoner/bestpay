require 'digest/md5'

module Bestpay
  module Mac
    KEYS = %w{MERCHANTID ORDERSEQ ORDERDATE ORDERAMOUNT CLIENTIP KEY}

    def self.build_mac(params)
      pairs = []
      KEYS.each do |k|
        value = params[k]
        if value.nil?
          raise "参数 #{k} 不能为空!" unless k == 'CLIENTIP'
        else
          pairs << "#{k}=#{value}"
        end
      end

      Digest::MD5.hexdigest(pairs.join("&")).upcase
    end

    def self.valid?(params)
      params['MAC'] == self.build_mac(params)
    end
  end
end
