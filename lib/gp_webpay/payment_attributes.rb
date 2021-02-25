module GpWebpay
  class PaymentAttributes
    KEYS = %w(MERCHANTNUMBER OPERATION ORDERNUMBER AMOUNT CURRENCY DEPOSITFLAG URL DESCRIPTION MD USERPARAM1)

    WS_KEYS = %w(MESSAGEID BANKID MERCHANTNUMBER ORDERNUMBER)

    REGULAR_PAYMENT_KEYS = %w(MESSAGEID BANKID MERCHANTNUMBER ORDERNUMBER MASTERORDERNUMBER MERORDERNUM AMOUNT CURRENCY)

    OPTIONAL_KEYS = %w(MERORDERNUM DESCRIPTION MD)

    MASTER_KEYS = %w(USERPARAM1)

    TRANSITIONS = {
      "MERCHANTNUMBER" => :merchant_number,
      "ORDERNUMBER" => :order_number,
      "MASTERORDERNUMBER" => :master_order_number,
      "AMOUNT" => :amount_in_cents,
      "DEPOSITFLAG" => :deposit_flag,
      "MERORDERNUM" => :merchant_order_number,
      "URL" => :redirect_url,
      "MD" => :merchant_description,
      "USERPARAM1" => :user_param,
      "MESSAGEID" => :message_id,
      "BANKID" => :bank_id,
    }

    def initialize(payment, ws_flag = false, type = "")
      @payment = payment
      @ws_flag = ws_flag
      @type = type
    end

    def keys
      case @payment.payment_type
      when "master"
        return (@ws_flag ? WS_KEYS : KEYS)
      when "recurring"
        case @type
        when "processRegularSubscriptionPayment"
          puts @payment.payment_type
          puts @type
          return REGULAR_PAYMENT_KEYS
        else
          return WS_KEYS
        end
      else
        return KEYS.reject { |k| MASTER_KEYS.include?(k) }
      end
    end

    def to_h
      keys.each_with_object({}) do |key, hash|
        method = TRANSITIONS[key] || key.downcase.to_sym

        if @payment.respond_to?(method)
          if method == TRANSITIONS["MESSAGEID"]
            hash[key] = @payment.public_send(method, @type)
          else
            hash[key] = @payment.public_send(method)
          end
        elsif !OPTIONAL_KEYS.include?(key)
          method_missing(method)
        end

        hash
      end
    end
  end
end
