require_relative "../../app/helpers/activities_helper"
require "date"

describe "Activities Helper" do
	describe("helper funtion") do
		it("should identify whether an input is a number or not") do
			res = ActivitiesHelper.is_number?("3a")
			expect(res).to be false

			res = ActivitiesHelper.is_number?("1")
			expect(res).to be true
		end
	end
  describe "parse date and time" do
      it("should return a value") do
          value = ActivitiesHelper.parse_date("2020-09-23", "17:30")
          expect(value).not_to eq(nil)
      end

      it("should return an instance of datetime") do
          value = ActivitiesHelper.parse_date("2020-09-23", "10:00")
          ans = DateTime.new(2020, 9, 23, 10, 0, 0, Rational(-5, 24))

          expect(value).to be_instance_of(DateTime)
      end

      it("should be able to be able to parse a AM time") do
        value = ActivitiesHelper.parse_date("2020-09-23", "10:00")

        ans = DateTime.new(2020, 9, 23, 10, 0, 0, Rational(-5, 24))
        expect(value).to eq(ans)
      end

      it("should be able to be able to parse a PM time") do
          value = ActivitiesHelper.parse_date("2020-09-23", "17:00")
  
          ans = DateTime.new(2020, 9, 23, 17, 0, 0, Rational(-5, 24))
          expect(value).to eq(ans)
      end
	end
    describe "form vaildation testing" do
        it("should have the correct number of the fields") do 
          wrong_hash = {
            "type" => "type", 
            "date" => "date",
            "time" => "time",
            "point_value" => "point value",
            "description" => "description"
          }
    
          res = ActivitiesHelper.correct_num_field?(wrong_hash)
          expect(res).to be false
    
          wrong_hash = {
            "type" => "type", 
            "time" => "time",
            "point_value" => "point value",
            "description" => "description"
          }
    
          res = ActivitiesHelper.correct_num_field?(wrong_hash)
          expect(res).to be false
    
          wrong_hash = {
            "type" => "type", 
            "date" => "date",
            "time" => "time",
            "point_value" => "point value",
            "description" => "description"
          }
    
          res = ActivitiesHelper.correct_num_field?(wrong_hash)
          expect(res).to be false
    
          correct_hash = {
            "activity_name" => "name",
            "activity_type" => "type", 
            "date" => "date",
            "time" => "time",
            "point_value" => "point value",
            "description" => "description"
          }
    
          res = ActivitiesHelper.correct_num_field?(correct_hash)
          expect(res).to be true
        
        end


        it("should deterine if the date and time were input correctly") do
          map = {
            "date" => "2020-09-23",
            "time" => "03:30P"
          }

          res = ActivitiesHelper.datetime_correct?(map)
          expect(res).to be false

          map = {
            "date" => "2020-09-23",
            "time" => "-3:30"
          }

          res = ActivitiesHelper.datetime_correct?(map)
          expect(res).to be false

          map = {
            "date" => "202--09-23",
            "time" => "15:00PM"
          }

          res = ActivitiesHelper.datetime_correct?(map)
          expect(res).to be false

          map = {
            "date" => "2020-09-23",
            "time" => "03:30PM"
          }

          res = ActivitiesHelper.datetime_correct?(map)
          expect(res).to be false

          map = {
            "date" => "2020-09-23",
            "time" => "3:30P"
          }

          res = ActivitiesHelper.datetime_correct?(map)
          expect(res).to be false

          map = {
            "date" => "12/32/2020",
            "time" => "03:30PM"
          }
  
          res = ActivitiesHelper.datetime_correct?(map)
          expect(res).to be false

          map = {
            "date" => "12/23/2020",
            "time" => "-03:30PM"
          }
  
          res = ActivitiesHelper.datetime_correct?(map)
          expect(res).to be false
        

        map = {
          "date" => "13/23/2020",
          "time" => "03:30PM"
        }

        res = ActivitiesHelper.datetime_correct?(map)
        expect(res).to be false
			
				map = {
          "date" => "13/23/2020",
          "time" => "03:30PM"
        }

        res = ActivitiesHelper.datetime_correct?(map)
        expect(res).to be false

        map = {
          "date" => "2020-09-23",
          "time" => "15:00"
        }

        res = ActivitiesHelper.datetime_correct?(map)
        expect(res).to be true

        # edge case testing

        map = {
          "date" => "1000-01-01",
          "time" => "00:00"
        }

        res = ActivitiesHelper.datetime_correct?(map)
        expect(res).to be true

        map = {
          "date" => "9999-12-31",
          "time" => "23:59"
        }

        res = ActivitiesHelper.datetime_correct?(map)
        expect(res).to be true

        map = {
          "date" => "9999-12-31",
          "time" => "24:00"
        }

        res = ActivitiesHelper.datetime_correct?(map)
        expect(res).to be false

    end
  end
end

