module Bestpay
  module Notify
    module Web
      NOTIFY_KEYS = %w{UPTRANSEQ MERCHANTID ORDERID PAYMENT RETNCODE RETNINFO PAYDATE KEY}
      def self.valid?(params,key)
        params = Utils.stringify_hash(params).merge('KEY' => key)

        #这个协议真是傻的没边了。
        params['ORDERID'] = params.delete('ORDERSEQ')
        params['PAYMENT'] = params.delete('ORDERAMOUNT')
        params['PAYDATE'] = params.delete('TRANDATE')

        Utils.build_mac(params,NOTIFY_KEYS) == params['SIGN']
      end

      def self.successful?(params,key)
        valid?(params, key) and (params['RETNCODE'] || params[:RETNCODE]) == '0000'
      end
    end

    module Wap
      NOTIFY_KEYS = %w{UPTRANSEQ MERCHANTID ORDERSEQ ORDERAMOUNT RETNCODE RETNINFO TRANDATE KEY}
      def self.valid?(params,key)
        params = Utils.stringify_hash(params).merge('KEY' => key)
        Utils.build_mac(params,NOTIFY_KEYS) == params['SIGN']
      end

      def self.successful?(params,key)
        valid?(params, key) and (params['RETNCODE'] || params[:RETNCODE]) == '0000'
      end
    end
  end
end
