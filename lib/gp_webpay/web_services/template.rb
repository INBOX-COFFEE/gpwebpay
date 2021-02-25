module GpWebpay
  module WebServices
    class Template

      ##
      # Generated XML request body
      # <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:core="http://gpe.cz/pay/pay-ws/core">
      #   <soapenv:Header/>
      #   <soapenv:Body>
      #     <v1:echo/>
      #   </soapenv:Body>
      # </soapenv:Envelope>
      ##
      def echo
        ::Nokogiri::XML::Builder.new(:encoding => "utf-8") do |xml|
          xml.send("soapenv:Envelope", "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:v1" => "http://gpe.cz/pay/pay-ws/proc/v1") {
            xml.send("soapenv:Header")
            xml.send("soapenv:Body") {
              xml.send("v1:echo")
            }
          }
        end.to_xml
      end

      ##
      # <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://gpe.cz/pay/pay-ws/proc/v1" xmlns:type="http://gpe.cz/pay/pay-ws/proc/v1/type">
      #    <soapenv:Header/>
      #    <soapenv:Body>
      #       <v1:processRegularSubscriptionPayment>
      #          <v1:regularSubscriptionPaymentRequest>
      #             <type:messageId>?</type:messageId>
      #             <type:provider>?</type:provider> -> previously as acquirer
      #             <type:merchantNumber>?</type:merchantNumber>
      #             <type:paymentNumber>?</type:paymentNumber> -> previously orderNumber (now optional)
      #             <type:masterPaymentNumber>?</type:masterPaymentNumber>
      #             <type:orderNumber>?</type:orderNumber>
      #             <type:subscriptionAmount>?</type:subscriptionAmount> -> previously amount, now unable to change
      #             <type:captureFlag>?</type:captureFlag>
      #             <type:cardHolderData>
      #                <type:cardholderDetails>
      #                   <type:name>?</type:name>
      #                   <type:email>?</type:email>
      #                   <type:phoneCountry>?</type:phoneCountry>
      #                   <type:phone>?</type:phone>
      #                   <type:mobilePhoneCountry>?</type:mobilePhoneCountry>
      #                   <type:mobilePhone>?</type:mobilePhone>
      #                   <type:clientIpAddress>?</type:clientIpAddress>
      #                </type:cardholderDetails>
      #                <type:addressMatch>?</type:addressMatch>
      #                <type:billingDetails>
      #                   <type:name>?</type:name>
      #                   <type:address1>?</type:address1>
      #                   <type:city>?</type:city>
      #                   <type:postalCode>?</type:postalCode>
      #                   <type:country>?</type:country>
      #                </type:billingDetails>
      #                <type:shippingDetails>
      #                   <type:name>?</type:name>
      #                   <type:address1>?</type:address1>
      #                   <type:city>?</type:city>
      #                   <type:postalCode>?</type:postalCode>
      #                   <type:country>?</type:country>
      #                </type:shippingDetails>
      #             </type:cardHolderData>
      #             <type:signature>cid:992953179904</type:signature>
      #          </v1:regularSubscriptionPaymentRequest>
      #       </v1:processRegularSubscriptionPayment>
      #    </soapenv:Body>
      # </soapenv:Envelope>
      ##
      def process_regular_subscription_payment(attributes = {})
        ::Nokogiri::XML::Builder.new(:encoding => "utf-8") do |xml|
          xml.send("soapenv:Envelope", "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:v1" => "http://gpe.cz/pay/pay-ws/proc/v1", "xmlns:type" => "http://gpe.cz/pay/pay-ws/proc/v1/type") {
            xml.send("soapenv:Header")
            xml.send("soapenv:Body") {
              xml.send("v1:processRegularSubscriptionPayment") {
                xml.send("v1:regularSubscriptionPaymentRequest") {
                  xml.send("type:messageId", attributes[:message_id])
                  xml.send("type:provider", "0100")
                  xml.send("type:merchantNumber", attributes[:merchant_number])
                  xml.send("type:paymentNumber", attributes[:order_number])
                  xml.send("type:masterPaymentNumber", attributes[:master_order_number])
                  xml.send("type:orderNumber", attributes[:merchant_order_number])
                  xml.send("type:subscriptionAmount", attributes[:amount])
                  xml.send("type:captureFlag", attributes[:capture_flag])
                  xml.send("type:cardHolderData") {
                    xml.send("type:cardholderDetails") {
                      xml.send("type:name", attributes[:card_holder_name])
                      xml.send("type:email", attributes[:card_holder_email])
                      xml.send("type:phoneCountry", attributes[:card_holder_phone_country])
                      xml.send("type:phone", attributes[:card_holder_phone])
                      xml.send("type:mobilePhoneCountry", attributes[:card_holder_mobile_phone_country])
                      xml.send("type:mobilePhone", attributes[:card_holder_mobile_phone])
                    }
                    xml.send("type:addressMatch", attributes[:address_match])
                    xml.send("type:billingDetails") {
                      xml.send("type:name", attributes[:billing_name])
                      xml.send("type:address1", attributes[:billing_address1])
                      xml.send("type:city", attributes[:billing_city])
                      xml.send("type:postalCode", attributes[:billing_postal_code])
                      xml.send("type:country", attributes[:billing_country])
                    }
                    xml.send("type:shippingDetails") {
                      xml.send("type:name", attributes[:shipping_name])
                      xml.send("type:address1", attributes[:shipping_address1])
                      xml.send("type:city", attributes[:shipping_city])
                      xml.send("type:postalCode", attributes[:shipping_postal_code])
                      xml.send("type:country", attributes[:shipping_country])
                    }
                  }
                  xml.send("type:signature", attributes[:digest])
                }
              }
            }
          }
        end.to_xml
      end

      ##
      # <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://gpe.cz/pay/pay-ws/proc/v1" xmlns:type="http://gpe.cz/pay/pay-ws/proc/v1/type">
      #    <soapenv:Header/>
      #    <soapenv:Body>
      #       <v1:getPaymentDetail>
      #          <v1:paymentDetailRequest>
      #             <type:messageId>?</type:messageId>
      #             <type:provider>?</type:provider>
      #             <type:merchantNumber>?</type:merchantNumber>
      #             <type:paymentNumber>?</type:paymentNumber>
      #             <type:signature>cid:1203306453242</type:signature>
      #          </v1:paymentDetailRequest>
      #       </v1:getPaymentDetail>
      #    </soapenv:Body>
      # </soapenv:Envelope>
      ##
      def get_payment_detail(attributes = {})
        ::Nokogiri::XML::Builder.new(:encoding => "utf-8") do |xml|
          xml.send("soapenv:Envelope", "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:v1" => "http://gpe.cz/pay/pay-ws/proc/v1", "xmlns:type" => "http://gpe.cz/pay/pay-ws/proc/v1/type") {
            xml.send("soapenv:Header")
            xml.send("soapenv:Body") {
              xml.send("v1:getPaymentDetail") {
                xml.send("v1:paymentDetailRequest") {
                  xml.send("type:messageId", attributes[:message_id])
                  xml.send("type:provider", "0100")
                  xml.send("type:merchantNumber", attributes[:merchant_number])
                  xml.send("type:paymentNumber", attributes[:order_number])
                  xml.send("type:signature", attributes[:digest])
                }
              }
            }
          }
        end.to_xml
      end

      ##
      # <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://gpe.cz/pay/pay-ws/proc/v1" xmlns:type="http://gpe.cz/pay/pay-ws/proc/v1/type">
      #    <soapenv:Header/>
      #    <soapenv:Body>
      #       <v1:getPaymentStatus>
      #          <v1:paymentStatusRequest>
      #             <type:messageId>?</type:messageId>
      #             <type:provider>?</type:provider>
      #             <type:merchantNumber>?</type:merchantNumber>
      #             <type:paymentNumber>?</type:paymentNumber>
      #             <type:signature>cid:619237523074</type:signature>
      #          </v1:paymentStatusRequest>
      #       </v1:getPaymentStatus>
      #    </soapenv:Body>
      # </soapenv:Envelope>
      ##
      def get_payment_status(attributes = {})
        ::Nokogiri::XML::Builder.new(:encoding => "utf-8") do |xml|
          xml.send("soapenv:Envelope", "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:v1" => "http://gpe.cz/pay/pay-ws/proc/v1", "xmlns:type" => "http://gpe.cz/pay/pay-ws/proc/v1/type") {
            xml.send("soapenv:Header")
            xml.send("soapenv:Body") {
              xml.send("v1:getPaymentStatus") {
                xml.send("v1:paymentStatusRequest") {
                  xml.send("type:messageId", attributes[:message_id])
                  xml.send("type:provider", "0100")
                  xml.send("type:merchantNumber", attributes[:merchant_number])
                  xml.send("type:paymentNumber", attributes[:order_number])
                  xml.send("type:signature", attributes[:digest])
                }
              }
            }
          }
        end.to_xml
      end

      ##
      # <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://gpe.cz/pay/pay-ws/proc/v1" xmlns:type="http://gpe.cz/pay/pay-ws/proc/v1/type">
      #   <soapenv:Header/>
      #   <soapenv:Body>
      # 		<v1:getMasterPaymentStatus>
      # 			 <v1:masterPaymentStatusRequest>
      # 					<type:messageId>?</type:messageId>
      # 					<type:provider>?</type:provider>
      # 					<type:merchantNumber>?</type:merchantNumber>
      # 					<type:paymentNumber>?</type:paymentNumber>
      # 					<type:signature>cid:300161986033</type:signature>
      # 			 </v1:masterPaymentStatusRequest>
      # 		</v1:getMasterPaymentStatus>
      #  </soapenv:Body>
      # </soapenv:Envelope>
      ##
      def get_master_payment_status(attributes = {})
        ::Nokogiri::XML::Builder.new(:encoding => "utf-8") do |xml|
          xml.send("soapenv:Envelope", "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:v1" => "http://gpe.cz/pay/pay-ws/proc/v1", "xmlns:type" => "http://gpe.cz/pay/pay-ws/proc/v1/type") {
            xml.send("soapenv:Header")
            xml.send("soapenv:Body") {
              xml.send("v1:getMasterPaymentStatus") {
                xml.send("v1:masterPaymentStatusRequest") {
                  xml.send("type:messageId", attributes[:message_id])
                  xml.send("type:provider", "0100")
                  xml.send("type:merchantNumber", attributes[:merchant_number])
                  xml.send("type:paymentNumber", attributes[:order_number])
                  xml.send("type:signature", attributes[:digest])
                }
              }
            }
          }
        end.to_xml
      end
    end
  end
end
