module Wsdl
  class Validator
    attr_accessor :schemas

    SCHEMA_URL = "spec/support/wsdl/types.xsd"

    def initialize
      self.schemas = Nokogiri::XML::Schema(File.open(SCHEMA_URL))
    end

    def extract_root_from_soap(envelope)
      body = envelope.children.find { |child| child.name == "Body" }
      root_element = body.children.reject { |child| child.is_a?(Nokogiri::XML::Text) }.first
      envelope.namespaces.each { |namespace, value| root_element[namespace] = value }
      body.namespaces.each { |namespace, value| root_element[namespace] = value }
      Nokogiri::XML root_element.to_s # Convert to Xml Document
    end

    def errors_for(xml)
      raise "Incorrect type #{xml.class}" unless [String, Nokogiri::XML::Document, Nokogiri::XML::NodeSet].include? xml.class
      xml_under_test = Nokogiri::XML(xml.to_s)
      soap_envelope = xml_under_test.children.find { |e| e.name == "Envelope" }
      xml_under_test = extract_root_from_soap(soap_envelope) if soap_envelope
      schemas.validate(xml_under_test)
    end
  end
end
