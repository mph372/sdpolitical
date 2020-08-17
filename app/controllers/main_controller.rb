class MainController < ApplicationController

    def index
    end

    def search
        @people = Person.ransack(last_name_cont: params[:q]).result(distinct:true)
        @jurisdictions = Jurisdiction.ransack(name_cont: params[:q]).result(distinct:true)


        respond_to do |format|
            format.html {}
            format.json {
                @people = @people.limit(5)
                @jurisdictions = @jurisdictions.limit(5)
            }
        end
    end
end
