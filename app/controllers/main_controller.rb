class MainController < ApplicationController

    def index
    end

    def search
        @people = Person.ransack(last_name_cont: params[:q]).result(distinct:true).limit(5)

        respond_to do |format|
            format.html {}
            format.json {
                @people = @people.limit(5)
            }
        end
    end
end
