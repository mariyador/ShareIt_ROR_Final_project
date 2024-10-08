class PagesController < ApplicationController
    def about
        @heading = "About us"
        @text = "Some text about the app"
    end
    def contacts
    end
end
