module Bestpay
  module Payment 
    #Wap支付
    module Wap
      GATEWAY_HOST = 'https://wappaywg.bestpay.com.cn/payWap.do'
      REQUIRED_PARAMS = %w{MERCHANTID ORDERSEQ ORDERREQTRANSEQ ORDERDATE ORDERAMOUNT PRODUCTAMOUNT ATTACHAMOUNT CURTYPE
                           ENCODETYPE MERCHANTURL BACKMERCHANTURL BUSICODE PRODUCTID TMNUM CUSTOMERID PRODUCTDESC}
      #默认
      def self.payment_url(params)
        default_params = {
          'SUBMERCHANTID' => "0018888888",
          'CURTYPE' => "RMB",# 币种
          'ENCODETYPE' => "1",# 加密方式
          'BUSICODE' => "0001",# 业务类型
          'PRODUCTID' => "08",# 业务标识
        }

        #TODO proc amount unit
        #协议定制者真是...,其他所有支付·退款都是分位单位，就WAP支付这用元为单位，没带小数点还不行(或许是补救措施吧)，
        #而且同一个请求里面的，DIVDETAILS（分账明细）还是用分为单位的。
        #精神分裂，鉴定完毕。

        Payment.build_payment_url(default_params, params, GATEWAY_HOST, REQUIRED_PARAMS)
      end

      #自定义银行交易请求
      def direct_payment_url
        raise 'TODO'
      end
    end
  end
end
