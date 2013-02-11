# Add a declarative step ere for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie[:title], :release_date => movie[:release_date], :rating => movie[:rating])
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  
  regexp = /#{e1}.*#{e2}/m
  page.body.should =~ regexp

  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
end
 
Given /^(?:|I )check the following ratings: "([^"]*)"$/ do |field|
  
    check(field)
  end
  
  Then /I uncheck the following ratings: "([^"]*)"$/ do |checkedbox| 
    
    uncheck(checkbox) 
  end
  
  Then /^(?:|I )press "([^"]*)"$/ do |button|
    click_button(button)
  end
  
  Then /^I should see "(.*?)", "(.*?)"$/ do |r1, r2|
   if page.respond_to? :should
    page.should have_content(r1)
    page.should have_content(r2)
   else
    assert page.has_content?(r1)
    assert page.has_content?(r2)
   end
  end 
  
  Then /^I should not see "(.*?)", "(.*?)"$/ do |r1, r2|
   if page.respond_to? :should
    page.should have_no_content(r1)
    page.should have_no_content(r2)
   else
    assert page.has_no_content?(r1)
    assert page.has_no_content?(r2) 
   end
  end

Then /^I should see all the movies$/ do  
    rows = Movie.count
    selected = Movie.find_all_by_rating(['R', 'G', 'RG', 'PG-13'])
    rows.should == selected
end

#Then /^(?:|I )uncheck the following ratings: "([^"]*)"$/ do |field| 
#    uncheck(field)
#end
