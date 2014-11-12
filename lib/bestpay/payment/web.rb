module Bestpay
  module Payment 
    #Web支付
    module Web
      GATEWAY_HOST = 'https://webpaywg.bestpay.com.cn/payWeb.do'
      REQUIRED_PARAMS  = %w{MERCHANTID ORDERSEQ ORDERREQTRANSEQ ORDERDATE ORDERAMOUNT PRODUCTAMOUNT ATTACHAMOUNT
                            CURTYPE ENCODETYPE MERCHANTURL BACKMERCHANTURL BUSICODE PRODUCTDESC CLIENTIP}

      #默认
      def self.payment_url(params)
        default_params = {
          'SUBMERCHANTID' => "0018888888",
          'CURTYPE' => "RMB",# 币种
          'ENCODETYPE' => "1",# 加密方式
          'BUSICODE' => "0001",# 业务类型
          'PRODUCTID' => "08",# 业务标识
        }

        Payment.build_payment_url(default_params, params, GATEWAY_HOST, REQUIRED_PARAMS)
      end

      #自定义银行交易请求
      def direct_payment_url
        raise 'TODO'
      end

      #统一收银柜台交易请求
      def unify_payment_url
        raise 'TODO'
      end
    end
  end
end
