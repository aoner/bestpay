module Bestpay
  module Payment 
    #PAYMENT_MAC_KEYS = %w{MERCHANTID ORDERSEQ ORDERDATE ORDERAMOUNT CLIENTIP KEY}
    PAYMENT_MAC_KEYS = %w{MERCHANTID ORDERSEQ ORDERDATE ORDERAMOUNT KEY}

    def self.build_payment_url(default_params, params, host, required_params)
      params = default_params.merge(Utils.stringify_hash(params))

      params['MAC'] = Utils.build_mac(params, PAYMENT_MAC_KEYS)
      params.delete('KEY')

      Utils.check_required_options(params, required_params)

      "#{host}?#{Utils.query_string(params)}"
    end
  end
end
