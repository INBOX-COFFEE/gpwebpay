module GpWebpay
  class PaymentAttributes
    KEYS = %i(merchant_number operation order_number amount_in_cents currency deposit_flag redirect_url description merchant_description user_param)

    WS_KEYS = %i(message_id bank_id merchant_number order_number)

    REGULAR_PAYMENT_KEYS = %i(message_id bank_id merchant_number order_number master_order_number merchant_order_number amount_in_cents currency)

    OPTIONAL_KEYS = %i(merchant_order_number description merchant_description)

    MASTER_KEYS = %i(user_param)

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
      keys.each_with_object({}) do |method, hash|
        if @payment.respond_to?(method)
          if method == :message_id
            hash[method] = @payment.public_send(method, @type)
          else
            hash[method] = @payment.public_send(method)
          end
        elsif !OPTIONAL_KEYS.include?(method)
          method_missing(method)
        end

        hash
      end
    end
  end
end
