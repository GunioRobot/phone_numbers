require 'test_helper'
require 'has_phone_number/phone_number'

class UsTest < ActiveSupport::TestCase
  context "An US Phone Number" do
    setup do
      @format = HasPhoneNumber::PhoneNumber.formats[:us]
    end
    
    context "with less than 10 digits" do
      setup { @phone_number = "(312) 456-789" }
      should("not match") { deny @format.match @phone_number }
    end # with less than 10 digits
    
    context "with more than 10 digits" do
      setup { @phone_number = "312-456-78901" }
      should("not match") { deny @format.match @phone_number }
    end # with more than 10 digits
    
    context "with 10 digits" do
      context "and characters other than (), - and space" do
        setup { @phone_number = "a312b456c7890" }
        
        should("not match") { deny @format.match @phone_number }
      end # and characters other than (), - and space
      
      context "that are grouped and separated by hyphens" do
        setup { @phone_number = "312-456-7890" }
        
        should("match") { assert @format.match @phone_number }
      end # that are grouped and separated by hyphens
      
      context "that are grouped and separated by spaces" do
        setup { @phone_number = "312 456 7890" }
        
        should("match") { assert @format.match @phone_number }
      end # that are grouped and separated by spaces
      
      context "where the area code is in parentheses" do
        context "followed by a hyphen, and the exchange is followed by a space" do
          setup { @phone_number = "(312)-456 7890" }
        
          should("not match") { deny @format.match @phone_number }
        end # followed by a hyphen, and then space-separated
        
        context "followed by a space, and the exchange is followed by a space" do
          setup { @phone_number = "(312) 456 7890" }
        
          should("match") { assert @format.match @phone_number }
        end # followed by a space, and the exchange is followed by a space
        
        context "followed by a space, and the exchange is followed by a hyphen" do
          setup { @phone_number = "(312) 456-7890" }
        
          should("match") { assert @format.match @phone_number }
        end # followed by a space, and the exchange is followed by a hyphen
      end # where the area code is in parentheses
    end # with 10 digits
  end # A Phone Number
end