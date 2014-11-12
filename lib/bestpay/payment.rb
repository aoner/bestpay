module Bestpay
  module Payment 
    def self.build_payment_url(default_params, params, host, required_params)
      params = default_params.merge(stringify_hash(params))

      params['MAC'] = Mac.build_mac(params)
      params.delete('KEY')

      check_required_options(params, required_params)

      warn "#{host}?#{query_string(params)}"
      "#{host}?#{query_string(params)}"
    end

    def self.query_string(options)
      options.map do |key, value|
        "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end.join('&')
    end

    def self.check_required_options(options, names)
      names.each do |name|
        warn("Bestpay Warn: missing required option: #{name}") unless options.has_key?(name)
      end
    end

    def self.stringify_hash(hash)
      hash.inject({}){|h,(k,v)| h[k.to_s] = v; h} 
    end
  end
end
