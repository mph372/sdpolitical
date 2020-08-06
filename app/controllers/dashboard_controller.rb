class DashboardController < ApplicationController
    before_action :authenticate_user!
    def index
        @districts = current_user.following_by_type('District')
        @expenditures = current_user.following_by_type('District').includes(:expenditures).collect{|u| u.expenditures}.flatten
        @district_candidates = current_user.following_by_type('District').includes(:candidates).collect{|u| u.candidates}.flatten
        @birthdays = Person.where(birth_month: Time.zone.now.month).order(:birth_day).where("birth_day >= ?", Time.zone.now.day.to_i)
        @deadlines = Deadline.all.order('deadline_date ASC')
        @incumbents = current_user.following_by_type('District').includes(:incumbent).collect{|u| u.incumbent}.flatten
        @atlarge_candidates = current_user.following_by_type('District').includes(:candidates).select{|c| c.at_large_district == true}.collect{|u| u.jurisdiction.candidates}.flatten

        @updates = Update.all

        @candidates = @district_candidates + @atlarge_candidates
        
        set_meta_tags title: 'My Dashboard',
        site: 'The Ballot Book'
        
    end

    
    

end
