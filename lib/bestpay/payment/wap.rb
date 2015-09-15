module Bestpay
  module Payment 
    #Wap支付
    module Wap
      GATEWAY_HOST = 'https://wappaywg.bestpay.com.cn/payWap.do'
      DIRECT_GATEWAY_HOST = 'https://wappaywg.bestpay.com.cn/payWapDirect.do'
      REQUIRED_PARAMS = %w{MERCHANTID ORDERSEQ ORDERREQTRANSEQ ORDERDATE ORDERAMOUNT PRODUCTAMOUNT ATTACHAMOUNT CURTYPE
                           ENCODETYPE MERCHANTURL BACKMERCHANTURL BUSICODE PRODUCTID TMNUM CUSTOMERID PRODUCTDESC}

      DEFAULT_OPTIONS = {
        'CURTYPE' => "RMB",# 币种
        'ENCODETYPE' => "1",# 加密方式
        'BUSICODE' => "0001",# 业务类型
        'PRODUCTID' => "08",# 业务标识
      }

      #生成支付链接。
      def self.generate_payment_url(in_params,host)
        params = in_params.dup

        #DONE proc amount unit
        #协议定制者真是...,其他所有支付·退款都是分位单位，就WAP支付这用元为单位，没带小数点还不行(或许是补救措施吧)，
        #而且同一个请求里面的，DIVDETAILS（分账明细）还是用分为单位的。
        #精神分裂，鉴定完毕。
        params = Utils.stringify_hash(params)
        params['ORDERAMOUNT'] = proc_amount(params['ORDERAMOUNT'])
        params['PRODUCTAMOUNT'] = proc_amount(params['PRODUCTAMOUNT'])
        params['ATTACHAMOUNT'] = proc_amount(params['ATTACHAMOUNT'])

        Payment.build_payment_url(DEFAULT_OPTIONS, params, GATEWAY_HOST, REQUIRED_PARAMS)
      end

      def self.payment_url(params)
        generate_payment_url(params, GATEWAY_HOST)
      end

      #自定义银行交易请求, 唯一区别是： 需要传入BANKID, 无需两次输入密码。
      def self.direct_payment_url(params)
        generate_payment_url(params, DIRECT_GATEWAY_HOST)
      end

      protected
      def self.proc_amount( value )
        value = value.to_i / 100.0
        '%.2f' % value
      end
    end
  end
end
