require 'digest/md5'

module Bestpay

  class ParameterNotFoundError < StandardError  
  end  

  module Utils
    def self.build_mac(params, keys)
      pairs = []
      keys.each do |k|
        value = params[k]
        if value.nil?
          raise Bestpay::ParameterNotFoundError, "参数 #{k} 不能为空!" unless k == 'CLIENTIP'
        else
          pairs << "#{k}=#{value}"
        end
      end

      Digest::MD5.hexdigest(pairs.join("&")).upcase
    end
    

    def self.query_string(options)
      options.map do |key, value|
        "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end.join('&')
    end

    def self.check_required_options(options, names)
      names.each do |name|

        unless options.has_key?(name)
          raise Bestpay::ParameterNotFoundError,"参数 #{name} 不能为空!" unless name == 'CLIENTIP'
        end
      end
    end

    def self.stringify_hash(hash)
      hash.to_unsafe_h.inject({}){|h,(k,v)| h[k.to_s] = v; h} 
    end
  end
end
