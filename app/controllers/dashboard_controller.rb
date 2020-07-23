class DashboardController < ApplicationController
    before_action :authenticate_user!
    def index
        @districts = current_user.following_by_type('District')
        @expenditures = current_user.following_by_type('District').includes(:expenditures).collect{|u| u.expenditures}.flatten
        @candidates = current_user.following_by_type('District').includes(:candidates).collect{|u| u.candidates}.flatten
        @birthdays = Person.where(birth_month: Time.zone.now.month).order(:birth_day)
        @deadlines = Deadline.all
    end
end
