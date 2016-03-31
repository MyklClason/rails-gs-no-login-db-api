class SheetsController < ApplicationController
 # input action is left blank
 def input
 end
 
 def output
   # This will use Roo and Set
   require 'roo'
   require 'set'
   
   # Don't try to work with invalid data
   if validate_data
     url = params[:url]
 
     # Use Roo to obtain the desired spreadsheet
     xlsx = Roo::Spreadsheet.open(url, extension: :xlsx)
     sheet = xlsx.sheet(0)
 
     # Use a loop to obtain the best friends data structure
     @best_friends = {}

     # This skip the headers (first row)
     (2..sheet.last_row).each do |i|
       row = sheet.row(i)

       # Obtain the name and best friend columns from the parameters
       name = row[params[:name].to_i]
       best_friend = row[params[:best_friend].to_i]

       if @best_friends[name]
         # If name already exists, add best friend to set
         @best_friends[name] = @best_friends[name].add(best_friend)
       else
         # If name already doesn't exists, create new set with best friend
         @best_friends[name] = Set.new [best_friend]
       end
     end
   end
 end
 
 def validate_data
   # Require returns an error if params are not present.
   begin
     params.require(:url) && params.require(:name) && params.require(:best_friend)
     return true
   rescue ActionController::ParameterMissing
     return nil
   end
 end
 
end
