class DashboardController < ApplicationController
    before_action :authenticate_user!
    def index
        @districts = current_user.following_by_type('District')
        @updates = Update.all.limit(3)
        @birthdays = Person.where(birth_month: Time.zone.now.month).order(:birth_day).where("birth_day >= ?", Time.zone.now.day.to_i)
        @deadlines = Deadline.all.order('deadline_date ASC')
        @incumbents = current_user.following_by_type('District').includes(:incumbent).collect{|u| u.incumbent}.flatten
        @atlarge_candidates = current_user.following_by_type('District').includes(:candidates).select{|c| c.at_large_district == true}.collect{|u| u.jurisdiction.candidates}.flatten
        @district_candidates = current_user.following_by_type('District').includes(:candidates).collect{|u| u.candidates}.flatten
        

        @candidates = @district_candidates + @atlarge_candidates
        @expenditures = @candidates.collect{|u| u.expenditures}.flatten.sort_by { |expenditure| expenditure.expenditure_date }.reverse
        
        set_meta_tags title: 'My Dashboard',
        site: 'The Ballot Book'
        
    end

    
    

end
