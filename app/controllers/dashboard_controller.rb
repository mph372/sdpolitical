class DashboardController < ApplicationController
    before_action :authenticate_user!
    # before_action :is_subscriber?
    def index
        @districts = current_user.following_by_type('District')
        @updates = Update.all.limit(3)
        @birthdays = Person.where(archived: false).where(birth_month: Time.zone.now.month).order(:birth_day).where("birth_day >= ?", Time.zone.now.day.to_i)
        @deadlines = Deadline.all.order('deadline_date ASC')
        @incumbents = current_user.following_by_type('District').includes(:person).collect{|u| u.person}.flatten
        @atlarge_candidates = current_user.following_by_type('District').includes(:campaigns).select{|c| c.at_large_district == true}.collect{|u| u.jurisdiction}.flatten.map(&:districts).flatten.map(&:campaigns).flatten.map(&:candidates).flatten.map(&:person).flatten
        @district_candidates = current_user.following_by_type('District').includes(:campaigns).map(&:campaigns).flatten.map(&:candidates).flatten.map(&:person).flatten
        

        @candidates = @district_candidates + @atlarge_candidates
        # @expenditures = @candidates.collect{|u| u.expenditures}.flatten.sort_by { |expenditure| expenditure.expenditure_date }.reverse
        
        set_meta_tags title: 'My Dashboard',
        site: 'The Ballot Book'
        
    end

    
    

end
